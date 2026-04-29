_class("BuffViewAddHPBySanChange", BuffViewBase)
BuffViewAddHPBySanChange = BuffViewAddHPBySanChange

function BuffViewAddHPBySanChange:IsNotifyMatch(notify)
  local nt = self._buffResult:GetLogicNotify()
  if nt and notify and nt:GetNotifyType() == NotifyType.SanValueChange and notify:GetNotifyType() == NotifyType.SanValueChange then
    return nt:GetCurValue() == notify:GetCurValue() and nt:GetOldValue() == notify:GetOldValue()
  end
end

function BuffViewAddHPBySanChange:PlayView(TT)
  local entity = self._entity
  local damageInfo = self._buffResult:GetDamageInfo()
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
end
