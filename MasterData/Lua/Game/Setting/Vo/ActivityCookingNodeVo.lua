---
--- 烹饪玩法食物表
--- Author: dawanfan
--- Date: 2024-3-12 19:21:53
---

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingNodeVo
local ActivityCookingNodeVo = Class("ActivityCookingNodeVo", SettingRefBase)

---__int
function ActivityCookingNodeVo:__init()
    self.id = nil              --节点Id
    self.kitchenwareId = nil
    self.foodGroupId = nil
    self.foodId = nil
    self.isCookedByIngredients = nil
    self.foodProcessable = nil
    self.isOneMachineToOneFood = nil
    self.autoIdleIfFinish = nil
    self.autoCooking = nil
    self.droppable = nil
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingNodeVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.kitchenwareId = parse_number(row, "kitchenwareId")
    self.foodGroupId = parse_number(row, "foodGroupId")
    self.foodId = parse_number(row, "foodId")
    self.isCookedByIngredients = (parse_number(row, "isCookedByIngredients") == 1)
    self.foodProcessable = (parse_number(row, "foodProcessable") == 1)
    self.isOneMachineToOneFood = (parse_number(row, "isOneMachineToOneFood") == 1)
    self.autoIdleIfFinish = (parse_number(row, "autoIdleIfFinish") == 1)
    self.autoCooking = (parse_number(row, "autoCooking") == 1)
    self.droppable = (parse_number(row, "isDisposable") == 1)
end

function ActivityCookingNodeVo:__delete()
    self.id = nil
    self.kitchenwareId = nil
    self.foodGroupId = nil
    self.foodId = nil
    self.isCookedByIngredients = nil
    self.foodProcessable = nil
    self.isOneMachineToOneFood = nil
    self.autoIdleIfFinish = nil
    self.autoCooking = nil
    self.droppable = nil
end

return ActivityCookingNodeVo
