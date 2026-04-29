_class("IEntityAbility", Object)
IEntityAbility = IEntityAbility

function IEntityAbility:Initialize(owner)
end

function IEntityAbility:GetAbilityType()
end

function IEntityAbility:IsEnable()
end

function IEntityAbility:SetEnable()
end

function IEntityAbility:SetDisable()
end

_class("AbilitiesComponent", Object)
AbilitiesComponent = AbilitiesComponent

function AbilitiesComponent:Constructor()
  self.abilities = SortedDictionary:New()
end

function AbilitiesComponent:WEC_PostInitialize(owner)
  self.WEC_OwnerEntity = owner
end

function AbilitiesComponent:WEC_PostRemoved()
  local abilities = self.abilities
  for i = 1, abilities:Size() do
    abilities:GetAt(i):OnDisable()
  end
  abilities:Clear()
  self.abilities = nil
  self.WEC_OwnerEntity = nil
end

function AbilitiesComponent:AddAbility(ability)
  ability:Initialize(self.WEC_OwnerEntity)
  local abilityType = ability:GetAbilityType()
  self.abilities:Insert(abilityType, ability)
end

function AbilitiesComponent:RemoveAbility(abilityType)
  self.abilities:Remove(abilityType)
end

function AbilitiesComponent:GetAbility(abilityType)
  return self.abilities:Find(abilityType)
end

function AbilitiesComponent:HandleCommand(cmd)
  local abilities = self.abilities
  for i = 1, abilities:Size() do
    local ability = abilities:GetAt(i)
    if ability:IsEnable() and ability.HandleCommand then
      ability:HandleCommand(cmd)
    end
  end
end

function Entity:Abilities()
  return self:GetComponent(self.WEComponentsEnum.Abilities)
end

function Entity:HasAbilities()
  return self:HasComponent(self.WEComponentsEnum.Abilities)
end

function Entity:AddAbility(ability)
  if not self:HasAbilities() then
    local index = self.WEComponentsEnum.Abilities
    local component = AbilitiesComponent:New()
    self:AddComponent(index, component)
  end
  self:Abilities():AddAbility(ability)
end

function Entity:RemoveAbility(abilityType)
  local abilities = self:Abilities()
  if abilities then
    abilities:RemoveAbility(abilityType)
  end
end

function Entity:GetAbility(abilityType)
  local abilities = self:Abilities()
  if abilities then
    return abilities:GetAbility(abilityType)
  end
end

function Entity:EnableAbility(abilityType)
  local ability = self:GetAbility(abilityType)
  if ability then
    return ability:SetEnable()
  end
end

function Entity:DisableAbility(abilityType)
  local ability = self:GetAbility(abilityType)
  if ability then
    return ability:SetDisable()
  end
end

function Entity:RemoveAbilities()
  if self:HasAbilities() then
    self:RemoveComponent(self.WEComponentsEnum.Abilities)
  end
end
