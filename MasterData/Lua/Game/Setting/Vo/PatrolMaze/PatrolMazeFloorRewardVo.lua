-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫楼层奖励表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-26 20:13:30
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeFloorRewardVo : SettingRefBase @ AutoIds.IdSetting367
local PatrolMazeFloorRewardVo = Class('PatrolMazeFloorRewardVo', SettingRefBase)


function PatrolMazeFloorRewardVo:__init()
    ---@type integer @ 表id
    self.rewardId = 0
    
    ---@type integer @ 区域id
    self.areaId = 0

    ---@type integer @ 积分数
    self.scoreNum = 0

    ---@type table[] @ 奖励数据
    self.rewardsData = {}

    ---@type string @ 宝箱图标
    self.chestIcon = 0
end


function PatrolMazeFloorRewardVo:__delete()
    self.rewardId    = nil
    self.areaId      = nil
    self.scoreNum    = nil
    self.rewardsData = nil
    self.chestIcon   = nil
end


---@param row TableML.TableFileRow
function PatrolMazeFloorRewardVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.rewardId    = parse_number(row, 'id')
    self.areaId      = parse_number(row, 'region')
    self.scoreNum    = parse_number(row, 'levelID')
    self.rewardsData = parse_rewardData(row, 'rewardId', 'RewardsNum')
    self.chestIcon   = parse_pathName(row, 'rewardIcon')
end


return PatrolMazeFloorRewardVo
