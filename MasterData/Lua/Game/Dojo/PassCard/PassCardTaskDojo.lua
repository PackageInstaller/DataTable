-------------------------------------------------------------------------------
-- Pass卡 - 任务数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-29 15:58:52
-------------------------------------------------------------------------------

local TaskInfoDojo = import('Game.Dojo.PassCard.PassCardTaskInfoDojo')
local BaseDojo     = import('Game.Dojo.BaseDojo')

---@class PassCardTaskDojo : BaseDojo
---@field New fun():PassCardTaskDojo
local PassCardTaskDojo = Class('PassCardTaskDojo', BaseDojo)


function PassCardTaskDojo:__init()
    ---@type PassCardTaskInfoDojo[] @ 日常任务dojo列表
    self.dailyTaskList = {}

    ---@type PassCardTaskInfoDojo[] @ 精英任务dojo列表
    self.eliteTaskList = {}

    ---@type integer @ 日常任务剩余时间
    self.dailyTaskTimeLeft = 0

    ---@type integer @ 精英任务剩余时间
    self.eliteTaskTimeLeft = 0
    
    ---@type integer @ 日常任务免费刷新次数
    self.dailyTaskRefreshTimes = 0

    ---@type integer @ 精英任务免费刷新次数
    self.eliteTaskRefreshTimes = 0
end


function PassCardTaskDojo:__delete()
end


---@param jsonData table
---@return PassCardTaskDojo
function PassCardTaskDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    -- update daily taskList
    self.dailyTaskList = {}
    for taskIndex, taskData in ipairs(checkTable(jsonData.dailyTask)) do
        self.dailyTaskList[taskIndex] = TaskInfoDojo.New():Fill(taskData)
    end
    
    -- update elite taskList
    self.eliteTaskList = {}
    for taskIndex, taskData in ipairs(checkTable(jsonData.eliteTask)) do
        self.eliteTaskList[taskIndex] = TaskInfoDojo.New():Fill(taskData)
    end

    return self
end


return PassCardTaskDojo
