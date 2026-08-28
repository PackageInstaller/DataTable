-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫区域任务表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-28 17:29:59
-------------------------------------------------------------------------------

local SettingRefBase  = require('Game.Setting.SettingRefBase')
---@class PatrolMazeAreaTaskVo : SettingRefBase @ AutoIds.IdSetting377
local PatrolMazeAreaTaskVo = Class('PatrolMazeAreaTaskVo', SettingRefBase)


function PatrolMazeAreaTaskVo:__init()
    ---@type integer @ 任务id
    self.taskId = 0

    ---@type string @ 任务介绍
    self.taskDescr = ''

    ---@type PatrolMazeUtils.TaskType @ 任务类型
    self.taskType = 0

    ---@type integer @ 目标id
    self.targetId = 0

    ---@type integer @ 目标值
    self.targetNum = 0

    ---@type table[] @ 
    self.rewardsData = {}
end


function PatrolMazeAreaTaskVo:__delete()
    self.taskId      = nil
    self.taskDescr   = nil
    self.taskType    = nil
    self.targetId    = nil
    self.targetNum   = nil
    self.rewardsData = nil
end


---@param row TableML.TableFileRow
function PatrolMazeAreaTaskVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.taskId      = parse_number(row, 'id')
    self.taskDescr   = parse_localizeText(row, 'desc', true)
    self.taskType    = parse_number(row, 'taskType')
    self.targetId    = parse_number(row, 'targetId')
    self.targetNum   = parse_number(row, 'targetNum')
    self.rewardsData = parse_rewardData(row, 'rewardId', 'rewardNum')
end


return PatrolMazeAreaTaskVo
