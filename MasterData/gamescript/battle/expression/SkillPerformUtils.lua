local SkillPerformUtils = {}
local Empty_List = {}
local StateStringToTable

function SkillPerformUtils.GetPerformByCondition(awaker, skillId, conIdx)
  local skillCfg = DT.Skill[skillId]
  if not skillCfg then
    return
  end
  local con = skillCfg.PerformCond
  local performTypes = skillCfg.PerformType or {}
  local performs = skillCfg.Perform or {}
  local sfx = skillCfg.SFX or {}
  local voc = skillCfg.CondVOC or {}
  if bg.isPVP then
    sfx, voc = SkillPerformUtils.GetPVPAwakerSfxAndVOC(awaker.tid, performs[1])
  end
  if not con or 0 == #con then
    local randVoc = #voc > 1 and voc[math.random(1, #voc)] or voc[1]
    return performTypes[1], performs[1], sfx[1], randVoc
  end
  if conIdx and con[conIdx] then
    return performTypes[conIdx] or performTypes[conIdx], performs[conIdx] or performs[conIdx], sfx[conIdx] or sfx[1], voc[conIdx] or voc[1]
  end
  local parserEnv = {awaker = awaker}
  local cmdParser = BattleCmdParserClient(parserEnv)
  for i = 1, #con do
    local r = cmdParser:GetValueByCmd(con[i])
    if r then
      return performTypes[i] or performTypes[1], performs[i] or performs[1], sfx[i] or sfx[1], voc[i] or voc[1]
    end
  end
end

function SkillPerformUtils.GetPVPAwakerSfxAndVOC(awakerTid, perform)
  local awakerCfg = DT.AwakerConfig[awakerTid] or {}
  local aniId = awakerCfg.PVPAnimationID or 0
  local aniCfg = DT.PVPAnimationConfig[aniId] or {}
  local sfxKey = string.format("%sSFX", perform)
  local vocKey = string.format("%sVOC", perform)
  return aniCfg[sfxKey] or {}, aniCfg[vocKey] or {}
end

function SkillPerformUtils.GetStateVFXList(stateId, stateLayer)
  local state = DT.State[stateId]
  if not state or not state.VFX then
    return Empty_List
  end
  local tVFX = type(state.VFX)
  if "table" == tVFX then
    return state.VFX
  end
  if "number" == tVFX then
    return {
      state.VFX
    }
  end
  if "string" == tVFX then
    local vfxList
    if StateStringToTable then
      vfxList = StateStringToTable[stateId]
    end
    if not vfxList then
      vfxList = {}
      local vfxs = string.split(state.VFX, ";")
      for i = 1, #vfxs do
        local layer_vfxs = string.split(vfxs[i], ":")
        table.insert(vfxList, {
          layer = tonumber(layer_vfxs[1]),
          sfxId = tonumber(layer_vfxs[2])
        })
      end
      StateStringToTable = StateStringToTable or {}
      StateStringToTable[stateId] = vfxList
      table.sort(vfxList, function(x, y)
        return x.layer < y.layer
      end)
    end
    if 0 == #vfxList then
      return Empty_List
    end
    local index = 1
    for i = 1, #vfxList do
      if stateLayer >= vfxList[i].layer then
        index = i
      else
        break
      end
    end
    return {
      vfxList[index].sfxId
    }
  end
  return Empty_List
end

return SkillPerformUtils
