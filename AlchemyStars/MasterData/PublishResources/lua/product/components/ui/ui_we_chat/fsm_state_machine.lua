_class("FSMStateMachine", Object)
FSMStateMachine = FSMStateMachine

function FSMStateMachine:Constructor(owner)
  self.owner = owner
  self.curState = nil
  self.states = {}
  self:OnInit()
  self.timer = GameGlobal.Timer():AddEventTimes(0, TimerTriggerCount.Infinite, self.Excute, self)
end

function FSMStateMachine:Dispose()
  if self.timer then
    GameGlobal.Timer():CancelEvent(self.timer)
    self.timer = nil
  end
  self:OnDispose()
  if self.curState then
    self.curState:Exit()
    self.curState = nil
  end
  for k, v in pairs(self.states) do
    v:Dispose()
    v = nil
  end
  self.states = {}
end

function FSMStateMachine:OnInit()
end

function FSMStateMachine:OnDispose()
end

function FSMStateMachine:IsCurrent(stateType)
  if not stateType or stateType == "" then
    return false
  end
  local curStateType = self:GetCurStateType()
  return curStateType == stateType
end

function FSMStateMachine:GetCurState()
  return self.curState
end

function FSMStateMachine:GetCurStateType()
  return self.curState and self.curState:GetStateType() or ""
end

function FSMStateMachine:SetOwner(owner)
  self.owner = owner
end

function FSMStateMachine:GetOwner()
  return self.owner
end

function FSMStateMachine:Add(state)
  if not state then
    return
  end
  local stateType = state:GetStateType()
  if self.states[stateType] then
    return
  end
  self.states[stateType] = state
  state:SetMachine(self)
end

function FSMStateMachine:SetDefault(stateType)
  if not stateType then
    return
  end
  self:_ChangeState(stateType)
end

function FSMStateMachine:ForceChangeState(stateType, ...)
  self:_ChangeState(stateType, ...)
end

function FSMStateMachine:ChangeState(stateType, ...)
  if self:IsCurrent(stateType) then
    return
  end
  self:_ChangeState(stateType, ...)
end

function FSMStateMachine:_ChangeState(stateType, ...)
  local nextState = self.states[stateType]
  local canEnter = nextState and nextState:TryEnter(...)
  if not canEnter then
    return
  end
  if self.curState then
    self.curState:Exit()
    self.curState = nil
  end
  local state = self.states[stateType]
  if state then
    self.curState = state
    self.curState:Enter(...)
  end
end

function FSMStateMachine:Excute()
  if not self.curState then
    return
  end
  self.curState:Excute()
end

function FSMStateMachine:SetStateFinishCallback(callback, sender)
  local curState = self:GetCurState()
  if curState then
    curState:SetStateFinishCallback(callback, sender)
  elseif error then
    error("SetStepOverCallback(...) but current state is null!")
  end
end
