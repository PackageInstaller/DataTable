require("skill_effect_result_base")
_class("SkillEffectResult_SkillCostFeatureStepPoint", SkillEffectResultBase)
SkillEffectResult_SkillCostFeatureStepPoint = SkillEffectResult_SkillCostFeatureStepPoint

function SkillEffectResult_SkillCostFeatureStepPoint:Constructor(curVal, oldVal, costVal)
  self._curVal = curVal
  self._oldVal = oldVal
  self._costVal = costVal
end

function SkillEffectResult_SkillCostFeatureStepPoint:GetEffectType()
  return SkillEffectType.SkillCostFeatureStepPoint
end

function SkillEffectResult_SkillCostFeatureStepPoint:GetCurVal()
  return self._curVal
end

function SkillEffectResult_SkillCostFeatureStepPoint:GetOldVal()
  return self._oldVal
end

function SkillEffectResult_SkillCostFeatureStepPoint:GetCostVal()
  return self._costVal
end
