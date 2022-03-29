FLAGS = -Wall -pedantic -Wextra 2>/dev/null
CCC = cc -c
CCO = cc -o
MV = -mv *.o bin/ 2>/dev/null
MD = -mkdir bin 2>/dev/null
DEL = -rm -r bin/*.o grapher temp bin/ 2>/dev/null
TEST = cd tests && make -s
WM = ./grapher -wm -rows 4 -start 1 -file tests/data/data.test -end 10 -columns 5
EM = ./grapher -em -rows 5 -file tests/data/data.test -end 20 -columns 7 -start 5
REM = ./grapher -file tests/data/data.test -rem -end 10 -rows 6 -start 1 -columns 7
RM_S = ./grapher -file tests/data/rm_s.test -rm -points 1,5,4,8 -standard
RM_E = ./grapher -extended -points 2,7,3,11 -file rm_e.test -rm

.PHONY: clean test

grapher: main.o alloc.o readGraph.o genGraph.o utils.o
	$(CCO) $@ $^
	$(MD)
	$(MV) 

wm: grapher
	$(WM)
	$(DEL)
	
em: grapher
	$(EM)
	$(DEL)

rem: grapher
	$(REM)
	$(DEL)

rm_s: grapher
	$(RM_S)
	$(DEL)

rm_e: grapher
	$(RM_E)
	$(DEL)

test:
	@$(TEST)

main.o: src/main.c src/alloc.h src/readGraph.h
	$(CCC) $< $(FLAGS)

alloc.o: src/alloc.c src/alloc.h
	$(CCC) $< $(FLAGS)

readGraph.o: src/readGraph.c src/readGraph.h
	$(CCC) $< $(FLAGS)

genGraph.o: src/genGraph.c src/genGraph.h
	$(CCC) $< $(FLAGS)

utils.o: src/utils.c src/utils.h
	$(CCC) $< $(FLAGS)

clean:
	$(DEL)