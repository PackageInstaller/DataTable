require("play_grid_range_convert_ins_r")
_class("PlayIslandConvertInstruction", PlayGridRangeConvertInstruction)
PlayIslandConvertInstruction = PlayIslandConvertInstruction

function PlayIslandConvertInstruction:Constructor(paramList)
  self._patternEffectID = tonumber(paramList.patternEffectID) or 0
end

function PlayIslandConvertInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local cRoutine = casterEntity:SkillRoutine():GetResultContainer()
  local results = cRoutine:GetEffectResultsAsArray(SkillEffectType.IslandConvert)
  local result = results[1]
  if not result then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local svcFx = world:GetService("Effect")
  if self._patternEffectID > 0 then
    local tv2FxPos = result:GetGroupCenterArray()
    for _, v2 in ipairs(tv2FxPos) do
      svcFx:CreateCommonGridEffect(self._patternEffectID, v2)
    end
  end
  local tConvertInfo = {}
  local tAtomicData = result:GetAtomicDataArray()
  for _, atomicData in ipairs(tAtomicData) do
    local pos = atomicData:GetPosition()
    local oldPieceType = atomicData:GetOldPieceType()
    local newPieceType = atomicData:GetTargetPieceType()
    local flushTrapIds = atomicData:GetDestroyedTrapArray()
    local traps = {}
    for i, v in ipairs(flushTrapIds) do
      local e = world:GetEntityByID(v)
      table.insert(traps, e)
    end
    self:_Convert(world, pos, newPieceType, traps)
    local convertInfo = NTGridConvert_ConvertInfo:New(pos, oldPieceType, newPieceType)
    table.insert(tConvertInfo, convertInfo)
  end
  local svcPlaySkill = world:GetService("PlaySkill")
  local svcPlayBuff = world:GetService("PlayBuff")
  if 0 < #tConvertInfo then
    local notify = NTGridConvert:New(casterEntity, tConvertInfo)
    notify:SetConvertEffectType(SkillEffectType.IslandConvert)
    notify.__attackPosMatchRequired = true
    svcPlayBuff:PlayBuffView(TT, notify)
  end
end

function PlayIslandConvertInstruction:GetCacheResource()
  local t = {}
  if self._patternEffectID and self._patternEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._patternEffectID].ResPath,
      1
    })
  end
  return t
end
