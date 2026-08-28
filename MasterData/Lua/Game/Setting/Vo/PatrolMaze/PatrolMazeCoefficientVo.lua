-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫楼层奖励表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-26 20:13:30
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeCoefficientVo : SettingRefBase @ AutoIds.IdSetting366
local PatrolMazeCoefficientVo = Class('PatrolMazeCoefficientVo', SettingRefBase)


function PatrolMazeCoefficientVo:__init()
    ---@type integer @ 表id
    self.coeffId = 0
    
    ---@type integer @ 区域id
    self.areaId = 0

    ---@type integer @ 层数
    self.floorNum = 0

    ---@type table[] @ 货币奖励加成系数（向上取整）
    self.rewardUp = 0
end


function PatrolMazeCoefficientVo:__delete()
    self.rewardId = nil
    self.areaId   = nil
    self.floorNum = nil
    self.rewardUp = nil
end


---@param row TableML.TableFileRow
function PatrolMazeCoefficientVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.coeffId  = parse_number(row, 'id')
    self.areaId   = parse_number(row, 'region')
    self.floorNum = parse_number(row, 'floor')
    self.rewardUp = parse_number(row, 'rewardUp')
end


return PatrolMazeCoefficientVo
