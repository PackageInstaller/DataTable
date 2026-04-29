_class("SkillEffectCalc_Base", Object)
SkillEffectCalc_Base = SkillEffectCalc_Base

function SkillEffectCalc_Base:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_Base:DoSkillEffectCalculator(skillEffectCalcParam)
  local tResultArray = {}
  local teidTarget = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(teidTarget) do
    local result = self:CalculateOnSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(tResultArray, result)
    end
  end
  return tResultArray
end

function SkillEffectCalc_Base:CalculateOnSingleTarget(skillEffectCalcParam, targetID)
  Log.exception("NotImplementedException: function is not implemented. ")
end
