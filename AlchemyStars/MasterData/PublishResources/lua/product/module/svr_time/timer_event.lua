_class("TimerEvent_Base", Object)
TimerEvent_Base = TimerEvent_Base
local TimerRunState = {
  Wait = 0,
  Called = 1,
  End = 2
}
_enum("TimerRunState", TimerRunState)

function TimerEvent_Base.LessComparer(a, b)
  if a.tmNextStep < b.tmNextStep then
    return 1
  elseif a.tmNextStep > b.tmNextStep then
    return -1
  else
    local nTempID = a.nTimeID - b.nTimeID
    return nTempID
  end
end

function TimerEvent_Base:Constructor(nTimeID, tmStart)
  self.nTimeID = nTimeID
  self.tmStart = tmStart
  self.tmNextStep = tmStart
end

function TimerEvent_Base:GetTimeID()
  return self.nTimeID
end

function TimerEvent_Base:AutoUpdate(tmNowMs)
  return 0
end

function TimerEvent_Base:_CreateCallBack(hObject, cbFunction, ...)
  if nil == cbFunction then
    return nil
  end
  local cbEvent
  if nil == hObject then
    cbEvent = GameHelper:GetInstance():CreateCallback(cbFunction, ...)
  else
    cbEvent = GameHelper:GetInstance():CreateCallback(cbFunction, hObject, ...)
  end
  return cbEvent
end

function TimerEvent_Base:_CallEvent(cbEvent, ...)
  if cbEvent then
    cbEvent:Call(...)
  end
end

function TimerEvent_Base:_GetStepCount(tmNow, nStepLong)
  local nTotalLong = tmNow - self.tmNextStep
  if nTotalLong < 0 or nStepLong <= 0 then
    return 0
  end
  if 0 == nTotalLong then
    return 1
  end
  return math.ceil(nTotalLong / nStepLong)
end

_class("TimerEvent_Loop", TimerEvent_Base)
TimerEvent_Loop = TimerEvent_Loop

function TimerEvent_Loop:Constructor(nTimeID, tmStart, nStepLong, funcStep, ...)
  self.nTimeID = nTimeID
  self.tmStart = tmStart
  if nStepLong <= 0 then
    nStepLong = 1000
  end
  self.nStepLong = nStepLong
  self.tmNextStep = tmStart + nStepLong
  self.nCountCall = 0
  self.cbEvent_Work = self:_CreateCallBack(nil, funcStep, ...)
end

function TimerEvent_Loop:AutoUpdate(tmNowMs)
  if tmNowMs < self.tmNextStep then
    return 0
  end
  local nStepCount = self:_GetStepCount(tmNowMs, self.nStepLong)
  if 0 < nStepCount then
    self:_CallEvent(self.cbEvent_Work, self.nTimeID, tmNowMs, nStepCount)
    self.tmNextStep = self.tmNextStep + self.nStepLong * nStepCount
  end
  return 1
end

_class("TimerEvent_Once", TimerEvent_Base)
TimerEvent_Once = TimerEvent_Once

function TimerEvent_Once:Constructor(nTimeID, tmStart, tmEnd, funcEnd, ...)
  self.nTimeID = nTimeID
  self.tmStart = tmStart
  self.tmNextStep = tmEnd
  self.nCountCall = 0
  self.cbEvent_Work = self:_CreateCallBack(nil, funcEnd, ...)
end

function TimerEvent_Once:AutoUpdate(tmNowMs)
  if tmNowMs < self.tmNextStep then
    return 0
  end
  self.nCountCall = self.nCountCall + 1
  self:_CallEvent(self.cbEvent_Work, self.nTimeID, tmNowMs, 1)
  return 2
end

_class("TimerEvent_LoopEnd", TimerEvent_Base)
TimerEvent_LoopEnd = TimerEvent_LoopEnd

function TimerEvent_LoopEnd:Constructor(nTimeID, tmStart, nStepLong, tmEnd, objectStep, funcStep, objectEnd, funcEnd, ...)
  self.nTimeID = nTimeID
  self.tmStart = tmStart
  if nStepLong < 0 then
    nStepLong = tmEnd - tmStart
  end
  self.nStepLong = nStepLong
  self.tmNextStep = tmStart + nStepLong
  self.tmEnd = tmEnd
  self.nCountCall = 0
  self.cbEvent_Work = self:_CreateCallBack(objectStep, funcStep, ...)
  self.cbEvent_End = self:_CreateCallBack(objectEnd, funcEnd, ...)
end

function TimerEvent_LoopEnd:AutoUpdate(tmNowMs)
  if tmNowMs >= self.tmEnd then
    self.nCountCall = self.nCountCall + 1
    self:_CallEvent(self.cbEvent_End, self.nTimeID, tmNowMs, 1)
    return TimerRunState.End
  end
  if tmNowMs < self.tmNextStep then
    return TimerRunState.Wait
  end
  local nStepCount = self:_GetStepCount(tmNowMs, self.nStepLong)
  if 0 < nStepCount then
    self:_CallEvent(self.cbEvent_Work, self.nTimeID, tmNowMs, nStepCount)
    self.tmNextStep = self.tmNextStep + self.nStepLong * nStepCount
  end
  return TimerRunState.Called
end
