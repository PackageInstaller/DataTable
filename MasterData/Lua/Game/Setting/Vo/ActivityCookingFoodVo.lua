---
--- 烹饪玩法食物表
--- Author: dawanfan
--- Date: 2024-3-12 19:30:21
---

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingFoodVo
local ActivityCookingFoodVo = Class("ActivityCookingFoodVo", SettingRefBase)


function ActivityCookingFoodVo:__init()
    self.id = nil             -- 食物Id
    self.name = nil
    self.ingredientsId = nil
    self.icon = nil
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingFoodVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.name = ParseUtils.ParseLocalizeText(row, "name")
    self.ingredientsId = parse_numbers(row, "ingredientsId")
    local icons = parse_strings(parse_string(row, "icon"))

    self.icon = {}
    for _, icon in pairs(icons) do
        if not string.isEmpty(icon) then
            local iconDict = parse_strings(icon, ":")
            table.insert(self.icon, CS.GameUtils.GetCombineResourceDirPath(tonumber(iconDict[1]), iconDict[2]))
        end
    end
    
end

function ActivityCookingFoodVo:__delete()
    self.id = nil
    self.name = nil
    self.ingredientsId = nil
    self.icon = nil
end

return ActivityCookingFoodVo
