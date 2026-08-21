require("base_ins_r")
_class("DataSelectNextDamageIndexInstruction", BaseInstruction)
DataSelectNextDamageIndexInstruction = DataSelectNextDamageIndexInstruction

function DataSelectNextDamageIndexInstruction:Constructor(paramList)
end

function DataSelectNextDamageIndexInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, damageStageIndex)
  local damageIndex = phaseContext:GetCurDamageIndex()
  damageIndex = damageIndex + 1
  phaseContext:SetCurDamageIndex(damageIndex)
end
