_class("BuffViewAddHPShield", BuffViewBase)
BuffViewAddHPShield = BuffViewAddHPShield

function BuffViewAddHPShield:IsNotifyMatch(notify)
  local buffResult = self._buffResult
  if notify:GetNotifyType() == NotifyType.SingleChainSkillAttackBegin or notify:GetNotifyType() == NotifyType.SinglePetChainSkillAttackBegin then
    return buffResult:GetChainPetEntityID() == notify:GetNotifyEntity():GetID() and buffResult:GetNotifyChainSkillTimeIndex() == notify:GetChainSkillTimeIndex()
  end
  return true
end

function BuffViewAddHPShield:PlayView(TT)
  local eid = self._buffResult:GetEntityID()
  local entity = self._world:GetEntityByID(eid)
  local damageInfo = self._buffResult:GetDamageInfo()
  if entity:HasPet() then
    entity = entity:Pet():GetOwnerTeamEntity()
  end
  local hpCmpt = entity:HP()
  local curShield = damageInfo:GetHPShield() or 0
  hpCmpt:SetShieldValue(curShield)
  local playDamageSvc = self._world:GetService("PlayDamage")
  playDamageSvc:UpdateTargetHPBar(TT, entity, damageInfo)
end

_class("BuffViewRemoveHPShield", BuffViewBase)
BuffViewRemoveHPShield = BuffViewRemoveHPShield

function BuffViewRemoveHPShield:IsNotifyMatch(notify)
  local buffResult = self._buffResult
  if notify:GetNotifyType() == NotifyType.SingleChainSkillAttackBegin or notify:GetNotifyType() == NotifyType.SingleChainSkillAttackFinish then
    return buffResult:GetChainPetEntityID() == notify:GetNotifyEntity():GetID() and buffResult:GetNotifyChainSkillTimeIndex() == notify:GetChainSkillTimeIndex()
  end
  return true
end

function BuffViewRemoveHPShield:PlayView(TT)
  local eid = self._buffResult:GetEntityID()
  local entity = self._world:GetEntityByID(eid)
  local damageInfo = self._buffResult:GetDamageInfo()
  if entity:HasPet() then
    entity = entity:Pet():GetOwnerTeamEntity()
  end
  local hpCmpt = entity:HP()
  local curShield = damageInfo:GetHPShield() or 0
  hpCmpt:SetShieldValue(curShield)
  local playDamageSvc = self._world:GetService("PlayDamage")
  playDamageSvc:UpdateTargetHPBar(TT, entity, damageInfo)
end
