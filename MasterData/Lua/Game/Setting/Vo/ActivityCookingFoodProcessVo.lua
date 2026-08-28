---
--- 烹饪玩法食物加工表
--- Author: dawanfan
--- Date: 2024-3-13 19:21:57
---

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingFoodProcessVo
local ActivityCookingFoodProcessVo = Class("ActivityCookingFoodProcessVo", SettingRefBase)


function ActivityCookingFoodProcessVo:__init()
    self.id = nil             -- 食物组Id
    self.foodId = nil
    self.ingredientsId = nil
    self.targetFoodId = nil
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingFoodProcessVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.foodId = parse_number(row, "foodId")
    self.ingredientsId = parse_number(row, "ingredientsId")
    self.targetFoodId = parse_number(row, "targetFoodId")
end

function ActivityCookingFoodProcessVo:__delete()
    self.id = nil
    self.foodId = nil
    self.ingredientsId = nil
    self.targetFoodId = nil
end

return ActivityCookingFoodProcessVo
