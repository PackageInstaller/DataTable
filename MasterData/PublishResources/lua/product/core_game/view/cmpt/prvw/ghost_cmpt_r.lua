_class("GhostComponent", Object)

function GhostComponent:Constructor(ownerID)
  self._ownerID = ownerID
end

function GhostComponent:GetOwnerID()
  return self._ownerID
end

function GhostComponent:WEC_PostInitialize(owner)
end

function GhostComponent:WEC_PostRemoved()
end

function Entity:Ghost()
  return self:GetComponent(self.WEComponentsEnum.Ghost)
end

function Entity:HasGhost()
  return self:HasComponent(self.WEComponentsEnum.Ghost)
end

function Entity:AddGhost(ownerID)
  local index = self.WEComponentsEnum.Ghost
  local component = GhostComponent:New(ownerID)
  self:AddComponent(index, component)
end

function Entity:ReplaceGhost(ownerID)
  local index = self.WEComponentsEnum.Ghost
  local component = GhostComponent:New(ownerID)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveGhost()
  if self:HasGhost() then
    self:RemoveComponent(self.WEComponentsEnum.Ghost)
  end
end
