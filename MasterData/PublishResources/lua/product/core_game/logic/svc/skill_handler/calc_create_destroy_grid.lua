require("calc_base")
_class("SkillEffectCalc_CreateDestroyGrid", SkillEffectCalc_Base)
SkillEffectCalc_CreateDestroyGrid = SkillEffectCalc_CreateDestroyGrid

function SkillEffectCalc_CreateDestroyGrid:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local isCreate = skillEffectParam:GetIsCreate()
  local range = skillEffectCalcParam:GetSkillRange()
  local result = SkillEffectResult_CreateDestroyGrid:New(isCreate, range)
  return result
end
