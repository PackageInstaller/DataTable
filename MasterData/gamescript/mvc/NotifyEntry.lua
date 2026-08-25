local NotifyEntry = NewClass("NotifyEntry")

function NotifyEntry._PoolCreateFunc()
  do return end
  return NotifyEntry, nil
end

function NotifyEntry._PoolDisposeFunc(entryObj)
end

function NotifyEntry._PoolResetFunc(entryObj)
  entryObj:Reset()
end

function NotifyEntry.InitPool()
  NotifyEntry.pool = ObjectPool(10, NotifyEntry._PoolCreateFunc, NotifyEntry._PoolDisposeFunc, NotifyEntry._PoolResetFunc)
end

function NotifyEntry.GetPool()
  return NotifyEntry.pool
end

function NotifyEntry:ctor()
  self:Reset()
end

function NotifyEntry:Reset()
  self.name = 0
  self.handler = nil
  self.handlerObj = nil
  self.status = NotifyStatus.Idle
  self.priority = NotifyPriority.Low
  self.isRemoveAllHandler = nil
end

return NotifyEntry
