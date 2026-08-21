_class("PickUpChessResultComponent", Object)
PickUpChessResultComponent = PickUpChessResultComponent

function PickUpChessResultComponent:Constructor()
  self._targetType = ChessPickUpTargetType.None
  self._lastPickUpGridPos = Vector2(0, 0)
  self._curPickUpGridPos = Vector2(0, 0)
  self._monsterEntityID = nil
  self._chessPetEntityID = nil
  self._previewGhostEntityID = nil
  self._pickUpTargetChanged = false
  self._walkRangeList = {}
  self._attackRangeList = {}
  self._walkRangeRealList = {}
  self._isRecover = false
  self._movePath = {}
  self._monsterChessTargetEffectIDList = {}
end

function PickUpChessResultComponent:SetChessPickUpResultType(type)
  self._targetType = type
end

function PickUpChessResultComponent:GetChessPickUpResultType()
  return self._targetType
end

function PickUpChessResultComponent:GetCurChessPickUpPos()
  return self._curPickUpGridPos
end

function PickUpChessResultComponent:GetCurChessPickUpSafePos()
  return self._curPickUpGridPosSafe
end

function PickUpChessResultComponent:GetPickUpChessPetEntityID()
  return self._chessPetEntityID
end

function PickUpChessResultComponent:SetPickUpChessPetEntityID(entityID)
  self._chessPetEntityID = entityID
end

function PickUpChessResultComponent:GetPickUpPreviewGhostEntityID()
  return self._previewGhostEntityID
end

function PickUpChessResultComponent:SetPickUpPreviewGhostEntityID(entityID)
  self._previewGhostEntityID = entityID
end

function PickUpChessResultComponent:GetPickUpMonsterEntityID()
  return self._monsterEntityID
end

function PickUpChessResultComponent:SetPickUpMonsterEntityID(entityID)
  self._monsterEntityID = entityID
end

function PickUpChessResultComponent:SetChessPickUpPos(pickUpGridPos)
  self._curPickUpGridPos = pickUpGridPos
end

function PickUpChessResultComponent:SetChessPickUpTargetChanged(isChange)
  self._pickUpTargetChanged = isChange
end

function PickUpChessResultComponent:IsChessPickUpTargetChanged()
  return self._pickUpTargetChanged
end

function PickUpChessResultComponent:SetChessPetWalkRange(range)
  self._walkRangeList = range
end

function PickUpChessResultComponent:GetChessPetWalkRange()
  return self._walkRangeList
end

function PickUpChessResultComponent:SetChessPetWalkRangeReal(range)
  self._walkRangeRealList = range
end

function PickUpChessResultComponent:GetChessPetWalkRangeReal()
  return self._walkRangeRealList
end

function PickUpChessResultComponent:SetChessPetAttackRange(range)
  self._attackRangeList = range
end

function PickUpChessResultComponent:GetChessPetAttackRange()
  return self._attackRangeList
end

function PickUpChessResultComponent:SetSkillIsRecover(isRecover)
  self._isRecover = isRecover
end

function PickUpChessResultComponent:GetSkillIsRecover()
  return self._isRecover
end

function PickUpChessResultComponent:SetChessPetMovePath(movePath)
  self._movePath = movePath
end

function PickUpChessResultComponent:GetChessPetMovePath()
  return self._movePath
end

function PickUpChessResultComponent:AddMonsterChessTargetEffectEntity(entityID)
  table.insert(self._monsterChessTargetEffectIDList, entityID)
end

function PickUpChessResultComponent:GetMonsterChessTargetEffectEntityIDList()
  return self._monsterChessTargetEffectIDList
end

function PickUpChessResultComponent:ClearMonsterChessTargetEffectEntityIDList()
  self._monsterChessTargetEffectIDList = {}
end

function PickUpChessResultComponent:ResetChessPickUp()
  self._pickUpTargetType = SkillPickUpType.None
  self._lastPickUpGridPos = Vector2(0, 0)
  self._curPickUpGridPos = Vector2(0, 0)
  self._monsterEntityID = nil
  self._chessPetEntityID = nil
  self._walkRangeList = {}
  self._attackRangeList = {}
  self._movePath = {}
end

function Entity:PickUpChessResult()
  return self:GetComponent(self.WEComponentsEnum.PickUpChessResult)
end

function Entity:HasPickUpChessResult()
  return self:HasComponent(self.WEComponentsEnum.PickUpChessResult)
end

function Entity:AddPickUpChessResult()
  local index = self.WEComponentsEnum.PickUpChessResult
  local component = PickUpChessResultComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePickUpChessResult()
  local component = self:GetComponent(self.WEComponentsEnum.PickUpChessResult)
  local index = self.WEComponentsEnum.PickUpChessResult
  self:ReplaceComponent(index, component)
end

function Entity:RemovePickUpChessResult()
  if self:HasPickUpChessResult() then
    self:RemoveComponent(self.WEComponentsEnum.PickUpChessResult)
  end
end
