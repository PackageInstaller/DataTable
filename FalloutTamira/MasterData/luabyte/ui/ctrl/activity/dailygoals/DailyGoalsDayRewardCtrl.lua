local DailyGoalsDayRewardCtrl = BaseClass("DailyGoalsDayRewardCtrl")
local M = DailyGoalsDayRewardCtrl



function M:Refresh(cfg, complete, data)
    self.m_data = cfg
    self.m_subData = data
    self:_DefaultSubData()
    self:_SetState()

    local itemCfg = ConfigHelper.GetCfg("itemGroup", cfg.reward)
    self._view.icon:SetItemIcon(itemCfg.items[1])
    self._view.curNum:SetText(tostring(complete.curNum))
    self._view.allNum:SetText(tostring(complete.allNum))
    self._view.barValue:SetFillAmount(complete.curNum / complete.allNum)
    self._view.state:SetState(self.m_state)
end

function M:_DefaultSubData()
    if self.m_subData then
        return
    end

    self.m_subData = {}
    self.m_subData.State = 0
    self.m_subData.Value0 = 0
    self.m_subData.ActivityId = self.m_data.activityId
    self.m_subData.SubActivityId = self.m_data.id
end

function M:_SetState()
    self.m_state = ActivityHelper.ESignState.DOING;

    if self.m_subData.State == 1 then
        self.m_state = ActivityHelper.ESignState.COMPLETE_NOT_GAIN;
    end

    if self.m_subData.State == 2 then
        self.m_state = ActivityHelper.ESignState.ALREADY_GAIN;
    end
end

function M:__init(view)
    self._view = view
    self._view.btn:onClick(Bind(self, self._OnClickItem))
end

function M:_OnClickItem()
    if self.m_state == ActivityHelper.ESignState.COMPLETE_NOT_GAIN then
        ActivityDataMgr:GetInstance():SendCommonReward(self.m_subData.ActivityId, { self.m_subData.SubActivityId },
            function(data)
                RedPointMgr:ForceCheck(CS.GameX.RedPointConst.ThreeDayGoalAwardChecker)
                GameHelper.ShowGetItems(data)
                EventMgr:Broadcast(UIMessageNames.ACTIVITY_COMMON_REWARD, data)
            end)
    else
        local isReceived = self.m_state == ActivityHelper.ESignState.ALREADY_GAIN
        local title = ConfigHelper.GetLocalString(293)
        local des = ConfigHelper.GetLocalString(709)
        GameHelper.ConfirmReward(self.m_data.reward, title, des, "", false, isReceived, nil)
    end
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return DailyGoalsDayRewardCtrl
