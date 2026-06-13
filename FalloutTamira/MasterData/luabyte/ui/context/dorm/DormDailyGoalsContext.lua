local DormDailyGoalsContext = BaseClass("DormDailyGoalsContext", BaseContext)
local M = DormDailyGoalsContext


function M:Init()
end


function M:Open(activityId, heroId)
    self.heroId = heroId
    ActivityDataMgr:GetInstance():GetActivityByIdAsyn(activityId ,Bind(self, self.AsynActCallBack))
end


function M:AsynActCallBack(data)
    self.m_actData = data
    self.m_actCfg = ConfigHelper.GetCfg("activity", self.m_actData:ActivityId())
    local sevenCfg = DormDailyGolasDataMgr:GetInstance():GetTaskByActivityId(self.m_actData:ActivityId())
    self:_Show(self.m_actData, sevenCfg)
end

function M:OnClose()
    M.super.OnClose(self)
end


return DormDailyGoalsContext