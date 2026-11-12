local TimerStatus = require("GameCore.Timer.TimerStatus")
local TimerResetType = require("GameCore.Timer.TimerResetType")
local TimerScaleType = require("GameCore.Timer.TimerScaleType")
local Time = CS.UnityEngine.Time
local Timer = class("Timer")

function Timer:ctor(mapParam)
  if mapParam.bAutoRun == true or mapParam.bAutoRun == nil then
    self._status = TimerStatus.Running
  else
    self._status = TimerStatus.ReadyToGo
  end
  self._nCreateTS = mapParam.nTs
  self._nTS = mapParam.nTs
  self._nPauseTS = 0
  self._bDestroyWhenComplete = mapParam.bDestroyWhenComplete
  self._nCurCount = 0
  self._nTargetCount = mapParam.nTargetCount
  self._nDelTime = 0
  self._nElapsed = 0
  self._nInterval = mapParam.nInterval
  self._nScaleType = mapParam.nScaleType
  self._data = mapParam.data
  self._listener = mapParam.listener
  self._callback = mapParam.callback
  self._nDelCountLimit = 10
  self._nRate = 1
  self._nRange = 0
  self._bDebugWatch = false
end

function Timer:_Run(nCurTS, nDelTime)
  if type(self._nInterval) ~= "number" or self._callback == nil then
    self:Cancel(false)
    return
  end
  if self._status ~= TimerStatus.Running then
    return
  end
  self._nDelTime = nDelTime
  if self._nInterval <= 0 then
    self:_DoCallback()
    return
  end
  self._nElapsed = self._nElapsed + (nCurTS - self._nTS)
  self._nTS = nCurTS
  local nInterval = self._nInterval / self._nRate
  if nInterval > self._nElapsed then
    local nRemain = nInterval - self._nElapsed
    if 60 < nRemain then
      self._nRange = 2
    elseif 1 < nRemain then
      self._nRange = 1
    else
      self._nRange = 0
    end
    return
  end
  local nDelCount = math.floor(self._nElapsed / nInterval)
  self._nElapsed = self._nElapsed - nDelCount * nInterval
  if 0 >= self._nTargetCount then
    self:_DoCallback()
  else
    if self._nCurCount + nDelCount >= self._nTargetCount then
      nDelCount = self._nTargetCount - self._nCurCount
      self._nCurCount = self._nTargetCount
      self:_Stop()
      self._nElapsed = 0
    else
      self._nCurCount = self._nCurCount + nDelCount
    end
    if nDelCount >= self._nDelCountLimit then
      nDelCount = 1
    end
    for i = 1, nDelCount do
      self:_DoCallback()
    end
  end
end

function Timer:_Stop()
  if self._bDestroyWhenComplete == true then
    self._status = TimerStatus.Destroy
  else
    self._status = TimerStatus.Complete
  end
end

function Timer:_ResetTimeStamp(bIsPauseTS)
  local TimerManager = require("GameCore.Timer.TimerManager")
  if bIsPauseTS == true then
    if self._nScaleType == TimerScaleType.None then
      self._nPauseTS = Time.time
    elseif self._nScaleType == TimerScaleType.Unscaled then
      self._nPauseTS = TimerManager.GetUnscaledTime()
    elseif self._nScaleType == TimerScaleType.RealTime then
      self._nPauseTS = Time.realtimeSinceStartup
    end
  else
    if self._nScaleType == TimerScaleType.None then
      self._nTS = Time.time
    elseif self._nScaleType == TimerScaleType.Unscaled then
      self._nTS = TimerManager.GetUnscaledTime()
    elseif self._nScaleType == TimerScaleType.RealTime then
      self._nTS = Time.realtimeSinceStartup
    end
    self._nCreateTS = self._nTS
  end
end

function Timer:_DoCallback()
  if self._listener == nil then
    self._callback(self, self._data)
  else
    self._callback(self._listener, self, self._data)
  end
end

function Timer:Pause(bSetPause)
  self._nRange = 0
  if type(bSetPause) ~= "boolean" then
    bSetPause = true
  end
  if bSetPause == true and self._status == TimerStatus.Running then
    self:_ResetTimeStamp(true)
    self._status = TimerStatus.Pause
  elseif bSetPause == false then
    if self._status == TimerStatus.Pause then
      local TimerManager = require("GameCore.Timer.TimerManager")
      if self._nScaleType == TimerScaleType.None then
        self._nTS = self._nTS + (Time.time - self._nPauseTS)
      elseif self._nScaleType == TimerScaleType.Unscaled then
        self._nTS = self._nTS + (TimerManager.GetUnscaledTime() - self._nPauseTS)
      elseif self._nScaleType == TimerScaleType.RealTime then
        self._nTS = self._nTS + (Time.realtimeSinceStartup - self._nPauseTS)
      end
      self._nPauseTS = 0
      self._status = TimerStatus.Running
    elseif self._status == TimerStatus.ReadyToGo then
      self:_ResetTimeStamp(false)
      self._status = TimerStatus.Running
    end
  end
end

function Timer:Cancel(bInvokeCallback)
  self._status = TimerStatus.Destroy
  if bInvokeCallback == true and self._listener ~= nil and self._callback ~= nil then
    self:_DoCallback()
  end
end

function Timer:Reset(nResetType, nNewInterval)
  self._nRange = 0
  if self._status == TimerStatus.Destroy then
    return
  end
  if nResetType == nil then
    nResetType = TimerResetType.ResetAll
  end
  if nResetType == TimerResetType.ResetAll then
    self._status = TimerStatus.Running
    self._nCurCount = 0
    self._nElapsed = 0
    self._nPauseTS = 0
    self:_ResetTimeStamp(false)
  elseif nResetType == TimerResetType.ResetCount then
    self._nCurCount = 0
  elseif nResetType == TimerResetType.ResetElapsed then
    self._nElapsed = 0
    self._nPauseTS = 0
    self:_ResetTimeStamp(false)
  end
  if type(nNewInterval) == "number" then
    self._nInterval = nNewInterval
  end
end

function Timer:GetRemainInterval()
  if self._status == TimerStatus.Running then
    local TimerManager = require("GameCore.Timer.TimerManager")
    if self._nScaleType == TimerScaleType.None then
      return self._nInterval - (self._nElapsed + Time.time - self._nTS)
    elseif self._nScaleType == TimerScaleType.Unscaled then
      return self._nInterval - (self._nElapsed + TimerManager.GetUnscaledTime() - self._nTS)
    elseif self._nScaleType == TimerScaleType.RealTime then
      return self._nInterval - (self._nElapsed + Time.realtimeSinceStartup - self._nTS)
    end
  elseif self._status == TimerStatus.Pause then
    return self._nInterval - (self._nElapsed + self._nPauseTS - self._nTS)
  else
    return 0
  end
end

function Timer:GetRemainTime()
  local nTotalTime = self._nTargetCount * self._nInterval
  local nPassedTime = self._nInterval * self._nCurCount + self._nElapsed
  if self._status == TimerStatus.Running then
    local TimerManager = require("GameCore.Timer.TimerManager")
    if self._nScaleType == TimerScaleType.None then
      nPassedTime = nPassedTime + (Time.time - self._nTS)
    elseif self._nScaleType == TimerScaleType.Unscaled then
      nPassedTime = nPassedTime + (TimerManager.GetUnscaledTime() - self._nTS)
    elseif self._nScaleType == TimerScaleType.RealTime then
      nPassedTime = nPassedTime + (Time.realtimeSinceStartup - self._nTS)
    end
    return nTotalTime - nPassedTime
  elseif self._status == TimerStatus.Pause then
    nPassedTime = nPassedTime + (self._nPauseTS - self._nTS)
    return nTotalTime - nPassedTime
  else
    return 0
  end
end

function Timer:GetDelTS()
  return self._nTS - self._nCreateTS
end

function Timer:GetCreateTS()
  return self._nCreateTS
end

function Timer:GetCurTS()
  return self._nTS
end

function Timer:GetCurCount()
  return self._nCurCount
end

function Timer:SetSpeed(rate)
  if rate <= 0 then
    return
  end
  self._nRate = rate
  self._nRange = 0
end

function Timer:IsUnused()
  return self._status == TimerStatus.Destroy
end

function Timer:GetDelTime()
  return self._nDelTime
end

function Timer:PrintSelf()
  local tb = {
    ["状态"] = self._status,
    ["创建时间"] = self._nCreateTS,
    ["时间戳"] = self._nTS,
    ["暂停时间戳"] = self._nPauseTS,
    ["完成时销毁"] = self._bDestroyWhenComplete,
    ["已触发次数"] = self._nCurCount,
    ["目标触发次数"] = self._nTargetCount,
    ["已流逝"] = self._nElapsed,
    ["触发间隔"] = self._nInterval,
    ["缩放类型"] = self._nScaleType,
    ["一帧里触发极限次数"] = self._nDelCountLimit,
    ["速率"] = self._nRate,
    ["精度"] = self._nRange,
    ["监视"] = self._bDebugWatch
  }
  printTable(tb)
end

return Timer
