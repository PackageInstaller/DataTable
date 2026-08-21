_class("SkillEffectCalc_AddRoundCount", Object)
SkillEffectCalc_AddRoundCount = SkillEffectCalc_AddRoundCount

function SkillEffectCalc_AddRoundCount:Constructor(world)
  self._world = world
end

function SkillEffectCalc_AddRoundCount:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillAddRoundParam = skillEffectCalcParam.skillEffectParam
  local addRoundCount = skillAddRoundParam:GetAddRoundCount()
  local mazeService = self._world:GetService("Maze")
  mazeService:AddLight(addRoundCount)
end
