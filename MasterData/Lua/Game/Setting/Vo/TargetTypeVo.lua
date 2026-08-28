--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:luqucheng
    time:2019-10-23 14:18:16
]]
local SettingRefBase = require('Game.Setting.SettingRefBase')

---@class TargetTypeVo
local TargetTypeVo = Class("TargetTypeVo", SettingRefBase)
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---__int
function TargetTypeVo:__init()
    self.camp = nil
    self.conditionId = nil
    self.conditionNum = nil
end


---FillVo
---@param row TableML.TableFileRow
function TargetTypeVo:FillVo(row)
    base.FillVo(self,row)
    self.camp = parse_number(row, "camp", 0)
    self.conditionId = parse_number(row, "conditionId", 0)
    self.conditionNum = Tools.splitToNum(parse_string(row,"conditionNum", ''), ';')
end

function TargetTypeVo:__delete()
    self.camp = nil
    self.conditionId = nil
    self.conditionNum = nil
end

return TargetTypeVo