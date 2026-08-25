local CommandEntry = NewClass("CommandEntry")

function CommandEntry._PoolCreateFunc()
  do return end
  return CommandEntry, nil
end

function CommandEntry._PoolDisposeFunc(entryObj)
end

function CommandEntry._PoolResetFunc(entryObj)
  entryObj:Reset()
end

function CommandEntry.InitPool()
  CommandEntry.pool = ObjectPool(10, CommandEntry._PoolCreateFunc, CommandEntry._PoolDisposeFunc, CommandEntry._PoolResetFunc)
end

function CommandEntry.GetPool()
  return CommandEntry.pool
end

function CommandEntry:ctor()
  self:Reset()
end

function CommandEntry:Reset()
  self.handler = nil
  self.handlerObj = nil
  self.params = nil
  self.isValid = nil
end

return CommandEntry
