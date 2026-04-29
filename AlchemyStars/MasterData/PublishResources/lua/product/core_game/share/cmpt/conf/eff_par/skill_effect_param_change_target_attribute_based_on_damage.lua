require("skill_effect_param_base")
_class("SkillEffectParamChangeTargetAttributeBasedOnDamage", SkillEffectParamBase)
SkillEffectParamChangeTargetAttributeBasedOnDamage = SkillEffectParamChangeTargetAttributeBasedOnDamage

function SkillEffectParamChangeTargetAttributeBasedOnDamage:Constructor(t)
  self._checkDamageEffectResultWithStageIndex = t.checkDamageEffectResultWithStageIndex or 1
  self._mulValue = t.mulValue or 0
  self._addValue = t.addValue or 0
  self._attributeType = t.attributeType or CalcChangeTargetAttributeType.MaxHP
end

function SkillEffectParamChangeTargetAttributeBasedOnDamage:GetCheckDamageEffectResultWithStageIndex()
  return self._checkDamageEffectResultWithStageIndex
end

function SkillEffectParamChangeTargetAttributeBasedOnDamage:GetMulValue()
  return self._mulValue
end

function SkillEffectParamChangeTargetAttributeBasedOnDamage:GetAddValue()
  return self._addValue
end

function SkillEffectParamChangeTargetAttributeBasedOnDamage:GetAttributeType()
  return self._attributeType
end
