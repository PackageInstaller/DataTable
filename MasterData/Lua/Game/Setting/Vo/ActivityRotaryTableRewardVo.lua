-------------------------------------------------------------------------------
-- 周年庆转盘奖励表vo
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-20 15:07:28
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class ActivityRotaryTableRewardVo : SettingRefBase
local ActivityRotaryTableRewardVo = Class("ActivityRotaryTableRewardVo", SettingRefBase)


function ActivityRotaryTableRewardVo:__init()
    self.id         = nil  -- id
    self.pools      = nil  -- 所属转盘
    self.rewardType = nil  -- 奖励类型：1大奖，2普通奖励
    self.reward     = nil  -- 奖励道具id
    self.rewardNum  = nil  -- 奖励数量
    self.stock      = nil  -- 库存数量（-1为无限
    self.seat       = nil  -- 对应位置：1、2、3、4、5、6、7、8
end


function ActivityRotaryTableRewardVo:__delete()
    self.id         = nil
    self.pools      = nil
    self.rewardType = nil
    self.reward     = nil
    self.rewardNum  = nil
    self.stock      = nil
    self.seat       = nil
end


---@param row TableML.TableFileRow
function ActivityRotaryTableRewardVo:FillVo(row)
    SettingRefBase.FillVo(self, row)
    self.id         = parse_number(row, 'id')
    self.pools      = parse_number(row, 'pools')
    self.rewardType = parse_number(row, 'rewardType')
    self.reward     = parse_number(row, 'reward')
    self.rewardNum  = parse_number(row, 'rewardNum')
    self.stock      = parse_number(row, 'stock')
    self.seat       = parse_number(row, 'seat')
end


return ActivityRotaryTableRewardVo
