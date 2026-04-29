_class("BuffViewAddHPByMonsterAttackDamage", BuffViewBase)
BuffViewAddHPByMonsterAttackDamage = BuffViewAddHPByMonsterAttackDamage

function BuffViewAddHPByMonsterAttackDamage:Constructor()
end

function BuffViewAddHPByMonsterAttackDamage:IsNotifyMatch(notify)
  if notify and notify:GetNotifyType() == NotifyType.MonsterAttackOrSkillDamageEnd then
    local n = notify
    local notifyEntity = n:GetNotifyEntity()
    if notifyEntity then
      local notifyEntityID = notifyEntity:GetID()
      local sourceEntityID = self._buffResult:GetSourceEntityID()
      if notifyEntityID and sourceEntityID and notifyEntityID == sourceEntityID then
        return true
      end
    end
    return false
  end
  return true
end

function BuffViewAddHPByMonsterAttackDamage:PlayView(TT)
  local res = self._buffResult
  local damageInfo = res:GetDamageInfo()
  local entity = self._world:GetEntityByID(res:GetEntityID())
  YIELD(TT)
  local materialAnimationComponent = entity:MaterialAnimationComponent()
  if materialAnimationComponent then
    materialAnimationComponent:PlayCure()
  end
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:AsyncUpdateHPAndDisplayDamage(entity, damageInfo)
end
