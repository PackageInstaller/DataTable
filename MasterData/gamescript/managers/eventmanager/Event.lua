local Event = System.NewClass("Event")

function Event:ctor()
  self.removeListeners = {}
  self.listeners = {}
  self.addListeners = {}
  self.dispatching = false
end

function Event:RegisterEvent(listener)
  if self.dispatching then
    if self.removeListeners[listener] ~= nil then
      self.removeListeners[listener] = nil
    else
      self.addListeners[listener] = listener
    end
    return
  end
  self.listeners[listener] = listener
end

function Event:RemoveEvent(listener)
  if self.dispatching then
    self.removeListeners[listener] = listener
    self.addListeners[listener] = nil
  else
    self.listeners[listener] = nil
  end
end

function Event:RemoveAllEvents()
  if self.dispatching then
    self.removeListeners = self.listeners
    self.addListeners = {}
  else
    self.listeners = {}
  end
end

function Event:Dispatch(...)
  self.dispatching = true
  for i, listener in pairs(self.listeners) do
    if self.removeListeners[listener] == nil then
      listener(...)
    end
  end
  for i, v in pairs(self.removeListeners) do
    self.listeners[v] = nil
  end
  table.clear(self.removeListeners)
  for k, v in pairs(self.addListeners) do
    self.listeners[k] = v
  end
  table.clear(self.addListeners)
  self.dispatching = false
end

return Event
