-------------------------------------------------------------------------------
-- 周年庆排行榜排名奖励表vo
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-20 15:07:28
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class ActivityRotaryTableRankingRewardVo : SettingRefBase
local ActivityRotaryTableRankingRewardVo = Class("ActivityRotaryTableRankingRewardVo", SettingRefBase)


function ActivityRotaryTableRankingRewardVo:__init()
    self.id         = nil  -- id
    self.name       = nil  -- 显示名称
    self.upperLimit = nil  -- 排名上限
    self.lowerLimit = nil  -- 排名下限
    self.rewards    = nil  -- 奖励道具
end


function ActivityRotaryTableRankingRewardVo:__delete()
    self.id         = nil
    self.name       = nil
    self.upperLimit = nil
    self.lowerLimit = nil
    self.rewards    = nil
end


---@param row TableML.TableFileRow
function ActivityRotaryTableRankingRewardVo:FillVo(row)
    SettingRefBase.FillVo(self, row)
    self.id         = parse_number(row, 'id')
    self.name       = parse_localizeText(row, 'name')
    self.upperLimit = parse_number(row, 'upperLimit')
    self.lowerLimit = parse_number(row, 'lowerLimit')
    self.rewards    = parse_rewardData(row, 'reward', 'rewardNum', ';')
end


return ActivityRotaryTableRankingRewardVo
