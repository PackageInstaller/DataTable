_class("EntityTypeComponent", Object)
EntityTypeComponent = EntityTypeComponent

function EntityTypeComponent:Constructor(value)
  self.Value = value
end

function EntityTypeComponent:IsSkillHolder()
  return self.Value == EntityType.SkillHolder
end

function EntityTypeComponent:IsPetShadow()
  return self.Value == EntityType.PetShadow
end

function EntityTypeComponent:IsPersonaSkillHolder()
  return self.Value == EntityType.PersonaSkillHolder
end

function EntityTypeComponent:IsAutoBeadSkillHolder()
  return self.Value == EntityType.AutoBeadSkillHolder
end

function Entity:EntityType()
  return self:GetComponent(self.WEComponentsEnum.EntityType)
end

function Entity:HasEntityType()
  return self:HasComponent(self.WEComponentsEnum.EntityType)
end

function Entity:AddEntityType(value)
  local index = self.WEComponentsEnum.EntityType
  local component = EntityTypeComponent:New(value)
  self:AddComponent(index, component)
end

function Entity:RemoveEntityType()
  if self:HasEntityType() then
    self:RemoveComponent(self.WEComponentsEnum.EntityType)
  end
end
