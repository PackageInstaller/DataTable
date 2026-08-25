local DispatchEntry = NewClass("DispatchEntry")

function DispatchEntry._PoolCreateFunc()
  do return end
  return DispatchEntry, nil
end

function DispatchEntry._PoolDisposeFunc(entryObj)
end

function DispatchEntry._PoolResetFunc(entryObj)
  entryObj:Reset()
end

function DispatchEntry.InitPool()
  DispatchEntry.pool = ObjectPool(10, DispatchEntry._PoolCreateFunc, DispatchEntry._PoolDisposeFunc, DispatchEntry._PoolResetFunc)
end

function DispatchEntry.GetPool()
  return DispatchEntry.pool
end

function DispatchEntry:ctor()
  self:Reset()
end

function DispatchEntry:Reset()
  self.name = 0
  self.message = nil
end

return DispatchEntry
