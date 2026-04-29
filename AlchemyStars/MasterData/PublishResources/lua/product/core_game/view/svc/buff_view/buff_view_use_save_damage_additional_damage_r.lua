_class("BuffViewUseSaveDamageAdditionalDamage", BuffViewBase)
BuffViewUseSaveDamageAdditionalDamage = BuffViewUseSaveDamageAdditionalDamage

function BuffViewUseSaveDamageAdditionalDamage:Constructor()
end

function BuffViewUseSaveDamageAdditionalDamage:IsNotifyMatch(notify)
  return true
end

function BuffViewUseSaveDamageAdditionalDamage:PlayView(TT)
  local entity = self._entity
  local damageInfo = self._buffResult:GetDamageInfo()
  local effectID = self._buffResult:GetEffectID()
  YIELD(TT)
  local materialEntity = entity
  if entity:HasSuperEntity() and entity:EntityType():IsSkillHolder() then
    materialEntity = entity:GetSuperEntity()
  end
  if entity:HasTeam() then
    materialEntity = entity:GetTeamLeaderPetEntity()
  end
  if materialEntity:MaterialAnimationComponent() and damageInfo:GetDamageType() == DamageType.Recover then
    materialEntity:MaterialAnimationComponent():PlayCure()
  end
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:AsyncUpdateHPAndDisplayDamage(materialEntity, damageInfo)
  if effectID then
    if entity:HasPet() then
      entity = entity:Pet():GetOwnerTeamEntity()
    end
    local effectService = self._world:GetService("Effect")
    local effectEntity = effectService:CreateEffect(effectID, entity)
  end
end
