module("LoopManager", Class.impl())

function ctor(self)
    RootLoop:addTicker(self)
    self:init()
end

function init(self)
    --帧循环
    self.m_frameList = {}
    self.m_frameLoopList = {}
    --时间循环
    self.m_timeList = {}
    self.m_timeLoopList = {}
    self.m_removeList = {}
    -- timeout
    self.m_timeoutList = {}
    --速率余数
    self.m_rate_residue = 0

    self.m_beStop = false

    self.m_luaDeltaTime = gs.Time.deltaTime
    self.m_luaUnscaledDeltaTime = gs.Time.unscaledDeltaTime
end

function setStop(self, beStop)
    self.m_beStop = beStop
end

function getDeltaTime(self)
    return self.m_luaDeltaTime
    -- return gs.Time.deltaTime
    -- return gs.Time.unscaledDeltaTime
end

function getUnscaledDeltaTime(self)
    return self.m_luaUnscaledDeltaTime
    -- return gs.Time.unscaledDeltaTime
end

--循环
function update(self)
    self.m_luaDeltaTime = gs.Time.deltaTime
    self.m_luaUnscaledDeltaTime = gs.Time.unscaledDeltaTime
    if self.m_beStop then return end
    
    local deltaTime = self.m_luaUnscaledDeltaTime
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
                    vo.m_callBack(vo.m_thisObject, deltaTime);
                    if RootLoop.TimerDebug then
                        TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                    end
                    if vo.m_repeatTime > 0 then
                        vo.m_repeatTime = vo.m_repeatTime - 1;
                        if vo.m_repeatTime <= 0 then
                            if vo.m_overBack then
                                vo.m_overBack(vo.m_thisObject, vo.m_overBackParams);
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
                vo.m_counter = vo.m_counter - 1;
                if vo.m_counter <= 0 then
                    vo.m_counter = vo.m_delay;
                    if RootLoop.TimerDebug then
                        TimeUtil:startTime()
                    end
                    vo.m_callBack(vo.m_thisObject, deltaTime);
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
        local cnt = #self.m_timeList
        for i = 1, cnt do
            -- for i,vo in ipairs(self.m_timeList) do
            local vo = self.m_timeList[i]
            if vo and vo.m_beRemove == false then
                if(vo.m_counter == nil) then 
                    logError("timer 间距传入为nil, 请检查")
                    vo.m_counter = 0.3
                end
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
    end
    if next(self.m_timeLoopList) then
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
    end
    --timeout
    if next(self.m_timeoutList) then
        local cnt = #self.m_timeoutList
        for i = 1, cnt do
            -- for _,vo in pairs(self.m_timeoutList) do
            local vo = self.m_timeoutList[i]
            if vo and vo.m_beRemove == false then
                vo.m_counter = vo.m_counter - deltaTime
                if vo.m_counter <= 0 then
                    if RootLoop.TimerDebug then
                        TimeUtil:startTime()
                    end
                    vo.m_callBack(vo.m_thisObject, vo.m_overBackParams, vo.m_sn);
                    if RootLoop.TimerDebug then
                        TimeUtil:endOverTime(RootLoop.TimerDebugTimeout, vo.debugTrace)
                    end
                    vo.m_beRemove = true
                    table.insert(self.m_removeList, i)
                    -- print("r timeout 1111", i, vo.m_sn)
                end
            else
                -- print("r timeout 22222", i, vo.m_sn)
                table.insert(self.m_removeList, i)
            end
        end

        if next(self.m_removeList) then
            for i = #self.m_removeList, 1, -1 do
                local idx = self.m_removeList[i]
                -- local vo = self.m_timeoutList[idx]
                -- if vo then
                --     print("r timeout ", idx, vo.m_sn)
                -- else
                --     print("r timeout ", idx, nil)
                -- end
                LuaPoolMgr:poolRecover(self.m_timeoutList[idx])
                table.remove(self.m_timeoutList, idx)
            end
            self.m_removeList = {}
        end

    end
end

function emptyFunc()
end

function setFrameout(self, cusDelay, cusThisObject, cusCallBack, cusCallBackParams)
    local loopVo = LuaPoolMgr:poolGet(LoopVo)
    loopVo:setData(cusDelay, 1, cusThisObject, emptyFunc, cusCallBack, cusCallBackParams)
    if RootLoop.TimerDebug then
        loopVo.debugTrace = debug.traceback();
    end
    table.insert(self.m_frameList, loopVo)
    return loopVo.m_sn
end

--帧循环--
function addFrame(self, cusDelay, cusRepeat, cusThisObject, cusCallBack, cusOverBack, cusOverBackParams)
    self:removeFrame(cusThisObject, cusCallBack);
    local loopVo = LuaPoolMgr:poolGet(LoopVo)
    loopVo:setData(cusDelay, cusRepeat, cusThisObject, cusCallBack, cusOverBack, cusOverBackParams)
    if RootLoop.TimerDebug then
        loopVo.debugTrace = debug.traceback();
    end
    if cusRepeat > 0 then
        table.insert(self.m_frameList, loopVo)
    else
        table.insert(self.m_frameLoopList, loopVo)
    end
    return loopVo.m_sn
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

function hasFrame(self, sn)
    for i = 1, #self.m_frameList do
        if(self.m_frameList[i].m_sn == sn)then
            return true
        end
    end
    for i = 1, #self.m_frameLoopList do
        if(self.m_frameLoopList[i].m_sn == sn)then
            return true
        end
    end
    return false
end

function getFrameCount(self)
    return #self.m_frameList + #self.m_frameLoopList;
end

--帧循环 end--
--时间循环--
function addTimer(self, cusDelay, cusRepeat, cusThisObject, cusCallBack, cusOverBack, cusOverBackParams)
    self:removeTimer(cusThisObject, cusCallBack);
    local loopVo = LuaPoolMgr:poolGet(LoopVo)
    loopVo:setData(cusDelay, cusRepeat, cusThisObject, cusCallBack, cusOverBack, cusOverBackParams)
    if RootLoop.TimerDebug then
        loopVo.debugTrace = debug.traceback();
    end
    if cusRepeat > 0 then
        table.insert(self.m_timeList, loopVo)
    else
        table.insert(self.m_timeLoopList, loopVo)
    end
    return loopVo.m_sn
end

function removeTimer(self, cusThisObject, cusCallBack)
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

function hasTimer(self, sn)
    for i = 1, #self.m_timeList do
        if(self.m_timeList[i].m_sn == sn)then
            return true
        end
    end
    for i = 1, #self.m_timeLoopList do
        if(self.m_timeLoopList[i].m_sn == sn)then
            return true
        end
    end
    return false
end
--时间环 end--
--timeout
function setTimeout(self, cusDelay, cusThisObject, cusCallBack, cusCallBackParams)
    if cusDelay <= 0 then
        cusCallBack(cusThisObject, cusCallBackParams)
        return nil;
    end

    local loopVo = LuaPoolMgr:poolGet(LoopVo)
    loopVo:setData(cusDelay, nil, cusThisObject, cusCallBack, nil, cusCallBackParams)
    if RootLoop.TimerDebug then
        loopVo.debugTrace = debug.traceback();
    end
    table.insert(self.m_timeoutList, loopVo)
    return loopVo.m_sn
end

function clearTimeout(self, cusIndex)
    if not cusIndex then return end
    for _, v in ipairs(self.m_timeoutList) do
        if v.m_beRemove == false and v.m_sn == cusIndex then
            v.m_beRemove = true
            -- print("r timeout 0202", cusIndex)
            return
        end
    end
end
-- timeout end--
function getTimerCount(self)
    return #self.m_timeList + #self.m_timeLoopList + #self.m_timeoutList;
end

-- dispatcher
function dispatchEventDelay(self, dispatcher,  delay, etype, event)
    self:setTimeout(delay,nil,function() 
        dispatcher:dispatchEvent(etype,event)
    end)
end

function dispatchEventDelayFrame(self, dispatcher, delayFrame, etype, event)
    self:setFrameout(delayFrame,nil,function() 
        dispatcher:dispatchEvent(etype,event)
    end)
end

return _M