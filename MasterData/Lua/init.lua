local luaModule = CS.Engine.Modules.LuaModule
local I18NModule = CS.Engine.I18N.I18NModule
local KTool = CS.Engine.Lib.KTool
local ParseUtils = CS.ParseUtils
local LuaBehaviour = CS.Engine.Modules.LuaBehaviour
local DateTime = CS.System.DateTime
local package = package

--重新require一个lua文件，替代系统文件。
function reimport(name)
    package.loaded[name] = nil
    package.preload[name] = nil
    local env = (_G or _ENV)
    env[name] = nil
    luaModule.Instance:ClearCache(name)
    return import(name)
end

--[[
--清除模块
--]]
function unrequire(m)
    package.loaded[m] = nil
    package.preload[m] = nil
    local env = (_G or _ENV)
    env[m] = nil
end

function unimport(name)
    unrequire(name)
    luaModule.Instance:ClearCache(name)
end

import("Frame.init")

---GetTargetLuaScript ALT+Enter快捷键生成
---获取指定对象身上的对象路径的lua脚本
---@param go UnityEngine.GameObject
---@param luaPath string
---@return UnityEngine.Component | nil
function GetLuaBehaviour(go, luaPath)
    local component = KTool.GetComponent(go, typeof(LuaBehaviour))
    if not isNull(component) and component.LuaPath == luaPath then
        if isNull(component.Env) then
            component:Init()
        end
        return component
    end
    return nil
end

---AttackLuaBehaviour
---@param go UnityEngine.GameObject
---@param luaPath string
---@return Engine.Modules.LuaBehaviour @ lua脚本对象
function AddLuaBehaviour(go, luaPath)
    if not KTool.IsNull(go) then
        return go:AddLuaComponent(luaPath)
    end
end


--- 格式化字符串方法的扩展和封装。
--- [用法1] format 后面跟一个 hashMap。会以后面的tabel的key查找format，替换成对应的value。
---
--- 例子1：string.fmt('_name_ get a _goods_', {['_name_'] = 'test', ['_goods_'] = 'apple'})
--- 结果1：test get a apple
---
--- 例子2：string.fmt('pi is _value_', { ['_value_'] = {'%0.4f', 3.1415926} })
--- 结果2：pi is 3.1416
---
--- [用法2] 按照format中使用 %+数字 的方式，依次替换为对应位置的参数。
---
--- 例子1：string.fmt('%1 %2 (%3s-%4s)', 'xxx', 'life', 1950, 1970)
--- 结果1：xxx life (1950-1970)
---
--- 例子2：string.fmt('current time %1:%2', {'%02d', 2}, {'%02d', 34})
--- 结果2：current time 02:34
---
---@param format string
---@vararg any
---@return string
local function fmt(format, ...)
    local argsNum = select("#", ...)
    local result  = tostring(format)

    -- 以hashMap结构，自定义key替换value
    if argsNum == 1 and type(select(1, ...)) == 'table' then
        for k,v in pairs(select(1, ...)) do
            local vstr = tostring(v)
            if type(v) == 'table' then
                vstr = string.format(tostring(v[1]), tostring(v[2]))
            else
                vstr = string.gsub(vstr, '%%', '%%%%')
            end
            result = (string.gsub(result, tostring(k), vstr))
        end

    -- 以 %1 开始，按照参数顺序替换
    elseif argsNum > 0 then
        local argsMap = {}
        for i,v in ipairs({...}) do
            local vstr = tostring(v)
            if type(v) == 'table' then
                vstr = string.format(tostring(v[1]), tostring(v[2]))
            end
            argsMap['%'..i] = vstr
        end
        result = (string.gsub(tostring(format), '%%[0-9]+', argsMap))
    end
    return result
end
local NEW_LINE = "_NEW_LINE_"
---localize
---[用法1] format 后面跟一个 hashMap。会以后面的tabel的key查找format，替换成对应的value。
---fmt('_name_ get a _goods_', {['_name_'] = 'test', ['_goods_'] = 'apple'})
---结果1：test get a apple
---需要国际化的字符串
---@param format string @需要国际化的字符串 '_name_ get a _goods_'
---@vararg table 可变参数
---@return string
function localize(format, ...)
    if Config.DEBUG then
        if string.contains(format, "¥") then
            assert(string.contains("¥"), "string don't contains ¥" ) 
        end
    end
    format = string.gsub(format, "\n", NEW_LINE)
    format = string.gsub(format, "\\n", NEW_LINE)
    format = I18NModule.StrLua(format)
    --format = string.gsub(format, "\\n", "\n")
    local text = fmt(format, ...)
    return text
end

---localizeText
---TableFileRow 某字段国际化
---@param row TableML.TableFileRow
---@param headerName string
---@param defaultStr string
---@return string
function ParseLocalizeText(row, headerName, defaultStr)
    return ParseUtils.ParseLocalizeText(row, headerName, defaultStr)
end

---格式化数值 例：1000 to 1k
---@param num number
---@return string
function FormatCurrencyNum(num)
    num = checkNumber(num)
    local symbol = num < 0 and -1 or 1
    if num == 0 then return "0" end
    --- 小于999999 直接返回
    if num <= 999999 then return tostring(math.floor(num)) end
    local i, units = 1, {"", "K", "M", "G", "T", "P", "E", "Y"}
    local absNum = math.abs(num)
    while absNum >= 1000 do
        absNum = absNum / 1000
        i = i + 1
    end
    local unit = units[ i ] or "?"
    local fStr = "%0.1f"
    local value = string.format(fStr, absNum * symbol)
    local strList = string.split2(value, '.')
    local decimal = checkInt(strList[2])
    if decimal == 0 then
        value = strList[1]
    end
    return value .. unit
end

--- 获取毫秒时间
---@return number
function GetTimeByMillisecond()
    return (DateTime.Now:ToUniversalTime().Ticks - 621355968000000000) / 10000000
end

string.fmt = fmt

--ECSWorldMgr = import 'Frame.ECS.ECSWorldMgr'
--local ecsWorld = ECSWorldMgr:GetInstance():GetWorld("GameWorld")
--if not isNull(ecsWorld) then
--    ECSWorldMgr:GetInstance():DestroyWorld(ecsWorld)
--
--end
--ECSWorldMgr:GetInstance():Initial(200)
--ecsWorld = ECSWorldMgr:GetInstance():CreateWorld("GameWorld")
--ecsWorld:IsClient(true)
--ecsWorld:CreateEntity(100002,100002)
--
--DEBUG = 2
--printInfo(table.dump(ecsWorld))