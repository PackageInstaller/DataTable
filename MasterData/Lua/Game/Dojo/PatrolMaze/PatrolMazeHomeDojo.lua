-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主页数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-26 19:55:30
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class PatrolMazeHomeDojo : BaseDojo
---@field New fun():PatrolMazeHomeDojo
local PatrolMazeHomeDojo = Class('PatrolMazeHomeDojo', BaseDojo)


function PatrolMazeHomeDojo:__init()
    ---@type integer @ 活动剩余时间
    self.remainTime = 0

    ---@type boolean @ 活动是否结束
    self.isEnded = false

    ---@type table<integer, PatrolMazeAreaDojo> @ 区域dojo字典
    self.areaDojoMap = {}

    ---@type PatrolMazeTaskDojo[] @ 任务dojo列表
    self.taskDojoList = {}
end


function PatrolMazeHomeDojo:__delete()
    self.remainTime   = nil
    self.isEnded      = nil
    self.areaDojoMap  = nil
    self.taskDojoList = nil
end


---@param jsonData table
---@return PatrolMazeHomeDojo
function PatrolMazeHomeDojo:Fill(jsonData)
    self:UpdateRemainTime(jsonData.remainTime)

    for areaId, areaData in pairs(checkTable(jsonData.areas)) do
        if not self.areaDojoMap[checkInt(areaId)] then
            self.areaDojoMap[checkInt(areaId)] = import('Game.Dojo.PatrolMaze.PatrolMazeAreaDojo').New()
        end
        self.areaDojoMap[checkInt(areaId)]:FillHomeData(areaData)
    end

    for taskIndex, taskData in ipairs(checkTable(jsonData.taskList)) do
        self.taskDojoList[taskIndex] = import('Game.Dojo.PatrolMaze.PatrolMazeTaskDojo').New()
        self.taskDojoList[taskIndex]:Fill(taskData)
    end

    return self
end


---@param areaId integer
---@return PatrolMazeAreaDojo
function PatrolMazeHomeDojo:GetAreaDojo(areaId)
    return self.areaDojoMap[checkInt(areaId)]
end


---@param remainTime integer
function PatrolMazeHomeDojo:UpdateRemainTime(remainTime)
    self.remainTime = checkInt(remainTime)

    if self.remainTime <= 0 then
        self.isEnded = true
    end
end


return PatrolMazeHomeDojo
