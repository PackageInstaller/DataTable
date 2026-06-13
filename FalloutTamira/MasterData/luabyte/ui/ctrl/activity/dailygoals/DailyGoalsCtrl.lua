-- 七日签到页面
local DailyGoalsCtrl = BaseClass("DailyGoalsCtrl", BaseUICtrl)
local M = DailyGoalsCtrl

function M:OnVisible()
    RedPointMgr:ForceCheck(CS.GameX.RedPointConst.ThreeDayGoalAwardChecker)
    RedPointMgr:ForceCheck(CS.GameX.RedPointConst.ThreeDayGoalLivenessChecker)
end

function M:IsAllComplete()
    return #self.m_taskIds <= 0 and #self.m_scoreIds <= 0 and #self.m_dayIds <= 0
end

-- 初始化
function M:Init()
    self._view.allBtn.transform:onClick(Bind(self, self._OnClickAllReward))
    self._ActivityUpdate = EventMgr:AddListener(UIMessageNames.ACTIVITY_UPDATE, Bind(self, self._OnActivityUpdate))
    self._ZeroClock = EventMgr:AddListener(UIMessageNames.ZERO_CLOCK_NOTIFY, Bind(self, self._OnZeroUpdateData))
end

-- data 活动数据  actCfg 活动对应表  sevenCfg 7日目标对应表  relationData 子活动数据
function M:OnEnter(data, actCfg, sevenCfg, relationData)
    self.m_data = data
    self.m_relationData = relationData
    self.m_roleData = data:RoleActivity()

    self._view.scoreCtrl:Refresh(self.m_relationData)
    self._view.tabCtrl:Refresh(data, sevenCfg, self._view.taskCtrl, self._view.dayCtrl)
    self._view.timeCtrl:Refresh(data)
    self:_RefreshAllButtonBg()
end

-- 界面更新
function M:_Update()
    self._view.tabCtrl:Update(self.m_data)
    self._view.timeCtrl:Refresh(self.m_data)
    self._view.scoreCtrl:Refresh(self.m_relationData)
    self:_RefreshAllButtonBg()
end

-- 刷新按钮
function M:_RefreshAllButtonBg()
    self.m_taskIds, self.m_dayIds = self._view.tabCtrl:CompleteIds()
    self.m_scoreIds = self._view.scoreCtrl:ScoreCompleteIds()

    if self:IsAllComplete() then
        self._view.allState:SetState(2)
    else
        self._view.allState:SetState(1)
    end
end

function M:_OnClickAllReward()
    if self:IsAllComplete() then
        GameHelper.TipsById(4152);
        return
    end

    local num = {}
    self.temptaskIds = {}
    if #self.m_taskIds > 0 then

        for i, v in ipairs(self.m_taskIds) do
            table.insert(num, 1)
            table.insert(self.temptaskIds, v)
        end
        ActivityDataMgr:GetInstance():SendCommonReward(self.m_data:ActivityId(), self.m_taskIds, Bind(self, self._OnCommonRewardCallBack), num)
        return
    end

    -- 领取圆圈内容
    if #self.m_dayIds > 0 then
        for i, v in ipairs(self.m_dayIds) do
            table.insert(num, 1)
            table.insert(self.temptaskIds, v)
        end
        ActivityDataMgr:GetInstance():SendCommonReward(self.m_data:ActivityId(), self.m_dayIds, Bind(self, self._OnCommonRewardCallBack), num)
        return
    end

    if #self.m_scoreIds > 0 then
        local activityId = self.m_relationData:ActivityId()
        ActivityDataMgr:GetInstance():SendCommonReward(activityId, self.m_scoreIds, Bind(self, self._OnCommonRewardCallBack))
    end
end

function M:_OnCommonRewardCallBack(rewardData)
    GameHelper.ShowGetItems(rewardData)
    RedPointMgr:ForceCheck(CS.GameX.RedPointConst.ThreeDayGoalAwardChecker)
    RedPointMgr:ForceCheck(CS.GameX.RedPointConst.ThreeDayGoalLivenessChecker)
    -- 七日目标埋点
    if #self.temptaskIds > 0 then
        local activityId = ConfigHelper.GetCfgPropByLua("activitySevenDay", self.temptaskIds[1], "activityId")
        local relationId = ConfigHelper.GetCfgPropByLua("activity", activityId, "relationId")
        local tempData = ActivityDataMgr:GetInstance():GetActivityData(relationId[1])
        local score = tempData:PassTimes()
        local sevenday_mission = self:_GetIds(self.temptaskIds)
        local dataKey = {"sevenday_mission", "sevenday_score"}
        local dataValues = {sevenday_mission, score}
        IBuriedPointDataMgr:SubmitData(BuriedPointConst.Activity_sevenday, dataValues)
    end
end

function M:_GetIds(ids)
    local idsStr = ""
    for i = 1, #ids do
        if i == 1 then
            idsStr = idsStr .. ids[i]
        else
            idsStr = idsStr .. "," .. ids[i]
        end
    end
    return idsStr
end

function M:_OnActivityUpdate(activityId)
    if self.m_relationData then
        if activityId == self.m_relationData:ActivityId() then
            ActivityDataMgr:GetInstance():GetActivityByIdAsyn(self.m_relationData:ActivityId(), Bind(self, self._OnAsynScoreCallBack))
        else
            ActivityDataMgr:GetInstance():GetActivityByIdAsyn(self.m_data:ActivityId(), Bind(self, self._OnAsynActCallBack))
        end
    end
end

function M:_OnAsynActCallBack(data)
    self.m_data = data;
    self.m_roleData = data:RoleActivity()
    self:_Update()
end

function M:_OnAsynScoreCallBack(data)
    self.m_relationData = data
    self:_Update()
end

function M:_OnZeroUpdateData()
    DailyGolasDataMgr:GetInstance():GetActivityData(Bind(self, self._OnZeroAsynActCallBack))
end

function M:_OnZeroAsynActCallBack(data)
    self.m_actData = data
    DailyGolasDataMgr:GetInstance():GetActivityScoreData(Bind(self, self._OnZeroAsynScoreCallBack))
end

function M:_OnZeroAsynScoreCallBack(data)
    self.m_relationData = data
    self:_Update()
end

-- 设置退出时调用，返回TRUE则为拦截底层逻辑
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.ACTIVITY_UPDATE, self._ActivityUpdate)
    EventMgr:RemoveListener(UIMessageNames.ZERO_CLOCK_NOTIFY, self._ZeroClock)
    M.super.OnDispose(self)
end

return DailyGoalsCtrl
