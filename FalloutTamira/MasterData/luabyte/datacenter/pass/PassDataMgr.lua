local M = BaseClass("PassDataMgr", Singleton)
local tInsert = table.insert
local MessageId = Proto.MessageId
local tIsNullOrEmpty = table.isNullOrEmpty

function M:__init()
    self.m_passLevel = 1
    self.m_passInfo = nil -- 服务器数据 message PassInfo
    self.m_passGroups = nil
    self.m_taskGroups = nil
    self.m_shopGroups = nil
    self.m_rewardGroups = nil
    self.m_mainActivityId = 0
    self.m_taskActivityId = 0
    self.m_shopActivityId = 0
    self.m_isPlayShop = false
    self.m_buyExpCallback = nil
    self.m_pointId = GameHelper.GetParamter(328) -- 通行证点数道具ID

    local taskHandler = Bind(self, self.OnPassTaskUpdate)
    local notifyHandler = Bind(self, self.OnNotifyPassInfoChange)
    self.m_onPassTaskUpdate = EventMgr:AddListener(UIMessageNames.ACTIVITY_UPDATE, taskHandler)
    self.m_passInfoChanged = NetPack:RegistResponse(MessageId.NotifyPassInfoChange, notifyHandler)
end

---------------------IDataGetter Begin-----------------
-- 用于在登录的时候初始化相关数据
function M:LoadData()
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0
    self:EnterPass()
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

---------------------IDataGetter End-------------------

---------------------初始化数据Begin----------------------

function M:_InitPassGroups()
    if not self.m_passGroups or not self.m_rewardGroups then
        self.m_passGroups = {}
        self.m_rewardGroups = {}
        local activityId = self.m_mainActivityId or 0
        for _, pass in pairs(ConfigHelper.GetCfgs("pass") or {}) do
            if pass.passId == activityId then
                tInsert(self.m_passGroups, pass)
                if pass.isStage == 1 then
                    tInsert(self.m_rewardGroups, pass)
                end
            end
        end
        table.sort(self.m_rewardGroups, function(a, b)
            return a.passLevel < b.passLevel
        end)
        table.sort(self.m_passGroups, function(a, b)
            return a.passLevel < b.passLevel
        end)
    end
end

function M:_InitTaskGroups()
    if not self.m_taskGroups then
        self.m_taskGroups = {}
        local activityId = self.m_taskActivityId or 0
        for _, passTask in pairs(ConfigHelper.GetCfgs("passTask") or {}) do
            if passTask.passId == activityId then
                local taskType = passTask.taskType
                local group = self.m_taskGroups[taskType]
                if not group then group = {} end
                passTask.progress = 0
                passTask.state = PassConst.TaskState.Doing
                tInsert(group, passTask)
                self.m_taskGroups[taskType] = group
            end
        end
        self:_UpdateTaskStates(activityId)
    end
end

function M:_UpdateTaskStates(activityId)
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(activityId, function(data)
        local taskDataDic = {}
        for _, value in pairs(data or {}) do
            taskDataDic[value.SubActivityId] = value
        end
        for _, list in pairs(self.m_taskGroups or {}) do
            for _, passTask in ipairs(list or {}) do
                local roleAct = taskDataDic[passTask.id]
                if roleAct then
                    passTask.progress = roleAct.Value0
                    passTask.state = roleAct.State
                end
            end
            TaskHelper.SortTasks(list)
        end
        EventMgr:Broadcast(UIMessageNames.PASS_TASK_UPDATE)
    end)
end

function M:_InitShopGroups()
    if not self.m_shopGroups then
        self.m_shopGroups = {}
        local activityId = self.m_shopActivityId or 0
        for _, passShop in pairs(ConfigHelper.GetCfgs("passShop") or {}) do
            if passShop.activityId == activityId then
                self.m_shopGroups[passShop.passBagType] = passShop
            end
        end
    end
end

---------------------初始化数据End----------------------

---------------------网络消息Begin----------------------

function M:SendBuyPassExp(level, callback)
    if self.m_rsBuyExp then
        return
    end

    local buyHandler = Bind(self, self.OnResponseBuyPassExp)
    self.m_rsBuyExp = NetPack:RegistResponse(MessageId.ResponseBuyPassExp, buyHandler)
    self.m_buyExpCallback = callback
    local request = { ActivityId = self.m_mainActivityId, BuyGrade = level }
    NetPack:SendMessage(MessageId.RequestBuyPassExp, request)
end

function M:OnResponseBuyPassExp(messageId, result, _)
    NetPack:UnRegistResponse(messageId, self.m_rsBuyExp)
    self.m_rsBuyExp = nil
    if result ~= 0 then
        return
    end

    if self.m_buyExpCallback then
        self.m_buyExpCallback()
        self.m_buyExpCallback = nil
    end
end

---------------------网络消息End----------------------

---------------------获取数据Begin--------------------

function M:GetPassGroups()
    return self.m_passGroups or {}
end

function M:GetTaskGroups()
    return self.m_taskGroups or {}
end

function M:GetShopPackByType(packType)
    if not self.m_shopGroups then return nil end
    return self.m_shopGroups[packType]
end

function M:GetTaskListByType(taskType)
    if not self.m_taskGroups then return nil end
    return self.m_taskGroups[taskType]
end

function M:GetCompletedTaskIdsByType(taskType)
    local list, ids = self:GetTaskListByType(taskType), {}
    local Completed = PassConst.TaskState.MissionComplete
    for _, passTask in ipairs(list or {}) do
        if passTask.state == Completed then
            tInsert(ids, passTask.id)
        end
    end
    return ids
end

function M:GetPassCfgByLevel(level)
    local len = self.m_passGroups and #self.m_passGroups or 0
    for i = level, len do
        local pass = self.m_passGroups[i]
        if pass.passLevel == level then return pass end
    end
    return nil
end

function M:GetActivityId()
    return self.m_mainActivityId or 0
end

-- 最后一次购买通行证的商城id（passShop Id）
function M:GetLastPassShopId()
    if not self.m_passInfo then return 0 end
    return self.m_passInfo.LastBuyShopId or 0
end

function M:GetTaskActivityId()
    return self.m_taskActivityId or 0
end

-- 本期通行证商店id
function M:GetShopActivityId()
    return self.m_shopActivityId or 0
end

-- 本期通行证期数
function M:GetCurOrder()
    local actId = self:GetShopActivityId() or 0
    local passShop = ConfigHelper.GetCfgsByLua("passShop", { activityId = actId })
    if not passShop or (#passShop <= 0) then return 0 end
    return passShop[1].order
end

-- 当前通行证等级
function M:GetPassLevel()
    if not self.m_passGroups then return 1 end
    local maxLevel = self:GetMaxLevel()
    if self.m_passLevel >= maxLevel then return maxLevel end

    local passPoint = self:GetPassPoint()
    for i = self.m_passLevel, #self.m_passGroups, 1 do
        local pass = self.m_passGroups[i]
        if pass.upgradePoint > passPoint then
            self.m_passLevel = pass.passLevel
            return self.m_passLevel
        end
    end
    self.m_passLevel = maxLevel
    return self.m_passLevel
end

-- 通行证最大等级
function M:GetMaxLevel()
    local len = self.m_passGroups and #self.m_passGroups or 0
    if len > 0 then
        return self.m_passGroups[len].passLevel
    end
    return 1
end

-- 首个未领取奖励的等级
function M:FirstUnGetPassLevel()
    local passLevel = self:GetPassLevel()
    if not tIsNullOrEmpty(self.m_passGroups) then
        local isPaid = self:IsPaid()
        for i = 1, passLevel, 1 do
            local pass = self.m_passGroups[i]
            if pass then
                local level = pass.passLevel
                if not self:IsGetFreeReward(level) then return level end
                if isPaid and not self:IsGetPaidReward(level) then return level end
            end
        end
    end
    return passLevel
end

-- 通行证总点数
function M:GetPassPoint()
    return ItemDataMgr:GetInstance():GetItemNumById(self.m_pointId)
end

function M:GetPassPointId()
    return self.m_pointId
end

-- 本期是否购买礼包
function M:IsPaid()
    local curShopActivityId = self:GetShopActivityId()
    local passShops = ConfigHelper.GetCfgsByLua("passShop", { activityId = curShopActivityId })
    if not passShops or (#passShops <= 0) then
        Logger.LogError("passShop 配置错误!")
        return
    end

    local lastPassShopId = self:GetLastPassShopId()
    return passShops[1].order == ConfigHelper.GetCfgPropByLua("passShop", lastPassShopId, "order")
end

-- 是否已领取免费奖励
function M:IsGetFreeReward(level)
    local freeMask
    if level > 63 then
        freeMask = self.m_passInfo and self.m_passInfo.FreeRewardValue1 or 0
    else
        freeMask = self.m_passInfo and self.m_passInfo.FreeRewardValue0 or 0
    end
    return ((freeMask >> level) & 1) == 1
end

-- 付费奖励是否领取
function M:IsGetPaidReward(level)
    local paidMask
    if level > 63 then
        paidMask = self.m_passInfo and self.m_passInfo.PayRewardValue1 or 0
    else
        paidMask = self.m_passInfo and self.m_passInfo.PayRewardValue0 or 0
    end
    return ((paidMask >> level) & 1) == 1
end

function M:GetShowRewardByLevel(curLv)
    local lastLevel = 0
    for _, pass in ipairs(self.m_rewardGroups or {}) do
        local level = pass.passLevel
        if (curLv > lastLevel) and (curLv <= level) then return pass end
        lastLevel = level
    end
    return nil
end

function M:GetRewardGroupsByLevel(level)
    local groups, isPaid = {}, self:IsPaid()
    local startLv = math.min(self:GetPassLevel() + 1, self:GetMaxLevel())
    if level >= startLv then
        for i = startLv, level, 1 do
            local pass = self:GetPassCfgByLevel(i)
            if pass then
                tInsert(groups, pass.freeReward)
                if isPaid then
                    tInsert(groups, pass.payReward)
                end
            end
        end
    end
    return groups
end

---------------------获取数据End----------------------

---------------------数据判断Begin--------------------

function M:HasRewardItemPending()
    if not tIsNullOrEmpty(self.m_passGroups) then
        local isPaid = self:IsPaid()
        for i = self:GetPassLevel(), 1, -1 do
            local pass = self.m_passGroups[i]
            if pass then
                local level = pass.passLevel
                if not self:IsGetFreeReward(level) then return true end
                if isPaid and not self:IsGetPaidReward(level) then return true end
            end
        end
    end
    return false
end

---------------------数据判断End----------------------

function M:EnterPass(callback)
    if self.m_rsEnterPass then
        self._isloading = false
        self._dataLoaded = true
        self._errorCode = 0
        return false
    end
    self.m_enterPassCallback = callback
    self.m_rsEnterPass = NetPack:RegistResponse(MessageId.ResponseEnterPass, Bind(self, self.OnResponseEnterPass))
    NetPack:SendMessage(MessageId.RequestEnterPass, {})
    self._isloading = false
    self._dataLoaded = true
    self._errorCode = 0
    return false
end

function M:OnResponseEnterPass(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsEnterPass)
    self.m_rsEnterPass = nil

    self._isloading = false
    self._dataLoaded = true
    self._errorCode = result
    if result ~= 0 then return end

    self.m_passInfo = msg.Data
    self.m_mainActivityId = self.m_passInfo.ActivityId
    local activity = ConfigHelper.GetCfgByLua("activity", self.m_mainActivityId)
    if activity then
        local relationId = activity.relationId
        if relationId and #relationId >= 2 then
            self.m_taskActivityId = relationId[1]
            self.m_shopActivityId = relationId[2]
        else
            self.m_taskActivityId = 0
            self.m_shopActivityId = 0
        end
        self:_InitPassGroups()
        self:_InitTaskGroups()
        self:_InitShopGroups()
        local data = ActivityDataMgr:GetInstance():GetActivityData(self.m_mainActivityId)
        if data and data:IsOpen() and self.m_enterPassCallback then
            if self.m_mainActivityId == 0 then
                GameHelper.TipsById(5790)
            else
                self.m_enterPassCallback(activity.prefabPath)
            end
            self.m_enterPassCallback = nil
        end
    else
        Logger.LogError("activity is 空, id = " .. self.m_mainActivityId)
    end
end

function M:OnNotifyPassInfoChange(_, result, msg)
    if result ~= 0 then return end

    self.m_passInfo = msg.Data
    self.m_mainActivityId = self.m_passInfo.ActivityId
    EventMgr:Broadcast(UIMessageNames.PASS_INFO_CHANGED)
end

-- 一键领取所有通行证等级奖励
function M:QuickGetPassLevelRewards(callback)
    local activityId = self:GetActivityId()
    local passIds, rewardTypes = self:GetRewardPassIds()
    if (activityId == 0) or (#passIds == 0) then return end
    ActivityDataMgr:GetInstance():SendCommonReward(activityId, passIds, callback, rewardTypes)
end

function M:QuickGetPassTaskRewards(taskType, callback)
    local activityId = self:GetTaskActivityId()
    local ids, nums = self:GetCompletedTaskIdsByType(taskType), {}
    if (activityId == 0) or (#ids == 0) then return end
    for _, _ in ipairs(ids) do tInsert(nums, 1) end
    ActivityDataMgr:GetInstance():SendCommonReward(activityId, ids, callback, nums)
end

-- 可领取的通行证奖励id
function M:GetRewardPassIds()
    local groups, passIds, rewardTypes = self:GetPassGroups(), {}, {}
    if not groups or #groups == 0 then
        return passIds, rewardTypes
    end
    local isPaid, RewardType = self:IsPaid(), PassConst.RewardType
    for i = 1, self:GetPassLevel(), 1 do
        local pass = groups[i]
        local level = pass.passLevel or 0
        local isFreeReward = not self:IsGetFreeReward(level)
        local isPaidReward = isPaid and not self:IsGetPaidReward(level)
        if (level > 0) and (isPaidReward or isFreeReward) then
            if isPaidReward and isFreeReward then
                tInsert(rewardTypes, RewardType.All)
            elseif isPaidReward then
                tInsert(rewardTypes, RewardType.Paid)
            else
                tInsert(rewardTypes, RewardType.Free)
            end
            tInsert(passIds, pass.id)
        end
    end
    return passIds, rewardTypes
end

-- 是否有可领取奖励
function M:IsPassLevelReward()
    local groups = self:GetPassGroups()
    local len = groups and #groups or 0
    if len == 0 then return false end
    local isPaid = self:IsPaid()
    for i = 1, self:GetPassLevel(), 1 do
        local pass = groups[i]
        local level = pass.passLevel or 0
        local isFreeReward = not self:IsGetFreeReward(level)
        local isPaidReward = isPaid and not self:IsGetPaidReward(level)
        if (level > 0) and (isPaidReward or isFreeReward) then return true end
    end
    return false
end

function M:OnPassTaskUpdate(activityId)
    local actId = self:GetTaskActivityId()
    if (actId == 0) or (actId ~= activityId) then return end

    self:_UpdateTaskStates(activityId)
end

-- 是否有可完成通行证任务
function M:HasCompletedTaskByType(taskType)
    local tasklist = self:GetTaskGroups()[taskType]
    local Completed = PassConst.TaskState.MissionComplete
    for _, passTask in ipairs(tasklist or {}) do
        if passTask.state == Completed then return true end
    end
    return false
end

-- 是否播放通行证商店动画
function M:IsPlayShop()
    return self.m_isPlayShop
end

function M:SetPlayShop(state)
    self.m_isPlayShop = state
end

-- 通行证任务红点 0:全部, 1:今日任务, 2:本周任务, 3:本期任务
function M:CheckPassTaskRedPoint(taskType)
    if self:GetPassLevel() == self:GetMaxLevel() then
        if not self:CheckPassRewardRedPoint(0) then return false end
    end

    if taskType > 0 then
        return self:HasCompletedTaskByType(taskType)
    end

    if taskType == 0 then
        for _, value in pairs(PassConst.PassTaskType) do
            if self:HasCompletedTaskByType(value) then return true end
        end
    end
    return false
end

-- 通行证奖励红点 0:全部等级
function M:CheckPassRewardRedPoint(level)
    if not tIsNullOrEmpty(self.m_passGroups) and (level >= 0) then
        local passLv = self:GetPassLevel()
        if level > passLv then return false end

        local isPaid = self:IsPaid()
        if level == 0 then
            for i = passLv, 1, -1 do
                local pass = self.m_passGroups[i]
                if pass then
                    local lv = pass.passLevel
                    if not self:IsGetFreeReward(lv) then return true end
                    if isPaid and not self:IsGetPaidReward(lv) then return true end
                end
            end
        else
            if not self:IsGetFreeReward(level) then return true end
            if isPaid and not self:IsGetPaidReward(level) then return true end
        end
    end
    return false
end

function M:Cleanup()
    self._isloading = false
    self._dataLoaded = false
    self._errorCode = 0
end

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.ResponseBuyPassExp, self.m_rsBuyExp)
    NetPack:UnRegistResponse(MessageId.NotifyPassInfoChange, self.m_passInfoChanged)
    EventMgr:RemoveListener(UIMessageNames.ACTIVITY_UPDATE, self.m_onPassTaskUpdate)

    self.m_pointId = nil
    self.m_rsBuyExp = nil
    self.m_passInfo = nil
    self.m_passLevel = nil
    self.m_passGroups = nil
    self.m_taskGroups = nil
    self.m_shopGroups = nil
    self.m_isPlayShop = nil
    self.m_rewardGroups = nil
    self.m_mainActivityId = nil
    self.m_taskActivityId = nil
    self.m_shopActivityId = nil
    self.m_buyExpCallback = nil
    self.m_passInfoChanged = nil
    self.m_onPassTaskUpdate = nil
end

return M
