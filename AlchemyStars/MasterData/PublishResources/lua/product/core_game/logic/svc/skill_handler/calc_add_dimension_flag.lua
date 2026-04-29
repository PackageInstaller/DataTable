require("calc_base")
_class("SkillEffectCalc_AddDimensionFlag", SkillEffectCalc_Base)
SkillEffectCalc_AddDimensionFlag = SkillEffectCalc_AddDimensionFlag

function SkillEffectCalc_AddDimensionFlag:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_AddDimensionFlag:_CalculateSingleTarget(skillEffectCalcParam, nTargetID)
  local eTarget = self._world:GetEntityByID(nTargetID)
  if not eTarget then
    return
  end
  if not eTarget:HasTeam() then
    return
  end
  local result = SkillEffectResult_AddDimensionFlag:New(nTargetID)
  return result
end
