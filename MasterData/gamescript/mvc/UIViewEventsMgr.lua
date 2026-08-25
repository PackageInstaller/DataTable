local UIViewEventsMgr = NewClass("UIViewEventsMgr")

function UIViewEventsMgr:ctor()
end

function UIViewEventsMgr:Dispose()
  self:RemoveAllEvents()
end

function UIViewEventsMgr:BindEvent(event, callback)
  self.bindedEvents = self.bindedEvents or {}
  self.bindedEvents[event] = self.bindedEvents[event] or {}
  self.bindedEvents[event][callback] = true
  event:RegisterEvent(callback)
end

function UIViewEventsMgr:BindEventOnce(event, callback)
  local onceCallback
  
  function onceCallback(...)
    if onceCallback then
      self:RemoveEvent(event, onceCallback)
      onceCallback = nil
    end
    callback(...)
  end
  
  self:BindEvent(event, onceCallback)
end

function UIViewEventsMgr:RemoveEvent(event, callback)
  if self.bindedEvents and self.bindedEvents[event] and self.bindedEvents[event][callback] then
    self.bindedEvents[event][callback] = nil
    event:RemoveEvent(callback)
  end
end

function UIViewEventsMgr:RemoveAllEvents()
  if not self.bindedEvents then
    return
  end
  for event, callbacks in pairs(self.bindedEvents) do
    for cb, v in pairs(callbacks) do
      if v then
        event:RemoveEvent(cb)
      end
    end
  end
  self.bindedEvents = nil
end

return UIViewEventsMgr
