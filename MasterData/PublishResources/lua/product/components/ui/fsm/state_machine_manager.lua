_class("StateMachineManager", Singleton)
StateMachineManager = StateMachineManager
local idSeedStateMachine = 1

function StateMachineManager:Constructor()
  self._stateMachineDict = {}
end

function StateMachineManager:CreateStateMachine(enumName, tStateEnum)
  local id = idSeedStateMachine
  idSeedStateMachine = idSeedStateMachine + 1
  local sm = StateMachine.CreateInstance(id, enumName)
  for key, enum in pairs(tStateEnum) do
    local name = enumName .. key
    local state = State.CreateInstance(name, enum)
    if state then
      state:SetFsm(sm)
      sm:AddState(state)
    else
      Log.fatal("### no class named :", name)
    end
  end
  self._stateMachineDict[id] = sm
  return sm
end

function StateMachineManager:DestroyStateMachine(fsmId)
  local sm
  if self._stateMachineDict and self._stateMachineDict[fsmId] then
    sm = self._stateMachineDict[fsmId]
    self._stateMachineDict[fsmId] = nil
  end
  if sm then
    sm:Destroy()
    sm = nil
  end
end

function StateMachineManager:AddState(fsmId, state)
  local sm = self:GetStateMachine(fsmId)
  if sm then
    sm:AddState(state)
  end
end

function StateMachineManager:GetStateMachine(fsmId)
  if self._stateMachineDict and self._stateMachineDict[fsmId] then
    local sm = self._stateMachineDict[fsmId]
    return sm
  end
  return nil
end

function StateMachineManager:Init(fsmId, stateId)
  local sm = self:GetStateMachine(fsmId)
  if sm then
    sm:Init(stateId)
  end
end

function StateMachineManager:ChangeState(fsmId, stateId)
  local sm = self:GetStateMachine(fsmId)
  if sm then
    sm:ChangeState(stateId)
  end
end
