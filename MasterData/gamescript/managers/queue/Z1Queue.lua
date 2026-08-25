local Z1Queue = System.NewClass("Z1Queue")

function Z1Queue:ctor(maxWaitTime)
  self.queue = {}
  self.activeTag = nil
  self.activeFrame = 0
  self.activeTagData = nil
  self.safeTime = nil
  self.funcDelayTime = 0
  self.nextFunc = nil
  self.curFuncTime = 0
  self.maxWaitTime = maxWaitTime or math.maxinteger
end

function Z1Queue:Update()
  if self.activeTag then
    self.curFuncTime = self.curFuncTime + TimerManager.deltaTime
    if self.safeTime and self.curFuncTime > self.safeTime then
      self:Next()
      return
    end
    if self.nextFunc and self.curFuncTime >= self.funcDelayTime then
      self.nextFunc()
      self.nextFunc = nil
      return
    end
    if self.curFuncTime > self.maxWaitTime and not self.safeTime then
      Logger.Error(string.format("Z1QueueMgr 当前执行的 %s 超过 %s 秒, 自动执行下一步", self.activeTag, self.maxWaitTime))
      self:Next()
      return
    end
  elseif #self.queue > 0 then
    self:_RunNext()
  end
end

function Z1Queue:IsActive()
  return self.activeTag ~= nil
end

function Z1Queue:IsDoing(tag)
  return self.activeTag == tag
end

function Z1Queue:IsHave(tag)
  for i, info in ipairs(self.queue) do
    if info.tag == tag then
      return true
    end
  end
end

function Z1Queue:Insert(tag, func, safeTime, funcDelayTime)
  table.insert(self.queue, {
    tag = tag,
    func = func,
    safeTime = tonumber(safeTime),
    delayTime = tonumber(funcDelayTime)
  })
  if not self.activeTag then
    self:_RunNext()
  end
  return self
end

function Z1Queue:InsertAfterTag(afterTag, tag, func, safeTime)
  local index = 0 == #self.queue and 0 or 1
  for i, info in ipairs(self.queue) do
    if info.tag == afterTag then
      index = i
      break
    end
  end
  table.insert(self.queue, index + 1, {
    tag = tag,
    func = func,
    safeTime = tonumber(safeTime)
  })
  if not self.activeTag then
    self:_RunNext()
  end
  return self
end

function Z1Queue:Next()
  if not self.queue then
    return
  end
  self.activeTag = nil
  self.activeFrame = nil
  self.safeTime = nil
  self.funcDelayTime = nil
  self.nextFunc = nil
  self.activeTagData = nil
  table.remove(self.queue, 1)
  self:_RunNext()
end

function Z1Queue:Clear()
  self.activeTag = nil
  self.activeFrame = nil
  self.safeTime = nil
  self.funcDelayTime = nil
  self.nextFunc = nil
  self.activeTagData = nil
  self.queue = {}
end

function Z1Queue:_RunNext()
  if not self.queue then
    return
  end
  local data = self.queue[1]
  self.activeTagData = data
  if data then
    Logger.Proto("Queue 当前执行 " .. data.tag)
    self.activeTag = data.tag
    self.curFuncTime = 0
    self.safeTime = data.safeTime
    self.funcDelayTime = data.delayTime or 0
    if 0 == self.funcDelayTime then
      if data.func then
        data.func()
      end
    else
      self.nextFunc = data.func
    end
  end
end

function Z1Queue:RunAll()
  local queueCount = self.queue and #self.queue or 0
  for i = 1, queueCount do
    self:Next()
  end
end

function Z1Queue:OnDestroy()
  self.queue = nil
  self.nextFunc = nil
end

return Z1Queue
