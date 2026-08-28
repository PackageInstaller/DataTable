-------------------------------------------------------------------------------
-- 周年庆转盘配置表vo
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-20 15:07:28
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class ActivityRotaryTableConfigVo : SettingRefBase
local ActivityRotaryTableConfigVo = Class("ActivityRotaryTableConfigVo", SettingRefBase)


function ActivityRotaryTableConfigVo:__init()
    self.id               = nil  -- id
    self.consumeId        = nil  -- 消耗道具Id
    self.group          = nil
    self.consumeNumSingle = nil  -- 单抽消耗道具数量
    self.getId            = nil  -- 获取道具Id
    self.getNum           = nil  -- 获取道具数量
    self.number           = nil  -- 保底次数：未达到该次数前无法抽出大奖
    self.drawNum          = nil
end


function ActivityRotaryTableConfigVo:__delete()
    self.id               = nil
    self.consumeId        = nil
    self.consumeNumSingle = nil
    self.getId            = nil
    self.getNum           = nil
    self.drawNum          = nil
    self.group            = nil
    self.number           = nil
end


---@param row TableML.TableFileRow
function ActivityRotaryTableConfigVo:FillVo(row)
    SettingRefBase.FillVo(self, row)
    self.id               = parse_number(row, 'id')
    self.consumeId        = parse_number(row, 'consumeId')
    self.group            = parse_number(row, 'group')
    self.consumeNumSingle = parse_number(row, 'consumeNumSingle')
    self.drawNum          = parse_number(row, 'drawNum')
    self.getId            = parse_number(row, 'getId')
    self.getNum           = parse_number(row, 'getNum')
    self.number           = parse_number(row, 'number')
end


return ActivityRotaryTableConfigVo
