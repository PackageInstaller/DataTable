
local getinfo, error, rawset, rawget = debug.getinfo, error, rawset, rawget
-- if true then
--     return
-- end

-- 函数内全局变量赋值会报错，除非通过G.Declare(...)声明过哪些全局变量可以在函数内赋值

-- 不能写在设metatable的后面，否则会触发__index的无限循环，rawget里的第一个参数还会触发__index
local _g = {}
local G
if ngx then
    _G.G = _g
    G = _g
else
    _G.G = _g
    G = _g
end

local _mt = {}
local _defineScope

_mt.__declared = {decoda_name = true}

_mt.__newindex = function (t, n, v)
    if not _mt.__declared[n] then
        local info = getinfo(2, "S")

        if info and info.linedefined > 0 then -- if info.what ~= "main" and info.what ~= "C" then -- 
            error("Check Failed: assign to undeclared variable '"..n.."'", 2)
        end
        _mt.__declared[n] = true
    end

    -- print("_defineScope", _defineScope, n, v)
    if _defineScope then
        t[_defineScope][n] = v
    else
        rawset(t, n, v)
    end

    -- rawset(t, n, v)
end

_mt.__index = function (t, n)
    if not _mt.__declared[n] then -- if not _mt.__declared[n] and debug.getinfo(2, "S").what ~= "C" then -- 
        local info = getinfo(2, "S")
        if info and info.linedefined > 0 then
            error("Check Failed: variable '"..n.."' is not declared", 2)
        end
    end
    return rawget(t, n)
end

setmetatable(_G, _mt)

function _g.Declare(...)
    for _, v in ipairs{...} do _mt.__declared[v] = true end
end

function _g.unDeclare(...)
    for _, v in ipairs{...} do _mt.__declared[v] = nil end
end

function G.AddEnums(t)
    for k,v in pairs(t) do
        GE[k] = v
    end
end

function G.AddFuncs(t)
    for k,v in pairs(t) do
        GF[k] = v
    end
end

function G.AddVars(t)
    for k,v in pairs(t) do
        GV[k] = v
    end
end

local function beginDefine(scopeStr)
    print("beginDefine", scopeStr)
    if _defineScope then
        error("Last Define not end:" .. _defineScope)
    end

    _defineScope = scopeStr
end

function G.BeginDefineEnum()
    beginDefine("GE")
end

function G.BeginDefineFunc()
    beginDefine("GF")
end

function G.BeginDefineVar()
    beginDefine("GV")
end

function G.EndDefine()
    print("EndDefine", _defineScope)
    _defineScope = nil
end

-- 全局枚举
GE = {
}
-- setmetatable in class.lua 

-- 全局变量
GV = {
    EnumStr = {},
}

-- 全局函数
GF = {

}


----------------------------------------------------------------
-- 快速找到全局变量在哪里定义过
-- setmetatable(_G, {
--     __newindex = function (t, k, v)
--         if k == "WantedKey" then
--          local info = debugx.getCallThisInfo()
--          print(info.callline, info.source, info.name)
--         end
--         rawset(t, k, v)
--     end
-- })
-- WantedKey = 56

----------------------------------------------------------------
-- 快速找到table的变量在哪里定义过
-- t = {}
-- setmetatable(t, {
--  __newindex = function (t, k, v)
--      local info = debugx.getCallThisInfo()
--      print(info.callline, info.source, info.name)
--  end
-- })
-- t.assign = 5


----------------------------------------------------------------
-- 以下代码使得定义全局变量必须用cc._global
-- local _g = _G
-- print(_g)
-- local cc = {}
-- cc._global = {}
-- setmetatable(cc._global, 
--     { 
--         __newindex = function(_, k, v)
--             rawset(_g, k, v)
--         end;
--         __index = function(t, k, v)
--             --这个方法必须写,不然不能用cc.global.xx来访问
--             return rawget(_g, k)
--         end; 
--     }
-- )
-- setmetatable(_g, { __newindex = function(_, k, v)
--     local msg = "you are trying to new a index,please using table cc._global to new,thanks"
--     error(string.format(msg), 0)
-- end; })--a = 1

--打印错误msgcc._global.a = 1print(a) --1print(cc._global.a)--1
