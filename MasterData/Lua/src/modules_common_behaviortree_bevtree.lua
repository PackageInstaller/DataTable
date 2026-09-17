local this = class("realBevTree")
local tag = this:getName()
this.event = {
  triggerButton = "triggerButton",
  triggerInterButton = "triggerInteractiveButton"
}
this.taskType = {
  composite = 2,
  decorator = 3,
  action = 4,
  condition = 5
}
this.taskResult = {
  none = 0,
  Inactive = 1,
  Success = 2,
  Failure = 3,
  Running = 4,
  Abort = 5
}
this.abortType = {
  none = 0,
  selfAbort = 1,
  lowerPriority = 2,
  both = 3
}
this.actionType = {
  none = 0,
  switchBtn = 1,
  interBtn = 2
}
local m_hashCode = 0

function this:ctor()
  self.eventCenter = require("core.event").new()
end

function this:registClass(className, ...)
  local cls = class(className, ...)
  self[className] = cls
  return cls
end

function this:getClass(className, ...)
  local node = self[className]
  if node then
    return node.new(...)
  else
    error("[realBevTree]Error : BehaviorTree.load : Invalid node name  " .. className .. "")
  end
end

function this:generateHashCode()
  m_hashCode = m_hashCode + 1
  return m_hashCode
end

function this:generateBevTree(...)
  local bevTree = require("modules.common.behaviorTree.core.behaviorTree").new(...)
  return bevTree
end

function this:sendEvent(eventName, ...)
  self.eventCenter:send(eventName, ...)
end

function this:addListener(eventName, func, register, obj, priority)
  return self.eventCenter:register(eventName, func, register, obj, priority)
end

function this:removeListener(eventName, func)
  self.eventCenter:unRegister(eventName, func)
end

return this
