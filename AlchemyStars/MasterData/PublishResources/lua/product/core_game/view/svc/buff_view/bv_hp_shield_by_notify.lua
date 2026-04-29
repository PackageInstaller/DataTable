_class("BuffViewAddHPShieldByNotify", BuffViewBase)
BuffViewAddHPShieldByNotify = BuffViewAddHPShieldByNotify

function BuffViewAddHPShieldByNotify:PlayView(TT)
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
