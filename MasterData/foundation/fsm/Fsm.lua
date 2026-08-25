local Fsm = System.NewClass("Fsm")

function Fsm:ctor(startState)
  self.States = {}
  self.GlobalTransitions = {}
  self.Current = self:AddOrGetState(startState)
  self.StartState = self.Current
end

function Fsm:AddStateChangedHandler(e)
  if nil == e then
    Logger.Exception(FsmException.HandlerCannotBeNull())
  end
  if nil == self.StateChanged then
    self.StateChanged = {}
  end
  self.StateChanged[e] = e
end

function Fsm:AddState(state)
  if nil == state then
    Logger.Exception(FsmException.StateCannotBeNull())
  end
  if nil ~= self.States[state.Identifier] then
    Logger.Exception(FsmException.StateCanOnlyBeAddedOnce(state))
  end
  self.States[state.Identifier] = state
end

function Fsm:AddOrGetState(state)
  local currentState = self.States[state]
  if not currentState then
    currentState = State(self, state)
    self.States[state] = currentState
  end
  return currentState
end

function Fsm:TryGetState(state, outState)
  outState = self.States[state]
  return nil ~= outState, outState
end

function Fsm:GetState(state)
  local currentState = self.States[state]
  if not currentState then
    Logger.Exception(FsmException.StateCannotBeNull())
  end
  return currentState
end

function Fsm:GetStateInstance(state, T)
  do return self:GetState(state).Instance.cast, self:GetState(state).Instance end
  return self:GetState(state).Instance.cast, self:GetState(state).Instance, T
end

function Fsm:HasState(state)
  return self.States[state] ~= nil
end

function Fsm:JumpTo(state)
  local s = self.States[state]
  if s then
    self:DoTransition(s)
  end
end

function Fsm:JumpToStartState()
  self:DoTransition(self.StartState)
end

function Fsm:DoTransition(state, input)
  if nil == state then
    return
  end
  local old = self.Current
  self.Current = state
  if self.Current == old then
    return
  end
  local args = StateChangeArgs(self, old, self.Current, input)
  old:RaiseExited(args)
  self.Current:RaiseEntered(args)
  if nil ~= self.StateChanged then
    for i, v in pairs(self.StateChanged) do
      v(args)
    end
  end
end

function Fsm:Trigger(input)
  local target, default
  default, target = self:CheckTrigger(input)
  if not default then
    return false
  end
  self:DoTransition(target, input)
  return true
end

function Fsm:AddOrGetGlobalTransition(state)
  local currentTransition
  for i, v in ipairs(self.GlobalTransitions) do
    if v.Target.Identifier == state then
      currentTransition = v
      break
    end
  end
  if nil == currentTransition then
    currentTransition = Transition(nil, self:AddOrGetState(state))
    table.insert(self.GlobalTransitions, currentTransition)
  end
  return currentTransition
end

function Fsm:CheckGlobalTransition(input)
  local ret
  for i, t in ipairs(self.GlobalTransitions) do
    if t:CheckTransition(input) then
      ret = t
      break
    end
  end
  return ret
end

function Fsm:CheckTrigger(input, target)
  if nil == input then
    target = self.Current
    return false, target
  end
  local t = self:CheckGlobalTransition(input)
  if nil ~= t then
    target = t.Target
    return true, target
  end
  t = self.Current:CheckTransition(input)
  if nil ~= t then
    target = t.Target
    return true, target
  end
  target = self.Current
  return false, target
end

function Fsm:State(state)
  do return self.AddOrGetState, self end
  return self.AddOrGetState, self, state
end

function Fsm:OnStateChanged(e)
  self:AddStateChangedHandler(e)
  return self
end

function Fsm:GlobalTransitionTo(state)
  do return self.AddOrGetGlobalTransition, self end
  return self.AddOrGetGlobalTransition, self, state
end

return Fsm
