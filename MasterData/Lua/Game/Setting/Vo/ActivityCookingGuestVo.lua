---
--- 烹饪玩法 顾客表
--- Author: dawanfan
--- Date: 2024-3-15 13:59:51
---


local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingGuestVo
local ActivityCookingGuestVo = Class("ActivityCookingGuestVo", SettingRefBase)


function ActivityCookingGuestVo:__init()
    self.id = nil             -- 顾客Id
    self.name = nil
    self.image = nil
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingGuestVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.name = ParseUtils.ParseLocalizeText(row, "name")
    self.image = ParseUtils.ParsePathName(row, "halfLiHui")
end

function ActivityCookingGuestVo:__delete()
    self.id = nil
    self.name = nil
    self.image = nil
end

return ActivityCookingGuestVo
