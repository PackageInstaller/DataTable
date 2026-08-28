---
--- 烹饪活动参数表
--- Author: dawanfan
--- Date: 2024-4-18 15:18:54
---


local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingParameterVo
local ActivityCookingParameterVo = Class("ActivityCookingParameterVo", SettingRefBase)

---__int
function ActivityCookingParameterVo:__init()
    self.id = nil              --状态ID
    self.name = nil              --参数名称
    self.num = nil              --数量
    self.status = nil              --状态
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingParameterVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.name = ParseUtils.ParseLocalizeText(row, "name")
    self.num = parse_string(row, "num")
    self.status = parse_number(row, "status")
end

function ActivityCookingParameterVo:__delete()
    self.id = nil
    self.name = nil
    self.num = nil
    self.status = nil
end

return ActivityCookingParameterVo
