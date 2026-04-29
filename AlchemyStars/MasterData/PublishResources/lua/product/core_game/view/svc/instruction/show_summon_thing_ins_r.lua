require("base_ins_r")
_class("ShowSummonThingInstruction", BaseInstruction)
ShowSummonThingInstruction = ShowSummonThingInstruction

function ShowSummonThingInstruction:Constructor(paramList)
end

function ShowSummonThingInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if skillEffectResultContainer == nil then
    Log.fatal("ShowSummonThingInstruction has no skill effect result")
    return
  end
  local summonResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  if not summonResultArray then
    return
  end
  local idx = phaseContext:GetCurSummonInEverythingIndex()
  local summonRes = summonResultArray[idx]
  if not summonRes then
    Log.fatal("### ShowSummonThingInstruction SkillEffectResult_SummonEverything nil")
    return
  end
  local summonType = summonRes:GetSummonType()
  local summonTrapID = summonRes:GetSummonID()
  local sPlaySkillInstruction = self:PlaySkillInstruction(casterEntity)
  if summonType == SkillEffectEnum_SummonType.Monster then
    sPlaySkillInstruction:ShowSummonAction(TT, world, summonRes)
  elseif summonType == SkillEffectEnum_SummonType.Trap then
    local inst = PlaySummonTrapInstruction:New({})
    inst:_ShowTrapFromSummonEverything(TT, world, summonRes)
  else
    Log.fatal("### ShowSummonThingInstruction summonType=", summonType)
  end
end
