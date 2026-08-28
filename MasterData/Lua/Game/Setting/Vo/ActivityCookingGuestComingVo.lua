---
--- 烹饪玩法 顾客出现表
--- Author: dawanfan
--- Date: 2024-3-15 13:59:51
---


local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class ActivityCookingGuestComingVo
local ActivityCookingGuestComingVo = Class("ActivityCookingGuesActivityCookingGuestComingVotVo", SettingRefBase)


function ActivityCookingGuestComingVo:__init()
    self.id = nil
    self.groupId = nil
    self.index = nil
    self.guestId = nil
    self.location = nil
    self.needFoods = nil
    self.survivalTime = nil
    self.addTime = nil
    self.appearTime = nil
end

---FillVo
---@param row TableML.TableFileRow
function ActivityCookingGuestComingVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.groupId = parse_number(row, "groupId")
    self.index = parse_number(row, "changeId")
    self.guestId = parse_number(row, "customerId")
    self.location = parse_number(row, "location")
    self.needFoods = parse_numbers(row, "needFood")
    self.survivalTime = parse_number(row, "survivalTime")
    self.addTime = parse_number(row, "addTime")
    self.appearTime = parse_number(row, "birthTime")
end

function ActivityCookingGuestComingVo:__delete()
    self.id = nil
    self.groupId = nil
    self.index = nil
    self.guestId = nil
    self.location = nil
    self.needFoods = nil
    self.survivalTime = nil
    self.addTime = nil
    self.appearTime = nil
end

return ActivityCookingGuestComingVo
