local Transition = System.NewClass("Transition")

function Transition:ctor(source, target)
  self._priority = 0
  self.Triggers = {}
  self.Conditions = {}
  self._ownerState = source
  self.Target = target
end

function Transition:getAnyTrigger()
  return self.Triggers == nil
end

function Transition:setAnyTrigger(value)
  if value then
    self.Triggers = nil
  elseif self.Triggers == nil then
    self.Triggers = {}
  end
end

function Transition.OnSort(a, b)
  return a:getPriority() - b:getPriority()
end

function Transition:getPriority()
  return self._priority
end

function Transition:setPriority(value)
  self._priority = value
end

function Transition:getSource()
  local default
  if self._ownerState == nil then
    default = self.Target.OwnerFsm.Current
  else
    default = self:getOwnerState()
  end
  return default
end

function Transition:getOwnerState()
  local default
  if self._ownerState == nil then
    default = self.Target.OwnerFsm.Current
  else
    default = self._ownerState
  end
  return default
end

function Transition:AddTrigger(trigger)
  if self.Triggers == nil then
    Logger.Debug(FsmException.TriggersIsAny())
  end
  if self.Triggers[trigger] ~= nil then
    Logger.Debug(FsmException.TriggerAlreadyDeclared(trigger))
  end
  self.Triggers[trigger] = trigger
  return self
end

function Transition:CheckTransition(input)
  return (self.Triggers == nil or self.Triggers[input] ~= nil) and self:ConditionsMet(input)
end

function Transition:ConditionsMet(input)
  local ret = true
  for i, condition in ipairs(self.Conditions) do
    if not condition(StateChangeArgs(self:getOwnerState().OwnerFsm, self:getSource(), self.Target, input)) then
      ret = false
    end
  end
  return ret
end

function Transition:On(trigger)
  do return self.AddTrigger, self end
  return self.AddTrigger, self, trigger
end

function Transition:OnAny()
  self:setAnyTrigger(true)
  return self
end

function Transition:If(condition)
  table.insert(self.Conditions, condition)
  return self
end

function Transition:TransitionTo(state)
  do return self:getOwnerState().TransitionTo, (self:getOwnerState()) end
  return self:getOwnerState().TransitionTo, self:getOwnerState(), state
end

function Transition:OnEnter(enter)
  self:getOwnerState():AddEnteredHandler(enter)
  return self
end

function Transition:OnExit(exit)
  self:getOwnerState():AddExitedHandler(exit)
  return self
end

function Transition:State(state)
  do return self:getOwnerState().OwnerFsm.AddOrGetState, self:getOwnerState().OwnerFsm end
  return self:getOwnerState().OwnerFsm.AddOrGetState, self:getOwnerState().OwnerFsm, state
end

function Transition:GlobalTransitionTo(state)
  do return self:getOwnerState().OwnerFsm.AddOrGetGlobalTransition, self:getOwnerState().OwnerFsm end
  return self:getOwnerState().OwnerFsm.AddOrGetGlobalTransition, self:getOwnerState().OwnerFsm, state
end

function Transition:SetPriority(priority)
  self:setPriority(priority)
  return self
end

return Transition
