---
--- 烹饪玩法 排行榜奖励表
--- Author: dawanfan
--- Date: 2024-3-15 14:23:04
---


local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingRankVo
local ActivityCookingRankVo = Class("ActivityCookingRankVo", SettingRefBase)


function ActivityCookingRankVo:__init()
    self.id = nil
    self.activityId = nil
    self.upperLimit = nil
    self.lowerLimit = nil
    self.name = nil
    self.type = nil
    self.reward = nil
    self.rewardNum = nil
    self.mailID = nil
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingRankVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.activityId = parse_number(row, "activityId")
    self.upperLimit = parse_number(row, "upperLimit")
    self.lowerLimit = parse_number(row, "lowerLimit")
    self.name = ParseUtils.ParseLocalizeText(row, "name")
    self.type = parse_number(row, "type")
    self.reward = parse_numbers(row, "reward")
    self.rewardNum = parse_numbers(row, "rewardNum")
    self.mailID = parse_number(row, "mailID")
end

function ActivityCookingRankVo:__delete()
    self.id = nil
    self.activityId = nil
    self.upperLimit = nil
    self.lowerLimit = nil
    self.name = nil
    self.type = nil
    self.reward = nil
    self.rewardNum = nil
    self.mailID = nil
end

return ActivityCookingRankVo
