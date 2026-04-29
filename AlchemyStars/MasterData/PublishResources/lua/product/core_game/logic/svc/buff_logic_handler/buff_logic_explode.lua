_class("BuffLogicAddExplode", BuffLogicBase)
BuffLogicAddExplode = BuffLogicAddExplode

function BuffLogicAddExplode:Constructor(buffInstance, logicParam)
  self._damagePercent = logicParam.damagePercent
end

function BuffLogicAddExplode:DoLogic(notify)
  local caster = notify:GetAttackerEntity()
  local defender = notify:GetDefenderEntity()
  local blsvc = self._world:GetService("BuffLogic")
  local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), caster, defender, {
    percent = self._damagePercent,
    baseDamage = notify:GetDamageValue(),
    formulaID = 16
  })
  if damageInfo:GetDamageType() == DamageType.Real then
    damageInfo:SetDamageType(DamageType.Explode)
  end
  local combo = self._world:GetService("Battle"):GetLogicComboNum()
  local buffResult = BuffResultExplode:New(combo, damageInfo)
  return buffResult
end
