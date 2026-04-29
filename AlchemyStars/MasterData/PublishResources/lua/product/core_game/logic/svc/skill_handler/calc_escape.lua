_class("SkillEffectCalc_Escape", SkillEffectCalc_Base)
SkillEffectCalc_Escape = SkillEffectCalc_Escape

function SkillEffectCalc_Escape:DoSkillEffectCalculator(skillEffectCalcParam)
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

function SkillEffectCalc_Escape:_CalculateSingleTarget(skillEffectCalcParam, targetID)
  local targetEntity = self._world:GetEntityByID(targetID)
  if not targetEntity then
    return
  end
  if targetEntity:HasDeadMark() then
    return
  end
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local escapeType = param:GetEscapeType()
  local escapeParam = param:GetEscapeParam()
  local disappear = false
  local addNum = true
  if escapeType == EscapeType.Chess then
    disappear = true
    if escapeParam then
      local chessPetCmpt = targetEntity:ChessPet()
      local chessPetClassID = chessPetCmpt:GetChessPetClassID()
      if table.intable(escapeParam, chessPetClassID) then
      else
        addNum = false
      end
    end
  end
  return SkillEffectResult_Escape:New(targetID, skillEffectCalcParam.gridPos, disappear, addNum)
end
