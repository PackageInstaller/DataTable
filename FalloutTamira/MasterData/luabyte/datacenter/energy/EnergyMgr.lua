-- 体力系统

local M = BaseClass("EnergyMgr", Singleton)
local MessageId = Proto.MessageId
function M:__init()
    self.m_energy = 0         -- 体力
    self.m_buyTimes = 0       -- 购买次数
    self.m_buyStamp = 0       -- 最后购买体力的时间
    self.m_recStamp = 0       -- 当前恢复体力时间戳,0 表示暂停

    self.m_recTimer = nil     -- 自动恢复定时器
    self.m_buyTimer = nil     -- 重置购买次数定时器
    local sys249 = GameHelper.GetParamters(249)
    self.m_recGap = sys249[1] -- 自动恢复体力间隔
    self.m_recVal = sys249[0] -- 自动恢复体力数量
    local sys248 = GameHelper.GetParamters(248)
    self.m_usableEnergyLimit = sys248[0]

    self.m_buyLimit = 0 -- 每日购买体力限制
    for _, value in pairs(ConfigHelper.GetCfgs("energyBuy") or {}) do
        if value.times > self.m_buyLimit then
            self.m_buyLimit = value.times
        end
    end

    self.m_recHandler = Bind(self, self.OnRecEnergyTimer)
    self.m_buyHandler = Bind(self, self.OnBuyEnergyTimer)

    self.m_rsEnergyInfo = NetPack:RegistResponse(MessageId.ResponseEnergyInfo, Bind(self, self.OnRsEnergyInfo))
    self.m_onEnergyChange = NetPack:RegistResponse(MessageId.NotifyEnergyChange, Bind(self, self.OnNotifyEnergyChange))
    self.m_rsRecoveryEnergy = NetPack:RegistResponse(MessageId.ResponseRecoveryEnergy,
        Bind(self, self.OnRsRecoveryEnergy))
end

---------------------初始化数据Begin----------------------

--IDataGetter start
--用于在登录的时候初始化相关数据
function M:LoadData()
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0
    self:RequestLoadEnergy()
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

---------------------初始化数据End----------------------

function M:Dispose()
    self.m_energy = 0
    self.m_buyTimes = 0
    self.m_buyStamp = 0
    self.m_recStamp = 0
    self:_StopBuyTimer()
    self:_StopRecoveryTimer()

    if self.m_rsBuyEnenry then
        NetPack:UnRegistResponse(MessageId.ResponseBuyEnergy, self.m_rsBuyEnenry)
        self.m_rsBuyEnenry = nil
    end
    NetPack:UnRegistResponse(MessageId.ResponseEnergyInfo, self.m_rsEnergyInfo)
    NetPack:UnRegistResponse(MessageId.NotifyEnergyChange, self.m_onEnergyChange)
    NetPack:UnRegistResponse(MessageId.ResponseRecoveryEnergy, self.m_rsRecoveryEnergy)
end

-- 定时恢复
function M:_TimingRecovery(delay)
    self:_StopRecoveryTimer()
    if not self:IsFullEnergy() then
        local remain = self:RemainRecTime()
        self:_StartRecoveryTimer(remain + (delay or 0))
    end
end

-- 定时刷新购买次数
function M:_TimingRefreshBuyTimes()
    self:_StopBuyTimer()
    -- 当天开始时间戳 00:00:00
    local dayStartTime = TimeUtil.GetNowTimerStart(TimeUtil.GetNowTimeStamp())
    local buyRecGap = (dayStartTime + 3600 * 5) - self.m_buyStamp --加5小时，5点刷新
    -- 最后购买时间戳小于今日5点，定时刷新，刚好5点默认已刷新
    if buyRecGap > 0 then
        self.m_buyTimer = TimerManager:GetInstance():GetTimer(buyRecGap, self.m_buyHandler, self, true, nil, true)
        self.m_buyTimer:Start()
    end
end

function M:_StopBuyTimer()
    if self.m_buyTimer then
        self.m_buyTimer:Stop()
        self.m_buyTimer = nil
    end
end

function M:_StopRecoveryTimer()
    if self.m_recTimer then
        self.m_recTimer:Stop()
        self.m_recTimer = nil
    end
end

function M:_StartRecoveryTimer(gap)
    self.m_recTimer = TimerManager:GetInstance():GetTimer(gap, self.m_recHandler, self, true, nil, true)
    self.m_recTimer:Start()
end

-- 定时请求恢复体力
function M:OnRecEnergyTimer()
    self:_StopRecoveryTimer()
    local remain = self:RemainRecTime()
    -- 防止时间未到
    if remain > 0 then
        self:_StartRecoveryTimer(remain)
    else
        NetPack:SendMessage(MessageId.RequestRecoveryEnergy, {})
    end
end

-- 定时刷新购买次数
function M:OnBuyEnergyTimer()
    self:_StopBuyTimer()

    self.m_buyTimes = 0
    self.m_buyStamp = TimeUtil.GetNowTimeStamp()
    EventMgr:Broadcast(UIMessageNames.ENERGY_BUYTIMES_NOTIFY)
end

-- ResponseEnergyInfo 体力信息,登录时请求返回
function M:OnRsEnergyInfo(_, result, msg)
    self._errorCode = result
    self._dataLoaded = true
    self._isloading = false

    if result ~= 0 then return end

    local oldValue = self.m_energy
    self.m_energy = msg.Value
    self.m_buyTimes = msg.BuyTimes
    self.m_buyStamp = msg.BuyTime
    self.m_recStamp = msg.StartRecoveryTime

    self:_TimingRecovery()
    self:_TimingRefreshBuyTimes()

    if oldValue ~= self.m_energy then
        EventMgr:Broadcast(UIMessageNames.ENERGY_CHANGED_NOTIFY)
    end
end

-- ResponseRecoveryEnergy 恢复体力
function M:OnRsRecoveryEnergy(_, result, _)
    -- Logger.Log("Recovery:" .. self.m_recStamp .. " || Error Time:" .. TimeUtil.GetNowTimeStamp())
    if result == -1 then self:_TimingRecovery(2) end
end

-- NotifyEnergyChange 体力恢复
function M:OnNotifyEnergyChange(_, result, msg)
    if result ~= 0 then return end

    local oldValue = self.m_energy
    self.m_energy = msg.Value
    self.m_recStamp = msg.StartRecoveryTime

    self:_TimingRecovery()

    if oldValue ~= self.m_energy then
        EventMgr:Broadcast(UIMessageNames.ENERGY_CHANGED_NOTIFY)
    end
end

-- ResponseBuyEnergy 体力购买
function M:OnRsBuyEnenry(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsBuyEnenry)
    self.m_rsBuyEnenry = nil
    if result ~= 0 then return end

    -- 购买成功，通过NotifyEnergyChange通知
    self.m_buyTimes = msg.BuyTimes
    self.m_buyStamp = msg.BuyTime
    EventMgr:Broadcast(UIMessageNames.ENERGY_BUYTIMES_NOTIFY)

    -- 兑换成功，增加体力%d
    local tips = ConfigHelper.GetLocalString(5184)
    local buyCfg = ConfigHelper.GetCfgByLua("energyBuy", self.m_buyTimes) or {}
    GameHelper.Tips(string.format(tips, buyCfg.addEnergy))
    --体力购买埋点
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Energy)
end

function M:RequestLoadEnergy()
    NetPack:SendMessage(MessageId.RequestEnergyInfo, {})
end

-- 体力值
function M:EnergyValue()
    return self.m_energy
end

-- 当前等级体力上限
function M:EnergyLimit()
    local lvCfg = ConfigHelper.GetCfg("homepageLevel", IPlayerData.level) or {}
    return lvCfg.energy or 0
end

-- 购买体力次数
function M:BuyTimes()
    return self.m_buyTimes
end

-- 购买体力上限
function M:BuyLimit()
    return self.m_buyLimit
end

-- 当前可用体力上限
function M:MaxEnergyLimit()
    return self.m_usableEnergyLimit
end

-- 剩余购买次数
function M:RemainBuyTimes()
    return self.m_buyLimit - self.m_buyTimes
end

-- 是否满体力
function M:IsFullEnergy()
    return self.m_energy >= self:EnergyLimit()
end

-- 剩余刷新时间
function M:RemainRecTime()
    if self.m_recStamp > 0 then
        local nextRecTime = self.m_recStamp + self.m_recGap
        local curTime = TimeUtil.GetNowTimeStamp()
        return math.max(0, nextRecTime - curTime)
    end
    return 0
end

-- 剩余总恢复时间戳
function M:RemainWholeRecTime()
    if self.m_recStamp > 0 then
        local value = math.max(0, self:EnergyLimit() - self:EnergyValue())
        return self.m_recStamp + self.m_recGap * value
    end
    return 0
end

-- 请求购买体力
function M:RqBuyEnenry()
    if self.m_rsBuyEnenry then return end

    self.m_rsBuyEnenry = NetPack:RegistResponse(MessageId.ResponseBuyEnergy, Bind(self, self.OnRsBuyEnenry))

    NetPack:SendMessage(MessageId.RequestBuyEnergy, {})
end

return M
