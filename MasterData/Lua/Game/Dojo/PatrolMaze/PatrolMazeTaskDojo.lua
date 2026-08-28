-------------------------------------------------------------------------------
-- 夜寻迷宫 - 任务数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-29 18:30:43
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class PatrolMazeTaskDojo : BaseDojo
---@field New fun():PatrolMazeTaskDojo
local PatrolMazeTaskDojo = Class('PatrolMazeTaskDojo', BaseDojo)


function PatrolMazeTaskDojo:__init()
    ---@type integer @ 任务ID
    self.taskId = 0

    ---@type integer @ 任务进度
    self.progress = 0

    ---@type Constants.GetStatus @ 领取状态
    self.status = Constants.GetStatus.Not
end


function PatrolMazeTaskDojo:__delete()
    self.taskId   = nil
    self.progress = nil
    self.status   = nil
end


---@param jsonData table
---@return PatrolMazeTaskDojo
function PatrolMazeTaskDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    self.taskId   = checkInt(jsonData.taskId)
    self.progress = checkInt(jsonData.progress)
    self.status   = checkInt(jsonData.status)

    return self
end


---@return boolean
function PatrolMazeTaskDojo:IsDoing()
    return self.status == Constants.GetStatus.Not
end


---@return boolean
function PatrolMazeTaskDojo:CanDraw()
    return self.status == Constants.GetStatus.Can
end


---@return boolean
function PatrolMazeTaskDojo:IsDrawn()
    return self.status == Constants.GetStatus.Has
end


return PatrolMazeTaskDojo
