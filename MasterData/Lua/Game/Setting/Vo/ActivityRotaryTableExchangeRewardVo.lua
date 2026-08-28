-------------------------------------------------------------------------------
-- 周年庆排行榜奖励表vo
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-20 15:07:28
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class ActivityRotaryTableExchangeRewardVo : SettingRefBase
local ActivityRotaryTableExchangeRewardVo = Class("ActivityRotaryTableExchangeRewardVo", SettingRefBase)


function ActivityRotaryTableExchangeRewardVo:__init()
    self.id         = nil  -- id
    self.name       = nil  -- 显示名称
    self.upperLimit = nil  -- 累计数量
    self.rewards    = nil  -- 奖励道具
end


function ActivityRotaryTableExchangeRewardVo:__delete()
    self.id         = nil
    self.name       = nil
    self.upperLimit = nil
    self.rewards    = nil
end


---@param row TableML.TableFileRow
function ActivityRotaryTableExchangeRewardVo:FillVo(row)
    SettingRefBase.FillVo(self, row)
    self.id         = parse_number(row, 'id')
    self.name       = parse_localizeText(row, 'name')
    self.upperLimit = parse_number(row, 'upperLimit')
    self.rewards    = parse_rewardData(row, 'reward', 'rewardNum', ';')
end


return ActivityRotaryTableExchangeRewardVo
