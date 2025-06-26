module('LuaUtil', Class.impl())

function ctor(self)
end

function reRequire(self, path)
    self:unRequire(path)
    return require(path)
end

function unRequire(self, path)
    for key, _ in pairs(package.preload) do
        if string.find(tostring(key), path) == 1 then
            package.preload[key] = nil
        end
    end
    for key, _ in pairs(package.loaded) do
        if string.find(tostring(key), path) == 1 then
            package.loaded[key] = nil
        end
    end
end

function split(self, str, delimiter)
    local list = {}
    -- 转义分隔符中可能存在的模式匹配字符
    local pattern = delimiter:gsub("([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1")
    -- 使用 string.gmatch 函数，根据分隔符遍历并分割字符串
    -- 模式 '[^'..pattern..']+' 匹配不包含分隔符的任意字符序列
    pattern = "([^" .. pattern .. "]+)"
    for word in string.gmatch(str, pattern) do
        table.insert(list, word)
    end
    return list
end

function isKeyInTable(self, tbl, key)
    if type(tbl) ~= "table" or tbl == nil then
        assert(false, "isKeyInTable: tbl is not a table or is nil")
        return false
    end

    -- 使用rawget来尝试从表中获取键的值
    local value = rawget(tbl, key)
    if value ~= nil then
        return true
    else
        return false
    end
end

return _M
