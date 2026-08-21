_class("BenumbEffectComponent", Object)
BenumbEffectComponent = BenumbEffectComponent

function BenumbEffectComponent:Constructor()
end

function Entity:BenumbEffect()
  return self:GetComponent(self.WEComponentsEnum.BenumbEffect)
end

function Entity:HasBenumbEffect()
  return self:HasComponent(self.WEComponentsEnum.BenumbEffect)
end

function Entity:AddBenumbEffect()
  local index = self.WEComponentsEnum.BenumbEffect
  local component = BenumbEffectComponent:New()
  self:AddComponent(index, component)
end

function Entity:RemoveBenumbEffect()
  if self:HasBenumbEffect() then
    self:RemoveComponent(self.WEComponentsEnum.BenumbEffect)
  end
end
