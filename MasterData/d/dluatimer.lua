
---@class DLuaTimer:DTimer
local DLuaTimer = class("DLuaTimer", function (...)
    return DTimer.Instance
end)

function DLuaTimer:ctor(...)
    
end

function DLuaTimer:DoAfter(interval, func, ...)
    ---@type DTimer.TimerInfo
    local info = DTimer.TimerInfo.New(interval):SetParams(...):OnComplete(func)
    info:Start()
    return info
end

function DLuaTimer:DoRepeat(interval, times, func)
    ---@type DTimer.TimerInfo
	local info = DTimer.TimerInfo.New(interval, times):OnComplete(func)
    info:Start()
    return info
end

function DLuaTimer:DoRepeatForever(interval, func)
	return self:DoRepeat(interval, mathx.maxint, func)
end

function DLuaTimer:DoAfterIfValid(gameObject, interval, func, ...)
    ---@type DTimer.TimerInfo
    local info = DTimer.TimerInfo.New(interval):SetParams(...):OnComplete(func)
    info:StartIfValid(gameObject)
    return info
end

function DLuaTimer:DoRepeatIfValid(gameObject, interval, times, func)
    ---@type DTimer.TimerInfo
	local info = DTimer.TimerInfo.New(interval, times):OnComplete(func)
    info:StartIfValid(gameObject)
    return info
end

function DLuaTimer:DoRepeatForeverIfValid(gameObject, interval, func)
	return self:DoRepeatIfValid(gameObject, interval, mathx.maxint, func)
end
return DLuaTimer