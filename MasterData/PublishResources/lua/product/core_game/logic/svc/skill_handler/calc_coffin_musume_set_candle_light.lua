require("calc_base")
_class("SkillEffectCalc_CoffinMusumeSetCandleLight", SkillEffectCalc_Base)
SkillEffectCalc_CoffinMusumeSetCandleLight = SkillEffectCalc_CoffinMusumeSetCandleLight

function SkillEffectCalc_CoffinMusumeSetCandleLight:DoSkillEffectCalculator(skillEffectCalcParam)
  local param = skillEffectCalcParam.skillEffectParam
  return {
    SkillEffectResult_CoffinMusumeSetCandleLight:New(skillEffectCalcParam.casterEntityID, param:IsLight())
  }
end
