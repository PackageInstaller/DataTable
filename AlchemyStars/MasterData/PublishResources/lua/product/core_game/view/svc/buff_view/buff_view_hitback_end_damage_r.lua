_class("BuffViewHitBackEndDamage", BuffViewBase)
BuffViewHitBackEndDamage = BuffViewHitBackEndDamage

function BuffViewHitBackEndDamage:PlayView(TT)
  local targetId = self._buffResult:GetDefenderID()
  local damageInfo = self._buffResult:GetDamageInfo()
  if not damageInfo then
    return
  end
  local viewParams = self._viewInstance:BuffConfigData():GetViewParams()
  local targetEntity = self._world:GetEntityByID(targetId)
  local damageType = damageInfo:GetDamageType()
  local targetDamage = damageInfo:GetDamageValue()
  local shieldLayer = damageInfo:GetShieldLayer()
  local hitEffectID = viewParams.HitEffectId
  if damageType == DamageType.Guard then
  elseif damageType == DamageType.Normal then
    if 0 < hitEffectID then
      self._world:GetService("Effect"):CreateBeHitEffect(hitEffectID, targetEntity)
    end
    local hitAnim = "Hit"
    targetEntity:SetAnimatorControllerTriggers({hitAnim})
  end
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:AsyncUpdateHPAndDisplayDamage(targetEntity, damageInfo)
end

function BuffViewHitBackEndDamage:IsNotifyMatch(notify)
  local defenderId = notify:GetDefenderId()
  if self._buffResult:GetDefenderID() == defenderId then
    return true
  end
  return false
end
