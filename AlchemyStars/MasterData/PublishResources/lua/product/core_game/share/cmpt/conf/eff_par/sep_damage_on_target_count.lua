require("skill_effect_param_base")
require("skill_damage_effect_param")
_class("SkillEffectDamageOnTargetCountParam", SkillEffectParamBase)
SkillEffectDamageOnTargetCountParam = SkillEffectDamageOnTargetCountParam

function SkillEffectDamageOnTargetCountParam:Constructor(t)
  assert(type(t.damageOnCount) == "table", "DamageOnTargetCount需要table参数damageOnCount")
  assert(type(t.defaultDamageParam) == "table", "DamageOnTargetCount需要table参数defaultDamageParam")
  self._damageParamsByCount = {}
  for count, damageParam in pairs(t.damageOnCount) do
    self._damageParamsByCount[count] = SkillDamageEffectParam:New(damageParam)
  end
  self._defaultDamageParam = SkillDamageEffectParam:New(t.defaultDamageParam)
  self._noRepeat = t.countNoRepeat or false
end

function SkillEffectDamageOnTargetCountParam:GetEffectType()
  return SkillEffectType.DamageOnTargetCount
end

function SkillEffectDamageOnTargetCountParam:GetDamageParamByCount(count)
  local damageParam = self._damageParamsByCount[count]
  Log.notice("SkillEffectType.DamageOnTargetCount", "count = ", count, " damageParamByCount = ", damageParam ~= nil)
  return damageParam or self._defaultDamageParam
end

function SkillEffectDamageOnTargetCountParam:IsCountNoRepeat()
  return self._noRepeat
end
