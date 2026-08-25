local MvcBase = NewClass("MvcBase")

function MvcBase:ctor()
end

function MvcBase:OnInit()
end

function MvcBase:OnReset()
end

function MvcBase:SetDispatcher(extDispatcher)
  self.localDispatcher = extDispatcher
end

function MvcBase:RegisterNotify(name, handler, handlerObj, priority)
  GlobalDispatcher:AddListener(name, handler, handlerObj, priority)
end

function MvcBase:UnregisterNotify(name, handler, handlerObj)
  GlobalDispatcher:RemoveListener(name, handler, handlerObj)
end

function MvcBase:Notify(name, ...)
  GlobalDispatcher:Dispatch(name, ...)
end

function MvcBase:RegisterLocalNotify(name, handler, handlerObj, priority)
  self.localDispatcher:AddListener(name, handler, handlerObj, priority)
end

function MvcBase:UnregisterLocalNotify(name, handler, handlerObj)
  self.localDispatcher:RemoveListener(name, handler, handlerObj)
end

function MvcBase:LocalNotify(name, ...)
  self.localDispatcher:Dispatch(name, ...)
end

return MvcBase
