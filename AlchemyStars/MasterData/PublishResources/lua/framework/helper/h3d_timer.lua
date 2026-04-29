local TimerTriggerCount = {Once = 1, Infinite = 99999999}
_enum("TimerTriggerCount", TimerTriggerCount)
_class("H3DTimer", Object)
H3DTimer = H3DTimer

function H3DTimer:Constructor(world)
  self._world = world
  self.eventQueue = Heap:New(Heap.CPM_CUSTOM, H3DTimerEvent.PriorityComparer)
  self._newEventList = ArrayList:New()
  self._delEventList = ArrayList:New()
end

function H3DTimer:AddEvent(delayMS, func, ...)
  return self:AddEventTimes(delayMS, 1, func, ...)
end

function H3DTimer:AddEventTimes(delayMS, times, func, ...)
  local curTime = self:_GetCurrentTime()
  local event = H3DTimerEvent:New(curTime, delayMS, times, func, ...)
  self._newEventList:PushBack(event)
  return event
end

function H3DTimer:CancelEvent(event)
  event:Cancel()
  if self._newEventList:Remove(event) == -1 then
    if event._heap_index < 0 and event._Complete == false then
      Log.error("H3DTimer:CancelEvent _Complete ==false error index ", event._heap_index, Log.traceback())
    elseif event._heap_index > 0 and event._Complete == true then
      Log.error("H3DTimer:CancelEvent _Complete ==true error index ", event._heap_index, Log.traceback())
    end
    self._delEventList:PushBack(event)
  end
end

function H3DTimer:_GetCurrentTime()
  if self._world then
    local timeService = self._world:GetService("Time")
    return timeService:GetCurrentTimeMs()
  else
    return GameGlobal:GetInstance():GetCurrentTime()
  end
end

function H3DTimer:Update(deltaTimeMS)
  local newevent_size = self._newEventList:Size()
  if self._newEventList:Size() > 0 then
    for i = 1, self._newEventList:Size() do
      local con = self._newEventList:GetAt(i)
      if con:IsCancel() == false then
        self.eventQueue:Enqueue(con)
      end
    end
    self._newEventList:Clear()
  end
  local delevent_size = self._delEventList:Size()
  if 0 < self._delEventList:Size() then
    for i = 1, self._delEventList:Size() do
      local con = self._delEventList:GetAt(i)
      self.eventQueue:Remove(con)
    end
    self._delEventList:Clear()
  end
  local queue = self.eventQueue
  local currentTime = self:_GetCurrentTime()
  local queue_size = self.eventQueue:Size()
  while true do
    local event = queue:Peek()
    if not event or currentTime < event.nextExecutionTime then
      return
    end
    queue:Dequeue()
    if event:IsCancel() == false then
      event:Complete()
      event:Call()
      if 0 < event:ReduceTimes() then
        event:Reset(self:_GetCurrentTime())
        self._newEventList:PushBack(event)
      else
      end
    else
      Log.error("H3dTimererror IsCancel true ")
    end
  end
  if self._last_update_time == nil then
    self._last_update_time = 0
  end
  if self._cur_time == nil then
    self._cur_time = 0
  end
  self._cur_time = self._cur_time + deltaTimeMS
  if 0 > self._cur_time - self._last_update_time then
    return
  end
  self._last_update_time = self._cur_time
  Log.debug("time size queue_size ", queue_size, " newevent_size ", newevent_size, " delevent_size ", delevent_size)
end

function H3DTimer:Clear()
  self._newEventList:Clear()
  self._delEventList:Clear()
  self.eventQueue:Clear()
end

_class("H3DTimerEvent", Object)
H3DTimerEvent = H3DTimerEvent

function H3DTimerEvent:Constructor(currentTime, delayMS, times, func, ...)
  self._heap_index = -1
  self._Complete = false
  self._insertion_index = -1
  self._times = times
  self.addTime = currentTime
  self._delayMs = delayMS
  self.nextExecutionTime = currentTime + delayMS or 0
  self._cancel = false
  self.callback = GameHelper:GetInstance():CreateCallback(func, ...)
end

function H3DTimerEvent:Cancel()
  self._cancel = true
end

function H3DTimerEvent:IsCancel()
  return self._cancel
end

function H3DTimerEvent:Reset(currentTime)
  self._heap_index = -1
  self._insertion_index = -1
  self._Complete = false
  self.addTime = currentTime
  self.nextExecutionTime = currentTime + self._delayMs or 0
end

function H3DTimerEvent:GetTimes()
  return self._times
end

function H3DTimerEvent:ReduceTimes()
  self._times = self._times - 1
  return self._times
end

function H3DTimerEvent:Call(...)
  if self.callback then
    self.callback:Call(...)
  end
end

function H3DTimerEvent:Complete()
  self._Complete = true
end

function H3DTimerEvent.PriorityComparer(a, b)
  if a.nextExecutionTime < b.nextExecutionTime then
    return 1
  elseif a.nextExecutionTime > b.nextExecutionTime then
    return -1
  else
    return 0
  end
end
