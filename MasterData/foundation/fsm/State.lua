local State = System.NewClass("State")

function State:ctor(owner, identifier)
  self.Instance = nil
  self.Identifier = nil
  self.Transitions = {}
  self.OwnerFsm = owner
  self.Identifier = identifier
end

function State:AddOrGetTransition(state)
  local currentTransition
  for i, v in ipairs(self.Transitions) do
    if v.Target.Identifier == state then
      currentTransition = v
      break
    end
  end
  if nil == currentTransition then
    currentTransition = Transition(self, self.OwnerFsm:AddOrGetState(state))
    table.insert(self.Transitions, currentTransition)
  end
  return currentTransition
end

function State:AddEnteredHandler(e)
  if nil == e then
    Logger.Exception(FsmException.HandlerCannotBeNull())
  end
  if nil == self._entered then
    self._entered = {}
  end
  self._entered[e] = e
end

function State:RemoveEnteredHandler(e)
  if nil == e then
    Logger.Exception(FsmException.HandlerCannotBeNull())
  end
  self._entered[e] = nil
end

function State:RaiseEntered(e)
  if self._entered ~= nil then
    for i, v in pairs(self._entered) do
      v(e)
    end
  end
end

function State:AddExitedHandler(e)
  if nil == e then
    Logger.Exception(FsmException.HandlerCannotBeNull())
  end
  if nil == self._exited then
    self._exited = {}
  end
  self._exited[e] = e
end

function State:RemoveExitedHandler(e)
  if nil == e then
    Logger.Exception(FsmException.HandlerCannotBeNull())
  end
  self._exited[e] = nil
end

function State:RaiseExited(e)
  if self._exited ~= nil then
    for i, v in pairs(self._exited) do
      v(e)
    end
  end
end

function State:CheckTransition(input)
  local ret
  for i, v in ipairs(self.Transitions) do
    if v:CheckTransition(input) then
      ret = v
      break
    end
  end
  return ret
end

function State:ToString()
  do return self.Identifier.ToString end
  return self.Identifier.ToString, self.Identifier
end

function State:State(state)
  do return self.OwnerFsm.AddOrGetState, self.OwnerFsm end
  return self.OwnerFsm.AddOrGetState, self.OwnerFsm, state
end

function State:OnStateChanged(e)
  self.OwnerFsm:AddStateChangedHandler(e)
  return self
end

function State:TransitionTo(state)
  do return self.AddOrGetTransition, self end
  return self.AddOrGetTransition, self, state
end

function State:OnEnter(enter)
  self:AddEnteredHandler(enter)
  return self
end

function State:OnExit(exit)
  self:AddExitedHandler(exit)
  return self
end

return State
