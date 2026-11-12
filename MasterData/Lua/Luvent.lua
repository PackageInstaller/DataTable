local Luvent = {}
Luvent.__index = Luvent

function Luvent.newEvent()
  local event = {}
  event.actions = {}
  return setmetatable(event, Luvent)
end

function Luvent.__eq(e1, e2)
  if getmetatable(e1) ~= Luvent or getmetatable(e2) ~= Luvent then
    return false
  end
  if #e1.actions ~= #e2.actions then
    return false
  end
  for _, a1 in ipairs(e1.actions) do
    local found = false
    for _, a2 in ipairs(e2.actions) do
      if a1 == a2 then
        found = true
        break
      end
    end
    if found == false then
      return false
    end
  end
  return true
end

Luvent.Action = {}
Luvent.Action.__index = Luvent.Action

local function isActionCallable(callable)
  if type(callable) == "table" then
    if type(getmetatable(callable).__call) == "function" then
      return true
    end
  elseif type(callable) == "function" then
    return true
  elseif type(callable) == "thread" and coroutine.status(callable) ~= "dead" then
    return true
  end
  return false
end

local function newAction(callable)
  local action = {}
  assert(isActionCallable(callable))
  action.callable = callable
  action.id = tostring(callable)
  action.enabled = true
  action.priority = 0
  action.limit = -1
  action.numberOfInvocations = 0
  action.interval = 0
  action.timeOfLastInvocation = os.time()
  return setmetatable(action, Luvent.Action)
end

function Luvent.Action.__eq(a1, a2)
  if getmetatable(a1) ~= Luvent.Action or getmetatable(a2) ~= Luvent.Action then
    return false
  end
  return a1.id == a2.id
end

local function findAction(event, actionToFind)
  local key
  if type(actionToFind) == "string" then
    key = "id"
  elseif isActionCallable(actionToFind) then
    key = "callable"
  else
    error("Invalid action parameter: " .. tostring(actionToFind))
  end
  for index, action in ipairs(event.actions) do
    if action[key] == actionToFind then
      return true, index
    end
  end
  return false, nil
end

local function sortActionsByPriority(event)
  table.sort(event.actions, function(a1, a2)
    return a1.priority > a2.priority
  end)
end

function Luvent:addAction(actionToAdd)
  assert(isActionCallable(actionToAdd) == true)
  if self:hasAction(actionToAdd) then
    return
  end
  local new = newAction(actionToAdd)
  table.insert(self.actions, new)
  return new.id
end

function Luvent:removeAction(actionToRemove)
  local exists, index = findAction(self, actionToRemove)
  if exists == true then
    table.remove(self.actions, index)
  end
end

function Luvent:removeAllActions()
  self.actions = {}
end

function Luvent:getActionCount()
  return #self.actions
end

function Luvent:hasAction(actionToFind)
  return (findAction(self, actionToFind))
end

local function invokeAction(action, ...)
  if action.enabled == false then
    return true
  end
  if type(action.callable) == "thread" then
    coroutine.resume(action.callable, ...)
    if coroutine.status(action.callable) == "dead" then
      return false
    end
  else
    action.callable(...)
  end
  action.numberOfInvocations = action.numberOfInvocations + 1
  if action.limit >= 0 and action.numberOfInvocations >= action.limit then
    action.enabled = false
  end
  return true
end

function Luvent:trigger(...)
  local function call(action, ...)
    local keep = invokeAction(action, ...)
    
    if keep == false then
      self:removeAction(action.id)
    end
  end
  
  sortActionsByPriority(self)
  for _, action in ipairs(self.actions) do
    if action.interval > 0 then
      if os.difftime(os.time(), action.timeOfLastInvocation) >= action.interval then
        call(action, ...)
        action.timeOfLastInvocation = os.time()
      end
    else
      call(action, ...)
    end
  end
end

local function createActionSetter(property, valueType, default)
  return function(event, actionToFind, newValue)
    local propertyValue = newValue or default
    local propertyValueType = type(propertyValue)
    local exists, index = findAction(event, actionToFind)
    assert(exists)
    assert(propertyValueType == valueType)
    if propertyValueType == "number" then
      assert(0 <= propertyValue)
    end
    event.actions[index][property] = propertyValue
  end
end

local function createActionGetter(property)
  return function(event, action)
    local exists, index = findAction(event, action)
    assert(exists)
    assert(event.actions[index][property])
    return event.actions[index][property]
  end
end

Luvent.setActionInterval = createActionSetter("interval", "number")
Luvent.getActionInterval = createActionGetter("interval")
Luvent.removeActionInterval = createActionSetter("interval", "number", 0)
Luvent.setActionPriority = createActionSetter("priority", "number")
Luvent.getActionPriority = createActionGetter("priority")
Luvent.removeActionPriority = createActionSetter("priority", "number", 0)
Luvent.enableAction = createActionSetter("enabled", "boolean", true)
Luvent.disableAction = createActionSetter("enabled", "boolean", false)

function Luvent:isActionEnabled(actionToFind)
  local exists, index = findAction(self, actionToFind)
  assert(exists)
  return self.actions[index].enabled
end

function Luvent:setActionTriggerLimit(actionToFind, limit)
  local exists, index = findAction(self, actionToFind)
  assert(exists)
  assert(type(limit) == "number" and 0 <= limit)
  self.actions[index].limit = limit
  self.actions[index].numberOfInvocations = 0
  if limit == 0 then
    self.actions[index].enabled = false
  end
end

function Luvent:getActionTriggerLimit(actionToFind)
  local exists, index = findAction(self, actionToFind)
  assert(exists)
  assert(self.actions[index].limit)
  return self.actions[index].limit
end

function Luvent:removeActionTriggerLimit(actionToFind)
  local exists, index = findAction(self, actionToFind)
  assert(exists)
  self.actions[index].limit = -1
  self.actions[index].numberOfInvocations = 0
  self.actions[index].enabled = true
end

function Luvent:allActions()
  local index = 0
  return function()
    index = index + 1
    local action = self.actions[index]
    if action then
      return action.id
    end
  end
end

function Luvent:forEachAction(f)
  for action in self:allActions() do
    f(self, action)
  end
end

return Luvent
