_class("DimensionFlagComponent", Object)
DimensionFlagComponent = DimensionFlagComponent

function DimensionFlagComponent:Constructor()
end

function Entity:DimensionFlag()
  return self:GetComponent(self.WEComponentsEnum.DimensionFlag)
end

function Entity:HasDimensionFlag()
  return self:HasComponent(self.WEComponentsEnum.DimensionFlag)
end

function Entity:AddDimensionFlag()
  local index = self.WEComponentsEnum.DimensionFlag
  local component = DimensionFlagComponent:New()
  self:AddComponent(index, component)
end

function Entity:RemoveDimensionFlag()
  if self:HasDimensionFlag() then
    self:RemoveComponent(self.WEComponentsEnum.DimensionFlag)
  end
end
