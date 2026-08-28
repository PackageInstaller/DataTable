-------------------------------------------------------------------------------
-- 噩梦回响Pass卡 - 奖励表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 11:43:38
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class ChaoticRecallPassCardRewardVo : SettingRefBase @see AutoIds.IdSetting6402
local ChaoticRecallPassCardRewardVo = Class('ChaoticRecallPassCardRewardVo', SettingRefBase)


function ChaoticRecallPassCardRewardVo:__init()
    ---@type integer @ 唯一ID
    self.rewardId = nil

    ---@type integer @ Pass卡等级
    self.passLevel = nil

    ---@type integer @ 免费 领取ID
    self.freeDrawId = nil

    ---@type integer @ 付费 领取ID
    self.paidDrawId = nil

    ---@type table[] @ 免费 奖励列表
    self.freeRewards = {}

    ---@type table[] @ 免费 奖励列表
    self.paidRewards = {}
end


function ChaoticRecallPassCardRewardVo:__delete()
    self.rewardId    = nil
    self.passLevel   = nil
    self.freeDrawId  = nil
    self.paidDrawId  = nil
    self.freeRewards = nil
    self.paidRewards = nil
end


---@param row TableML.TableFileRow
function ChaoticRecallPassCardRewardVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.rewardId    = parse_number(row, 'id')
    self.passLevel   = parse_number(row, 'PassLv')
    self.freeDrawId  = parse_number(row, 'id1')
    self.paidDrawId  = parse_number(row, 'id2')
    self.freeRewards = parse_rewardData(row, 'freeRewardId', 'freeRewardNum')
    self.paidRewards = parse_rewardData(row, 'PayRewardId', 'PayRewardNum')
end


return ChaoticRecallPassCardRewardVo
