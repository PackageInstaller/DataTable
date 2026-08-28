local cs_coroutine = import('XLua.cs_coroutine')
local Yielders = CS.Engine.Lib.Yielders

local TimerType = {
    None = 0,
    Unlimited = 1,
    Limited = 2,
}

return
function(timerType)
    ---@class TimeCoroutine
    local TimeCoroutine = {}
    TimeCoroutine.timerType = timerType

    function TimeCoroutine:Clear()
        self.co_run = nil
        self.timerType = TimerType.None
        self.timer = 0
        self.timeMax = 0
        self.onTimerCallback = nil
        self.onTimerEndCallback = nil
    end

    --- 设置计时器类型
    ---@param timerType any
    function TimeCoroutine:SetTimerType(timerType)
        self.timerType = timerType
    end

    --- 开始计时
    ---@param timerType any
    function TimeCoroutine:Start(timeMax, onEnd)
        if isNotNull(self.co_run) then return end
        self.timeMax = timeMax or 0
        self.timer = 0

        self.co_run = cs_coroutine.start(function()
            while self:__hasNext() do
                if isNotNull(self.onTimerCallback) then
                    self.onTimerCallback(self.timer)
                end
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1))
                self.timer = self.timer + 1
            end
            if isNotNull(self.onTimerEndCallback) then
                self.onTimerEndCallback()
            end
            if isNotNull(onEnd) then
                onEnd()
            end
            self.co_run = nil
        end)
    end

    --- 停止计时
    function TimeCoroutine:Stop()
        self.timer = 0
        if isNotNull(self.co_run) then
            cs_coroutine.stop(self.co_run)
            self.co_run = nil
        end
    end

    --- 计时器是否在运行
    function TimeCoroutine:IsRunning()
        return isNotNull(self.co_run)
    end

    --- 获取计时器运行时间
    function TimeCoroutine:GetTime()
        return self.timer
    end

    --- 检查是否要继续计时
    function TimeCoroutine:__hasNext()
        if self.timerType == TimerType.Limited then
            return self.timer <= self.timeMax
        elseif self.timerType == TimerType.Unlimited then
            return true
        end
        return false
    end

    function TimeCoroutine:OnTimerCallback(func)
        self.onTimerCallback = func
    end

    function TimeCoroutine:OnTimerEndCallback(func)
        self.onTimerEndCallback = func
    end

    return TimeCoroutine
end