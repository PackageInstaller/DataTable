local ActivityData = BaseClass("ActivityData")
local M = ActivityData

-- data 为活动配置数据  ActConfigData
function M:__init(data)
    self._data = data
end

function M:ActivityId()
    return self._data.ActivityId
end

function M:Type()
    return self._data.Type
end

function M:StartTime()
    return self._data.StartTime
end

function M:EndTime()
    return self._data.EndTime
end

function M:CloseTime()
    return self._data.CloseTime
end

function M:RoleActivity()
    return self._roleData
end

-- 更新活动进度
function M:UpdateRoleActivity(roleData)
    if not self._roleData then
        self._roleData = {}
    end

    local oldData = MapUtil.Filter(self._roleData, function(v) return v.SubActivityId == roleData.SubActivityId end)
    if MapUtil.Empty(oldData) then
        table.insert(self._roleData, roleData)
    else
        for k, _ in pairs(oldData) do
            self._roleData[k] = roleData
        end
    end

    EventMgr:Broadcast(UIMessageNames.ACTIVITY_UPDATE, roleData.ActivityId)
end

-- 更新或初始化活动详细数据
function M:UpdataActData(actData)
    if not actData then
        return
    end

    self._roleData = actData
end

--活动详细数据是否申请
function M:IsActivityReady()
    return self._roleData ~= nil
end

function M:UpdataData(data)
    self._data = data
end

--是否在开放中
function M:IsOpen()
    local cfg = self:ActivityCfg()
    if not cfg or (cfg.ifOpen ~= 1) then return false end
    if not GameHelper.CheckLockByOpenConditionIds(cfg.openCondition) then return false end

    if cfg.openType == 1 then     -- 1.开服时间（开服第N天的凌晨0点开启若第一天则几点开服几点开活动，以凌晨0点结算天数）
        -- body
    elseif cfg.openType == 2 then -- 2.固定时间（时间戳）
        return GameUtil.CheckInTime(self:StartTime(), self:EndTime())
    elseif cfg.openType == 3 then -- 3.功能达到开放条件后开始计时
        -- body
    elseif cfg.openType == 4 then -- 4.创角后开启
        -- body
    end
    return GameUtil.CheckInTime(self:StartTime(), self:EndTime())
end

--是否正在关闭中
function M:IsClosing()
    return GameUtil.CheckInTime(self:EndTime(), self:CloseTime())
end

--是否已经关闭
function M:IsClosed()
    return TimeUtil.GetNowTimeStamp() > self:CloseTime()
end

--状态
function M:State()
    if self:IsClosed() then
        return 2
    elseif self:IsClosing() then
        return 1
    elseif self:IsOpen() then
        return 0
    end
    return -1
end

-- 限时活动通关次数
function M:PassTimes()
    if self._roleData and #self._roleData > 0 then
        return self._roleData[1].Value0 or 0
    end
    return 0
end

-- 限时活动通关时间戳
function M:PassStamp()
    if self._roleData and #self._roleData > 0 then
        return self._roleData[1].Value1 or 0
    end
    return 0
end

-- 限时活动次数限制
function M:PassLimit()
    if self._roleData and #self._roleData > 0 then
        return self._roleData[1].Value2 or 0
    end
    return 0
end

-- 限时活动剩余次数
function M:RemainTimes()
    local times = self:PassTimes()
    local limit = self:PassLimit()
    return math.max(0, limit - times)
end

-- 活动剩余关闭时间
function M:RemainEndTime()
    local curTime = TimeUtil.GetNowTimeStamp()
    return math.max(0, self:EndTime() - curTime)
end

--图片是否激活
function M:FlipCardActive(idx)
    if self._roleData and #self._roleData > 0 then
        for key, value in pairs(self._roleData) do
            if  value.SubActivityId == 0 then
                return (value.Value0 & (1 << (idx))) ~= 0
            end
        end
    end
    return false
end

--奖励是否领取
function M:CheckReward(idx)
    if self._roleData and #self._roleData > 0 then
        for key, value in pairs(self._roleData) do
            if  value.SubActivityId == 0 then
                return (value.Value1 & (1 << (idx))) ~= 0
            end
        end
    end
    return false
end

--奖励是否可以领取
function M:CanReward(group)
    if self._roleData and #self._roleData > 0 then
        for key, value in pairs(self._roleData) do
            if  value.SubActivityId == 0 then
                local result = false
                for _, data in pairs(group) do
                    result = (value.Value0 & (1 << (data))) ~= 0
                    if result == false then
                        return result
                    end
                end
                return result
            end
        end
    end
    return false
end

function M:GetActiveNum(group)
    if self._roleData and #self._roleData > 0 then
        for key, value in pairs(self._roleData) do
            if  value.SubActivityId == 0 then
                local result = false
                local num = 0
                for _, data in pairs(group) do
                    result = (value.Value0 & (1 << (data))) ~= 0
                    if result == true then
                        num = num + 1
                    end
                end
                return num
            end
        end
    end
    return 0
end

function M:GetEventNode()
    if self._roleData and #self._roleData > 1 then
        for key, value in pairs(self._roleData) do
            if  value.SubActivityId == 1 then
                return value.Value0
            end
        end
    end
    return 0;
end

function M:GetEventNodeType()
    if self._roleData and #self._roleData > 1 then
        for key, value in pairs(self._roleData) do
            if  value.SubActivityId == 1 then
                return value.State
            end
        end
    end
    return 0;
end

function M:GetHistoryEventNode()
    if self._roleData and #self._roleData > 1 then
        for key, value in pairs(self._roleData) do
            if  value.SubActivityId == 1 then
                return value.Value1
            end
        end
    end
    return 0;
end

function M:CheckDormActive()
    if self._roleData and #self._roleData > 0 then
        for key, value in pairs(self._roleData) do
            local cfg = ConfigHelper.GetCfgByLua("activitySevenDay", value.SubActivityId)
            if cfg.target == 1 then
                if value.State == 2 then
                    return true
                end
            end
        end
    end
    return false
end

function M:ActivityCfg()
    local id = self:ActivityId()
    if not self._activityCfg or (self._activityCfg.id ~= id) then
        self._activityCfg = ConfigHelper.GetCfgByLua("activity", id)
        if not self._activityCfg then
            Logger.LogError("activity is nil, 检查配置, id = " .. id)
        end
    end
    return self._activityCfg
end

function M:LockId()
    local cfg = self:ActivityCfg()
    if not cfg then return 0 end
    return GameHelper.GetFirstLockReason(cfg.openCondition)
end

function M:SubActivityIds()
    local cfg = self:ActivityCfg()
    return cfg and cfg.relationId or {}
end

return ActivityData
