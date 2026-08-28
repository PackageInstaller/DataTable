local unpack = unpack or table.unpack

local io = io

local rapidjson = require("rapidjson")

-- 解决原生pack的nil截断问题，SafePack与SafeUnpack要成对使用
function SafePack(...)
    local params = { ... }
    params.n = select('#', ...)
    return params
end

-- 解决原生unpack的nil截断问题，SafePack与SafeUnpack要成对使用
function SafeUnpack(safe_pack_tb)
    return unpack(safe_pack_tb, 1, safe_pack_tb.n)
end

-- 对两个SafePack的表执行连接
function ConcatSafePack(safe_pack_l, len, ...)
    --local concat = {}
    --for i = 1, safe_pack_l.n do
    --    concat[i] = safe_pack_l[i]
    --end
    --for i = 1, safe_pack_r.n do
    --    concat[safe_pack_l.n + i] = safe_pack_r[i]
    --end
    --concat.n = safe_pack_l.n + safe_pack_r.n
    --return concat
    local n = select('#', ...)
    local length = len + n
    for i = len + 1, length do
        safe_pack_l[i] = unpack({ ... }, i - len)
    end
    safe_pack_l.n = length
    return safe_pack_l
end

-- 闭包绑定
function Bind(self, func, ...)
    assert(self == nil or type(self) == "table")
    assert(func ~= nil and type(func) == "function")
    local params = nil
    if self == nil then
        params = SafePack(...)
    else
        params = SafePack(self, ...)
    end
    local len = params.n
    return function(...)
        local args = ConcatSafePack(params, len, ...)
        return func(SafeUnpack(args))
    end
end

-- 回调绑定
-- 重载形式：
-- 1、成员函数、私有函数绑定：BindCallback(obj, callback, ...)
-- 2、闭包绑定：BindCallback(callback, ...)
function BindCallback(...)
    local bindFunc = nil
    local params = SafePack(...)
    assert(params.n >= 1, "BindCallback : error params count!")
    if type(params[1]) == "table" and type(params[2]) == "function" then
        bindFunc = Bind(...)
    elseif type(params[1]) == "function" then
        bindFunc = Bind(nil, ...)
    else
        error("BindCallback : error params list!")
    end
    return bindFunc
end


-- 将字符串转换为boolean值
function ToBoolean(s)
    local transform_map = {
        ["true"] = true,
        ["false"] = false,
    }

    return transform_map[s]
end

-- 深拷贝对象
function DeepCopy(object)
    local lookup_table = {}

    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end

        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end

        return setmetatable(new_table, getmetatable(object))
    end

    return _copy(object)
end

-- 序列化表
function Serialize(tb, flag)
    local result = ""
    result = string.format("%s{", result)

    local filter = function(str)
        str = string.gsub(str, "%[", " ")
        str = string.gsub(str, "%]", " ")
        str = string.gsub(str, '\"', " ")
        str = string.gsub(str, "%'", " ")
        str = string.gsub(str, "\\", " ")
        str = string.gsub(str, "%%", " ")
        return str
    end

    for k, v in pairs(tb) do
        if type(k) == "number" then
            if type(v) == "table" then
                result = string.format("%s[%d]=%s,", result, k, Serialize(v))
            elseif type(v) == "number" then
                result = string.format("%s[%d]=%d,", result, k, v)
            elseif type(v) == "string" then
                result = string.format("%s[%d]=%q,", result, k, v)
            elseif type(v) == "boolean" then
                result = string.format("%s[%d]=%s,", result, k, tostring(v))
            else
                if flag then
                    result = string.format("%s[%d]=%q,", result, k, type(v))
                else
                    error("the type of value is a function or userdata")
                end
            end
        else
            if type(v) == "table" then
                result = string.format("%s%s=%s,", result, k, Serialize(v, flag))
            elseif type(v) == "number" then
                result = string.format("%s%s=%d,", result, k, v)
            elseif type(v) == "string" then
                result = string.format("%s%s=%q,", result, k, v)
            elseif type(v) == "boolean" then
                result = string.format("%s%s=%s,", result, k, tostring(v))
            else
                if flag then
                    result = string.format("%s[%s]=%q,", result, k, type(v))
                else
                    error("the type of value is a function or userdata")
                end
            end
        end
    end
    result = string.format("%s}", result)
    return result
end

---
---table相关扩展
---
-- 1、所有参数带hashtable的函数，将把table当做哈希表对待
-- 2、所有参数带array的函数，将把table当做可空值数组对待
-- 3、所有参数带tb的函数，对表通用，不管是哈希表还是数组
--]]

-- 计算哈希表长度
local function count(hashtable)
    local count = 0
    for _, _ in pairs(hashtable) do
        count = count + 1
    end
    return count
end

-- 计算数据长度
local function length(array)
    if array.n ~= nil then
        return array.n
    end

    local count = 0
    for i, _ in pairs(array) do
        if count < i then
            count = i
        end
    end
    return count
end

-- 设置数组长度
local function setlen(array, n)
    array.n = n
end

-- 获取哈希表所有键
local function keys(hashtable)
    local keys = {}
    for k, v in pairs(hashtable) do
        keys[#keys + 1] = k
    end
    return keys
end

-- 获取哈希表所有值
local function values(hashtable)
    local values = {}
    for k, v in pairs(hashtable) do
        values[#values + 1] = v
    end
    return values
end

-- 合并哈希表：将src_hashtable表合并到dest_hashtable表，相同键值执行覆盖
local function merge(dest_hashtable, src_hashtable)
    for k, v in pairs(src_hashtable) do
        dest_hashtable[k] = v
    end
end

-- 合并数组：将src_array数组从begin位置开始插入到dest_array数组
-- 注意：begin <= 0被认为没有指定起始位置，则将两个数组执行拼接
local function insertto(dest_array, src_array, begin)
    assert(begin == nil or type(begin) == "number")
    if begin == nil or begin <= 0 then
        begin = #dest_array + 1
    end

    local src_len = #src_array
    for i = 0, src_len - 1 do
        dest_array[i + begin] = src_array[i + 1]
    end
end

-- 从数组中查找指定值，返回其索引，没找到返回false
local function indexof(array, value, begin)
    for i = begin or 1, #array do
        if array[i] == value then
            return i
        end
    end
    return false
end

-- 从哈希表查找指定值，返回其键，没找到返回nil
-- 注意：
-- 1、containskey用hashtable[key] ~= nil快速判断
-- 2、containsvalue由本函数返回结果是否为nil判断
local function keyof(hashtable, value)
    for k, v in pairs(hashtable) do
        if v == value then
            return k
        end
    end
    return nil
end

-- 从数组中删除指定值，返回删除的值的个数
function table.removebyvalue(array, value, removeall)
    local remove_count = 0
    for i = #array, 1, -1 do
        if array[i] == value then
            table.remove(array, i)
            remove_count = remove_count + 1
            if not removeall then
                break
            end
        end
    end
    return remove_count
end

-- 遍历写：用函数返回值更新表格内容
local function map(tb, func)
    for k, v in pairs(tb) do
        tb[k] = func(k, v)
    end
end

-- 遍历读：不修改表格
local function walk(tb, func)
    for k, v in pairs(tb) do
        func(k, v)
    end
end

-- 按指定的排序方式遍历：不修改表格
local function walksort(tb, sort_func, walk_func)
    local keys = table.keys(tb)
    table.sort(keys, function(lkey, rkey)
        return sort_func(lkey, rkey)
    end)
    for i = 1, table.length(keys) do
        walk_func(keys[i], tb[keys[i]])
    end
end

-- 过滤掉不符合条件的项：不对原表执行操作
local function filter(tb, func)
    local filter = {}
    for k, v in pairs(tb) do
        if not func(k, v) then
            filter[k] = v
        end
    end
    return filter
end

-- 筛选出符合条件的项：不对原表执行操作
local function choose(tb, func)
    local choose = {}
    for k, v in pairs(tb) do
        if func(k, v) then
            choose[k] = v
        end
    end
    return choose
end

-- 获取数据循环器：用于循环数组遍历，每次调用走一步，到数组末尾从新从头开始
local function circulator(array)
    local i = 1
    local iter = function()
        i = i >= #array and 1 or i + 1
        return array[i]
    end
    return iter
end

local DUMP_STRING = ''
-- dump表
local function dump(tb, dump_metatable, max_level)
    if Config and not Config.DEBUG then
        ---如果不是debug状态
        return DUMP_STRING
    end
    local lookup_table = {}
    local level = 0
    local rep = string.rep
    local dump_metatable = dump_metatable
    local max_level = max_level or 1

    local function _dump(tb, level)
        local str = "\n" .. rep("\t", level) .. "{\n"
        for k, v in pairs(tb) do
            local k_is_str = type(k) == "string" and 1 or 0
            local v_is_str = type(v) == "string" and 1 or 0
            str = str .. rep("\t", level + 1) .. "[" .. rep("\"", k_is_str) .. (tostring(k) or type(k)) .. rep("\"", k_is_str) .. "]" .. " = "
            if type(v) == "table" then
                if not lookup_table[v] and ((not max_level) or level < max_level) then
                    lookup_table[v] = true
                    str = str .. _dump(v, level + 1, dump_metatable) .. "\n"
                else
                    str = str .. (tostring(v) or type(v)) .. ",\n"
                end
            else
                str = str .. rep("\"", v_is_str) .. (tostring(v) or type(v)) .. rep("\"", v_is_str) .. ",\n"
            end
        end
        if dump_metatable then
            local mt = getmetatable(tb)
            if mt ~= nil and type(mt) == "table" then
                str = str .. rep("\t", level + 1) .. "[\"__metatable\"]" .. " = "
                if not lookup_table[mt] and ((not max_level) or level < max_level) then
                    lookup_table[mt] = true
                    str = str .. _dump(mt, level + 1) .. "\n"
                end
            end
        end
        str = str .. rep("\t", level) .. "},"
        return str
    end

    -- traceback
    -- 1: stack traceback:
    -- 2: table.dump
    -- 3: xxx (dump source)
    -- ...
    return tostring(string.split2(debug.traceback("", 1), '\n')[3]) .. _dump(tb, level)
end

local function haskey(t, key)
    return type(t) == 'table' and t[key] ~= nil
end

---takeFirst
---取得数据组中的第一个元素
---@param t table
local function takeFirst(t)
    if (isTable(t) or isUserData(t)) and table.length(t) > 0 then
        return t[1]
    end
end

---takeLast
------取得数据组中的最后元素
---@param t table
local function takeLast(t)
    if isTable(t) and table.length(t) > 0 then
        return t[#t]
    end
end

local function max(t)
    local _, r = next(t)
    for _, v in pairs(t) do
        r = math.max(checkNumber(v), checkNumber(r))
    end
    return r
end
---min table中的最小值
---@param t table
local function min(t)
    local _, r = next(t)
    for _, v in pairs(t) do
        r = math.min(checkNumber(v), checkNumber(r))
    end
    return r
end

local function find(t, func)
    for k, v in pairs(t) do
        if func(v) then
            return v, k
        end
    end

    return nil
end

local function groupBy(t, func)
    local grouped = {}
    for k, v in pairs(t) do
        local groupKey = func(v)
        if not grouped[groupKey] then
            grouped[groupKey] = {}
        end
        table.insert(grouped[groupKey], v)
    end

    return grouped
end

---serialize json序列化
---@param t table
---@return string json
local function serialize(t)
    local _json = require('rapidjson')
    return _json.encode(t)
end

---deserialize json decode反序列化
---@param str string
---@return table
local function deserialize(str)
    local _json = require("rapidjson")
    local result = nil
    local function deserialize_json()
        result = _json.decode(str)
    end
    pcall(deserialize_json)
    return result
end
--
-- table相关扩展的对应方法相关
--
table.count = count
table.length = length
table.setlen = setlen
table.keys = keys
table.values = values
table.merge = merge
table.insertto = insertto
table.indexof = indexof
table.keyof = keyof
table.haskey = haskey
table.map = map
table.walk = walk
table.walksort = walksort
table.filter = filter
table.choose = choose
table.takeFirst = takeFirst
table.takeLast = takeLast
table.circulator = circulator
table.dump = dump
table.max = max
table.min = min
table.find = find
table.groupBy = groupBy
table.serialize = serialize
table.deserialize = deserialize

---
---string扩展的相关方法
-- 字符串分割
-- @split_string：被分割的字符串
-- @delimiter：分隔符，可以为模式匹配
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

-- 字符串连接
local function join(join_table, joiner)
    if #join_table == 0 then
        return ""
    end

    local fmt = "%s"
    for i = 2, #join_table do
        fmt = fmt .. joiner .. "%s"
    end

    return string.format(fmt, unpack(join_table))
end

-- 是否包含
-- 注意：plain为true时，关闭模式匹配机制，此时函数仅做直接的 “查找子串”的操作
local function contains(target_string, pattern, plain)
    plain = plain == true
    local find_pos_begin, find_pos_end = string.find(target_string, pattern, 1, plain)
    return find_pos_begin ~= nil
end

-- 以某个字符串开始
local function startswith(target_string, start_pattern, plain)
    plain = plain == true
    local find_pos_begin, find_pos_end = string.find(target_string, start_pattern, 1, plain)
    return find_pos_begin == 1
end

-- 以某个字符串结尾
local function endswith(target_string, start_pattern, plain)
    plain = plain == true
    local find_pos_begin, find_pos_end = string.find(target_string, start_pattern, -#start_pattern, plain)
    return find_pos_end == #target_string
end

string._htmlspecialchars_set = {}
string._htmlspecialchars_set["&"] = "&amp;"
string._htmlspecialchars_set["\""] = "&quot;"
string._htmlspecialchars_set["'"] = "&#039;"
string._htmlspecialchars_set["<"] = "&lt;"
string._htmlspecialchars_set[">"] = "&gt;"

function string.htmlspecialchars(input)
    for k, v in pairs(string._htmlspecialchars_set) do
        input = string.gsub(input, k, v)
    end
    return input
end

function string.restorehtmlspecialchars(input)
    for k, v in pairs(string._htmlspecialchars_set) do
        input = string.gsub(input, v, k)
    end
    return input
end

function string.nl2br(input)
    return string.gsub(input, "\n", "<br />")
end

function string.text2html(input)
    input = string.gsub(input, "\t", "    ")
    input = string.htmlspecialchars(input)
    input = string.gsub(input, " ", "&nbsp;")
    input = string.nl2br(input)
    return input
end

function string.ltrim(input)
    return string.gsub(input, "^[ \t\n\r]+", "")
end

function string.rtrim(input)
    return string.gsub(input, "[ \t\n\r]+$", "")
end

function string.trim(input)
    input = string.gsub(input, "^[ \t\n\r]+", "")
    return string.gsub(input, "[ \t\n\r]+$", "")
end

function string.dc_first(input)
    return string.lower(string.sub(input, 1, 1)) .. string.sub(input, 2)
end

function string.uc_first(input)
    return string.upper(string.sub(input, 1, 1)) .. string.sub(input, 2)
end

local function url_encode_char(char)
    return "%" .. string.format("%02X", string.byte(char))
end
function string.url_encode(input)
    -- convert line endings
    input = string.gsub(tostring(input), "\n", "\r\n")
    -- escape all characters but alphanumeric, '.' and '-'
    input = string.gsub(input, "([^%w%.%- ])", url_encode_char)
    -- convert spaces to "+" symbols
    return string.gsub(input, " ", "+")
end

function string.url_decode(input)
    input = string.gsub(input, "+", " ")
    input = string.gsub(input, "%%(%x%x)", function(h)
        return string.char(checkNumber(h, 16))
    end)
    input = string.gsub(input, "\r\n", "\n")
    return input
end

local function isEmpty(value)
    return value == nil or value == rapidjson.null or string.len(tostring(value)) == 0
end

local function str_date2_timestamp(value)
    local p = '(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)'
    local year, month, day, hour, min, sec = value:match(p)
    local t = os.time({ day = day, month = month, year = year, hour = hour, min = min, sec = sec })
    return t
end

---str_date2_time
---string to time
---@param value string
---@param default function
local function str_date2_time(value, default)
    local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
    local year, month, day, hour, min, sec = string.match(value, pattern)
    if year and month and day and hour and min and sec then
        return {
            year = tonumber(year),
            month = tonumber(month),
            day = tonumber(day),
            hour = tonumber(hour),
            min = tonumber(min),
            sec = tonumber(sec),
        }
    else
        return default
    end
end

---format_color_tag
---将color与text构造成 <color=3dsd></color
---@param text string
---@param color string
local function format_color_tag(text, color)
    return string.format('<color=%s>%s</color>', color, text)
end

---将size与text构造成 <size></size>
---@param text string
---@param size string
local function format_size_tag(text, size)
    return string.format('<size=%s>%s</size>', size, text)
end

local stringByte = string.byte

--==============================--
--desc: 从一个字符串中查找另一个字符串的最后一次匹配的索引
--@str: 原字符串
--@separator: 需要匹配的字符串
--@return 索引号
--==============================--
local function last_index_of(str, separator)
    if not str or str == "" or not separator or separator == "" then
        return -1
    end
    local strLen = #str
    local sepLen = #separator
    for i = 0, strLen - 1 do
        local success = true
        for s = 0, sepLen - 1 do
            local strChar = stringByte(str, strLen - i - s)
            local sepChar = stringByte(separator, sepLen - s)
            if strChar ~= sepChar then
                success = false
                break
            end
        end
        if success then
            return strLen - i - sepLen + 1
        end
    end
    return -1
end


string.split = split
string.join = join
string.contains = contains
string.startsWith = startswith
string.endsWith = endswith
string.isEmpty = isEmpty
string.str_date2_time = str_date2_time
string.str_date2_timestamp = str_date2_timestamp
string.format_color_tag = format_color_tag
string.format_size_tag = format_size_tag
string.last_index_of = last_index_of

function io.exists(path)
    local file = io.open(path, "r")
    if file then
        io.close(file)
        return true
    end
    return false
end

function io.readFile(path)
    local file = io.open(path, "r")
    if file then
        local content = file:read("*a")
        io.close(file)
        return content
    end
    return nil
end

function io.writeFile(path, content, mode)
    mode = mode or "w+b"
    local file = io.open(path, mode)
    if file then
        if file:write(content) == nil then
            return false
        end
        io.close(file)
        return true
    else
        return false
    end
end

function io.pathInfo(path)
    local pos = string.len(path)
    local extpos = pos + 1
    while pos > 0 do
        local b = string.byte(path, pos)
        if b == 46 then
            -- 46 = char "."
            extpos = pos
        elseif b == 47 then
            -- 47 = char "/"
            break
        end
        pos = pos - 1
    end

    local dirname = string.sub(path, 1, pos)
    local filename = string.sub(path, pos + 1)
    extpos = extpos - pos
    local basename = string.sub(filename, 1, extpos - 1)
    local extname = string.sub(filename, extpos)
    return {
        dirname = dirname,
        filename = filename,
        basename = basename,
        extname = extname
    }
end

function io.fileSize(path)
    local size = false
    local file = io.open(path, "r")
    if file then
        local current = file:seek()
        size = file:seek("end")
        file:seek("set", current)
        io.close(file)
    end
    return size
end


--通用的一些方法
--
---[[--
-- 添加一排序方法
--]]
--升序排序 /quicksort  asc
--target: 目标table/target table such as {9, -1, 4, 5, 18, 1, 8, 0, 20, 31}
--low：起始下标/start position
--high：终止下标/end position
function quick_sort_ASC(target, low, high)
    local t = low or 1
    local r = high or #target
    local temp = target[t]

    if low < high then
        while (t < r) do
            while (target[r] >= temp and t < r) do
                r = r - 1
            end
            target[t] = target[r]
            while (target[t] <= temp and t < r) do
                t = t + 1
            end
            target[r] = target[t]
        end
        target[t] = temp
        quick_sort_ASC(target, low, t - 1)
        quick_sort_ASC(target, r + 1, high)
    end
end

--降序排序 /quicksort  desc
--target: 目标table/target table such as {9, -1, 4, 5, 18, 1, 8, 0, 20, 31}
--low：起始下标/start position
--high：终止下标/end position
function quick_sort_DESC(target, low, high)
    local t = low or 1
    local r = high or #target
    local temp = target[t]

    if low < high then
        while (t < r) do
            while (target[r] <= temp and t < r) do
                r = r - 1
            end
            target[t] = target[r]
            while (target[t] >= temp and t < r) do
                t = t + 1
            end
            target[r] = target[t]
        end
        target[t] = temp
        quick_sort_DESC(target, low, t - 1)
        quick_sort_DESC(target, r + 1, high)
    end
end

--- check number
---@param value any
---@param base integer
---@return number
function checkNumber(value, base)
    return tonumber(value, base) or 0
end

--- check integer
---@param value any
---@return integer
function checkInt(value)
    return math.floor((tonumber(value) or 0) + 0.5)
end

--- check string
---@param value any
---@return string
function checkString(value)
    return string.isEmpty(value) and '' or tostring(value)
end

--- check boolean
---@param value any
---@return boolean
function checkBool(value)
    return (value ~= nil and value ~= false)
end

--- check table
---@generic T
---@param value T
---@return T
function checkTable(value)
    if type(value) ~= "table" then
        value = {}
    end
    return value
end

---@param value any
---@return boolean
function isTable(value)
    return type(value) == 'table'
end

---@param value any
---@return boolean
function isFunction(value)
    return type(value) == 'function'
end

---@param value any
---@return boolean
function isUserData(value)
    return type(value) == 'userdata'
end

---isSet table数据下指定的key是否设置过了
---@param value table
---@param key string
---@return boolean
function isSet(value, key)
    local t = type(value)
    return (t == "table" or t == "userdata") and value[key] ~= nil
end

function printLog(tag, fmt, ...)
    fmt = tostring(fmt)
    fmt = string.gsub(fmt,'%%', '%%%%')
    local t = {
        "[",
        string.upper(tostring(tag)),
        "] ",
        string.format(tostring(fmt), ...)
    }
    local where = debug.traceback("", 2)
    print(table.concat(t) .. '\n' .. where)
end

local MyLogger = CS.Engine.Lib.MyLogger
local function print_to_file(msg)
    MyLogger.LogToFile(tostring(msg))
end

function printError(fmt, ...)
    if Config and Config.DEBUG then
        local util = require 'XLua.util'
        if util.track_back then
            local errMsg = string.format(tostring(fmt), ...)
            local errRet = errMsg .. util.track_back('')
            MyLogger.LogError(errRet)
            print_to_file(errRet)
            return
        end
    end
    MyLogger.LogError(string.format(tostring(fmt), ...) .. debug.traceback("",2))
    print_to_file(debug.traceback("", 2))
    -- print(debug.traceback("", 2))
end

function printInfo(fmt, ...)
    if type(Config.DEBUG) ~= "boolean" or Config.DEBUG == false then
        return
    end
    printLog("INFO", fmt, ...)
end

local KTool = CS.Engine.Lib.KTool

---isNull 是否为空
---@param unity_object userdata
---@return boolean
function isNull(unity_object)
    if unity_object == nil then
        return true
    end

    if unity_object == rapidjson.null then
        return true
    end

    if type(unity_object) == "userdata" then
        return KTool.IsNull(unity_object)
    end

    return false
end

---isNotNull 是否非空
---@param unity_object userdata
---@return boolean
function isNotNull(unity_object)
    return isNull(unity_object) == false
end

---sorted_pairs hashtable排序式的迭代
---@param t table
function sorted_pairs(t)
    local keys = table.keys(t)
    table.sort(keys, function(a, b)
        if type(a) == type(b) then
            if type(b) == type(0) then
                return a < b
            else
                return tonumber(a) < tonumber(b)
            end
        end
        return type(a) < type(b)
    end)
    local index = 0
    return function(...)
        -- body
        index = index + 1
        if index <= #keys then
            return keys[index], t[keys[index]]
        end
    end
end

---array_pairs
---csharp 层的数组典型的是getcomponents返回的列表
---@param array userdata csharp array
function array_pairs(array)
    local index = -1
    return function(...)
        index = index + 1
        if index < array.Length then
            return index, array[index]
        end
    end
end

function math.newrandomseed()
    local next = tostring(os.time()):reverse():sub(1, 6)
    --if ok then
    --    local a = socket.gettime() * 1000
    --    print(a, type(a))
    --    math.randomseed(socket.gettime() * 1000)
    --else
    --    math.randomseed(os.time())
    --end
    math.randomseed(next)
    math.random()
    math.random()
    math.random()
    math.random()
end

local xTryCatchGetErrorInfo = function(errMsg)
    printError("%s : %s", errMsg or '', debug.traceback())
end
--[[
-- 模拟try
-- catch操作
--]]
---@return boolean
function xTry(try, catch)
    if not catch then
        catch = xTryCatchGetErrorInfo
    end
    local ret, errorMessage = xpcall(try, catch)
    return ret
end


local functionType = "function"
---try 函数
---使用方法
---try {
---  catch { ---optional
---  },
---  finally { ---optional
--- }
---}
---@param tryBlock table
function try(tryBlock)
    local status, err = true, nil
    if type(tryBlock) == functionType then
        status, err = xpcall(tryBlock, debug.traceback)
    end

    local finally = function (finallyBlock, catchBlockDeclared)
        if type(finallyBlock) == functionType then
            finallyBlock()
        end

        if not catchBlockDeclared and not status then
            error(err)
        end
    end

    local catch = function (catchBlock)
        local catchBlockDeclared = type(catchBlock) == functionType

        if not status and catchBlockDeclared then
            local ex = err or "unknown error occurred"
            catchBlock(ex)
        end

        return {
            finally = function(finallyBlock)
                finally(finallyBlock, catchBlockDeclared)
            end
        }
    end

    return
    {
        catch = catch,
        finally = function(finallyBlock)
            finally(finallyBlock, false)
        end
    }
end

---second_toHHMMSS
---秒数转为HH：MM：ss格式
---@param second number
function second_toHHMMSS(second)
    local minute = math.floor(second / 60)
    local lastSecond = second - minute * 60

    local hour = math.floor(minute / 60)
    local lastMinute = minute - hour * 60
    local str = string.format("%02d:%02d:%02d", hour, lastMinute, lastSecond)
    return str
end

---second_toMMSS
---格式化为 MM:ss格式
---@param second number
function second_toMMSS(second)
    local minute = math.floor(second / 60)
    local lastSecond = second - minute * 60
    local hour = math.floor(minute / 60)
    local lastMinute = minute - hour * 60
    local str = string.format("%02d:%02d", lastMinute, lastSecond)
    return str
end

function TID(t)
    local name = tostring(t)
    local pos = name:find('0x')
    local target
    if pos then
        target = string.sub(name, pos)
    else
        local pos = name:find(':')
        if pos then
            target = string.trim(string.sub(name, pos))
        end
    end
    if not target then
        target = name
    end
    return target
end

--[[--
以某一元素对数组排充
@param t table
@param memberName 字段名
@param asc 是否为升序
--]]
function SortByMember(t, memberName, asc)
    if asc == nil then
        asc = true
    end
    local memberSort = function(a, b, memberName, asc)
        if type(a) ~= 'table' then
            return not asc
        end
        if type(a) ~= 'table' then
            return asc
        end
        if not a[memberName] then
            return not asc
        end
        if not b[memberName] then
            return asc
        end
        if type(a[memberName]) == "string" then
            if string.match(a[memberName], '^%d+$') then
                --number
                if asc then
                    return checkInt(a[memberName]) < checkInt(b[memberName])
                else
                    return checkInt(a[memberName]) > checkInt(b[memberName])
                end
            else
                if asc then
                    return a[memberName]:lower() < b[memberName]:lower()
                else
                    return a[memberName]:lower() > b[memberName]:lower()
                end
                if asc then
                    return a[memberName] < b[memberName]
                else
                    return a[memberName] > b[memberName]
                end
            end
        elseif type(a[memberName]) == 'number' then
            if asc then
                return checkInt(a[memberName]) < checkInt(b[memberName])
            else
                return checkInt(a[memberName]) > checkInt(b[memberName])
            end
        elseif type(a[memberName]) == 'nil' then
            if asc then
                return checkInt(a[memberName]) < checkInt(b[memberName])
            else
                return checkInt(a[memberName]) > checkInt(b[memberName])
            end
        end
    end
    table.sort(t, function(a, b)
        return memberSort(a, b, memberName, asc)
    end)
end

---timestamp_to_time
---时间缀转为日期时间
---@param unixTime number @ 时间缀
function timestamp_to_time(unixTime)
    unixTime = checkNumber(unixTime)
    if unixTime >= 0 then
        local tb = {}
        tb.year = tonumber(os.date('%Y', unixTime))
        tb.month = tonumber(os.date('%m', unixTime))
        tb.day = tonumber(os.date('%d', unixTime))
        tb.hour = tonumber(os.date('%H', unixTime))
        tb.min = tonumber(os.date('%M', unixTime))
        tb.sec = tonumber(os.date('%S', unixTime))
        return tb
    end
end

-- 客户端时区（秒数，例如：GMT+8 = 8*60*60 = 28800）
function getClientTimezone()
    local nowTime  = os.time(os.date("*t")--[[@as osdate]])
    local pureTime = os.time(os.date("!*t", nowTime)--[[@as osdate]])
    if os.date("*t", os.time()).isdst then
        nowTime = nowTime + 3600
    end
    return os.difftime(nowTime, pureTime)
end