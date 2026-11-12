local Timer = require("GameCore.Timer.Timer")
local TimerStatus = require("GameCore.Timer.TimerStatus")
local TimerScaleType = require("GameCore.Timer.TimerScaleType")
local Time = CS.UnityEngine.Time
local TimerManager = {}
local MAX_TIMER_COUNT = 500
local tbTimer, tbTempAddTimer
local nDelUnscaledTime = 0
local nUnscaledTime = 0
local bCheckRange1 = false
local bCheckRange2 = false
local nLastTS_Range1 = 0
local nLastTS_Range2 = 0
local bForceFrameUpdate = false

local function CheckRange()
  if 1 <= nUnscaledTime - nLastTS_Range1 then
    nLastTS_Range1 = nUnscaledTime
    bCheckRange1 = true
  else
    bCheckRange1 = false
  end
  if 60 <= nUnscaledTime - nLastTS_Range2 then
    nLastTS_Range2 = nUnscaledTime
    bCheckRange2 = true
  else
    bCheckRange2 = false
  end
end

local function ProcAddTimer()
  if tbTimer == nil then
    return
  end
  if type(tbTempAddTimer) ~= "table" or #tbTempAddTimer <= 0 then
    return
  end
  for i, timer in ipairs(tbTempAddTimer) do
    table.insert(tbTimer, timer)
  end
  tbTempAddTimer = {}
end

local function ProcUpdateTimer()
  if tbTimer == nil then
    return
  end
  CheckRange()
  for i, timer in ipairs(tbTimer) do
    if bForceFrameUpdate == true or timer._nRange == 0 or timer._nRange == 1 and bCheckRange1 == true or timer._nRange == 2 and bCheckRange2 == true then
      if timer._nScaleType == TimerScaleType.None then
        timer:_Run(Time.time, Time.deltaTime)
      elseif timer._nScaleType == TimerScaleType.Unscaled then
        timer:_Run(nUnscaledTime, Time.unscaledDeltaTime)
      elseif timer._nScaleType == TimerScaleType.RealTime then
        timer:_Run(Time.realtimeSinceStartup, Time.unscaledDeltaTime)
      else
        timer:_Stop()
      end
    end
  end
end

local function ProcRemoveTimer()
  if tbTimer == nil then
    return
  end
  local nCount = #tbTimer
  for i = nCount, 1, -1 do
    local timer = tbTimer[i]
    if timer._status == TimerStatus.Destroy then
      table.remove(tbTimer, i)
    end
  end
end

function TimerManager.MonoUpdate()
  nDelUnscaledTime = Time.unscaledDeltaTime
  if nDelUnscaledTime > Time.maximumDeltaTime then
    nDelUnscaledTime = Time.maximumDeltaTime
  end
  nUnscaledTime = nUnscaledTime + nDelUnscaledTime
  ProcAddTimer()
  ProcUpdateTimer()
  ProcRemoveTimer()
end

local function UnInit()
  tbTimer = nil
  tbTempAddTimer = nil
  EventManager.Remove(EventId.CSLuaManagerShutdown, TimerManager, UnInit)
end

function TimerManager.Init()
  tbTimer = {}
  tbTempAddTimer = {}
  EventManager.Add(EventId.CSLuaManagerShutdown, TimerManager, UnInit)
end

function TimerManager.Add(nTargetCount, nInterval, listener, callback, bAutoRun, bDestroyWhenComplete, nScaleType, tbParam)
  if tbTempAddTimer == nil then
    return
  end
  local nTotalCount = #tbTimer + #tbTempAddTimer
  if nTotalCount >= MAX_TIMER_COUNT then
    print("lua timer count reach max.")
    return nil
  end
  if callback == nil then
    print("lua timer need a callback.")
    return
  end
  if nScaleType == true then
    nScaleType = TimerScaleType.Unscaled
  elseif nScaleType == false then
    nScaleType = TimerScaleType.RealTime
  else
    nScaleType = TimerScaleType.None
  end
  local mapParam = {}
  mapParam.bAutoRun = bAutoRun
  mapParam.bDestroyWhenComplete = bDestroyWhenComplete
  mapParam.nTargetCount = nTargetCount
  mapParam.nInterval = nInterval
  mapParam.nScaleType = nScaleType
  mapParam.data = tbParam
  mapParam.listener = listener
  mapParam.callback = callback
  if nScaleType == TimerScaleType.None then
    mapParam.nTs = Time.time
  elseif nScaleType == TimerScaleType.Unscaled then
    mapParam.nTs = nUnscaledTime
  elseif nScaleType == TimerScaleType.RealTime then
    mapParam.nTs = Time.realtimeSinceStartup
  end
  local timer = Timer.new(mapParam)
  table.insert(tbTempAddTimer, timer)
  return timer
end

function TimerManager.Remove(timer, bInvokeCallback)
  if timer ~= nil then
    timer:Cancel(bInvokeCallback)
  end
end

function TimerManager.GetUnscaledTime()
  return nUnscaledTime
end

function TimerManager.ForceFrameUpdate(bEnable)
  bForceFrameUpdate = bEnable == true
end

return TimerManager
