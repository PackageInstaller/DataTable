local event = class("event")

function event:ctor()
  self.eventDic = {}
end

local function safeSameCallback(funcA, funcB)
  if funcA == nil or funcB == nil then
    return false
  end
  if funcA ~= funcB then
    return tostring(funcA) == tostring(funcB)
  end
  return true
end

function event:register(eventName, func, register, obj, priority)
  if string.isEmpty(eventName) then
    errorf("eventName is empty!!")
    return
  end
  if func == nil then
    errorf(eventName .. " : func is nill!!")
    return
  end
  local node = {
    register = register,
    obj = obj,
    func = func,
    activeIn = true,
    priority = math.clamp(priority or 1, 0)
  }
  if table.isEmpty(self.eventDic[eventName]) then
    self.eventDic[eventName] = {}
  end
  local ele = self.eventDic[eventName]
  for _, v in ipairs(ele) do
    if not v.needRemove then
      if register ~= nil then
        if safeSameCallback(v.func, func) and v.register == register then
          return
        end
      elseif safeSameCallback(v.func, func) then
        return
      end
    end
  end
  if register ~= nil then
    local eventMap = register._hasRegisteredEvent or {}
    eventMap[self] = true
    register._hasRegisteredEvent = eventMap
  end
  for i, v in ipairs(ele) do
    if node.priority >= v.priority then
      table.insert(ele, i, node)
      return node
    end
  end
  table.insert(ele, node)
  return node
end

function event:unRegister(eventName, func, register)
  if func == nil then
    errorf("尝试注销空函数！\n")
  end
  local ele = self.eventDic[eventName]
  if ele == nil then
    return
  end
  local metaF = getmetatable(func)
  local node, index = table.ipairsFind(ele, function(v)
    if register ~= nil then
      return safeSameCallback(v.func, func) and v.register == register
    else
      if metaF and getmetatable(v.func) then
        return safeSameCallback(v.func, func)
      end
      return safeSameCallback(v.func, func)
    end
  end)
  if index then
    if self.isLock then
      node.needRemove = true
    else
      table.fastRemove(ele, index)
    end
  end
end

function event:unRegisterAll(register)
  for _, ele in pairs(self.eventDic) do
    for i = #ele, 1, -1 do
      local node = ele[i]
      if node.register == register then
        if self.isLock then
          node.needRemove = true
        else
          table.fastRemove(ele, i)
        end
      end
    end
  end
end

function event:send(eventName, ...)
  local ele = self.eventDic[eventName]
  if ele == nil then
    return
  end
  self.isLock = true
  for i = #ele, 1, -1 do
    local node = ele[i]
    if node.needRemove then
      table.fastRemove(ele, i)
    else
      local isDo = true
      if node.obj then
        if node.obj:IsNull() then
          table.remove(ele, i)
          isDo = false
        else
          isDo = not node.activeIn or not not node.obj.activeInHierarchy
        end
      end
      if isDo then
        if node.register then
          node.func(node.register, ...)
        else
          node.func(...)
        end
      end
    end
  end
  self.isLock = nil
end

return event
