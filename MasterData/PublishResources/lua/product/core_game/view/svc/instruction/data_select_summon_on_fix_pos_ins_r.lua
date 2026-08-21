require("base_ins_r")
_class("DataSelectSummonOnFixPosInstruction", BaseInstruction)
DataSelectSummonOnFixPosInstruction = DataSelectSummonOnFixPosInstruction

function DataSelectSummonOnFixPosInstruction:Constructor(paramList)
  self._summonIndex = tonumber(paramList.index)
  assert(self._summonIndex, "DataSelectSummonOnFixPos需要配置index")
end

function DataSelectSummonOnFixPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if not skillEffectResultContainer then
    Log.fatal("DataSelectSummonOnFixPosInstruction error: no data result container.")
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
  local trapID = trapIDList[self._summonIndex]
  local world = casterEntity:GetOwnerWorld()
  local eTrap = world:GetEntityByID(trapID)
  if not eTrap then
    phaseContext:SetCurSummonOnFixPosIndex(-1)
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  phaseContext:SetCurSummonInEverythingIndex(self._summonIndex)
  if eTrap then
    phaseContext:SetCurTargetEntityID(trapID)
  end
end
