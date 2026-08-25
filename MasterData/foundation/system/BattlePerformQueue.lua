local BattlePerformQueue = System.NewClass("BattlePerformQueue")

function BattlePerformQueue:ctor()
  self:Clear()
end

function BattlePerformQueue:Push(func, tag, isBlock)
  self.funcBlockMap[func] = isBlock or false
  self.funcTagMap[func] = tag
  self.queue:Push(func)
  self:CheckFunctionCall()
end

function BattlePerformQueue:CheckFunctionCall()
  if not self.queue:IsEmpty() and self.curFunc == nil then
    self.curFunc = self.queue:Peek()
    self:ResetAwaiter()
    self.curFunc()
  end
end

function BattlePerformQueue:ResetAwaiter()
  if self.queueAwaiter == nil then
    self.queueAwaiter = Awaiter.Get()
    EventMgr.Instance.AnimAwaiterArise:Dispatch(self.queueAwaiter, "BattlePerformQueue", 1000, true)
  else
    self:ClearSafeTimer()
  end
  if self.funcBlockMap[self.curFunc] then
    return
  end
  self.safeTimer = bg.battleRender:PerformWithDelay(5, function()
    local tag = self.funcTagMap[self.curFunc]
    Logger.Warn("表演队列异常，请检查: ", tag)
    self.funcTagMap[self.curFunc] = nil
    self.funcBlockMap[self.curFunc] = nil
    self.curFunc = nil
    self.queue:Pop()
    self:SetAwaiterFinish()
  end, self)
end

function BattlePerformQueue:ClearSafeTimer()
  if self.safeTimer then
    bg.battleRender:UnperformWithDelay(self.safeTimer)
    self.safeTimer = nil
  end
end

function BattlePerformQueue:Clear()
  self.queue = Queue.New()
  self.curFunc = nil
  self.funcTagMap = {}
  self.funcBlockMap = {}
  self:ClearSafeTimer()
  self.queueAwaiter = nil
end

function BattlePerformQueue:SetAwaiterFinish()
  if self.queueAwaiter then
    self.queueAwaiter:SetCompleted()
    self:ClearSafeTimer()
    self.queueAwaiter = nil
    while not self.queue:IsEmpty() do
      Logger.Warn("AwaiterFinish call func")
      local func = self.queue:Pop()
      self.funcTagMap[func] = nil
      self.funcBlockMap[func] = nil
      func()
    end
  end
end

function BattlePerformQueue:Pop(tag)
  if self.queue:IsEmpty() then
    return
  end
  if self.curFunc == nil then
    return
  end
  if tag then
    local curExcuteTag = self.funcTagMap[self.curFunc]
    if tag ~= curExcuteTag then
      Logger.Warn("BattlePerformQueue Pop Tag error, req tag : %s, curTag : %s", tag, curExcuteTag)
    end
  end
  self.funcTagMap[self.curFunc] = nil
  self.funcBlockMap[self.curFunc] = nil
  self.curFunc = nil
  self.queue:Pop()
  self:CheckFunctionCall()
  if self.curFunc == nil then
    self:SetAwaiterFinish()
  end
end

return BattlePerformQueue
