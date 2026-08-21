_class("SkillEffectCalc_DimensionTransport", SkillEffectCalc_Base)
SkillEffectCalc_DimensionTransport = SkillEffectCalc_DimensionTransport

function SkillEffectCalc_DimensionTransport:DoSkillEffectCalculator(skillEffectCalcParam)
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

function SkillEffectCalc_DimensionTransport:_CalculateSingleTarget(skillEffectCalcParam, nTargetID)
  local teamEntity = self._world:GetEntityByID(nTargetID)
  if not teamEntity then
    return
  end
  if not teamEntity:HasTeam() then
    return
  end
  local logicPickUpCmpt = teamEntity:LogicPickUp()
  local posNew = logicPickUpCmpt:GetLogicCurPickUpGridSafePos()
  if not posNew then
    return
  end
  return SkillEffectResult_DimensionTransport:New(nTargetID, skillEffectCalcParam.gridPos, PieceType.Any, posNew, nil, nil)
end
