require("base_ins_r")
_class("DataSelectBuffInstruction", BaseInstruction)
DataSelectBuffInstruction = DataSelectBuffInstruction

function DataSelectBuffInstruction:Constructor(paramList)
  self._buffIndex = tonumber(paramList.buffIndex)
end

function DataSelectBuffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local buffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBuff)
  if buffResultArray == nil then
    Log.warn("[ins] caster has no buff:", tostring(casterEntity:GridLocation().Position))
    return InstructionConst.HeightWise
  end
  local buffResult = buffResultArray[self._buffIndex]
  if buffResult == nil or next(buffResult._newBuffArray) == nil then
    phaseContext:SetCurBuffResultIndex(self._buffIndex)
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  local targetEntityID = buffResult:GetEntityID()
  phaseContext:SetCurBuffResultIndex(self._buffIndex)
  phaseContext:SetCurTargetEntityID(targetEntityID)
end
