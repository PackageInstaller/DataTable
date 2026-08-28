-------------------------------------------------------------------------------
-- Pass卡 - 任务信息数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-29 19:07:23
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class PassCardTaskInfoDojo : BaseDojo
---@field New fun():PassCardTaskInfoDojo
local PassCardTaskInfoDojo = Class('PassCardTaskInfoDojo', BaseDojo)


function PassCardTaskInfoDojo:__init()
    ---@type integer @ 任务id
    self.taskId = 0
    
    ---@type integer @ 任务状态（0：进行中，1：可经取，2：已领取）
    self.status = 0
    
    ---@type integer @ 进度
    self.progress = 0
end


function PassCardTaskInfoDojo:__delete()
    self.taskId   = nil
    self.status   = nil
    self.progress = nil
end


---@param jsonData table
---@return PassCardTaskInfoDojo
function PassCardTaskInfoDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    self.taskId = checkInt(jsonData.id)

    return self
end


function PassCardTaskInfoDojo:IsDoing()
    return self.status == Constants.GetStatus.Not
end


function PassCardTaskInfoDojo:CanDraw()
    return self.status == Constants.GetStatus.Can
end


function PassCardTaskInfoDojo:IsDrawn()
    return self.status == Constants.GetStatus.Has
end


return PassCardTaskInfoDojo
