-- print("Class.class LoopVo", LoopVo)
local LiveLoopVo = Class.class("LiveLoopVo", LoopVo)
function LiveLoopVo:setData(liveID, cusDelay, cusRepeat, cusThisObject, cusCallBack, cusOverBack, cusOverBackParams)
    LiveLoopVo.super.setData(self, cusDelay, cusRepeat, cusThisObject, cusCallBack, cusOverBack, cusOverBackParams)
    self.m_liveID = liveID
end

module("fight.LiveLooper", Class.impl())
FRAME = 60
DELTA_TIME = 1/FRAME

function ctor(self)
    RootLoop:addTicker(self)
    --帧循环
    self.m_frameList = {}
    self.m_frameLoopList = {}
    --时间循环
    self.m_timeList = {}
    self.m_timeLoopList = {}
    self.m_removeList = {}
    --速率余数
    self.m_rate_residue = 0
    --当前正常情况下是否暂停(通常是特写镜头时要用到的情况)
    self.m_beStop = false
    self.m_nonStopLiveIDs = {}
end

-- 设置不被因特写而暂时的角色事件
function setNonStop( self,liveID )
    self.m_nonStopLiveIDs[liveID] = true
    STravelHandle:setToManual(true, liveID)
    -- BuffHandler:setToManual(true, liveID)
end
-- 移除不被因特写而暂时的角色事件
function removeNonStop( self, liveID )
    self.m_nonStopLiveIDs[liveID] = nil
    STravelHandle:setToManual(false, liveID)
    -- BuffHandler:setToManual(false, liveID)
end
-- 判断是不是特写的角色
function isNonStopLive( self, liveID )
    return self.m_nonStopLiveIDs[liveID]
end
-- 设置是否触发特写
function setNorFrameStop(self, beStop)
    if self.m_beStop==beStop then return end
    self.m_beStop = beStop
    GameDispatcher:dispatchEvent(EventName.NORMAL_FRAME_STOP)
end
-- 获取是否在特写状态
function isNorFrameStop( self )
    return self.m_beStop
end

function getDeltaTime(self)
    return LoopManager:getUnscaledDeltaTime()
    -- return DELTA_TIME
end
function getPlayRate(self)
    return RateLooper:getPlayRate()
end

function clearLive( self, liveID )
    self:removeAllLiveFrame(liveID)
    self:removeAllLiveTimer(liveID)
end

--帧循环--
function addFrame(self, liveID, cusDelay, cusRepeat, cusThisObject, cusCallBack, cusOverBack, cusOverBackParams)
    self:removeFrame(cusThisObject, cusCallBack);
    local lVo = LuaPoolMgr:poolGet(LiveLoopVo)
    lVo:setData(liveID, cusDelay, cusRepeat, cusThisObject, cusCallBack, cusOverBack, cusOverBackParams)
    if RootLoop.TimerDebug then
        lVo.debugTrace = debug.traceback();
    end
    if cusRepeat > 0 then
        table.insert(self.m_frameList, lVo)
    else
        table.insert(self.m_frameLoopList, lVo)
    end
    return lVo.m_sn
end

function removeFrame(self, cusThisObject, cusCallBack)
    for _, v in ipairs(self.m_frameList) do
        if v.m_beRemove == false and v.m_thisObject == cusThisObject and v.m_callBack == cusCallBack then
            v.m_beRemove = true
            return
        end
    end
    for _, v in ipairs(self.m_frameLoopList) do
        if v.m_beRemove == false and v.m_thisObject == cusThisObject and v.m_callBack == cusCallBack then
            v.m_beRemove = true
            return
        end
    end
end

function removeFrameByIndex(self, cusIndex)
    if not cusIndex then return end
    for _, v in ipairs(self.m_frameList) do
        if v.m_beRemove == false and v.m_sn == cusIndex then
            v.m_beRemove = true
            return
        end
    end
    for _, v in ipairs(self.m_frameLoopList) do
        if v.m_beRemove == false and v.m_sn == cusIndex then
            v.m_beRemove = true
            return
        end
    end
end
-- 移除角色的帧事件
function removeAllLiveFrame(self, liveID)
    for _, v in ipairs(self.m_frameList) do
        if v.m_beRemove == false and v.m_liveID == liveID then
            v.m_beRemove = true
        end
    end
    for _, v in ipairs(self.m_frameLoopList) do
        if v.m_beRemove == false and v.m_liveID == liveID then
            v.m_beRemove = true
        end
    end
end

function getFrameCount(self)
    return #self.m_frameList + #self.m_frameLoopList;
end

--帧循环 end--
--时间循环--
function addTimer(self, liveID, cusDelay, cusRepeat, cusThisObject, cusCallBack, cusOverBack, cusOverBackParams)
    if cusCallBack then
        self:removeTimer(cusThisObject, cusCallBack, cusDelay)
    elseif cusOverBack then
        self:_removeTimer1(cusThisObject, cusOverBack, cusDelay)
    end
    local lVo = LuaPoolMgr:poolGet(LiveLoopVo)
    lVo:setData(liveID, cusDelay, cusRepeat, cusThisObject, cusCallBack, cusOverBack, cusOverBackParams)
    if RootLoop.TimerDebug then
        lVo.debugTrace = debug.traceback();
    end
    if cusRepeat > 0 then
        table.insert(self.m_timeList, lVo)
    else
        table.insert(self.m_timeLoopList, lVo)
    end
    return lVo.m_sn
end

function setTimeout( self, liveID, cusDelay, cusThisObject, cusOverBack, cusOverBackParams )
    return self:addTimer(liveID, cusDelay, 1, cusThisObject, nil, cusOverBack, cusOverBackParams)
end

function removeTimer(self, cusThisObject, cusCallBack, cusDelay)
    if cusDelay==nil then
        for _, v in ipairs(self.m_timeList) do
            if v.m_beRemove == false and v.m_thisObject == cusThisObject and v.m_callBack == cusCallBack then
                v.m_beRemove = true
                return
            end
        end
        for _, v in ipairs(self.m_timeLoopList) do
            if v.m_beRemove == false and v.m_thisObject == cusThisObject and v.m_callBack == cusCallBack then
                v.m_beRemove = true
                return
            end
        end
    else
        for _, v in ipairs(self.m_timeList) do
            if v.m_beRemove == false and v.m_thisObject == cusThisObject and v.m_callBack == cusCallBack and v.m_delay==cusDelay then
                v.m_beRemove = true
                return
            end
        end
        for _, v in ipairs(self.m_timeLoopList) do
            if v.m_beRemove == false and v.m_thisObject == cusThisObject and v.m_callBack == cusCallBack and v.m_delay==cusDelay then
                v.m_beRemove = true
                return
            end
        end
    end
end

function _removeTimer1( self, cusThisObject, cusOverBack, cusDelay )
    if cusDelay==nil then
        for _, v in ipairs(self.m_timeList) do
            if v.m_beRemove == false and v.m_thisObject == cusThisObject and v.m_overBack == cusOverBack then
                v.m_beRemove = true
                return
            end
        end
        for _, v in ipairs(self.m_timeLoopList) do
            if v.m_beRemove == false and v.m_thisObject == cusThisObject and v.m_overBack == cusOverBack then
                v.m_beRemove = true
                return
            end
        end
    else
        for _, v in ipairs(self.m_timeList) do
            if v.m_beRemove == false and v.m_thisObject == cusThisObject and v.m_overBack == cusOverBack and v.m_delay==cusDelay then
                v.m_beRemove = true
                return
            end
        end
        for _, v in ipairs(self.m_timeLoopList) do
            if v.m_beRemove == false and v.m_thisObject == cusThisObject and v.m_overBack == cusOverBack and v.m_delay==cusDelay then
                v.m_beRemove = true
                return
            end
        end
    end
end

function removeTimerByIndex(self, cusIndex)
    if not cusIndex then return end
    for _, v in ipairs(self.m_timeList) do
        if v.m_beRemove == false and v.m_sn == cusIndex then
            v.m_beRemove = true
            return
        end
    end
    for _, v in ipairs(self.m_timeLoopList) do
        if v.m_beRemove == false and v.m_sn == cusIndex then
            v.m_beRemove = true
            return
        end
    end
end
-- 移除角色的Timer事件
function removeAllLiveTimer( self, liveID )
    for _, v in ipairs(self.m_timeList) do
        if v.m_beRemove == false and v.m_liveID == liveID then
            v.m_beRemove = true
        end
    end
    for _, v in ipairs(self.m_timeLoopList) do
        if v.m_beRemove == false and v.m_liveID == liveID then
            v.m_beRemove = true
        end
    end
end

function getTimerCount(self)
    return #self.m_timeList + #self.m_timeLoopList;
end

function removeAll(self)
    --帧循环
    self.m_frameList = {}
    self.m_frameLoopList = {}
    --时间循环
    self.m_timeList = {}
    self.m_timeLoopList = {}
    self.m_removeList = {}
end

--循环
function update(self)
    -- 非整数速率累计到下次
    local rate = self:getPlayRate()
    -- 游戏暂停
    if rate==0 then
        return
    end
    -- 触发特写帧并没有数据要处理的情况
    if self.m_beStop==true and table.empty(self.m_nonStopLiveIDs) then
        return
    end

    local rate, residue = math.modf(rate)
    if residue>=0 then
        self.m_rate_residue = self.m_rate_residue + residue
        local integer, residue = math.modf(self.m_rate_residue)
        self.m_rate_residue = residue
        rate = rate + integer
    end

    local deltaTime = self:getDeltaTime()
    local rateDeltaTime = deltaTime*rate
    
    self:_updateTimers(self.m_frameList, 1, rateDeltaTime)
    self:_updateTimers(self.m_frameLoopList, 1, rateDeltaTime)
    self:_updateTimers(self.m_timeList, rateDeltaTime, rateDeltaTime)
    self:_updateTimers(self.m_timeLoopList, rateDeltaTime, rateDeltaTime)
end

function _updateTimers(self, checkTimers, counter, deltaTime)
    if next(checkTimers) then
        -- local timeLoopRate = 0
        -- while timeLoopRate < rate do
            local cnt = #checkTimers
            for i = 1, cnt do
                local vo = checkTimers[i]
                if vo and vo.m_beRemove == false then
                    if not self.m_beStop or self.m_nonStopLiveIDs[vo.m_liveID] then 
                        vo.m_counter = vo.m_counter - counter
                        if vo.m_counter <= 0 then
                            vo.m_counter = vo.m_delay
                            if vo.m_callBack then
                                if RootLoop.TimerDebug then
                                    TimeUtil:startTime()
                                end
                                vo.m_callBack(vo.m_thisObject, deltaTime)
                                if RootLoop.TimerDebug then
                                    TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                                end
                            end
                            if vo.m_repeatTime > 0 then
                                vo.m_repeatTime = vo.m_repeatTime - 1
                                if vo.m_repeatTime <= 0 then
                                    if vo.m_overBack then
                                        if RootLoop.TimerDebug then
                                            TimeUtil:startTime()
                                        end
                                        vo.m_overBack(vo.m_thisObject, vo.m_overBackParams)
                                        if RootLoop.TimerDebug then
                                            TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                                        end
                                    end
                                    vo.m_beRemove = true
                                    table.insert(self.m_removeList, i)
                                end
                            end
                        end
                    end
                else
                    table.insert(self.m_removeList, i)
                end
            end
            if next(self.m_removeList) then
                for i = #self.m_removeList, 1, -1 do
                    local idx = self.m_removeList[i]
                    LuaPoolMgr:poolRecover(checkTimers[idx])
                    table.remove(checkTimers, idx)
                end
                self.m_removeList = {}
            end
        --     timeLoopRate = timeLoopRate + 1
        -- end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
