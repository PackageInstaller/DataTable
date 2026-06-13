local VotingDataMgr = BaseClass("VotingDataMgr", Singleton)
local M = VotingDataMgr
local VotingTimer = EnumConst.VotingTimer

function M:__init()
    self.m_itemTag = ItemDataMgr:GetInstance():AddItemChange(5002, Bind(self, self.RefreshConsume))
end

function M:InitVotingData()
    ActivityDataMgr:GetInstance():GetActivityByTypeAsyn(ActivityType.VOTE, Bind(self, self._LoadDataCallBack))
end

function M:_LoadDataCallBack(data)
    self._loadData = true
    self.VotingActiveData = data
    if self._haveVoteNum then
        local result = self:HaveVoteNum()
        self._haveVoteNum(result)
        self._haveVoteNum = nil
    end
    if self._haveExchangeNum then
        local result = self:HaveExchangeNum()
        self._haveExchangeNum(result)
        self._haveExchangeNum = nil
    end
end

-- 是否有开放的票选活动(结束未关闭也属于开放)
function M:IsOpen()

    -- 活动的简单数据
    local datas = ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.VOTE)
    for _, data in pairs(datas) do
        if data:IsOpen() or data:IsClosing() then
            self:InitVotingData()
            return true
        end
    end
end

-- 获取当前阶段
function M:GetNowState()
    local nowTimer = TimeUtil.GetNowTimeStamp()
    local timeTable = self:GetTimers()

    for k, value in ipairs(timeTable) do
        if value.endTimer > nowTimer and value.startTimer <= nowTimer then
            return k
        end
    end
end

-- 获取activityGirl  Id
function M:GetActivityGirlId()
    if not self.activityGirlId or self.activityGirlId == 0 then
        local activityId = ActivityDataMgr:GetInstance():GetActivityIdByType(ActivityType.VOTE)
        local activityGirls = ConfigHelper.GetCfgs("activityGirl")

        for _, activityGirl in ipairs(activityGirls) do
            if activityId == activityGirl.activityId then
                self.activityGirlId = activityGirl.id
                break
            end
        end
    end
    return self.activityGirlId
end

-- 获取票选活动的id activityId
function M:GetActivityId()
    local activityGirlId = self:GetActivityGirlId()
    return ConfigHelper.GetCfgPropByLua("activityGirl", activityGirlId, "activityId")
end

-- function M:Get

-- 获取票选活动的信息
function M:GetVotingActive()
    if not self.VotingActiveData and not self._loadData then
        -- 这个时候肯定经过主界面 红点已经请求过票选信息
        Logger.LogError("错误 找包小威修改")
        ActivityDataMgr:GetInstance():GetActivityByTypeAsyn(ActivityType.VOTE, Bind(self, self._LoadDataCallBack))
        return
    end

    if not self.VotingActiveData:ActivityId() then
        Logger.LogError("没有找到票选活动的的信息")
    end
    return self.VotingActiveData
end

-- 获取兑换id
function M:GetExchangeId()
    local activityId = self:GetActivityId()
    local exchangeIds = ConfigHelper.GetCfgPropByLua("activity", activityId, "relationId")

    if not exchangeIds or #exchangeIds <= 0 then
        Logger.LogError("获取兑换id错误：" .. activityId)
    end

    if exchangeIds[1] <= 0 then
        Logger.LogError("获取兑换id错误：" .. activityId)
    end
    return exchangeIds[1]
end

function M:GetTimers(index)
    if not self.timeData then
        self.timeData = {}
        local VotingActiveData = self:GetVotingActive()
        local activityGirl = ConfigHelper.GetCfgByLua("activityGirl", self:GetActivityGirlId())

        if not activityGirl then
            Logger.LogError("没有找到配置表信息，配置表Id：" .. tostring(self:GetActivityGirlId()))
            return
        end
        do
            local data = {} -- 海选时间
            data.startTimer = VotingActiveData:StartTime()
            data.endTimer = activityGirl.auditionSettleTime
            self.timeData[VotingTimer.Timer1] = data
        end
        do
            local data = {} -- 海选时间展示时间
            data.startTimer = activityGirl.auditionSettleTime
            data.endTimer = activityGirl.topEightTime
            self.timeData[VotingTimer.Timer2] = data
        end
        do
            local data = {} -- 八强时间
            data.startTimer = activityGirl.topEightTime
            data.endTimer = activityGirl.topEightSettleTime
            self.timeData[VotingTimer.Timer3] = data
        end
        do
            local data = {} -- 八强展示时间
            data.startTimer = activityGirl.topEightSettleTime
            data.endTimer = activityGirl.top2Time
            self.timeData[VotingTimer.Timer4] = data
        end
        do
            local data = {} -- 双王时间
            data.startTimer = activityGirl.top2Time
            data.endTimer = activityGirl.top2SettleTime
            self.timeData[VotingTimer.Timer5] = data
        end
        do
            local data = {} -- 双王展示时间
            data.startTimer = activityGirl.top2SettleTime
            data.endTimer = VotingActiveData:CloseTime()
            self.timeData[VotingTimer.Timer6] = data
        end
    end

    if not index then
        return self.timeData
    end
    return self.timeData[index]
end

function M:Cleanup()
end

-- 票选红点提示
function M:HaveVoteNum(callBack)
    if not self._loadData then
        self._haveVoteNum = callBack
        self:InitVotingData()
        return false
    end

    if not self.VotingActiveData or not self.VotingActiveData:ActivityId() then
        return false
    end

    local activityGirlId = self:GetActivityGirlId()

    if not activityGirlId or activityGirlId <= 0 then
        return false
    end

    local voteId = self:GetVotingId()
    local num = ConfigHelper.GetSystemParam(223)
    return ItemDataMgr:GetInstance():GetItemNumById(voteId) >= num
end

-- 获得支持券id
function M:GetVotingId()
    if not self.votingId then
        local activityGirlId = self:GetActivityGirlId()
        self.votingId = ConfigHelper.GetCfgPropByLua("activityGirl", activityGirlId, "support")
    end
    return self.votingId
end

-- 兑换红点
function M:HaveExchangeNum(callBack)
    if not self._loadData then
        self._haveExchangeNum = callBack
        self:InitVotingData()
        return false
    end

    if not self.VotingActiveData then
        return false
    end

    local activityGirlId = self:GetActivityGirlId()

    if not activityGirlId or activityGirlId <= 0 then
        return false
    end

    local voteId = ConfigHelper.GetCfgPropByLua("activityGirl", activityGirlId, "supportReward")
    local num = ConfigHelper.GetSystemParam(224)

    return ItemDataMgr:GetInstance():GetItemNumById(voteId) >= num
end

function M:RefreshConsume(itemId, old, now)
    if itemId ~= 5002 then
        return
    end
    RedPointMgr:ForceCheck(CS.GameX.RedPointConst.VotingVoteChecker)
end

function M:Dispose()
    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
end

return VotingDataMgr
