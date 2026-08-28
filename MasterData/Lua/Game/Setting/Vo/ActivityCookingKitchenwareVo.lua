---
--- 烹饪玩法厨具表
--- Author: dawanfan
--- Date: 2024-3-12 19:30:21
---

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingKitchenwareVo
local ActivityCookingKitchenwareVo = Class("ActivityCookingKitchenwareVo", SettingRefBase)


function ActivityCookingKitchenwareVo:__init()
    self.id = nil             -- 食物Id
    self.name = nil
    self.startLevel = nil
    self.maxLevel = nil
    self.icon = nil
    self.des = nil
    self.des2 = nil
    self.levelupConsumeItem = nil
    self.levelupConsume = nil
    self.processingTime = nil
    self.burntTime = nil
    self.kitchenwareNum = nil
    self.unlockLevel = nil
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingKitchenwareVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.name = ParseUtils.ParseLocalizeText(row, "name")
    self.startLevel = parse_number(row, "startLevel")
    self.maxLevel = parse_number(row, "maxLevel")
    self.icon = parse_strings(parse_string(row, "icon"))
    self.des = ParseUtils.ParseLocalizeText(row, "des")
    self.des2 = ParseUtils.ParseLocalizeText(row, "des2")
    self.levelupConsumeItem = parse_numbers(row, "levelupConsumeItem")
    self.levelupConsume = parse_numbers(row, "levelupConsume")
    self.processingTime = parse_numbers(row, "processingTime")
    self.burntTime = parse_number(row, "burntTime")
    self.kitchenwareNum = parse_numbers(row, "kitchenwareNum")
    self.unlockLevel = parse_number(row, "unlockLevel")
end

function ActivityCookingKitchenwareVo:__delete()
    self.id = nil
    self.name = nil
    self.startLevel = nil
    self.maxLevel = nil
    self.icon = nil
    self.des = nil
    self.des2 = nil
    self.levelupConsumeItem = nil
    self.levelupConsume = nil
    self.processingTime = nil
    self.burntTime = nil
    self.kitchenwareNum = nil
    self.unlockLevel = nil
end

return ActivityCookingKitchenwareVo
