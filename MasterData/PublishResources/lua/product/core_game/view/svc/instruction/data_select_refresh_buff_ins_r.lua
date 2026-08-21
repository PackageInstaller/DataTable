require("base_ins_r")
_class("DataSelectRefreshBuffInstruction", BaseInstruction)
DataSelectRefreshBuffInstruction = DataSelectRefreshBuffInstruction

function DataSelectRefreshBuffInstruction:Constructor(paramList)
  self._Index = tonumber(paramList.Index)
end

function DataSelectRefreshBuffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local buffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ModifyBuffValue)
  if buffResultArray == nil then
    Log.fatal("[ins] caster has no buff:", tostring(casterEntity:GridLocation().Position))
    return InstructionConst.HeightWise
  end
  local buffResult = buffResultArray[self._Index]
  if buffResult == nil then
    phaseContext:SetCurBuffResultIndex(self._Index)
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local targetEntityID = buffResult:GetEntityID()
  phaseContext:SetCurBuffResultIndex(self._Index)
  phaseContext:SetCurTargetEntityID(targetEntityID)
end
