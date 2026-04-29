require("skill_damage_effect_param")
_class("SkillEffectParamRandomCountDamageSameHalf", SkillDamageEffectParam)
SkillEffectParamRandomCountDamageSameHalf = SkillEffectParamRandomCountDamageSameHalf

function SkillEffectParamRandomCountDamageSameHalf:Constructor(t)
  self._dampPer = t.dampPer
  self._percentAdd = t.percentAdd or 0
  self._selTargetLoop = t.selTargetLoop or false
  self._damageRandomCount = t.damageRandomCount
end

function SkillEffectParamRandomCountDamageSameHalf:GetEffectType()
  return SkillEffectType.RandomCountDamageSameHalf
end

function SkillEffectParamRandomCountDamageSameHalf:GetPercentAdd()
  return self._percentAdd
end

function SkillEffectParamRandomCountDamageSameHalf:GetDampPercent()
  return self._dampPer
end

function SkillEffectParamRandomCountDamageSameHalf:GetIsSelTargetLoop()
  return self._selTargetLoop
end

function SkillEffectParamRandomCountDamageSameHalf:GetDamageRandomCount()
  return self._damageRandomCount
end
