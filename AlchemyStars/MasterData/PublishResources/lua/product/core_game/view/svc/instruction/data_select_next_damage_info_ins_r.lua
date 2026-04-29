require("base_ins_r")
_class("DataSelectNextDamageInfoInstruction", BaseInstruction)
DataSelectNextDamageInfoInstruction = DataSelectNextDamageInfoInstruction

function DataSelectNextDamageInfoInstruction:Constructor(paramList)
end

function DataSelectNextDamageInfoInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, damageStageIndex)
  local damageIndex = phaseContext:GetCurDamageResultIndex()
  if damageIndex > #damageResultArray or #damageResultArray == 0 then
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local damageResult = damageResultArray[damageIndex]
  local damageInfoArray = damageResult:GetDamageInfoArray()
  local damageInfoIndex = phaseContext:GetCurDamageInfoIndex()
  damageInfoIndex = damageInfoIndex + 1
  phaseContext:SetCurDamageInfoIndex(damageInfoIndex)
  if damageInfoIndex > #damageInfoArray or #damageInfoArray == 0 then
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local targetEntityID = damageResult:GetTargetID()
  phaseContext:SetCurTargetEntityID(targetEntityID)
end
