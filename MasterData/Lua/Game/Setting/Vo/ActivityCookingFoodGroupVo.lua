---
--- 烹饪玩法食物组表
--- Author: dawanfan
--- Date: 2024-3-13 18:13:49
---

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingFoodGroupVo
local ActivityCookingFoodGroupVo = Class("ActivityCookingFoodGroupVo", SettingRefBase)


function ActivityCookingFoodGroupVo:__init()
    self.id = nil             -- 食物Id
    self.foodIds = nil
    self.ingredientsId = nil
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingFoodGroupVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.foodIds = parse_numbers(row, "foodIds")
    self.ingredientsId = parse_numbers(row, "ingredientsId")
end

function ActivityCookingFoodGroupVo:__delete()
    self.id = nil
    self.foodIds = nil
    self.ingredientsId = nil
end

return ActivityCookingFoodGroupVo
