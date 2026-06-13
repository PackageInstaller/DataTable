local M = BaseClass("LimitTaskData")

function M:__init(protoData)
    self.m_taskId = protoData.Id
    if protoData.State == "Open" then 
        self.m_state = 0
    elseif protoData.State == "Completed" then 
        self.m_state = 1
    else
        self.m_state = 2
    end
    self.m_cfg = ConfigHelper.GetCfg("extremeMissionTasks",self.m_taskId)
end

function M:GetId()
    return self.m_taskId
end

function M:GetState()
    return self.m_state
end

function M:SetState(state)
    self.m_state = state
end

function M:GetCfg()
    return self.m_cfg
end

function M:GetType()
    return self.m_cfg.type
end

return M