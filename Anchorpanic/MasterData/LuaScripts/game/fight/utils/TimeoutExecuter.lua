module("fight.TimeoutExecuter", Class.impl("lib.event.EventDispatcher"))
--构造
function ctor(self)
    self.m_timeouts = {}
    self.m_liveTimeouts = {}
end

function _emptyCall( self )
end

function setFrameout(self,cusDelay,cusThisObject,cusCallBack,cusCallBackParams)
    return RateLooper:setFrameout(cusDelay,cusThisObject,cusCallBack,cusCallBackParams)
end

function setTimeout(self,cusDelay,cusThisObject,cusCallBack,cusCallBackParams)
    if cusDelay<=0 then
        cusCallBack(cusThisObject, cusCallBackParams)
        return 0
    end
    local sn = RateLooper:setTimeout(cusDelay,cusThisObject,cusCallBack,cusCallBackParams)
    self.m_timeouts[sn] = 1
    return sn
end

function clearTimeout(self,cunIndex)
    RateLooper:clearTimeout(cunIndex)
    self.m_timeouts[cunIndex] = nil
end

-- 针对角色的延迟事件
function setLiveTimeout( self, liveID, cusDelay, cusThisObject, cusCallBack, cusCallBackParams )
    local sn = fight.LiveLooper:setTimeout(liveID, cusDelay, cusThisObject, cusCallBack, cusCallBackParams)
    self.m_liveTimeouts[sn] = 1
    return sn
end

-- 取消针对角色的延迟事件
function clearLiveTimeout( self, sn )
    fight.LiveLooper:removeTimerByIndex(sn)
    self.m_liveTimeouts[sn] = nil
end

function reset(self)
    if not table.empty(self.m_timeouts) then
        for sn,_ in pairs(self.m_timeouts) do
            RateLooper:clearTimeout(sn)
        end
        self.m_timeouts = {}
    end
    if not table.empty(self.m_liveTimeouts) then
        for sn,_ in pairs(self.m_liveTimeouts) do
            fight.LiveLooper:removeTimerByIndex(sn)
        end
        self.m_liveTimeouts = {}
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
