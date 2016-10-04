function brainfuck(program)

    %% Establish symbol map
    symbolMap = containers.Map;
    symbolMap('>') = 'ShiftRight';
    symbolMap('<') = 'ShiftLeft';
    symbolMap('+') = 'Increment';
    symbolMap('-') = 'Decrement';
    symbolMap('[') = 'LoopStart';
    symbolMap(']') = 'LoopEnd';
    symbolMap('.') = 'Print';

    %% Initialize variables
    % Tape to move a pointer across
    % Set to a vector of 1x100 dimensions, can be expanded as needed
    tape = zeros(1, 1000);
    % Pointer position. MatLab starts counting at 1, not 0
    ptr = 1;
    % Index position for interpreting
    i = 1;
    
    %% Iterate over program
    while i <= length(program)
        % Shift the pointer one index to the left
        if (strcmp(symbolMap(program(i)), 'ShiftLeft') == 1)
            ptr = ptr - 1;
        % Shift the pointer 1 index to the right
        elseif (strcmp(symbolMap(program(i)), 'ShiftRight') == 1)
            ptr = ptr + 1;
        % Increment the tape value ptr is pointing to
        elseif (strcmp(symbolMap(program(i)), 'Increment') == 1)
            if (ptr > length(tape))
                tape(ptr) = 0;
            end
            tape(ptr) = tape(ptr) + 1;
        % Decrement the tape value ptr is pointing to
        elseif (strcmp(symbolMap(program(i)), 'Decrement') == 1)
            tape(ptr) = tape(ptr) - 1;
        % Begin a loop
        elseif (strcmp(symbolMap(program(i)), 'LoopStart') == 1)
            if (tape(ptr) == 0)
                loop = 1;
                while (loop > 0)
                    i = i + 1;
                    c = program(i);
                    if (c == '[')
                        loop = loop + 1;
                    elseif c == ']'
                        loop = loop - 1;
                    end
                end
            end
        % End a loop
        elseif (strcmp(symbolMap(program(i)), 'LoopEnd') == 1)
            loop = 1;
            while (loop > 0)
                i = i - 1;
                c = program(i);
                if (c == '[')
                    loop = loop - 1;
                elseif (c == ']')
                    loop = loop + 1;
                end
            end
            i = i - 1;
        % Print char value of where ptr is in the tape
        elseif (strcmp(symbolMap(program(i)), 'Print') == 1)
            fprintf('%s', char((tape(ptr))));
        end
        i = i + 1;
    end
end
