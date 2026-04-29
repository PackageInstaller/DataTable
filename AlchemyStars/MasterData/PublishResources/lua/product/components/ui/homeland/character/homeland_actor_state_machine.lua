_class("HomelandActorStateMachine", Object)
HomelandActorStateMachine = HomelandActorStateMachine

function HomelandActorStateMachine:Constructor()
  self._curState = nil
  self._mcc = nil
  self._stateMap = {}
  self._stateSwitchLock = false
  self._nextStateType = nil
end

function HomelandActorStateMachine:Init(mcc)
  self._mcc = mcc
  self:AddState(HomelandActorStateIdle:New(self))
  self:AddState(HomelandActorStateSwim:New(self))
  self:AddState(HomelandActorStateRun:New(self))
  self:AddState(HomelandActorStateDash:New(self))
  self:AddState(HomelandActorStateInteract:New(self))
  self:AddState(HomelandActorStateAxe:New(self))
  self:AddState(HomelandActorStatePick:New(self))
  self:AddState(HomelandActorStateNavigate:New(self))
end

function HomelandActorStateMachine:AddState(state)
  local type = state:GetType()
  if self._stateMap[type] then
    return
  end
  self._stateMap[type] = state
end

function HomelandActorStateMachine:Dispose()
  for _, state in pairs(self._stateMap) do
    state:Dispose()
  end
  self._stateMap = {}
end

function HomelandActorStateMachine:Update(deltaTimeMS)
  self._stateSwitchLock = true
  if self._curState then
    self._curState:Update(deltaTimeMS)
  end
  self._stateSwitchLock = false
  self:CheckSwitchState()
end

function HomelandActorStateMachine:CurrenStateType()
  if self._curState then
    return self._curState:GetType()
  end
end

function HomelandActorStateMachine:GetMainCharacterController()
  return self._mcc
end

function HomelandActorStateMachine:SwitchState(targetState, ...)
  if self._curState and self._curState:GetType() == targetState then
    return
  end
  self._nextStateType = targetState
  self._nextStateParam = table.pack(...)
  if not self._stateSwitchLock then
    self:CheckSwitchState()
  end
end

function HomelandActorStateMachine:CheckSwitchState()
  self._stateSwitchLock = true
  while self._nextStateType do
    local nextState = self._stateMap[self._nextStateType]
    self._nextStateType = nil
    if not nextState then
      break
    end
    if self._curState then
      self._curState:Exit()
    end
    self._curState = nextState
    self._curState:Enter(table.unpack(self._nextStateParam))
  end
  self._stateSwitchLock = false
end

function HomelandActorStateMachine:HandleEvent(eventType, ...)
  if self._curState then
    self._curState:HandleEvent(eventType, ...)
  end
end
