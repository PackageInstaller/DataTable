require("base_ins_r")
_class("DataSelectNextSummonThingInstruction", BaseInstruction)
DataSelectNextSummonThingInstruction = DataSelectNextSummonThingInstruction

function DataSelectNextSummonThingInstruction:Constructor(paramList)
end

function DataSelectNextSummonThingInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if skillEffectResultContainer == nil then
    Log.fatal("DataSelectNextSummonThingInstruction has no result")
    return
  end
  local summonEverythingResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  if not summonEverythingResultArray then
    return
  end
  assert(0 < #summonEverythingResultArray, "DataSelectNextSummonThing目前只对SummonEverything有效")
  local summonIndex = phaseContext:GetCurSummonInEverythingIndex()
  summonIndex = summonIndex + 1
  phaseContext:SetCurSummonInEverythingIndex(-1)
  phaseContext:SetCurTargetEntityID(-1)
  if summonIndex > #summonEverythingResultArray then
    return
  end
  local result = summonEverythingResultArray[summonIndex]
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
  phaseContext:SetCurSummonInEverythingIndex(summonIndex)
  if entityWork then
    phaseContext:SetCurTargetEntityID(entityWorkID)
  end
end
