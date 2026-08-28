-------------------------------------------------------------------------------
-- 卡牌养成 - 收集奖励vo
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-04-28 18:12:40
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class CardCollectRewardsVo : SettingRefBase
local CardCollectRewardsVo = Class('CardCollectRewardsVo', SettingRefBase)


function CardCollectRewardsVo:__init()
    ---@type integer @ 奖励id
    self.rewardId = nil
    ---@type integer @ 收集类型
    self.collectType = nil
    ---@type string @ 收集描述
    self.collectDescr = nil
    ---@type integer @ 收集目标数
    self.collectTarget = nil
    ---@type integer @ 属性类型id (属性加成定义表里的ID)
    self.attTypeId = nil
    ---@type integer @ 属性值
    self.attAddNum = nil
end


function CardCollectRewardsVo:__delete()
    self.rewardId = nil
    self.collectType = nil
    self.collectDescr = nil
    self.collectTarget = nil
    self.attTypeId = nil
    self.attAddNum = nil
end


---@param row TableML.TableFileRow
function CardCollectRewardsVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.rewardId      = parse_number(row, 'id')
    self.collectType   = parse_number(row, 'type')
    self.collectDescr  = parse_localizeText(row, 'dec')
    self.collectTarget = parse_number(row, 'target')
    self.attTypeId     = parse_number(row, 'attTypeId')
    self.attAddNum     = parse_number(row, 'num')
end


return CardCollectRewardsVo
