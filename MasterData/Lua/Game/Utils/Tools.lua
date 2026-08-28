---@class Tools
local Tools = {}

function Tools.isNullKey( key )
    if not key or key == 0 or key == "" or key == "0" then
        return true
    end

    return false
end

function table.shuffle(array)
    if #array <= 1 then
        return array
    end
    -- let clone = array.concat();
    local len = #array;
    for i=1,len do
        local index = math.random(1, len);
        local temp = array[i];
        array[i] = array[index];
        array[index] = temp;
    end
    return array
end

function math.sign( num )
    if num >= 0 then
        return 1
    else
        return -1
    end
end

function table.getn( tab )
    return #tab
end

function Tools.getVector3(pos)
    return Vector3(pos.x, pos.y, pos.z)
end

function Tools.getGroundVector3( pos )
    return Vector3(pos.x, 0, pos.z)
end

function Tools.getQuaternion(rq)
    local q = Quaternion.New(rq.x, rq.y, rq.z, rq.w)
    return q
end

function Tools.rotateVector3(dir, vec3)
    local q = Quaternion.FromToRotation(Vector3.forward, dir)
    return Quaternion.MulVec3(q, vec3)
end

function Tools.syncStand(transform, stand)
    if isNull(transform) then
        return
    end
    transform.localPosition = stand.position
    local r = stand.rotation
    transform.localRotation = Quaternion.Euler(r.x, r.y, r.z)
end

function math.range(num, min, max)
    -- body
    return math.min(math.max(num, min), max)
end

function math.round(num)
    return math.floor(num + 0.5)
end

function fipairs(t)
    local function iter(t, i)
        -- body
        i = i - 1
        local v = t[i]
        if (v) then
            return i, v
        end
    end

    -- body
    return iter, t, #t + 1
end

function IEnumerator(t)
    local function iter(t)
        if t:MoverNext() then
            return t.Current
        end
    end
    return iter, t
end

function string.s2n(s)
    -- body
    local n = { 1 }
    local l = string.split2(s)
    for i = 1, string.len(s) do
        local t = string.byte(string.sub(s, i, i))

        if t < 10 then
            table.insert(n, 0)
            table.insert(n, 0)
            table.insert(n, t)
        elseif t < 100 then
            table.insert(n, 0)
            table.insert(n, t)
        else
            table.insert(n, t)
        end
    end
    return tonumber(table.concat(n, ""))
end

function string.unit(s, ...)
    local l = string.split(s, "{")
    local p = { ... }
    local t = {}
    for k, v in ipairs(l) do
        if k % 2 == 0 then
            local c = string.split(v, "}")
            table.insert(t, tonumber(p[1]))
            table.insert(t, c[2])
        else
            table.insert(t, v)
        end
    end
    return table.concat(t, "")
end

--只分割
function string:split2(sep)
    local sep, fields = sep or "\t", {}
    local pattern = string.format("([^%s]+)", sep)
    if type(self) == "string" then
        self:gsub(
            pattern,
            function(c)
                fields[#fields + 1] = c
            end
        )
    end
    return fields
end

--由分隔符取得字符串参数的方法
function string.slice(word, keyWord)
    if type(word) ~= "string" or type(keyWord) ~= "string" then
        error("please give a string type " .. (word or "nil") .. "  " .. (keyWord or "nil"), 1)
        return {}
    end

    local nowWord = word
    local result = {}
    local indexStart = 1
    local indexLast = 1
    local keyWordLast = 1

    while indexLast ~= nil do
        indexLast, keyWordLast = string.find(nowWord, keyWord)
        if indexLast == nil then
            result[#result + 1] = nowWord
            break
        end
        local temp = string.sub(nowWord, indexStart, indexLast - 1)
        if temp then
            result[#result + 1] = temp
        end

        nowWord = string.sub(nowWord, keyWordLast + 1)
    end

    return result
end

local function _split(array, ...)
    if select('#', ...) < 0 then
        return
    end

    for i, v in ipairs(array) do
        local word = array[i]
        local ls = string.slice(word, select(1, ...))
        array[i] = ls

        if select('#', ...) >= 2 then
            _split(ls, select(2, ...))
        else
            for j, u in ipairs(ls) do
                ls[j] = tonumber(u)
            end
        end

    end
end

function Tools.splitToNum(word, ...)
    local count = select('#', ...)
    if count <= 0 then
        return {}
    end
    local array = string.slice(word, select(1, ...))
    if select('#', ...) >= 2 then
        _split(array, select(2, ...))
    else
        for i, v in ipairs(array) do
            array[i] = tonumber(v)
        end
    end
    return array
end

function string.stripFileName(path)
    return string.match(path, ".+/([^/]*%.%w+)$")
end

function string.stripExtension(path)
    local idx = path:match(".+()%.%w+$")
    if idx then
        return path:sub(1, idx-1)
    else
        return path
    end
end

---这个方法会覆盖已有的方法会有问题
--function isNull(obj)
--    return obj == nil or (type(obj) == "table" and _G.next(obj) == nil) or obj == "" or obj == "nil" or obj == "0" or obj == 0
--end


function table.some(t, fn)
    for k, v in pairs(t) do
        if fn(v, k) == true then
            return true
        end
    end
    return false
end

function table.sum(tab)
    local sumNum = 0
    for _, var in ipairs(tab) do
        if type(var) == "number" then
            sumNum = sumNum + var
        end
    end
    return sumNum
end


function table.unit(...)
    local tab = {}
    for index = 1, select("#", ...) do
        local temp = select(index, ...)
        tab = table.insertTo(tab, temp)
    end
    return tab
end

--判断表中是否包含某元素，用法同sort
function table.isContain(table, element, conditionFunc)
    if table == nil then
        return false
    end
    if conditionFunc then
        for _, var in pairs(table) do
            if conditionFunc(var, element) == true then
                return true
            end
        end
    else
        for _, var in pairs(table) do
            if var == element then
                return true
            end
        end
    end
    return false
end

--冒泡排序
function table.sortBubble(nTable, sortFunc)
    local rTable = {}
    local isIn = false
    for _, var in ipairs(nTable) do
        isIn = false
        for index, var2 in ipairs(rTable) do
            if sortFunc(var, var2) == true then
                table.insert(rTable, index, var)
                isIn = true
                break
            end
        end
        if isIn == false then
            rTable[#rTable + 1] = var
        end
    end

    --为了要让参数的表改变顺序，不能直接覆盖，只能每个位置一次覆盖
    for key, var in ipairs(nTable) do
        nTable[key] = rTable[key]
    end

    return nTable
end

function table.inPlaceBubbleSort(arr, sortFunc)  
    -- body
    local tmp = 0
    for i=1,#arr-1 do
        for j=1,#arr-i do
            if not sortFunc(arr[j], arr[j+1]) then
                tmp = arr[j]
                arr[j] = arr[j+1]
                arr[j+1] = tmp
            end
        end
    end
    return arr
end  

function table.compare(table1, table2)
    -- body
    for k, v in table1 do
        if table2[k] then
            if type(v) == "table" then
                if table.compare(v, table2[k]) == false then
                    return false
                end
            else
                if table2[k] ~= v then
                    return false
                end
            end
        end
    end
    return true
end

function table.link(table1, table2)
    for i, v in ipairs(table2) do
        table.insert(table1, v)
    end
    return table1
end

function table.getKey(table, value)
    for k, v in pairs(table) do
        if value == v then
            return k
        end
    end
end

-- --加入数学四舍五入方法
-- function math.round(num)
--     return math.floor(num + 0.5)
-- end

--随机数工厂
function Tools.baRandFactory(nSeed)
    nSeed = tonumber(nSeed, 16)
    local seed = nSeed
    local jingdu = 64
    assert(nSeed >= 0 and nSeed < 2 ^ jingdu, "seed is out of bound,seed == " .. nSeed)
    --scope如果不传就是个0~1之间的小数，如果传了就是1~scope之间的整数，Min为最小数
    return function(scope, min)
        --@return typeOrObject
        min = min or 0
        seed = ((22695477 * seed + 1) % (2 ^ jingdu))
        if scope == nil then
            return (seed / (2 ^ jingdu))
        else
            assert(scope % 1 == 0 and min % 1 == 0, "scope and min need to be int scope == " .. scope .. " min == " .. min)
            -- assert(scope >= min, "scope is smaller than min scope == " .. scope .. " min == " .. min)
            return math.floor((seed / (2 ^ jingdu)) * scope - min + 1) + min
        end
    end
end

function table.toString(t, name, indent)
    if Config and not Config.DEBUG then
        ---如果不是debug状态
        return
    end
    local lookup_table = {}
    local level = 0
    local rep = string.rep
    local max_level = 5

    local function _dump(tb, level)
        local str = "\n" .. rep("\t", level) .. "{\n"
        for k, v in pairs(tb) do
            local k_is_str = type(k) == "string" and 1 or 0
            local v_is_str = type(v) == "string" and 1 or 0
            str = str .. rep("\t", level + 1) .. "[" .. rep("\"", k_is_str) .. (tostring(k) or type(k)) .. rep("\"", k_is_str) .. "]" .. " = "
            if type(v) == "table" then
                if not lookup_table[v] and ((not max_level) or level < max_level) then
                    lookup_table[v] = true
                    str = str .. _dump(v, level + 1) .. "\n"
                else
                    str = str .. (tostring(v) or type(v)) .. ",\n"
                end
            else
                str = str .. rep("\"", v_is_str) .. (tostring(v) or type(v)) .. rep("\"", v_is_str) .. ",\n"
            end
        end
        str = str .. rep("\t", level) .. "},"
        return str
    end

    return (name or "unknow") .. ":" .. (t and _dump(t, level) or "nil") 
end


local function tail(n, k)
    local u, r = "", 0
    for i = 1, k do
        n, r = math.floor(n / 0x40), n % 0x40
        u = string.char(r + 0x80) .. u
    end
    return u, n
end

function string.to_utf8(a)
    local n, r, u = tonumber(a)
    if n < 0x80 then
        -- 1 byte
        return string.char(n)
    elseif n < 0x800 then
        -- 2 byte
        u, n = tail(n, 1)
        return string.char(n + 0xc0) .. u
    elseif n < 0x10000 then
        -- 3 byte
        u, n = tail(n, 2)
        return string.char(n + 0xe0) .. u
    elseif n < 0x200000 then
        -- 4 byte
        u, n = tail(n, 3)
        return string.char(n + 0xf0) .. u
    elseif n < 0x4000000 then
        -- 5 byte
        u, n = tail(n, 4)
        return string.char(n + 0xf8) .. u
    else
        -- 6 byte
        u, n = tail(n, 5)
        return string.char(n + 0xfc) .. u
    end
end

return Tools
