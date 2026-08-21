require("base_ins_r")
_class("DataSelectLastDamageInstruction", BaseInstruction)
DataSelectLastDamageInstruction = DataSelectLastDamageInstruction

function DataSelectLastDamageInstruction:Constructor(paramList)
end

function DataSelectLastDamageInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray == nil then
    Log.fatal("[ins] caster has no damage")
    return InstructionConst.PhaseEnd
  end
  local damageIndex = #damageResultArray
  local damageResult = damageResultArray[damageIndex]
  if damageResult == nil then
    phaseContext:SetCurDamageResultIndex(-1)
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local targetEntityID = damageResult:GetTargetID()
  phaseContext:SetCurDamageResultIndex(damageIndex)
  phaseContext:SetCurTargetEntityID(targetEntityID)
end
