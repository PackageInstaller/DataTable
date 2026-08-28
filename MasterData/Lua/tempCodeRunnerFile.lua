local function split(split_string, delimiter)
    assert(type(split_string) == "string")
    assert(type(delimiter) == "string" and #delimiter > 0)
    if (delimiter == '') then
        return false
    end
    local pos, arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(split_string, delimiter, pos, false) end do
        table.insert(arr, string.sub(split_string, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(split_string, pos))
    return arr
end

function string:split2(sep)
    local sep, fields = sep or "\t", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(
            pattern,
            function(c)
                fields[#fields + 1] = c
            end
    )
    return fields
end
local strList = string.split2("", ";")
print(next(strList))

print(string.find("1Probability", "Probability"))