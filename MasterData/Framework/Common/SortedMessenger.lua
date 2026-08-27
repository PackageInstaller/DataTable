local base = require("Framework.Common.Messenger")
local SortedMessenger = class("Messenger", base)

function SortedMessenger:AddListener(type, callback, ...)
  local event = self.events[type]
  if event == nil then
    event = {}
    event.index = {}
    event.calbacks = setmetatable({}, {__mode = "v"})
  end
  local indexT = event.index
  local priority = select(1, ...)
  for k, v in ipairs(event.calbacks) do
    if v ~= nil and v == callback then
      error("Aready cotains listener : " .. tostring(callback))
      return
    end
  end
  if priority == nil then
    priority = 1
  end
  if indexT[priority] == nil then
    indexT[priority] = 1
    for k, v in pairs(indexT) do
      if k < priority then
        indexT[priority] = v
      end
    end
  end
  local index = indexT[priority]
  table.insert(event.calbacks, index, callback)
  for k, v in pairs(indexT) do
    if priority <= k then
      indexT[k] = v + 1
    end
  end
  self.events[type] = event
end

function SortedMessenger:Broadcast(type, ...)
  local event = self.events[type]
  if event == nil then
    return
  end
  for k, v in ipairs(event.calbacks) do
    assert(v ~= nil)
    v(...)
  end
end

function SortedMessenger:RemoveListener(type, callback)
  local event = self.events[type]
  if event == nil or callback == nil then
    warn(string.format("event = %s, callback = %s", event, callback))
    return
  end
  local index = 0
  for i = #event.calbacks, 1, -1 do
    if event.calbacks[i] == callback then
      index = i
      table.remove(event.calbacks, i)
      break
    end
  end
  if 0 >= #event.calbacks then
    event.index = {}
    return
  end
  if 0 < index then
    for k, v in pairs(event.index) do
      if index < v then
        event.index[k] = v - 1
      end
    end
  end
end

return SortedMessenger
