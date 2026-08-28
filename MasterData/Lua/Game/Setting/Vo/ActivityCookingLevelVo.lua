---
--- 烹饪玩法 关卡表
--- Author: dawanfan
--- Date: 2024-3-15 14:23:04
---


local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingLevelVo
local ActivityCookingLevelVo = Class("ActivityCookingLevelVo", SettingRefBase)


function ActivityCookingLevelVo:__init()
    self.id = nil
    self.name = nil
    self.cookingActivityId = nil
    self.type = nil
    self.groupId = nil
    self.unlockStarNum = nil
    self.preId = nil
    self.levelDuration = nil
    self.ratingCondition = nil
    self.ratingParam = nil
    self.des = nil
    self.guidePic = nil
    self.costItem = nil
    self.costNum = nil
    self.failingCondition = nil
    self.rewardItem1 = nil
    self.num1 = nil
    self.rewardItem2 = nil
    self.num2 = nil
    self.rewardItem3= nil
    self.num3 = nil
    self.useTrash = nil
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingLevelVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.name = ParseUtils.ParseLocalizeText(row, "name")
    self.cookingActivityId = parse_number(row, "cookingActivityId")
    self.type = parse_number(row, "type")
    self.groupId = parse_number(row, "groupId")
    self.unlockStarNum = parse_number(row, "unlockStarNum")
    self.preId = parse_number(row, "preId")
    self.levelDuration = parse_number(row, "levelDuration")
    self.ratingCondition = parse_number(row, "ratingCondition")
    self.ratingParam = parse_numbers(row, "ratingPara")
    self.des = ParseUtils.ParseLocalizeText(row, "des")
    self.guidePic = parse_number(row, "guidePic")
    self.costItem = parse_number(row, "costItem")
    self.costNum = parse_number(row, "costNum")
    self.failingCondition = parse_numbers(row, "failingCondition")
    self.rewardItem1 = parse_numbers(row, "awardItem1")
    self.num1 = parse_numbers(row, "num1")
    self.rewardItem2 = parse_numbers(row, "awardItem2")
    self.num2 = parse_numbers(row, "num2")
    self.rewardItem3= parse_numbers(row, "awardItem3")
    self.num3 = parse_numbers(row, "num3")
    self.useTrash = (parse_number(row, "trashCan") == 1)
end

function ActivityCookingLevelVo:__delete()
    self.id = nil
    self.name = nil
    self.cookingActivityId = nil
    self.type = nil
    self.groupId = nil
    self.unlockStarNum = nil
    self.preId = nil
    self.levelDuration = nil
    self.ratingCondition = nil
    self.ratingParam = nil
    self.des = nil
    self.costItem = nil
    self.costNum = nil
    self.failingCondition = nil
    self.rewardItem1 = nil
    self.num1 = nil
    self.rewardItem2 = nil
    self.num2 = nil
    self.rewardItem3= nil
    self.num3 = nil
    self.useTrash = nil
end

return ActivityCookingLevelVo
