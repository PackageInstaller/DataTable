local ConfigHelper = {}
local files = require("Config.ConfigRequire")

local _allConfigNames = {}
for i, fileName in ipairs(files) do
    _allConfigNames[fileName] = "Config.Data." .. fileName
end

local _allConfigs = {}
local _allConfigTitle = {}
-- for i, fileName in ipairs(files) do
--     _allConfigs[fileName] = require("Config.Data." .. fileName)
-- end
local _cs_ConfigHelper = CS.GameX.Config.ConfigHelper

--元表，当查找不到的时候，则查找元表对应的方法
local _cs_propertyChecker = {}
_cs_propertyChecker.__index = function(t, k)
    return _cs_ConfigHelper[k]
end

setmetatable(ConfigHelper, _cs_propertyChecker)

function ConfigHelper.GetCfgs(fileName)
    return ConfigHelper.GetCfgsByLua(fileName)
end

function ConfigHelper.CheckConfig(fileName)
    if _allConfigNames[fileName] and _allConfigs[fileName] == nil and _allConfigNames[fileName] ~= nil then
        local v = require(_allConfigNames[fileName])
        if v.title ~= nil  then
            _allConfigs[fileName] = v.value
            _allConfigTitle[fileName] = v.title
            ConfigHelper.SetItemMeta(_allConfigs[fileName],fileName)
        else
            _allConfigs[fileName] = v
        end
    end
end

function ConfigHelper.GetCfgsByLua(fileName, checkHandler)
    ConfigHelper._checkHandler = checkHandler
    --使用的时候才会require
    ConfigHelper.CheckConfig(fileName)
    if _allConfigs[fileName] then
        if checkHandler then
            local rtnList = {}
            local list = _allConfigs[fileName]
            for index, value in pairs(list) do
                -- body
                if ConfigHelper.CheckFun(value) then
                    table.insert(rtnList, value)
                end
            end
            ConfigHelper._checkHandler = nil
            return rtnList
        end
        return _allConfigs[fileName]
    end
    local list = _cs_ConfigHelper.GetCfgsByLua(fileName, ConfigHelper.CheckFun)
    ConfigHelper._checkHandler = nil
    return list
end

function ConfigHelper.CheckFun(cfg)
    local h = ConfigHelper._checkHandler
    if type(h) == "function" then
        return h(cfg)
    elseif type(h) == "table" then
        for key, value in pairs(h) do
            -- body
            if cfg[key] ~= value then
                return false
            end
        end
    end
    return true
end

function ConfigHelper.GetCfg(fileName, id)
    return ConfigHelper.GetCfgByLua(fileName, id)
end

local allMeata = {}

-- allMeata["tableName"] =  
-- {
--     tbName="tableName",
--     __index=function(k)
--         return allTitleTable[tbName][k]
--     end
-- }

function ConfigHelper.SetItemMeta(itemTable,tableName)
    if not allMeata[tableName] then 
        allMeata[tableName] = {tbName=tableName,__index=function(t,key)
            local titleTable = _allConfigTitle[tableName]
            return titleTable[key]
        end}

        for key, value in pairs(itemTable) do
            setmetatable(value,allMeata[tableName])
        end
    end
end

function ConfigHelper.GetCfgByLua(fileName, id)
    --使用的时候才会require
    ConfigHelper.CheckConfig(fileName)
    if _allConfigs[fileName] then
        local arr =  _allConfigs[fileName]
        for index, c in pairs(arr) do
            -- body
            if c.id and c.id == id then 
                if getmetatable(c) == nil then 
                    setmetatable(c,allMeata[fileName] )
                end
                return c 
            end
        end
        return nil 
        --return _allConfigs[fileName][id]
    end
    return _cs_ConfigHelper.GetCfgByLua(fileName, id)
end

function ConfigHelper.GetCfgPropByLua(fileName, id, prop)
    local conf =  ConfigHelper.GetCfgByLua(fileName,id)
    if conf==nil then
        return 
    end
    return conf[prop]
end

function ConfigHelper.GetLocalString(id)
    return _cs_ConfigHelper.GetLocalString(id)
end

function ConfigHelper.GetSystemParam(id)
    return _cs_ConfigHelper.GetSystemParam(id)
end

function ConfigHelper.GetSystemParams(id)
    return _cs_ConfigHelper.GetSystemParams(id)
end

function ConfigHelper.GetLocalStringByPlayerName(id)
    return _cs_ConfigHelper.GetLocalStringByPlayerName(id)
end

function ConfigHelper.ShowCustomerService()
    local packageInfo = _cs_ConfigHelper.GetPackageInfo()
    if IsNull(packageInfo ) then 
        return false 
    end
    return packageInfo.showCustomerService
end

function ConfigHelper.CheckBlockWord(context)
    return _cs_ConfigHelper.CheckBlockWord(context)
end

function ConfigHelper.GetHeroName(heroId)
    local nameId = ConfigHelper.GetCfgPropByLua("hero", heroId, "name")
    if nameId then
        return ConfigHelper.GetLocalString(nameId)
    end
end

return ConfigHelper
