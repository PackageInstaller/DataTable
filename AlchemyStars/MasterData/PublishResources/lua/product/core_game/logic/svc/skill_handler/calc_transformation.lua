_class("SkillEffectCalc_Transformation", Object)
SkillEffectCalc_Transformation = SkillEffectCalc_Transformation

function SkillEffectCalc_Transformation:Constructor(world)
  self._world = world
end

function SkillEffectCalc_Transformation:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam.skillEffectParam
  return SkillTransformationEffectResult:New(skillEffectCalcParam.casterEntityID, skillParam:GetTargetMonsterID(), skillParam:GetUseHpPercent())
end
