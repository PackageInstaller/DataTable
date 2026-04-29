require("calc_base")
_class("SkillEffectCalc_SkillCostFeatureStepPoint", SkillEffectCalc_Base)
SkillEffectCalc_SkillCostFeatureStepPoint = SkillEffectCalc_SkillCostFeatureStepPoint

function SkillEffectCalc_SkillCostFeatureStepPoint:CalculateOnSingleTarget(calcParam, targetEntityID)
  if targetEntityID <= 0 then
    return
  end
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if not lsvcFeature:HasFeatureType(FeatureType.StepPoint) then
    return
  end
  local param = calcParam:GetSkillEffectParam()
  local val = param:GetCostStepPointValue()
  local oldVal = lsvcFeature:GetCurStepPoint()
  local maxVal = lsvcFeature:GetMaxStepPoint()
  local curVal = oldVal - val
  if curVal < 0 then
    curVal = 0
  end
  if maxVal < curVal then
    curVal = maxVal
  end
  local costVal = oldVal - curVal
  return SkillEffectResult_SkillCostFeatureStepPoint:New(curVal, oldVal, costVal)
end
