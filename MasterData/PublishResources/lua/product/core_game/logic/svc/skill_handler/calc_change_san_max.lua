require("calc_base")
_class("SkillEffectCalc_ChangeSanMax", SkillEffectCalc_Base)
SkillEffectCalc_ChangeSanMax = SkillEffectCalc_ChangeSanMax

function SkillEffectCalc_ChangeSanMax:CalculateOnSingleTarget(calcParam, targetEntityID)
  if targetEntityID <= 0 then
    return
  end
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if not lsvcFeature:HasFeatureType(FeatureType.Sanity) then
    return
  end
  local param = calcParam:GetSkillEffectParam()
  local val = param:GetChangeValue()
  local currentMaxVal = lsvcFeature:GetSanMaxValue()
  local finalMaxVal = currentMaxVal + val
  if finalMaxVal < 0 then
    finalMaxVal = 0
  end
  local deltaMax = finalMaxVal - currentMaxVal
  local minVal = lsvcFeature:GetSanMinValue()
  local maxVal = finalMaxVal
  local currentVal = lsvcFeature:GetSanValue()
  local finalVal = currentVal
  if minVal > finalVal then
    finalVal = minVal
  end
  if maxVal < finalVal then
    finalVal = maxVal
  end
  local delta = finalVal - currentVal
  return SkillEffectResultChangeSanMax:New(deltaMax, delta)
end
