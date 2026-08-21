require("base_ins_r")
_class("DataSelectNextDamageInstruction", BaseInstruction)
DataSelectNextDamageInstruction = DataSelectNextDamageInstruction

function DataSelectNextDamageInstruction:Constructor(paramList)
end

function DataSelectNextDamageInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, damageStageIndex)
  local damageIndex = phaseContext:GetCurDamageResultIndex()
  damageIndex = damageIndex + 1
  phaseContext:SetCurDamageResultIndex(damageIndex)
  if damageIndex > #damageResultArray or #damageResultArray == 0 then
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local damageResult = damageResultArray[damageIndex]
  local targetEntityID = damageResult:GetTargetID()
  phaseContext:SetCurTargetEntityID(targetEntityID)
end
