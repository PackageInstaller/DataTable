require("base_ins_r")
_class("PlayEffectAtSummonPosInstruction", BaseInstruction)
PlayEffectAtSummonPosInstruction = PlayEffectAtSummonPosInstruction

function PlayEffectAtSummonPosInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
end

function PlayEffectAtSummonPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
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
  local posSummon = summonRes:GetSummonPos()
  Log.error("PlayEffectAtSummonPos     ", posSummon)
  local sEffect = world:GetService("Effect")
  sEffect:CreateWorldPositionEffect(self._effectID, posSummon)
end

function PlayEffectAtSummonPosInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
