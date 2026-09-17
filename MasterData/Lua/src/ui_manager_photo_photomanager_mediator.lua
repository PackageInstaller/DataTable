local this = {}

function this:onCsEntityDestroy(csEntityId)
  if self._csEntityId2StateMachine then
    if self._csEntityId2StateMachine[csEntityId] then
      local machine = self._csEntityId2StateMachine[csEntityId]
      machine:destroy()
    end
    self._csEntityId2StateMachine[csEntityId] = nil
  end
end

function this:getStateMachine(csEntityId)
  if not self._csEntityId2StateMachine or self._csEntityId2StateMachine and not self._csEntityId2StateMachine[csEntityId] then
    local csEntity = C_EntityManager.GetAliveEntity(csEntityId)
    local stateMachine = require(L_R.world.core .. "stateMachine.stateMachine").new(csEntity)
    self._csEntityId2StateMachine = self._csEntityId2StateMachine or {}
    self._csEntityId2StateMachine[csEntityId] = stateMachine
  end
  return self._csEntityId2StateMachine[csEntityId]
end

function this:getMainControlIsFree()
  local mainControl = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if not mainControl then
    return true
  end
  local state = self:getStateMachine(mainControl.data.entityId)
  return state:getCurStateType() == L_Const.stateType.free
end

function this:destroyAllStateMachine()
  if not self._csEntityId2StateMachine then
    return
  end
  for csEntityId, machine in pairs(self._csEntityId2StateMachine) do
    if machine then
      machine:reset()
      machine:destroy()
    end
  end
  self._csEntityId2StateMachine = nil
end

return this
