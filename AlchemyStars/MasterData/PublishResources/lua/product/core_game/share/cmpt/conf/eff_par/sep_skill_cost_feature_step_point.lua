require("skill_damage_effect_param")
_class("SkillEffectParam_SkillCostFeatureStepPoint", SkillEffectParamBase)
SkillEffectParam_SkillCostFeatureStepPoint = SkillEffectParam_SkillCostFeatureStepPoint

function SkillEffectParam_SkillCostFeatureStepPoint:Constructor(t)
  self._val = t.val
end

function SkillEffectParam_SkillCostFeatureStepPoint:GetEffectType()
  return SkillEffectType.SkillCostFeatureStepPoint
end

function SkillEffectParam_SkillCostFeatureStepPoint:GetCostStepPointValue()
  return self._val
end
