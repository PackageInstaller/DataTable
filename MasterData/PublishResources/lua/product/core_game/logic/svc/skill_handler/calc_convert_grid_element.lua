_class("SkillEffectCalc_ConvertGridElement", Object)
SkillEffectCalc_ConvertGridElement = SkillEffectCalc_ConvertGridElement

function SkillEffectCalc_ConvertGridElement:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_ConvertGridElement:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  return self._skillEffectService:_DoCalcSkillConvertGridElementEffect(skillEffectCalcParam.skillEffectParam, skillEffectCalcParam.skillRange, casterEntity)
end
