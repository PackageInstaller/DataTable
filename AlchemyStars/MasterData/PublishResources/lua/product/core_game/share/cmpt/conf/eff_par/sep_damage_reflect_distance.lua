_class("SkillEffectParam_DamageReflectDistance", SkillDamageEffectParam)
SkillEffectParam_DamageReflectDistance = SkillEffectParam_DamageReflectDistance

function SkillEffectParam_DamageReflectDistance:Constructor(t)
  self._formulaID = t.formulaID
  self._percent = t.percent
  self._distanceDamageParam = t.distanceDamageParam
  self._skillIncreaseType = t.skillIncreaseType
end

function SkillEffectParam_DamageReflectDistance:GetEffectType()
  return SkillEffectType.DamageReflectDistance
end

function SkillEffectParam_DamageReflectDistance:GetDamagePercent()
  return self._percent
end

function SkillEffectParam_DamageReflectDistance:GetDamageFormulaID()
  return self._formulaID
end

function SkillEffectParam_DamageReflectDistance:GetDistanceDamageParam()
  return self._distanceDamageParam
end

function SkillEffectParam_DamageReflectDistance:GetSkillIncreaseType()
  return self._skillIncreaseType
end
