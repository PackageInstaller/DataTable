-------------------------------------------------------------------------------
-- Pass卡 - 奖励表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 11:43:38
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PassCardRewardVo : SettingRefBase @see AutoIds.IdSetting4051
local PassCardRewardVo = Class('PassCardRewardVo', SettingRefBase)


function PassCardRewardVo:__init()
    ---@type integer @ 唯一ID
    self.rewardId = nil

    ---@type integer @ 普通领取ID
    self.freeDrawId = nil

    ---@type integer @ 标准领取ID
    self.normalDrawId = nil

    ---@type integer @ 豪华领取ID
    self.deluxeDrawId = nil

    ---@type integer @ 排期ID
    self.scheduleId = nil

    ---@type integer @ Pass卡等级
    self.passLevel = nil

    ---@type integer @ 普通道具ID
    self.freeGoodsId = nil

    ---@type integer @ 普通道具数量
    self.freeGoodsNum = nil

    ---@type integer @ 标准道具ID
    self.normalGoodsId = nil

    ---@type integer @ 标准道具数量
    self.normalGoodsNum = nil

    ---@type integer @ 豪华道具ID
    self.deluxeGoodsId = nil

    ---@type integer @ 豪华道具数量
    self.deluxeGoodsNum = nil

    ---@type integer @ 阶段奖励标识（0-不是 1-阶段奖励标识）
    self.stageRewardSign = nil
end


function PassCardRewardVo:__delete()
    self.rewardId        = nil
    self.freeDrawId    = nil
    self.normalDrawId  = nil
    self.deluxeDrawId  = nil
    self.scheduleId      = nil
    self.passLevel       = nil
    self.freeGoodsId     = nil
    self.freeGoodsNum    = nil
    self.normalGoodsId   = nil
    self.normalGoodsNum  = nil
    self.deluxeGoodsId   = nil
    self.deluxeGoodsNum  = nil
    self.stageRewardSign = nil
end


---@param row TableML.TableFileRow
function PassCardRewardVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.rewardId   = parse_number(row, 'id')
    self.scheduleId = parse_number(row, 'ScheduleId')
    self.passLevel  = parse_number(row, 'PassLv')
    
    self.freeDrawId   = parse_number(row, 'id1')
    self.normalDrawId = parse_number(row, 'id2')
    self.deluxeDrawId = parse_number(row, 'id3')

    self.freeGoodsId   = parse_number(row, 'freeRewardId')
    self.normalGoodsId = parse_number(row, 'PayRewardId')
    self.deluxeGoodsId = parse_number(row, 'PayRewardId2')

    self.freeGoodsNum   = parse_number(row, 'freeRewardNum')
    self.normalGoodsNum = parse_number(row, 'PayRewardNum')
    self.deluxeGoodsNum = parse_number(row, 'PayRewardNum2')

    self.stageRewardSign = parse_number(row, 'StageRewardSign')
end


---@return boolean
function PassCardRewardVo:IsStageReward()
    return self.stageRewardSign == 1
end


return PassCardRewardVo
