local ActivityDataMgr = BaseClass("ActivityDataMgr", Singleton)
local M = ActivityDataMgr
local ActivityData = require("DataCenter.Activity.ActivityData")
local MessageId = Proto.MessageId
local tInsert = table.insert

-- IDataGetter start
-- 用于在登录的时候初始化相关数据
function M:LoadData()
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0
    self:RequestActConfig()
end

function M:IsLoading()
    return self._isloading
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._isloading
end

-- IDataGetter end

function M:__init()
    self.m_totalActivitys = {}
    self.m_asynGetActsByIdHandler = Bind(self, self.OnAsynGetActivitysById)
    self.m_rsActData = NetPack:RegistResponse(MessageId.ResponseActData, Bind(self, self.OnResponseActData))
    self.m_notifyUpdateActivity = NetPack:RegistResponse(MessageId.NotifyUpdateActivity, Bind(self, self.OnNotifyUpdateActivity))
    self.m_rsCommonActivityAward = NetPack:RegistResponse(MessageId.ResponseCommonActivityAward, Bind(self, self.OnResponseCommonActivityAward))
end

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.ResponseActData, self.m_rsActData)
    NetPack:UnRegistResponse(MessageId.NotifyUpdateActivity, self.m_notifyUpdateActivity)
    NetPack:UnRegistResponse(MessageId.ResponseCommonActivityAward, self.m_rsCommonActivityAward)
    self.m_rsActData = nil
    self.m_notifyUpdateActivity = nil
    self.m_rsCommonActivityAward = nil
    self.m_asynGetActsByIdHandler = nil

    self.m_activityIds = nil
    self.m_rqActivityIds = nil
    self.m_actDataRqList = nil
    self.m_actDataCallbackList = nil
    self.m_commonRewardCallback = nil
    self.m_getActivitysCallBack = nil
    self.m_asynGetActsByIdCallback = nil
end

function M:Cleanup()
    self._dataLoaded = false
    self._errorCode = 0
    self._isloading = false
end

-- 通过活动类型，获得正在处理的活动ID
function M:GetActivityIdByType(actType)
    for id, actData in pairs(self.m_totalActivitys) do
        if actData:Type() == actType then
            return id
        end
    end
    return 0
end

--- 同步获取活动的简单数据
---@param actType any
function M:GetActivitySimpleByType(actType)
    local simpleDatas = {}
    for _, data in pairs(self.m_totalActivitys) do
        if data:Type() == actType then
            tInsert(simpleDatas, data)
        end
    end
    return simpleDatas
end

-- 异步获取活动详细数据
function M:GetActivityByIdAsyn(id, callback)
    local actData = self.m_totalActivitys[id]
    if not actData then
        Logger.LogError("无活动配置数据, activityId = " .. id)
        callback()
        return
    end
    if actData:IsActivityReady() then
        if callback then
            callback(actData)
        end
        return
    end
    self:_SendRequestActData(id, callback)
end

-- 异步通过类型获取活动详细数据
function M:GetActivityByTypeAsyn(actType, callback)
    local actData = MapUtil.Find(self.m_totalActivitys, function(v)
        return v:Type() == actType
    end)
    if not actData then
        Logger.Log("无活动配置数据, type = " .. actType)
        callback()
        return
    end
    self:GetActivityByIdAsyn(actData:ActivityId(), callback)
end

-- 异步通过类型获取活动详细数据
function M:GetActivitysByTypeAsyn(type, callback)
    self.m_activityIds = MapUtil.FilterKeys(self.m_totalActivitys, function(v)
        return v:Type() == type
    end)
    self.m_getActivitysCallBack = callback
    self:_GetActivitysData()
end

function M:_GetActivitysData()
    local activitysData = {}
    if self.m_activityIds then
        for _, v in ipairs(self.m_activityIds) do
            local actData = self.m_totalActivitys[v]
            if not actData then
                Logger.LogError("无活动配置数据, activityId = " .. v)
                return
            end

            if not actData:IsActivityReady() then
                self:_SendRequestActData(v, Bind(self, self._GetActivitysData))
                return
            end

            activitysData[#activitysData + 1] = actData
        end
        self.m_activityIds = nil
    end

    if self.m_getActivitysCallBack then
        self.m_getActivitysCallBack(activitysData)
        self.m_getActivitysCallBack = nil
    end
end

function M:GetActivityByType(type)
    return MapUtil.Find(self.m_totalActivitys, function(v)
        return v:Type() == type
    end)
end

---返回活动的开始结束时间
function M:GetActivityTime(ActivityId)
    local activityData = self.m_totalActivitys[ActivityId]
    if not activityData or (activityData:ActivityId() <= 0) then
        return 0, 0
    end
    return activityData:StartTime(), activityData:EndTime()
end

---获取活动进度 注意，只能在确保客户端已经有该活动进度的时候才能调用，否则只能获取活动的简单数据
function M:GetActivityData(id)
    local activityData = self.m_totalActivitys[id]
    if not activityData then
        Logger.Log("无活动配置数据, activityId = " .. id)
        return
    end
    return activityData
end

-- 异步通过id获取活动进度
function M:GetActivityRoleDatasAsyn(id, callback)
    if not callback then
        return
    end

    self:GetActivityByIdAsyn(id, function(data)
        callback(data and data:RoleActivity() or nil)
    end)
end

-- 通过ID异步获得多个活动
function M:GetActivitysByIdAsyn(ids, callback)
    if not ids or (#ids == 0) or not callback then
        return
    end

    for i = #ids, 1, -1 do
        if ids[i] <= 0 then
            table.remove(ids, i)
        end
    end
    local actId = ids[1] or 0
    if actId <= 0 then
        Logger.LogError("活动ID异常" .. tostring(actId))
        return
    end
    self.m_actDataRqList = {}
    self.m_rqActivityIds = ids
    self.m_asynGetActsByIdCallback = callback
    self:GetActivityByIdAsyn(actId, self.m_asynGetActsByIdHandler)
end

function M:OnAsynGetActivitysById(data)
    if not data then
        return
    end

    local activityID = data:ActivityId()
    table.removeValue(self.m_rqActivityIds, activityID)
    tInsert(self.m_actDataRqList, data)
    local actId = self.m_rqActivityIds[1] or 0
    if actId > 0 then -- 依次请求
        self:GetActivityByIdAsyn(actId, self.m_asynGetActsByIdHandler)
    else -- 全部请求完成
        if self.m_asynGetActsByIdCallback then
            self.m_asynGetActsByIdCallback(self.m_actDataRqList)
            self.m_asynGetActsByIdCallback = nil
        end
    end
end

-- 异步通过id获取活动进度
function M:GetActivityByTypeRoleDatasAsyn(type, callback)
    if not callback then
        return
    end

    self:GetActivityByTypeAsyn(type, function(data)
        callback(data and data:RoleActivity() or nil)
    end)
end

function M:SendCommonReward(activityId, subIds, callback, num)
    if self.isSending then
        return
    end
    self.isSending = false
    if not num then
        num = {}
        for _, _ in pairs(subIds or {}) do
            tInsert(num, 1)
        end
    end
    self.m_commonRewardCallback = callback
    local request = {ActivityId=activityId, SubActivityId=subIds, Num=num}
    NetPack:SendMessage(MessageId.RequestCommonActivityAward, request)
end
-- 请求活动的简单数据
function M:RequestActConfig()
    self._tempOnResponseActConfig = NetPack:RegistResponse(MessageId.ResponseActConfig, Bind(self, self.OnResponseActConfig))
    NetPack:SendMessage(MessageId.RequestActConfig, {})
end
-- 请求活动的详细数据
function M:_SendRequestActData(id, callback)
    if id <= 0 then
        return
    end

    self.m_actDataCallbackList = self.m_actDataCallbackList or {}
    if callback then
        local group = self.m_actDataCallbackList[id]
        if not group then
            group = {}
        end
        tInsert(group, callback)
        self.m_actDataCallbackList[id] = group
        -- 相同的ID同时在请求
        if #group > 1 then
            return
        end
    end
    local request = {}
    request.ActivityId = id
    NetPack:SendMessage(MessageId.RequestActData, request)
end

-- 请求活动配置  活动进度 Req
function M:OnResponseActConfig(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseActConfig, self._tempOnResponseActConfig)
    if result ~= 0 then
        return
    end

    for _, v in ipairs(msg.Data) do
        local activityId = v.ActivityId
        local cfg = ConfigHelper.GetCfg("activity", activityId)
        if cfg then
            v.Type = cfg.type
            self.m_totalActivitys[activityId] = ActivityData.New(v)
        else
            Logger.LogError("activity is nil, id = " .. activityId)
        end
    end
    self._dataLoaded = true
end

function M:OnResponseActData(_, result, msg)
    if result ~= 0 then
        return
    end

    local activityId = msg.ActivityId
    local actData = self.m_totalActivitys[activityId]
    if not actData then
        Logger.LogError("没有当前活动数据, Id：" .. activityId)
        return
    end

    actData:UpdataActData(msg.Data)
    -- 申请完成之后回调
    for _, c in ipairs(self.m_actDataCallbackList[activityId] or {}) do
        if c then
            c(actData)
        end
    end
    self.m_actDataCallbackList[activityId] = nil
end

-- 活动进度
function M:OnNotifyUpdateActivity(_, result, msg)
    if result ~= 0 then
        return
    end

    local activityId = msg.Data.ActivityId
    local actData = self.m_totalActivitys[activityId]
    if actData then
        actData:UpdateRoleActivity(msg.Data)
    else
        Logger.LogError("没有当前活动数据 无法刷新, Id：" .. activityId)
    end
end

function M:OnResponseCommonActivityAward(_, result, msg)
    self.isSending = false
    if result ~= 0 then
        return
    end

    local awardData = self:_ShowRewardItems(msg.SubActivityAward)
    if self.m_commonRewardCallback then
        self.m_commonRewardCallback(awardData)
        self.m_commonRewardCallback = nil
    else
        GameHelper.ShowGetItems(awardData)
        EventMgr:Broadcast(UIMessageNames.ACTIVITY_COMMON_REWARD, msg)
    end
end

function M:_ShowRewardItems(data)
    local awardData = {}
    for _, v in ipairs(data) do
        for _, kv in ipairs(v.Items) do
            local id = kv.Id
            local num = awardData[id] or 0
            awardData[id] = num + kv.Cnt
        end
    end
    return awardData
end

-- 更新活动数据信息
function M:UpdateActivityData()
    for id, actData in pairs(self.m_totalActivitys) do
        if actData:IsClosed() then
            actData:Delete()
            self.m_totalActivitys[id] = nil
        end
    end
    local activitys = ConfigHelper.GetCfgs("activity")
    local nowTime = TimeUtil.GetNowTimeStamp()
    for activityId, activity in pairs(activitys) do
        if not self.m_totalActivitys[activityId] and activity.openType == 2 and activity.ifOpen == 1 and nowTime > activity.startTime and nowTime < activity.closeTime then
            local data = {}
            data.ActivityId = activityId
            data.Type = activity.type
            data.StartTime = activity.startTime
            data.EndTime = activity.endTime
            data.CloseTime = activity.closeTime
            self.m_totalActivitys[activityId] = ActivityData.New(data)

            -- 这个地方请求票选详细信息
            if activity.type == ActivityType.VOTE then
                VotingDataMgr:GetInstance():InitVotingData()
            end
        end
    end
end
--获取活动副本开放的所有章节
function M:GetActivityChapterIds()
    local tempChapterIds = {}
    local activitys = ConfigHelper.GetCfgs("activity")
    local nowTime = TimeUtil.GetNowTimeStamp()
    for activityId, activity in pairs(activitys) do
        if activity.type == ActivityType.MASKEDBALL_MAIN and nowTime > activity.startTime and nowTime < activity.endTime then
            local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=activityId})
            if #activityCopys <= 0 then
                Logger.LogError("配置错误，错误id:" .. activityId)
            else
                local activityCopy = activityCopys[1]
                tInsert(tempChapterIds, activityCopy.chapterId)
                if nowTime > activityCopy.specialTime then
                    tInsert(tempChapterIds, activityCopy.specialChapterId)
                end
            end
        end
    end
    return tempChapterIds
end
return M
