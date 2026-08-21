_class("GridEffectComponent", Object)
GridEffectComponent = GridEffectComponent

function GridEffectComponent:Constructor(gridEffectType)
  self._gridEffectType = gridEffectType
  self._pieceType = nil
  self._pathIndex = 0
end

function GridEffectComponent:GetGridEffectType()
  return self._gridEffectType
end

function GridEffectComponent:SetPieceType(pieceType)
  self._pieceType = pieceType
end

function GridEffectComponent:GetPieceType()
  return self._pieceType
end

function GridEffectComponent:SetPathIndex(pathIndex)
  self._pathIndex = pathIndex
end

function GridEffectComponent:GetPathIndex()
  return self._pathIndex
end

function Entity:GridEffect()
  return self:GetComponent(self.WEComponentsEnum.GridEffect)
end

function Entity:HasGridEffect()
  return self:HasComponent(self.WEComponentsEnum.GridEffect)
end

function Entity:AddGridEffect(gridEffectType)
  local index = self.WEComponentsEnum.GridEffect
  local component = GridEffectComponent:New(gridEffectType)
  self:AddComponent(index, component)
end

function Entity:ReplaceGridEffect(gridEffectType)
  local index = self.WEComponentsEnum.GridEffect
  local component = GridEffectComponent:New(gridEffectType)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveGridEffect()
  if self:HasGridEffect() then
    self:RemoveComponent(self.WEComponentsEnum.GridEffect)
  end
end
