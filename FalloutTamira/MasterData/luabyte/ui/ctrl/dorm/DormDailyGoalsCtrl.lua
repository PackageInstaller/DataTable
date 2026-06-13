local DormDailyGoalsCtrl = BaseClass("DormDailyGoalsCtrl", BaseUICtrl)
local M = DormDailyGoalsCtrl



function M:Init()
    self._ActivityUpdate = EventMgr:AddListener(UIMessageNames.ACTIVITY_UPDATE, Bind(self, self._OnActivityUpdate))
    self._ZeroClock = EventMgr:AddListener(UIMessageNames.ZERO_CLOCK_NOTIFY, Bind(self, self._OnZeroUpdateData))
end


function M:OnEnter(data, sevenCfg)
    self.m_data = data
    self.m_roleData = data:RoleActivity()

    self._view.tabCtrl:Refresh(data, sevenCfg, self._view.taskCtrl, self._view.dayCtrl, self._view.videoCtrl)
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true 
end

function M:_Update()
    self._view.tabCtrl:Update(self.m_data)
end

function M:_OnCommonRewardCallBack(rewardData)
    GameHelper.ShowGetItems(rewardData)
end


function M:_OnActivityUpdate(activityId)
    ActivityDataMgr:GetInstance():GetActivityByIdAsyn(self.m_data:ActivityId(), Bind(self, self._OnAsynActCallBack))
end


function M:_OnAsynActCallBack(data)
    self.m_data = data;
    self.m_roleData = data:RoleActivity()
    self:_Update()
end

function M:_OnZeroUpdateData()
    DailyGolasDataMgr:GetInstance():GetActivityData(Bind(self, self._OnZeroAsynActCallBack))
end


function M:_OnZeroAsynActCallBack(data)
    self.m_actData = data
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.ACTIVITY_UPDATE, self._ActivityUpdate)
    EventMgr:RemoveListener(UIMessageNames.ZERO_CLOCK_NOTIFY, self._ZeroClock)
    M.super.OnDispose(self)
end



return DormDailyGoalsCtrl