_class("Callback", Object)
Callback = Callback
local unpack = table.unpack
local maxn = table.maxn

function Callback:Constructor(id, func, ...)
  self.id = id
  self.f = func
  self.p = {
    ...
  }
end

function Callback:GetID()
  return self.id
end

function Callback:Call(...)
  local func = self.f
  local params = {}
  for k, v in ipairs(self.p) do
    params[#params + 1] = v
  end
  local args = {
    ...
  }
  for k, v in ipairs(args) do
    params[#params + 1] = v
  end
  if func then
    return func(unpack(params, 1, maxn(params)))
  end
end

function Callback:CallHaveReturn(...)
  local func = self.f
  local params = {}
  for k, v in ipairs(self.p) do
    params[#params + 1] = v
  end
  local args = {
    ...
  }
  for k, v in ipairs(args) do
    params[#params + 1] = v
  end
  if func then
    return func(unpack(params, 1, table.maxn(params)))
  end
  return nil
end

function Callback:GetOoObject()
  local params = self.p
  if params and 0 < #params then
    return params[1]
  end
end

_class("EventCallback", Callback)
EventCallback = EventCallback

function EventCallback:SetEventType(eventType)
  self.eventType = eventType
end

function EventCallback:GetEventType()
  return self.eventType
end
