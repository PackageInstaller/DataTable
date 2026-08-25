local SystemEvent = System.NewClass("SystemEvent")

function SystemEvent:ctor()
  self.removeListeners = {}
  self.addListeners = {}
  self.listeners = {}
  self.dispatching = false
  self.index = 0
  self.listener2index = {}
end

local function AddListener(self, listener, index, condFunc)
  self.listeners[index] = {
    listener,
    index,
    condFunc
  }
  self.listener2index[listener] = index
end

function SystemEvent:Register(listener, condFunc)
  self.index = self.index + 1
  if self.dispatching then
    if self.removeListeners[listener] ~= nil then
      self.removeListeners[listener] = nil
    end
    self.addListeners[listener] = {
      listener,
      self.index,
      condFunc
    }
    return
  end
  AddListener(self, listener, self.index, condFunc)
end

local function RemoveListener(self, listener)
  if self.listener2index[listener] then
    local index = self.listener2index[listener]
    self.listeners[index] = nil
    self.listener2index[listener] = nil
  end
end

function SystemEvent:Remove(listener)
  if self.dispatching then
    if self.addListeners[listener] ~= nil then
      self.addListeners[listener] = nil
    end
    if self.listener2index[listener] then
      local index = self.listener2index[listener]
      self.removeListeners[listener] = {listener, index}
    end
    return
  end
  RemoveListener(self, listener)
end

function SystemEvent:Destroy()
  if self.dispatching then
    self.removeListeners = {}
    for _, v in pairs(self.listeners) do
      self.removeListeners[v[1]] = {
        v[1],
        v[2]
      }
    end
  else
    self.listeners = {}
  end
end

function SystemEvent:IsMonitoring()
  return next(self.listeners) ~= nil
end

function SystemEvent:Dispatch(target, ...)
  if not self:IsMonitoring() then
    return
  end
  self.dispatching = true
  for _, listener in pairs(self.listeners) do
    if self.removeListeners[listener] == nil then
      if not listener[3] then
        listener[1](target, ...)
      else
        local ok, data = listener[3](target)
        if ok then
          if data then
            listener[1](data, ...)
          else
            listener[1](...)
          end
        end
      end
    end
  end
  for _, v in pairs(self.removeListeners) do
    RemoveListener(self, v[1])
  end
  for _, v in pairs(self.addListeners) do
    AddListener(self, v[1], v[2], v[3])
  end
  self.removeListeners = {}
  self.addListeners = {}
  self.dispatching = false
end

return SystemEvent
