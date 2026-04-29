require("base_ins_r")
_class("DataSelectNextBuffInstruction", BaseInstruction)
DataSelectNextBuffInstruction = DataSelectNextBuffInstruction

function DataSelectNextBuffInstruction:Constructor(paramList)
end

function DataSelectNextBuffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local addBuffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBuff)
  local buffIndex = phaseContext:GetCurBuffResultIndex()
  buffIndex = buffIndex + 1
  phaseContext:SetCurBuffResultIndex(buffIndex)
  if not addBuffResultArray then
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  if buffIndex > #addBuffResultArray then
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local buffResult = addBuffResultArray[buffIndex]
  if buffResult == nil or next(buffResult._newBuffArray) == nil then
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local targetEntityID = buffResult:GetEntityID()
  phaseContext:SetCurTargetEntityID(targetEntityID)
end
