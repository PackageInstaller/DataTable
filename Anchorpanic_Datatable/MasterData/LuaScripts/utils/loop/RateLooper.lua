module("RateLooper", Class.impl('utils/loop/LoopManager'))
FRAME = 60

function ctor(self)
    self:init()
    RootLoop:addTicker(self)
end

function init(self)
    super.init(self)
    self.m_playRate = 1
    self.m_isStop = false
end


-- 设置播放速率
function setPlayRate(self, cusValue)
    if self.m_playRate ~= cusValue then
        self.m_playRate = cusValue
        GameDispatcher:dispatchEvent(EventName.PLAY_RATE_CHANGE)
    end
end

function getPlayRate(self)
    if self.m_isStop then
        return 0
    end
    return self.m_playRate
end

function beStop( self )
    return self.m_isStop
end
function setStop( self, beStop )
    if self.m_isStop~=beStop then
        self.m_isStop = beStop
        GameDispatcher:dispatchEvent(EventName.PLAY_RATE_CHANGE)
    end
end

--循环
function update(self)
    if self.m_beStop then return end

    local deltaTime = self:getDeltaTime()

    -- 非整数速率累计到下次
    local rate = self:getPlayRate()
    local rate, residue = math.modf(rate);
    self.m_rate_residue = self.m_rate_residue + residue
    local integer, residue = math.modf(self.m_rate_residue)
    self.m_rate_residue = residue
    rate = rate + integer

    --帧循环
    if next(self.m_frameList) then
        local cnt = #self.m_frameList
        for i = 1, cnt do
            -- for i,vo in ipairs(self.m_frameList) do
            local vo = self.m_frameList[i]
            if vo and vo.m_beRemove == false then
                vo.m_counter = vo.m_counter - 1;
                if vo.m_counter <= 0 then
                    vo.m_counter = vo.m_delay;
                    if RootLoop.TimerDebug then
                        TimeUtil:startTime()
                    end
                    vo.m_callBack(vo.m_thisObject, deltaTime * rate);
                    if RootLoop.TimerDebug then
                        TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                    end
                    if vo.m_repeatTime > 0 then
                        vo.m_repeatTime = vo.m_repeatTime - 1;
                        if vo.m_repeatTime <= 0 then
                            if vo.m_overBack then
                                if RootLoop.TimerDebug then
                                    TimeUtil:startTime()
                                end
                                vo.m_overBack(vo.m_thisObject, vo.m_overBackParams);
                                if RootLoop.TimerDebug then
                                    TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                                end
                            end
                            vo.m_beRemove = true
                            table.insert(self.m_removeList, i)
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
                LuaPoolMgr:poolRecover(self.m_frameList[idx])
                table.remove(self.m_frameList, idx)
            end
            self.m_removeList = {}
        end
    end
    if next(self.m_frameLoopList) then
        local cnt = #self.m_frameLoopList
        for i = 1, cnt do
            -- for i,vo in ipairs(self.m_frameLoopList) do
            local vo = self.m_frameLoopList[i]
            if vo and vo.m_beRemove == false then
                if vo.m_delay>0 then
                    vo.m_counter = vo.m_counter - 1;
                    if vo.m_counter <= 0 then
                        vo.m_counter = vo.m_delay;
                        if RootLoop.TimerDebug then
                            TimeUtil:startTime()
                        end
                        vo.m_callBack(vo.m_thisObject, deltaTime * rate);
                        if RootLoop.TimerDebug then
                            TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                        end
                    end
                else
                    if RootLoop.TimerDebug then
                        TimeUtil:startTime()
                    end
                    vo.m_callBack(vo.m_thisObject, deltaTime * rate);
                    if RootLoop.TimerDebug then
                        TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                    end
                end
            else
                table.insert(self.m_removeList, i)
            end
        end
        if next(self.m_removeList) then
            for i = #self.m_removeList, 1, -1 do
                local idx = self.m_removeList[i]
                local obj = self.m_frameLoopList[idx]
                -- print("m_removeList", idx, obj)
                if obj then
                    LuaPoolMgr:poolRecover(obj)
                    table.remove(self.m_frameLoopList, idx)
                end
            end
            self.m_removeList = {}
        end
    end
    --时间循环
    if next(self.m_timeList) then
        local timeRate = 0
        while timeRate < rate do
            local cnt = #self.m_timeList
            for i = 1, cnt do
                -- for i,vo in ipairs(self.m_timeList) do
                local vo = self.m_timeList[i]
                if vo and vo.m_beRemove == false then
                    vo.m_counter = vo.m_counter - deltaTime
                    if vo.m_counter <= 0 then
                        vo.m_counter = vo.m_delay;
                        if RootLoop.TimerDebug then
                            TimeUtil:startTime()
                        end
                        vo.m_callBack(vo.m_thisObject, deltaTime);
                        if RootLoop.TimerDebug then
                            TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                        end
                        if vo.m_repeatTime > 0 then
                            vo.m_repeatTime = vo.m_repeatTime - 1;
                            if vo.m_repeatTime <= 0 then
                                if vo.m_overBack then
                                    if RootLoop.TimerDebug then
                                        TimeUtil:startTime()
                                    end
                                    vo.m_overBack(vo.m_thisObject, vo.m_overBackParams);
                                    if RootLoop.TimerDebug then
                                        TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                                    end
                                end
                                vo.m_beRemove = true
                                table.insert(self.m_removeList, i)
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
                    LuaPoolMgr:poolRecover(self.m_timeList[idx])
                    table.remove(self.m_timeList, idx)
                end
                self.m_removeList = {}
            end
            timeRate = timeRate + 1
        end
    end
    if next(self.m_timeLoopList) then
        local timeLoopRate = 0
        while timeLoopRate < rate do
            local cnt = #self.m_timeLoopList
            for i = 1, cnt do
                -- for _,vo in ipairs(self.m_timeLoopList) do
                local vo = self.m_timeLoopList[i]
                if vo and vo.m_beRemove == false then
                    vo.m_counter = vo.m_counter - deltaTime
                    if vo.m_counter <= 0 then
                        vo.m_counter = vo.m_delay;
                        if RootLoop.TimerDebug then
                            TimeUtil:startTime()
                        end
                        vo.m_callBack(vo.m_thisObject);
                        if RootLoop.TimerDebug then
                            TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                        end
                    end
                else
                    table.insert(self.m_removeList, i)
                end
            end
            if next(self.m_removeList) then
                for i = #self.m_removeList, 1, -1 do
                    local idx = self.m_removeList[i]
                    LuaPoolMgr:poolRecover(self.m_timeLoopList[idx])
                    table.remove(self.m_timeLoopList, idx)
                end
                self.m_removeList = {}
            end
            timeLoopRate = timeLoopRate + 1
        end
    end
    --timeout
    if next(self.m_timeoutList) then
        local timeoutRate = 0
        while timeoutRate < rate do
            local cnt = #self.m_timeoutList
            for i = 1, cnt do
                local vo = self.m_timeoutList[i]
                if vo and vo.m_beRemove == false then
                    vo.m_counter = vo.m_counter - deltaTime
                    if vo.m_counter <= 0 then
                        if RootLoop.TimerDebug then
                            TimeUtil:startTime()
                        end
                        vo.m_callBack(vo.m_thisObject, vo.m_overBackParams);
                        if RootLoop.TimerDebug then
                            TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                        end
                        vo.m_beRemove = true
                        table.insert(self.m_removeList, i)
                    end
                else
                    table.insert(self.m_removeList, i)
                end
            end

            if next(self.m_removeList) then
                for i = #self.m_removeList, 1, -1 do
                    local idx = self.m_removeList[i]
                    local vo = self.m_timeoutList[idx]
                    LuaPoolMgr:poolRecover(vo)
                    table.remove(self.m_timeoutList, idx)
                end
                self.m_removeList = {}
            end
            timeoutRate = timeoutRate + 1
        end
    end
end

function clearTimeout(self, cusIndex)
    if not cusIndex then return end
    for i, v in ipairs(self.m_timeoutList) do
        if v.m_beRemove == false and v.m_sn == cusIndex then
            v.m_beRemove = true
            return
        end
    end
end

function getDeltaTime(self)
    return LoopManager:getDeltaTime()
--     return gs.Time.deltaTime
--     -- return 1 / FRAME
end

function removeAll(self)
    --帧循环
    self.m_frameList = {}
    self.m_frameLoopList = {}
    --时间循环
    self.m_timeList = {}
    self.m_timeLoopList = {}
    self.m_removeList = {}
    -- timeout
    self.m_timeoutList = {}
end

return _M