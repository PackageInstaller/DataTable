_class("SkillEffectCalc_SwitchBodyPart", Object)
SkillEffectCalc_SwitchBodyPart = SkillEffectCalc_SwitchBodyPart

function SkillEffectCalc_SwitchBodyPart:Constructor(world)
  self._world = world
end

function SkillEffectCalc_SwitchBodyPart:DoSkillEffectCalculator(skillEffectCalcParam)
  local effParam = skillEffectCalcParam.skillEffectParam
  local showID = effParam:GetShowID()
  local hideID = effParam:GetHideID()
  local result = SkillEffectResultSwitchBodyPart:New(showID, hideID)
  return result
end
