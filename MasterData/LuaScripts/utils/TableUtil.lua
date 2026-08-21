--------------------------------
-- @module table

-- start --

--------------------------------
-- 计算表格包含的字段数量
-- @function [parent=#table] nums
-- @param table t 要检查的表格
-- @return integer#integer 

--[[--

计算表格包含的字段数量

Lua table 的 "#" 操作只对依次排序的数值下标数组有效，table.nums() 则计算 table 中所有不为 nil 的值的个数。

]]

-- end --

function table.nums(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

-- 判断table是否有数据
function table.empty( t )
    if t~=nil and type(t)=="table" then
        return next(t)==nil
    end
    return true
end

-- start --

--------------------------------
-- 返回指定表格中的所有键
-- @function [parent=#table] keys
-- @param table hashtable 要检查的表格
-- @return table#table 

--[[--

返回指定表格中的所有键

~~~ lua

local hashtable = {a = 1, b = 2, c = 3}
local keys = table.keys(hashtable)
-- keys = {"a", "b", "c"}

~~~

]]

-- end --

function table.keys(hashtable)
    local keys = {}
    for k, _ in pairs(hashtable) do
        table.insert(keys, k)
    end
    return keys
end

-- start --

--------------------------------
-- 返回指定表格中的所有值
-- @function [parent=#table] values
-- @param table hashtable 要检查的表格
-- @return table#table 

--[[--

返回指定表格中的所有值

~~~ lua

local hashtable = {a = 1, b = 2, c = 3}
local values = table.values(hashtable)
-- values = {1, 2, 3}

~~~

]]

-- end --

function table.values(hashtable)
    local values = {}
    for _, v in pairs(hashtable) do
        table.insert(values, v)
    end
    return values
end

-- start --

--------------------------------
-- 将来源表格中所有键及其值复制到目标表格对象中，如果存在同名键，则覆盖其值
-- @function [parent=#table] merge
-- @param table dest 目标表格
-- @param table src 来源表格

--[[--

将来源表格中所有键及其值复制到目标表格对象中，如果存在同名键，则覆盖其值

~~~ lua

local dest = {a = 1, b = 2}
local src  = {c = 3, d = 4}
table.merge(dest, src)
-- dest = {a = 1, b = 2, c = 3, d = 4}

~~~

]]

-- end --

function table.merge(dest, src)
    for k, v in pairs(src) do
        dest[k] = v
    end
    return dest
end

function table.mergeList(dest, src)
    local tmpLst = table.copy(src)
    for _, v in ipairs(dest) do
        for i=#tmpLst,1 do
            if v==tmpLst[i] then
                table.remove(tmpLst, i)
            end
        end        
    end
    for i,v in ipairs(tmpLst) do
        table.insert(dest, v)
    end
end

function table.mergeAll(dest, src)
    local tmplist = table.copy(dest)
    for i,v in ipairs(src) do
        table.insert(tmplist, v)
    end
    return tmplist;
end


-- start --

--------------------------------
-- 从表格中查找指定值，返回其索引，如果没找到返回 false
-- @function [parent=#table] indexof
-- @param table array 表格
-- @param mixed value 要查找的值
-- @param integer begin 起始索引值
-- @return integer#integer 

--[[--

从表格中查找指定值，返回其索引，如果没找到返回 false

~~~ lua

local array = {"a", "b", "c"}
print(table.indexof(array, "b")) -- 输出 2

~~~

]]

-- end --

function table.indexof(array, value, begin)
    for i = begin or 1, #array do
        if array[i] == value then return i end
    end
	return false
end

-- start --

function table.indexof01(array,value, begin)
    for i = begin or 1, #array do
        if array[i] == value then return i end
    end
    return 0
end

--------------------------------
-- 从表格中查找指定值，返回其 key，如果没找到返回 nil
-- @function [parent=#table] keyof
-- @param table hashtable 表格
-- @param mixed value 要查找的值
-- @return string#string  该值对应的 key

--[[--

从表格中查找指定值，返回其 key，如果没找到返回 nil

~~~ lua

local hashtable = {name = "dualface", comp = "chukong"}
print(table.keyof(hashtable, "chukong")) -- 输出 comp

~~~

]]

-- end --

function table.keyof(hashtable, value)
    for k, v in pairs(hashtable) do
        if v == value then return k end
    end
    return nil
end

-- start --

--------------------------------
-- 从表格中删除指定值，返回删除的值的个数
-- @function [parent=#table] removebyvalue
-- @param table array 表格
-- @param mixed value 要删除的值
-- @param boolean removeall 是否删除所有相同的值
-- @return integer#integer 

--[[--

从表格中删除指定值，返回删除的值的个数

~~~ lua

local array = {"a", "b", "c", "c"}
print(table.removebyvalue(array, "c", true)) -- 输出 2

~~~

]]

-- end --

function table.removebyvalue(array, value, removeall)
    local c, i, max = 0, 1, #array
    while i <= max do
        if array[i] == value then
            table.remove(array, i)
            c = c + 1
            if not removeall then break end
            i = i - 1
            max = max - 1
        end
        i = i + 1
    end
    return c
end

-- start --

--------------------------------
-- 对表格中每一个值执行一次指定的函数，并用函数返回值更新表格内容
-- @function [parent=#table] map
-- @param table t 表格
-- @param function fn 函数

--[[--

对表格中每一个值执行一次指定的函数，并用函数返回值更新表格内容

~~~ lua

local t = {name = "dualface", comp = "chukong"}
table.map(t, function(v, k)
    -- 在每一个值前后添加括号
    return "[" .. v .. "]"
end)

-- 输出修改后的表格内容
for k, v in pairs(t) do
    print(k, v)
end

-- 输出
-- name [dualface]
-- comp [chukong]

~~~

fn 参数指定的函数具有两个参数，并且返回一个值。原型如下：

~~~ lua

function map_function(value, key)
    return value
end

~~~

]]

-- end --

function table.map(t, fn)
    for k, v in pairs(t) do
        t[k] = fn(v, k)
    end
end

-- start --

--------------------------------
-- 对表格中每一个值执行一次指定的函数，但不改变表格内容
-- @function [parent=#table] walk
-- @param table t 表格
-- @param function fn 函数

--[[--

对表格中每一个值执行一次指定的函数，但不改变表格内容

~~~ lua

local t = {name = "dualface", comp = "chukong"}
table.walk(t, function(v, k)
    -- 输出每一个值
    print(v)
end)

~~~

fn 参数指定的函数具有两个参数，没有返回值。原型如下：

~~~ lua

function map_function(value, key)

end

~~~

]]

-- end --

function table.walk(t, fn)
    for k,v in pairs(t) do
        fn(v, k)
    end
end

-- start --

--------------------------------
-- 对表格中每一个值执行一次指定的函数，如果该函数返回 false，则对应的值会从表格中删除
-- @function [parent=#table] filter
-- @param table t 表格
-- @param function fn 函数

--[[--

对表格中每一个值执行一次指定的函数，如果该函数返回 false，则对应的值会从表格中删除

~~~ lua

local t = {name = "dualface", comp = "chukong"}
table.filter(t, function(v, k)
    return v ~= "dualface" -- 当值等于 dualface 时过滤掉该值
end)

-- 输出修改后的表格内容
for k, v in pairs(t) do
    print(k, v)
end

-- 输出
-- comp chukong

~~~

fn 参数指定的函数具有两个参数，并且返回一个 boolean 值。原型如下：

~~~ lua

function map_function(value, key)
    return true or false
end

~~~

]]

-- end --

function table.filter(t, fn)
    for k, v in pairs(t) do
        if not fn(v, k) then t[k] = nil end
    end
end

-- start --

--------------------------------
-- 遍历表格，确保其中的值唯一
-- @function [parent=#table] unique
-- @param table array 数组
-- @return table#table  包含所有唯一值的新表格

--[[--

遍历表格，确保其中的值唯一

~~~ lua

local t = {"a", "a", "b", "c"} -- 重复的 a 会被过滤掉
local n = table.unique(t)

for k, v in pairs(n) do
    print(v)
end

-- 输出
-- a
-- b
-- c

~~~

]]

-- end --

function table.unique(array)
    local check = {}
    local n = {}
    for k, v in pairs(array) do
        if not check[v] then
            n[k] = v
            check[v] = true
        end
    end
    return n
end

function table.isArrayTable(t)
    if type(t) ~= "table" then
        return false
    end
    local lastIdx = 0
    -- local n = #t
    for i,v in pairs(t) do
        if type(i) ~= "number" then
            return false
        end
        lastIdx = lastIdx+1
        if lastIdx~=i then
            return false
        end
        -- if i > n then
        --     return false
        -- end
    end    
    return true
end

---
-- @function: 打印table的内容，递归
-- @param: tbl 要打印的table
-- @param: level 递归的层数，默认不用传值进来
-- @param: filteDefault 是否过滤打印构造函数，默认为是
-- @return: return
function table.print( tbl , level, filteDefault)
    logError('===================打印堆栈来源===================')
    print(table.tostring(tbl, level, filteDefault))
end

function table.tostring( tbl , level, filteDefault)
    local context = ""
    filteDefault = filteDefault or true --默认过滤关键字（DeleteMe, _class_type）
    level = level or 1
    local indent_str = ""
    for i = 1, level do
        indent_str = indent_str.."  "
    end

    context = context..indent_str .. "{\n"
    for k,v in pairs(tbl) do
        if filteDefault then
            if k~="class" and k ~= "_class_type" and k ~= "DeleteMe" then
                context = context..string.format("%s[%s] = %s\n", indent_str .. " ",tostring(k), tostring(v))
                if type(v) == "table" then
                    context = context..table.tostring(v, level + 1, filteDefault).."\n"
                end
            end
        else
            context = context..string.format("%s[%s] = %s\n", indent_str .. " ",tostring(k), tostring(v))
            if type(v) == "table" then
                context = context..table.tostring(v, level + 1, filteDefault).."\n"
            end
        end
    end
    context = context..indent_str .. "}\n"
    return context
end

function table.tostring2( tbl , level, filteDefault, firstSpace)
    local context = ""
    filteDefault = filteDefault or true --默认过滤关键字（DeleteMe, _class_type）
    level = level or 1

    local indent_str = ""
    for i = 1, level do
        indent_str = indent_str.."  "
    end

    if firstSpace~=false then
        context = context..indent_str .. "{\n"
    else
        context = context.."{\n"
    end
    local keys = table.keys(tbl)
    table.sort( keys )
    for _,k in ipairs(keys) do
        local v = tbl[k]
    -- for k,v in pairs(tbl) do
        if type(k)=="string" then
            k = "\""..k.."\""
        else
            k = tostring(k)
        end
        if filteDefault then
            if k~="class" and k ~= "_class_type" and k ~= "DeleteMe" then
                if type(v) == "table" then
                    context = context..string.format("%s[%s] =%s,\n", indent_str .. " ",k, table.tostring2(v, level + 1, filteDefault, false))
                    -- context = context..table.tostring2(v, level + 1, filteDefault).."\n"
                else
                    if type(v)=="string" then
                        context = context..string.format("%s[%s] = \"%s\",\n", indent_str .. " ",k, v)
                    else
                        if math.floor(v)<v then
                            context = context..string.format("%s[%s] = %s,\n", indent_str .. " ",k, string.format("%.3f",v))
                        else
                            context = context..string.format("%s[%s] = %s,\n", indent_str .. " ",k, tostring(v))
                        end
                    end
                end
            end
        else
            if type(v) == "table" then
                context = context..string.format("%s[%s] =%s,\n", indent_str .. " ",k, table.tostring2(v, level + 1, filteDefault, false))
                -- context = context..table.tostring2(v, level + 1, filteDefault).."\n"
            else
                if type(v)=="string" then
                    context = context..string.format("%s[%s] = \"%s\",\n", indent_str .. " ",k, v)
                else
                    if math.floor(v)<v then
                        context = context..string.format("%s[%s] = %s,\n", indent_str .. " ",k, string.format("%.3f",v))
                    else
                        context = context..string.format("%s[%s] = %s,\n", indent_str .. " ",k, tostring(v))
                    end
                end
            end
        end
    end
    context = context..indent_str .. "}"
    return context
end

function table.copy(t)
	if(not t) then return nil end
	if(type(t) ~= "table") then 
		print("table  deepCopy error type ! args is not a table")
		return t 
	end
	
	if(table.nums(t) == 0) then return {} end

    local result = {}
    for k,v in pairs(t) do
        if(type(v) == "table" and k ~= "class") then        
            result[k] = table.copy(v)
        else
            result[k] = v
        end
    end
    return result
end

-- @function: 数组打乱，影响传进的参数
-- @param: arr 要打乱的数组
-- @return: return
function table.randomArray(list)
    local tempValue, index
    for i = 1, #list - 1 do
        index = math.random(i, #list)
        if i ~= index then
            tempValue = list[index]
            list[index] = list[i]
            list[i] = tempValue
        end
    end
    return list
end
