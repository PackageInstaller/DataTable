_class("MoveFSMComponent", Object)
MoveFSMComponent = MoveFSMComponent

function MoveFSMComponent:Constructor(fsmID, actorID)
  self._fsmID = tonumber(fsmID)
  self._moveFSMGenInfo = GameFSMGenInfo:New()
  self._moveFSMGenInfo.CustomLogicConfigTable = ConfigData_PlayerActionFSM
  self._moveFSMGenInfo.CustomLogicConfigID = self._fsmID
  self._moveFSMGenInfo.EntityID = actorID
end

function MoveFSMComponent:Dispose()
  if self._fsmImp then
    self._fsmImp:Destroy()
    self._fsmImp = nil
  end
end

function MoveFSMComponent:Initialize(world)
  self._moveFSMGenInfo.World = world
  self._fsmImp = CustomLogicFactory.Static_CreateLogic(self._moveFSMGenInfo)
end

function MoveFSMComponent:Update(deltaTimeMS)
  return self._fsmImp:Update(deltaTimeMS)
end

function MoveFSMComponent:GetMoveFSMCurStateID()
  if self._fsmImp == nil then
    return PlayerActionStateID.Idle
  end
  local fsmNode = self._fsmImp.nodes.elements[1]
  local stateID = fsmNode:CurrentStateID()
  return stateID
end

function Entity:MoveFSM()
  return self:GetComponent(self.WEComponentsEnum.MoveFSM)
end

function Entity:HasMoveFSM()
  return self:HasComponent(self.WEComponentsEnum.MoveFSM)
end

function Entity:AddMoveFSM(fsmID, actorID)
  local index = self.WEComponentsEnum.MoveFSM
  local component = MoveFSMComponent:New(fsmID, actorID)
  local world = self:GetOwnerWorld()
  component:Initialize(world)
  self:AddComponent(index, component)
end

function Entity:ReplaceMoveFSM(fsmID, actorID)
  local index = self.WEComponentsEnum.MoveFSM
  local component = self:MoveFSM()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveMoveFSM()
  if self:HasMoveFSM() then
    self:RemoveComponent(self.WEComponentsEnum.MoveFSM)
  end
end
