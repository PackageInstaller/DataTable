---
--- 烹饪玩法配置表
--- Author: dawanfan
--- Date: 2024-3-12 19:42:39
---

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingConfigVo
local ActivityCookingConfigVo = Class("ActivityCookingConfigVo", SettingRefBase)


function ActivityCookingConfigVo:__init()
    self.id = nil
    self.changeId = nil
    self.useNode = nil
    self.infiniteDes = nil
    self.energyId = nil
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingConfigVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.changeId = parse_number(row, "changeId")
    self.useNode = parse_numbers(row, "useNode")
    self.infiniteDes = ParseUtils.ParseLocalizeText(row, "infiniteDes")
    self.energyId = parse_number(row, "energyId")
end

function ActivityCookingConfigVo:__delete()
    self.id = nil
    self.changeId = nil
    self.useNode = nil
    self.infiniteDes = nil
    self.energyId = nil
end

return ActivityCookingConfigVo
