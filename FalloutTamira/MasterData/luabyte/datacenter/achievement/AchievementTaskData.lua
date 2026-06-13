local AchievementTaskData = BaseClass("AchievementTaskData")
local M = AchievementTaskData


function M:Id()
    return self.m_Cfg.id
end


function M:State()
    return self.m_State
end


function M:FinishTime()
    return self.m_FinishTime
end


function M:Config()
    return self.m_Cfg
end


function M:Hide()
    return self.m_Cfg.hide
end


function M:Score()
    return self.m_Cfg.integral
end


function M:Front()
    return self.m_Cfg.front
end


function M:Complete()
    return self.m_State == 2
end


function M:CurProgress()
    return self.m_CurProgress
end


function M:MaxProgress()
    return self.m_MaxProgress
end


function M:Update(data)
    self.m_State = data.State
    self.m_CurProgress = data.Parameter1 or {0,0,0}
    self.m_FinishTime = data.FinishTime
end


function M:SetFinish(data)
    self.m_State = 2
    self.m_FinishTime = data.FinishTime
end


function M:__init(cfg, dataMgr)
    self.m_Cfg = cfg
    self.m_DataMgr = dataMgr
    self.m_CurProgress = {}
    self.m_MaxProgress = {}
    self.m_State = 0;
    self:_InitData()
end


function M:_InitData()
    for i=1,2 do
        local name = string.format("parameter%d", i)
        local cur = self.m_Cfg["Initial"]
        local max = self.m_Cfg[name]
        table.insert(self.m_CurProgress, cur)
        table.insert(self.m_MaxProgress, max)
    end
end


return AchievementTaskData



