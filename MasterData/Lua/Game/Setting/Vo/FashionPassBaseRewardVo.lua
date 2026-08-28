

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class FashionPassBaseRewardVo
local FashionPassBaseRewardVo = Class("FashionPassBaseRewardVo", SettingRefBase)

function FashionPassBaseRewardVo:__init()
    self:CleanFields()
end

function FashionPassBaseRewardVo:__delete()
    self:CleanFields()
end

function FashionPassBaseRewardVo:CleanFields()
    self.id = nil
    self.ScheduleId = nil
    self.level = nil
    self.freeRewardId = nil
    self.freeRewardNum = nil
    self.status = nil

end

---FillVo
---@param row TableML.TableFileRow
function FashionPassBaseRewardVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, 'id') -- 序号ID  （1免费2付费000序号）
    self.scheduleId = parse_number(row, 'ScheduleId') -- 排期id
    self.level = parse_number(row, 'level') -- 奖励等级
    self.freeRewardId = parse_string(row, 'freeRewardId') -- 普通奖励ID
    self.freeRewardNum = parse_string(row, 'freeRewardNum') -- 普通奖励ID数量
    self.status = parse_number(row, 'status') -- 状态

    self.rewards = parse_rewards(self.freeRewardId, self.freeRewardNum)
end

return FashionPassBaseRewardVo
