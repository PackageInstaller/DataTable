_class("PreviewChessPetComponent", Object)
PreviewChessPetComponent = PreviewChessPetComponent

function PreviewChessPetComponent:Constructor()
  self._moveRangeEffectEntityIDList = {}
  self._attackTargetEffectEntityIDList = {}
  self._attackRangeEffectEntityIDList = {}
end

function PreviewChessPetComponent:AddMoveRangeEffectEntityID(entityID)
  self._moveRangeEffectEntityIDList[#self._moveRangeEffectEntityIDList + 1] = entityID
end

function PreviewChessPetComponent:AddAttackRangeEffectEntityID(entityID)
  self._attackRangeEffectEntityIDList[#self._attackRangeEffectEntityIDList + 1] = entityID
end

function PreviewChessPetComponent:AddAttackTargetEffectEntityID(entityID)
  self._attackTargetEffectEntityIDList[#self._attackTargetEffectEntityIDList + 1] = entityID
end

function PreviewChessPetComponent:GetMoveRangeEffectEntityIDList()
  return self._moveRangeEffectEntityIDList
end

function PreviewChessPetComponent:GetAttackRangeEffectEntityIDList()
  return self._attackRangeEffectEntityIDList
end

function PreviewChessPetComponent:GetAttackTargetEffectEntityIDList()
  return self._attackTargetEffectEntityIDList
end

function PreviewChessPetComponent:ClearChessPetPreviewList()
  self._moveRangeEffectEntityIDList = {}
  self._attackTargetEffectEntityIDList = {}
  self._attackRangeEffectEntityIDList = {}
end

function Entity:PreviewChessPet()
  return self:GetComponent(self.WEComponentsEnum.PreviewChessPet)
end

function Entity:HasPreviewChessPet()
  return self:HasComponent(self.WEComponentsEnum.PreviewChessPet)
end

function Entity:AddPreviewChessPet()
  local index = self.WEComponentsEnum.PreviewChessPet
  local component = PreviewChessPetComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePreviewChessPet()
  local index = self.WEComponentsEnum.PreviewChessPet
  local component = PreviewChessPetComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemovePreviewChessPet()
  if self:HasPreviewChessPet() then
    self:RemoveComponent(self.WEComponentsEnum.PreviewChessPet)
  end
end
