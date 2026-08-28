---
--- 烹饪玩法食材表
--- Author: dawanfan
--- Date: 2024-3-12 19:21:53
---

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingIngredientsVo
local ActivityCookingIngredientsVo = Class("ActivityCookingIngredientsVo", SettingRefBase)


function ActivityCookingIngredientsVo:__init()
    self.id = nil             -- 食材Id
    self.name = nil
    self.startLevel = nil
    self.maxLevel = nil
    self.icon = nil
    self.des = nil
    self.des2 = nil
    self.levelupConsumeItem = nil
    self.levelupConsume = nil
    self.price = nil
    self.unlockLevel = nil
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingIngredientsVo:FillVo(row)
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
    self.price = parse_numbers(row, "price")
    self.unlockLevel = parse_number(row, "unlockLevel")
end

function ActivityCookingIngredientsVo:__delete()
    self.id = nil
    self.name = nil
    self.startLevel = nil
    self.maxLevel = nil
    self.icon = nil
    self.des = nil
    self.des2 = nil
    self.levelupConsumeItem = nil
    self.levelupConsume = nil
    self.price = nil
    self.unlockLevel = nil
end

return ActivityCookingIngredientsVo
