local GlobalDispatcher = {}

function GlobalDispatcher.Init()
  NotifyEntry.InitPool()
  DispatchEntry.InitPool()
  CommandEntry.InitPool()
  NotifyDispatcher.Extend(GlobalDispatcher)
end

return GlobalDispatcher
