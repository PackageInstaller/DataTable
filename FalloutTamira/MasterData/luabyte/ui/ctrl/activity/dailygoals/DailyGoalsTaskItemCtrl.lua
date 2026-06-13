local ActivityDailyGoalsItem = BaseClass("ActivityDailyGoalsItem")
local M = ActivityDailyGoalsItem



function M:Update(data, roledata, isUnLock)
    self.m_data = data
    self.m_subData = roledata
    self.m_isUnLock = isUnLock
    self.m_rewards = ConfigHelper.GetCfg("itemGroup", self.m_data.reward)

    self:_DefaultSubData()
    self:_SetState()
    self:_SetItemUI()
    self._view:SetActive(true)
end

function M:_DefaultSubData()
    if self.m_subData.SubActivityId then
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

    if self.m_isUnLock == false then
        self.m_state = 4
        return
    end

    if self.m_subData.State == 1 then
        self.m_state = ActivityHelper.ESignState.COMPLETE_NOT_GAIN;
    end

    if self.m_subData.State == 2 then
        self.m_state = ActivityHelper.ESignState.ALREADY_GAIN;
    end
end

function M:_SetItemUI()
    self._view.title:SetText(ConfigHelper.GetLocalString(self.m_data.des))

    local value = self.m_subData.Value0 > self.m_data.limitValue1 and self.m_data.limitValue1 or self.m_subData.Value0;
    self._view.value:SetText(string.format("%d/%d", value, self.m_data.limitValue1))
    self._view.value:SetActive(self.m_isUnLock)
    self._view.state:SetState(self.m_state + 1)
    self._view.rewardScroll:Init(Bind(self, self._SetRewardItem));
    self._view.rewardScroll:ShowList(#self.m_rewards.items);
end

function M:_SetRewardItem(go, index)
    local itemPfbUI = go:GetItemPfbUI()
    itemPfbUI:SetInfo(self.m_rewards.items[index], 1, self.m_rewards.cnts[index]);
    itemPfbUI:EnablePopItem(true);
end

function M:__init(view, curDay)
    self._view = view
    self._curDay = curDay

    self._view.awardBtn.transform:onClick(Bind(self, self._OnClickItem))
    self._view.goBtn.transform:onClick(Bind(self, self._OnClickGoto))
end

function M:_OnClickItem()
    if self.m_state == ActivityHelper.ESignState.COMPLETE_NOT_GAIN then
        ActivityDataMgr:GetInstance():SendCommonReward(self.m_subData.ActivityId, { self.m_subData.SubActivityId },
            Bind(self, self._OnCommonRewardCallBack))
    end
end

function M:_OnCommonRewardCallBack(rewardData)
    RedPointMgr:ForceCheck(CS.GameX.RedPointConst.ThreeDayGoalAwardChecker)
    GameHelper.ShowGetItems(rewardData)
    EventMgr:Broadcast(UIMessageNames.ACTIVITY_COMMON_REWARD, rewardData)
    --埋点信息
    local relationId = ConfigHelper.GetCfgPropByLua("activity", self.m_subData.ActivityId, "relationId")
    local tempData = ActivityDataMgr:GetInstance():GetActivityData(relationId[1])
    local score = tempData:PassTimes()
    local sevenday_mission = tostring(self.m_subData.SubActivityId)
    local dataKey = { "sevenday_mission", "sevenday_score" }
    local dataValues = { sevenday_mission, score }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Activity_sevenday, dataValues)
end

function M:_OnClickGoto()
    GameHelper.Jump(self.m_data.linkto)
end

function M:OnRecovery()
    self._view:SetActive(false)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return ActivityDailyGoalsItem
