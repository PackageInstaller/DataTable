local Awaiter = System.NewClass("Awaiter")
Awaiter.showDebugInfo = false

function Awaiter:ctor()
  self:Reset()
  self.inPool = false
end

function Awaiter:Reset()
  self.completed = false
  self.completedCallbackList = nil
end

function Awaiter:SetCompleted()
  if not self.inPool and not self.completed then
    self.completed = true
  end
  self:RunCompleteCb()
end

function Awaiter:RunCompleteCb()
  if not self.completedCallbackList then
    return
  end
  for _, callback in ipairs(self.completedCallbackList) do
    callback(self)
  end
  self.completedCallbackList = nil
end

function Awaiter:IsCompleted()
  return self.completed
end

function Awaiter:OnCompleted(callback)
  if not self.inPool then
    if self.completed then
      if callback then
        callback(self)
      end
    elseif callback then
      self.completedCallbackList = self.completedCallbackList or {}
      table.insert(self.completedCallbackList, callback)
    end
  end
end

function Awaiter:Recycle()
  if Awaiter.pool and not self.inPool then
    self:Reset()
    self.inPool = true
    table.insert(Awaiter.pool, self)
  end
end

function Awaiter.Get()
  if not Awaiter.pool then
    Awaiter.pool = {}
  end
  local awaiter = table.remove(Awaiter.pool, 1)
  if awaiter then
    awaiter.inPool = false
    return awaiter
  else
    do return end
    return Awaiter, 1
  end
end

function Awaiter.Dispatch(desc, overTime, isStopAll)
  local awaiter = Awaiter.Get()
  EventMgr.Instance.AnimAwaiterArise:Dispatch(awaiter, desc, overTime, isStopAll)
  return awaiter
end

function Awaiter.WhenAll(awaiters)
  local awaiter = Awaiter.Get()
  if 0 == #awaiters then
    awaiter:SetCompleted()
  elseif Awaiter._AllCompleted(awaiters) then
    awaiter:SetCompleted()
  else
    for _, v in ipairs(awaiters) do
      if not v:IsCompleted() then
        v:OnCompleted(function()
          if Awaiter._AllCompleted(awaiters) then
            awaiter:SetCompleted()
          end
        end)
      end
    end
  end
  return awaiter
end

function Awaiter._AllCompleted(awaiters)
  local allCompleted = true
  for _, awaiter in ipairs(awaiters) do
    if not awaiter:IsCompleted() then
      allCompleted = false
      break
    end
  end
  return allCompleted
end

function Awaiter.Debug(msg, ...)
  if Awaiter.showDebugInfo then
    msg = string.format(msg, ...)
    Logger.Info("[awaiter] " .. msg)
  end
end

return Awaiter
