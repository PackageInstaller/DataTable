_class("ArchivedEffectComponent", Object)
ArchivedEffectComponent = ArchivedEffectComponent

function ArchivedEffectComponent:Constructor(effectIDs)
  self.EffectIDs = effectIDs
end

function Entity:ArchivedEffect()
  return self:GetComponent(self.WEComponentsEnum.ArchivedEffect)
end

function Entity:HasArchivedEffect()
  return self:HasComponent(self.WEComponentsEnum.ArchivedEffect)
end

function Entity:AddArchivedEffect(effectIDs)
  local index = self.WEComponentsEnum.ArchivedEffect
  local component = ArchivedEffectComponent:New(effectIDs)
  self:AddComponent(index, component)
end

function Entity:RemoveArchivedEffect()
  if self:HasArchivedEffect() then
    self:RemoveComponent(self.WEComponentsEnum.ArchivedEffect)
  end
end
