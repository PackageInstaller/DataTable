local Awaiter = require("Foundation.System.Awaiter")
local EventMgr = require("Managers.EventManager.EventMgr")
local StageAwaiter = System.NewClass("StageAwaiter", Awaiter)

function StageAwaiter.Dispatch(desc, overTime, isStopAll)
  local awaiter = StageAwaiter.Get()
  EventMgr.Instance.StageAwaiterArise:Dispatch(awaiter, desc, overTime, isStopAll)
  return awaiter
end

function StageAwaiter.Get()
  if not StageAwaiter.pool then
    StageAwaiter.pool = {}
  end
  local awaiter = table.remove(StageAwaiter.pool)
  if awaiter then
    awaiter.inPool = false
    return awaiter
  else
    do return end
    return StageAwaiter
  end
end

function StageAwaiter:Recycle()
  if not StageAwaiter.pool then
    StageAwaiter.pool = {}
  end
  if self.inPool then
    return
  end
  self:Reset()
  self.inPool = true
  table.insert(StageAwaiter.pool, self)
end

return StageAwaiter
