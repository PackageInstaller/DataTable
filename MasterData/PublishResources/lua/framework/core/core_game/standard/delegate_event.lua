DelegateEvent = {}

function DelegateEvent:New()
  local event = {}
  setmetatable(event, self)
  self.__index = self
  self.__call = self.Call
  event._callArray = ArrayList:New()
  return event
end

function DelegateEvent:AddEvent(source, func)
  self._callArray:PushBack({source, func})
end

function DelegateEvent:RemoveEvent(source, func)
  for i = 1, self._callArray:Size() do
    local item = self._callArray:GetAt(i)
    if item[2] == func and item[1] == source then
      self._callArray:RemoveAt(i)
      return true
    end
  end
  return false
end

function DelegateEvent:Clear()
  self._callArray:Clear()
end

function DelegateEvent:Call(...)
  local size = self._callArray:Size()
  for i = 1, size do
    local item = self._callArray:GetAt(i)
    item[2](item[1], ...)
  end
end
