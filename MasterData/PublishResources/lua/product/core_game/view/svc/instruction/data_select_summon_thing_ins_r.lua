require("base_ins_r")
_class("DataSelectSummonThingInstruction", BaseInstruction)
DataSelectSummonThingInstruction = DataSelectSummonThingInstruction

function DataSelectSummonThingInstruction:Constructor(paramList)
  self._summonIndex = tonumber(paramList.index)
  assert(self._summonIndex, "DataSelectSummonThing需要配置index")
end

function DataSelectSummonThingInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if not skillEffectResultContainer then
    Log.fatal("DataSelectSummonThingInstruction error,has no data result container")
    return
  end
  local summonEverythingResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  if not summonEverythingResultArray then
    Log.fatal("### Get SummonEverything result failed.")
    return
  end
  assert(0 < #summonEverythingResultArray, "DataSelectNextSummonThing目前只对SummonEverything有效")
  local result = summonEverythingResultArray[self._summonIndex]
  if not result then
    Log.fatal("### Get SummonEverything invalid index: ", tostring(self._summonIndex))
    return
  end
  local tmpData = result:GetMonsterData()
  local entityWorkID = tmpData.m_entityWorkID
  if not entityWorkID then
    tmpData = result:GetTrapData()
    entityWorkID = tmpData.m_entityWorkID
  end
  local world = casterEntity:GetOwnerWorld()
  local entityWork = world:GetEntityByID(entityWorkID)
  if not entityWork then
    phaseContext:SetCurSummonInEverythingIndex(-1)
    phaseContext:SetCurTargetEntityID(-1)
    return
  end
  phaseContext:SetCurSummonInEverythingIndex(self._summonIndex)
  if entityWork then
    phaseContext:SetCurTargetEntityID(entityWorkID)
  end
end
