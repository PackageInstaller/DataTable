require("abilities_component")
_enum("EntityAbilitysLookup", {Invalid = 0})
_class("EntityAbility", IEntityAbility)

function EntityAbility:Constructor()
  self.m_abilityType = EntityAbilitysLookup.Invalid
end

function EntityAbility:Initialize(owner)
  self.m_owner = owner
  self.m_is_enable = true
  self:OnEnable()
end

function EntityAbility:GetAbilityType()
  return self.m_abilityType
end

function EntityAbility:IsEnable()
  return self.m_is_enable
end

function EntityAbility:SetEnable()
  if self.m_is_enable == true then
    return
  end
  self.m_is_enable = true
  self:OnEnable()
end

function EntityAbility:SetDisable()
  if self.m_is_enable == false then
    return
  end
  self.m_is_enable = false
  self:OnDisable()
end

function EntityAbility:Reset()
  self.m_is_enable = true
end

function EntityAbility:OnEnable()
end

function EntityAbility:OnDisable()
end
