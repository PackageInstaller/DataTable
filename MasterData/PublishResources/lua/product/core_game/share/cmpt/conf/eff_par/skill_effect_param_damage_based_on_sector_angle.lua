require("skill_effect_param_base")
_class("SkillEffectParam_DamageBasedOnSectorAngle", SkillEffectParamBase)
SkillEffectParam_DamageBasedOnSectorAngle = SkillEffectParam_DamageBasedOnSectorAngle

function SkillEffectParam_DamageBasedOnSectorAngle:Constructor(t)
  self._percent = t.percent
  self._formulaID = t.formulaID
  self._maxAngle = t.maxAngle
  self._minDamageRate = t.minDamageRate
  self._skillIncreaseType = t.skillIncreaseType or ModifySkillIncreaseParamType.ActiveSkill
  self._angleDamageRate = 1
end

function SkillEffectParam_DamageBasedOnSectorAngle:GetEffectType()
  return SkillEffectType.DamageBasedOnSectorAngle
end

function SkillEffectParam_DamageBasedOnSectorAngle:GetMaxAngle()
  return self._maxAngle
end

function SkillEffectParam_DamageBasedOnSectorAngle:GetMinDamageRate()
  return self._minDamageRate
end

function SkillEffectParam_DamageBasedOnSectorAngle:GetDamagePercent()
  return self._percent
end

function SkillEffectParam_DamageBasedOnSectorAngle:GetDamageFormulaID()
  return self._formulaID
end

function SkillEffectParam_DamageBasedOnSectorAngle:GetSkillIncreaseType()
  return self._skillIncreaseType
end

function SkillEffectParam_DamageBasedOnSectorAngle:SetAngleDamageRate(rate)
  self._angleDamageRate = rate
end

function SkillEffectParam_DamageBasedOnSectorAngle:GetAngleDamageRate()
  return self._angleDamageRate
end
