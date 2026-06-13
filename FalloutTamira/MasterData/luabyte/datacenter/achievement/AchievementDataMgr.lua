local AchievementData = require("DataCenter.Achievement.AchievementData")
local AchievementDataMgr = BaseClass("AchievementDataMgr", Singleton)
local M = AchievementDataMgr
local MessageId = Proto.MessageId


function M:AchievementData()
    local result ={}
    for i = 1, #self.m_AllData do
        if self.m_AllData[i].m_Cfg.show == 1 then
            table.insert(result, self.m_AllData[i])
        end
    end
    return result
end

function M:AchievementDataById(id)
    return MapUtil.Find(self.m_AllData, function (v) return v:Id() == id end)
end

function M:AchievementInfoData()
    return self.m_InfoToAchievement
end

function M:FinishDataByTaskId(id)
    return MapUtil.Find(self.m_FinishData, function (v) return v.Id == id end)
end

function M:CurScore()
    return self:_ComputeNumByType("Score", 0)
end

function M:DoneNum(id)
    return self:_ComputeNumByType("DoneNum", id or 0)
end

function M:RewardNum(id)
    return self:_ComputeNumByType("RewardNum", id or 0)
end

function M:TaskNum()
    local num = 0
    for i,v in ipairs(self.m_AllData) do
        if self.m_AllData[i].m_Cfg.show == 1 then
            num = num + #(v:Tasks())
        end
    end
    return num
end

-- 获取成就详细信息
function M:SendRequestAchievementGroupDetail(id, callback)
    self.m_CallBack = callback

    local data = {}
    data.AchievementGroupId = id
    NetPack:SendMessage(MessageId.RequestAchievementGroupDetail, data)
end

-- 领取成就奖励
function M:SendRequestAchievementReward(groupId, id, callback)
    --领取成就奖励回调函数
    self.m_CallBackReward = callback
    local data = {}
    data.AchievementGroupId = groupId
    data.AchievementId = id
    NetPack:SendMessage(MessageId.RequestAchievementAward, data)
end

-- 领取所有成就奖励
function M:SendRequestAchievementRewardAll()
    local data = {}
    NetPack:SendMessage(MessageId.RequestAchievementAwardAll, data)
end

-- 获取个人展示柜成就
function M:SendRequestAchievementShowInfo(callback)
    if #self.m_InfoToAchievement > 0 then
        callback()
        return
    end

    self.m_CallBack = callback
    NetPack:SendMessage(MessageId.RequestAchievementShowInfo, {})
end

-- 编辑个人展示柜成就
function M:SendRequestAchievementShow(data, callback)
    self.m_CallBack = callback
    self.m_CacheData = data

    local request = {}
    request.Achievements = data  
    NetPack:SendMessage(MessageId.RequestUpdateAchievementShow, request)
end

function M:_ComputeNumByType(name, id)
    local data = id ~= 0 and { self:AchievementDataById(id) } or self.m_AllData 
    local num = 0
    for i,v in ipairs(data) do
        num = num + v[name](v)
    end
    return num
end

function M:_SortData()
    -- 排个序
    table.sort( self.m_AllData, function (v1, v2)
        local r1 = v1:RewardNum()
        local r2 = v2:RewardNum()
        local id1 = v1:Id()
        local id2 = v2:Id()

        if r1 > 0 and r2 > 0 then
            return id1 < id2
        end

        if r1 == r2 then
            return id1 < id2
        end

        return r1 > r2
    end )
end

function M:__init()
    self.m_AllData = {}
    self.m_CallBack = nil
    self.m_InfoToAchievement = {}
    self.m_ResponseEnterAchievementGroup = NetPack:RegistResponse(MessageId.ResponseEnterAchievementGroup, Bind(self, self._OnResponseEnterAchievementGroupCallBack))
    self.m_ResponseAchievementGroupDetail = NetPack:RegistResponse(MessageId.ResponseAchievementGroupDetail, Bind(self, self._OnResponseAchievementGroupDetailCallBack))
    self.m_ResponseAchievementAward = NetPack:RegistResponse(MessageId.ResponseAchievementAward, Bind(self, self._OnResponseAchievementAwardCallBack))
    self.m_ResponseAchievementAwardAll = NetPack:RegistResponse(MessageId.ResponseAchievementAwardAll, Bind(self, self._OnResponseAchievementAllAwardCallBack))
    self.m_NotifyUpdateAchievement = NetPack:RegistResponse(MessageId.NotifyUpdateAchievement, Bind(self, self._OnNotifyUpdateAchievementCallBack))
    self.m_ResponseAchievementShowInfo = NetPack:RegistResponse(MessageId.ResponseAchievementShowInfo, Bind(self, self._OnResponseAchievementShowInfoCallBack))
    self.m_ResponseUpdateAchievementShow = NetPack:RegistResponse(MessageId.ResponseUpdateAchievementShow, Bind(self, self._OnResponseUpdateAchievementShowCallBack))
end

function M:_OnResponseUpdateAchievementShowCallBack(messagId, result, msg)
    if (result ~= 0) then
        Logger.LogError("【Achievement】编辑成就展示柜 错误码：" .. result)
        return
    end
    
    self.m_InfoToAchievement = self.m_CacheData
    self:_CallBack()
end

function M:_OnResponseAchievementShowInfoCallBack(messagId, result, msg)
    if (result ~= 0) then
        Logger.LogError("【Achievement】获取成就展示柜 错误码：" .. result)
        return
    end
    
    self.m_InfoToAchievement = msg.Achievements
    self:_CallBack()
end

function M:_OnNotifyUpdateAchievementCallBack(messagId, result, msg)
    if (result ~= 0) then
        Logger.LogError("【Achievement】成就进度通知 错误码：" .. result)
        return
    end

    for kk,kv in pairs(msg.notifyData) do
        local data = MapUtil.Find(self.m_AllData, function (v) return kv.AchievementGroupId == v:Id() end)

        if data then
            data:RewardTask(kv.data)
        end
    end

    self:_SortData()
    IRedPointMgr:ForceCheck(RedPointConst.AchievementRewardRedPointChecker)
    EventMgr:Broadcast(UIMessageNames.NOTIFY_UPDATE_ACHIEVEMENT, msg.AchievementGroupId)
end

function M:_OnResponseAchievementAwardCallBack(messagId, result, msg)
    if (result ~= 0) then
        Logger.LogError("【Achievement】领取成就奖励 错误码：" .. result)
        return
    end

    local awardData = {}
    for _,kv in ipairs(msg.Awards) do
        if awardData[kv.Id] then
            awardData[kv.Id] = awardData[kv.Id] + kv.Cnt
        else
            awardData[kv.Id] = kv.Cnt
        end
    end
    
    self:_SortData()
    IRedPointMgr:ForceCheck(RedPointConst.AchievementRewardRedPointChecker)
    GameHelper.ShowGetItems(awardData)

    if self.m_CallBackReward then
        self.m_CallBackReward()
        self.m_CallBackReward = nil
    end
end


function M:_OnResponseAchievementAllAwardCallBack(messagId, result, msg)
    if (result ~= 0) then
        Logger.LogError("【Achievement】领取成就奖励 错误码：" .. result)
        return
    end

    local awardData = {}
    for _,kv in ipairs(msg.Awards) do
        if awardData[kv.Id] then
            awardData[kv.Id] = awardData[kv.Id] + kv.Cnt
        else
            awardData[kv.Id] = kv.Cnt
        end
    end
    
    self:_SortData()
    IRedPointMgr:ForceCheck(RedPointConst.AchievementRewardRedPointChecker)
    GameHelper.ShowGetItems(awardData)
end

function M:_OnResponseEnterAchievementGroupCallBack(messagId, result, msg)
    self._dataLoaded = true
    self._isloading = false

    if (result ~= 0) then
        Logger.LogError("【Achievement】获取成就套件数据 错误码：" .. result)
        return
    end

    self.m_AllData = {}
    self.m_FinishData = msg.Finished

    local cfg = ConfigHelper.GetCfgs("achievementGroup") 
    for i,k in pairs(cfg) do
        local msgData = MapUtil.Find(msg.AchievementGroups, function (v) return k.id == v.GroupId end)
        local data = AchievementData.New(k, msgData or {}, self)
        table.insert(self.m_AllData, data)
    end

    self:_SortData()
end

function M:_OnResponseAchievementGroupDetailCallBack(messagId, result, msg)
    if (result ~= 0) then
        Logger.LogError("【Achievement】成就详细详细数据 错误码：" .. result)
        return
    end

    local data = MapUtil.Find(self.m_AllData, function (v) return msg.AchievementGroupId == v:Id() end)
    data:Update(msg)
    
    self:_SortData()
    self:_CallBack(data)
end

function M:_CallBack(...)
    if not self.m_CallBack then
        return
    end

    self.m_CallBack(...)
end

function M:_Destory()
    NetPack:UnRegistResponse(MessageId.ResponseEnterAchievementGroup, self.m_ResponseEnterAchievementGroup)
    NetPack:UnRegistResponse(MessageId.ResponseAchievementGroupDetail, self.m_ResponseAchievementGroupDetail)
    NetPack:UnRegistResponse(MessageId.ResponseAchievementAward, self.m_ResponseAchievementAward)
    NetPack:UnRegistResponse(MessageId.ResponseAchievementAwardAll, self.m_ResponseAchievementAwardAll)
    NetPack:UnRegistResponse(MessageId.NotifyUpdateAchievement, self.m_NotifyUpdateAchievement)
    NetPack:UnRegistResponse(MessageId.ResponseUpdateAchievementShow, self.m_ResponseUpdateAchievementShow)
    NetPack:UnRegistResponse(MessageId.ResponseAchievementShowInfo, self.m_ResponseAchievementShowInfo)
end

function M:Dispose()
    self:_Destory()
end

--IDataGetter start 
--用于在登录的时候初始化相关数据
function M:LoadData()
    self._isloading = true 
    self._dataLoaded = false
    self._errorCode = 0
    NetPack:SendMessage(MessageId.RequestEnterAchievementGroup, {})
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

--IDataGetter end 


return AchievementDataMgr
