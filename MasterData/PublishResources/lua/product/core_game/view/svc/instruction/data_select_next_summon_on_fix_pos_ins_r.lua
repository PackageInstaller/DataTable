require("base_ins_r")
_class("DataSelectNextSummonOnFixPosInstruction", BaseInstruction)
DataSelectNextSummonOnFixPosInstruction = DataSelectNextSummonOnFixPosInstruction

function DataSelectNextSummonOnFixPosInstruction:Constructor(paramList)
end

function DataSelectNextSummonOnFixPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if skillEffectResultContainer == nil then
    Log.fatal("DataSelectNextSummonOnFixPosInstruction  error: no data result container.")
    return
  end
  local summonResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonOnFixPosLimit)
  if not summonResultArray then
    Log.error("Get SummonOnFixPosLimit result failed.")
    return
  end
  local result = summonResultArray[1]
  local trapIDList = result:GetTrapIDList()
  if not trapIDList then
    Log.error("GetTrapIDList trap list is null.")
    return
  end
  local summonIndex = phaseContext:GetCurSummonOnFixPosIndex()
  summonIndex = summonIndex + 1
  phaseContext:SetCurSummonOnFixPosIndex(-1)
  phaseContext:SetCurTargetEntityID(-1)
  if summonIndex > #trapIDList then
    return
  end
  local trapID = trapIDList[summonIndex]
  local world = casterEntity:GetOwnerWorld()
  local eTrap = world:GetEntityByID(trapID)
  if not eTrap then
    return
  end
  phaseContext:SetCurSummonOnFixPosIndex(summonIndex)
  if eTrap then
    phaseContext:SetCurTargetEntityID(trapID)
  end
end
