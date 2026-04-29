_class("SkillRangeOutlineComponent", Object)
SkillRangeOutlineComponent = SkillRangeOutlineComponent

function SkillRangeOutlineComponent:Constructor(pieceType, isPreview)
  self._pieceType = pieceType
  self._isPreview = isPreview
  self._isDestroy = false
end

function SkillRangeOutlineComponent:SetPieceType(pieceType)
  self._pieceType = pieceType
end

function SkillRangeOutlineComponent:SetIsPreview(isPreview)
  self._isPreview = isPreview
end

function SkillRangeOutlineComponent:GetPieceType()
  return self._pieceType
end

function SkillRangeOutlineComponent:IsPreview()
  return self._isPreview
end

function SkillRangeOutlineComponent:SetIsDestroy(isDestroy)
  self._isDestroy = isDestroy
end

function SkillRangeOutlineComponent:IsDestroy()
  return self._isDestroy
end

function Entity:SkillRangeOutline()
  return self:GetComponent(self.WEComponentsEnum.SkillRangeOutline)
end

function Entity:HasSkillRangeOutline()
  return self:HasComponent(self.WEComponentsEnum.SkillRangeOutline)
end

function Entity:AddSkillRangeOutline(pieceType)
  local index = self.WEComponentsEnum.SkillRangeOutline
  local component = SkillRangeOutlineComponent:New(pieceType)
  self:AddComponent(index, component)
end

function Entity:ReplaceSkillRangeOutline(pieceType, isPreview)
  local index = self.WEComponentsEnum.SkillRangeOutline
  local component = SkillRangeOutlineComponent:New(pieceType, isPreview)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveSkillRangeOutline()
  if self:HasSkillRangeOutline() then
    self:RemoveComponent(self.WEComponentsEnum.SkillRangeOutline)
  end
end
