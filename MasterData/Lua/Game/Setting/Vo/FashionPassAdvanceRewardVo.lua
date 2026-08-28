

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class FashionPassAdvanceRewardVo
local FashionPassAdvanceRewardVo = Class("FashionPassAdvanceRewardVo", SettingRefBase)

function FashionPassAdvanceRewardVo:__init()
    self:CleanFields()
end

function FashionPassAdvanceRewardVo:__delete()
    self:CleanFields()
end

function FashionPassAdvanceRewardVo:CleanFields()
    self.id = nil
    self.ScheduleId = nil
    self.level = nil
    self.PayRewardId = nil
    self.PayRewardNum = nil
    self.status = nil

end

---FillVo
---@param row TableML.TableFileRow
function FashionPassAdvanceRewardVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, 'id') -- 序号ID
    self.scheduleId = parse_number(row, 'ScheduleId') -- 排期id
    self.level = parse_number(row, 'level') -- 奖励等级
    self.PayRewardId = parse_string(row, 'PayRewardId') -- 付费奖励ID
    self.PayRewardNum = parse_string(row, 'PayRewardNum') -- 付费奖励ID数量
    self.status = parse_number(row, 'status') -- 状态

    self.rewards = parse_rewards(self.PayRewardId, self.PayRewardNum)
end

return FashionPassAdvanceRewardVo
