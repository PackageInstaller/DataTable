_class("PickUpTargetComponent", Object)
PickUpTargetComponent = PickUpTargetComponent

function PickUpTargetComponent:Constructor()
  self._pickUpTargetType = SkillPickUpType.None
  self._activeSkillID = -1
  self._petPstID = -1
  self._lastPickUpGridPos = Vector2(0, 0)
  self._curPickUpGridPos = Vector2(0, 0)
  self._curPickUpGridPosSafe = nil
  self._entityID = -1
  self._linkLineType = nil
end

function PickUpTargetComponent:SetLinkLineType(typ)
  self._linkLineType = typ
end

function PickUpTargetComponent:SetPickUpTargetType(type)
  self._pickUpTargetType = type
end

function PickUpTargetComponent:GetPickUpTargetType()
  return self._pickUpTargetType
end

function PickUpTargetComponent:GetCurPickUpGridPos()
  return self._curPickUpGridPos
end

function PickUpTargetComponent:GetCurPickUpGridSafePos()
  return self._curPickUpGridPosSafe
end

function PickUpTargetComponent:GetPetPstid()
  return self._petPstID
end

function PickUpTargetComponent:GetEntityID()
  return self._entityID
end

function PickUpTargetComponent:SetEntityID(entityID)
  self._entityID = entityID
end

function PickUpTargetComponent:SetPickUpGridPos(pickUpGridPos)
  self._lastPickUpGridPos = self._curPickUpGridPos
  self._curPickUpGridPos = pickUpGridPos
end

function PickUpTargetComponent:SetPickUpGridSafePos(pickUpGridPos)
  self._curPickUpGridPosSafe = pickUpGridPos
end

function PickUpTargetComponent:GetCurActiveSkillID()
  return self._activeSkillID
end

function PickUpTargetComponent:SetCurActiveSkillInfo(activeSkillID, petPstID)
  self._activeSkillID = activeSkillID
  self._petPstID = petPstID
end

function PickUpTargetComponent:Reset()
  self._pickUpTargetType = SkillPickUpType.None
  self._activeSkillID = -1
  self._petPstID = -1
  self._lastPickUpGridPos = Vector2(0, 0)
  self._curPickUpGridPos = Vector2(0, 0)
  self._curPickUpGridPosSafe = nil
  self._entityID = -1
end

function Entity:PickUpTarget()
  return self:GetComponent(self.WEComponentsEnum.PickUpTarget)
end

function Entity:HasPickUpTarget()
  return self:HasComponent(self.WEComponentsEnum.PickUpTarget)
end

function Entity:AddPickUpTarget()
  local index = self.WEComponentsEnum.PickUpTarget
  local component = PickUpTargetComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePickUpTarget()
  local component = self:GetComponent(self.WEComponentsEnum.PickUpTarget)
  local index = self.WEComponentsEnum.PickUpTarget
  self:ReplaceComponent(index, component)
end

function Entity:RemovePickUpTarget()
  if self:HasPickUpTarget() then
    self:RemoveComponent(self.WEComponentsEnum.PickUpTarget)
  end
end
