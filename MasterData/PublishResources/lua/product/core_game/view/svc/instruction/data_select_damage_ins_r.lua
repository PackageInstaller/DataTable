require("base_ins_r")
_class("DataSelectDamageInstruction", BaseInstruction)
DataSelectDamageInstruction = DataSelectDamageInstruction

function DataSelectDamageInstruction:Constructor(paramList)
  self._damageIndex = tonumber(paramList.damageIndex)
  self._damageStageIndex = tonumber(paramList.damageStageIndex) or 1
end

function DataSelectDamageInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if skillEffectResultContainer == nil then
    return InstructionConst.PhaseEnd
  end
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, self._damageStageIndex)
  if damageResultArray == nil then
    Log.fatal("[ins] caster has no damage:", tostring(casterEntity:GridLocation().Position))
    return InstructionConst.PhaseEnd
  end
  local damageResult = damageResultArray[self._damageIndex]
  if damageResult == nil then
    phaseContext:SetCurDamageResultIndex(-1)
    phaseContext:SetCurDamageResultStageIndex(-1)
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local targetEntityID = damageResult:GetTargetID()
  phaseContext:SetCurDamageResultIndex(self._damageIndex)
  phaseContext:SetCurDamageResultStageIndex(self._damageStageIndex)
  phaseContext:SetCurTargetEntityID(targetEntityID)
end
