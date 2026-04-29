_class("SkillEffectCalc_AddCollectDropNum", Object)
SkillEffectCalc_AddCollectDropNum = SkillEffectCalc_AddCollectDropNum

function SkillEffectCalc_AddCollectDropNum:Constructor(world)
  self._world = world
end

function SkillEffectCalc_AddCollectDropNum:DoSkillEffectCalculator(skillEffectCalcParam)
  local result = SkillAddCollectDropNumResult:New(1)
  return result
end
