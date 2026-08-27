local Messenger = class("Messenger")

function Messenger:ctor()
  self.events = {}
end

function Messenger:AddListener(type, callback, ...)
  local event = self.events[type]
  if event == nil then
    event = setmetatable({}, {__mode = "k"})
  end
  for k, v in pairs(event) do
    if k == callback then
      error("Aready cotains listener : " .. tostring(callback))
      return
    end
  end
  event[callback] = true
  self.events[type] = event
end

function Messenger:Broadcast(type, ...)
  local event = self.events[type]
  if event ~= nil then
    for k, v in pairs(event) do
      assert(k ~= nil)
      k(...)
    end
  end
  if self.__subMessenger ~= nil then
    self.__subMessenger:Broadcast(type, ...)
  end
end

function Messenger:RemoveListener(type, callback)
  local event = self.events[type]
  if event == nil then
    return
  end
  if callback == nil then
    warn(string.format("event = %s, callback = %s", event, callback))
    return
  end
  event[callback] = nil
end

function Messenger:RemoveListenerByType(type)
  self.events[type] = nil
end

function Messenger:Clear()
  self.events = {}
end

function Messenger:BindSubBroadcast(messenger)
  self.__subMessenger = messenger
end

return Messenger
