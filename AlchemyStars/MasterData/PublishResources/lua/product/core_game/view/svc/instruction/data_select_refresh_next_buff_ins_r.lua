require("base_ins_r")
_class("DataSelectRefreshNextBuffInstruction", BaseInstruction)
DataSelectRefreshNextBuffInstruction = DataSelectRefreshNextBuffInstruction

function DataSelectRefreshNextBuffInstruction:Constructor(paramList)
end

function DataSelectRefreshNextBuffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local refreshBuffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ModifyBuffValue)
  local buffIndex = phaseContext:GetCurBuffResultIndex()
  buffIndex = buffIndex + 1
  phaseContext:SetCurBuffResultIndex(buffIndex)
  if not refreshBuffResultArray then
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  if buffIndex > #refreshBuffResultArray then
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local buffResult = refreshBuffResultArray[buffIndex]
  if buffResult == nil then
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local targetEntityID = buffResult:GetEntityID()
  phaseContext:SetCurTargetEntityID(targetEntityID)
end
