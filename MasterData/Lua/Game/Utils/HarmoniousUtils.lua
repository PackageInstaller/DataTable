
---@type IdolLive3D_Utils
local IdolLive3D_Utils = import('Game.IdolLive3D.IdolLive3D_Utils')
local support = require 'Frame.support'
local try_get_value = support.try_get_value

local strFormat = string.format
local parse_string = parse_string
local parse_pathNameByData = parse_pathNameByData

---@class HarmoniousUtils
local HarmoniousUtils = {}

local IsThisSkinInHeXieMode = IdolLive3D_Utils.IsThisSkinInHeXieMode

local StringTable

local function CheckHarmoniousPath(resourceName, customPath)
    StringTable = StringTable or {"", "_hexie"}
    StringTable[1] =  string.gsub(resourceName, "_hexie", "")

    local newResourceName = table.concat(StringTable)

    local resPath

    if customPath then
        resPath = strFormat(customPath, newResourceName)
    else
        resPath   = parse_pathNameByData(newResourceName)
    end

    return CfUtils.IsBundleResourceExist(resPath), resPath, newResourceName
end

local function ReplaceTableRowValue(row, fieldName, newResourceName)
    local HeaderInfos = row.HeaderInfos
    local info = try_get_value(HeaderInfos, fieldName)
    row[info.ColumnIndex] = newResourceName
end

---和谐资源路径
---@param row TableML.TableFileRow
---@param fieldName string
---@param skinId number 皮肤id
---@return string 资源路径
local function HarmoniousPath(row, fieldName, skinId)
    local resourceName = parse_string(row, fieldName)
    if not IsThisSkinInHeXieMode(skinId) then 
        return parse_pathNameByData(resourceName)
    end

    local isExist, resPath, newResourceName = CheckHarmoniousPath(resourceName)
    if not isExist then
        return parse_pathNameByData(resourceName)
    end

    ReplaceTableRowValue(row, fieldName, newResourceName)
    
    return resPath

end

---和谐资源名称
---@param row TableML.TableFileRow
---@param fieldName string
---@param skinId number 皮肤id
---@param customPath string 自定义路径
---@return string 资源路径
local function HarmoniousName(row, fieldName, skinId, customPath)
    local resourceName = parse_string(row, fieldName)
    if not IsThisSkinInHeXieMode(skinId) then 
        return resourceName
    end

    local isExits, resPath, newResourceName = CheckHarmoniousPath(resourceName, customPath)
    if not isExits then
        return resourceName
    end

    ReplaceTableRowValue(row, fieldName, newResourceName)
    
    return newResourceName
end

local function GetHarmoniousName(resourceName, customPath)
    resourceName = string.gsub(resourceName, "_hexie", "")
    local isExits, _, newResourceName = CheckHarmoniousPath(resourceName, customPath)
    if not isExits then
        return resourceName
    end
    return newResourceName
end

HarmoniousUtils.HarmoniousPath = HarmoniousPath
HarmoniousUtils.HarmoniousName = HarmoniousName
HarmoniousUtils.GetHarmoniousName = GetHarmoniousName

return HarmoniousUtils