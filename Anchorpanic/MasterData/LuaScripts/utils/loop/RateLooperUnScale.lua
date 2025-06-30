module("RateLooperUnScale", Class.impl(RateLooper))

function setStop( self, beStop )
    if self.m_isStop~=beStop then
        self.m_isStop = beStop
        -- GameDispatcher:dispatchEvent(EventName.PLAY_RATE_CHANGE)
    end
end

function getDeltaTime(self)
    return LoopManager:getUnscaledDeltaTime()
end

return _M