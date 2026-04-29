_class("SkillPhaseParamBase", Object)
SkillPhaseParamBase = SkillPhaseParamBase

function SkillPhaseParamBase:Constructor(t)
  if t then
    self._hitTurnToTarget = t.hitTurnToTarget
  end
end

function SkillPhaseParamBase:GetCacheTable(skillConfig, skinId)
  Log.fatal(self._className .. " not implicate GetCacheTable() !!!")
end

function SkillPhaseParamBase:GetSoundCacheTable()
  return nil
end

function SkillPhaseParamBase:GetVoiceCacheTable()
  return nil
end

function SkillPhaseParamBase:HitTurnToTarget()
  return self._hitTurnToTarget
end

function SkillPhaseParamBase:AddEffectIDToListID(listID, nEffectID)
  if nEffectID and 0 < nEffectID then
    listID[#listID + 1] = nEffectID
  end
end

function SkillPhaseParamBase:GetCacheTableFromListID(listID)
  local t = {}
  local nMaxCount = table.count(listID)
  for i = 1, nMaxCount do
    local nEffectID = listID[i]
    if nEffectID and 0 < nEffectID then
      t[#t + 1] = {
        Cfg.cfg_effect[nEffectID].ResPath,
        1
      }
    end
  end
  return t
end

function SkillPhaseParamBase:GenerateCacheTableElementByID(effectID, cacheCount)
  cacheCount = cacheCount or 1
  if "number" ~= type(effectID) then
    return nil
  end
  local cfg = Cfg.cfg_effect[effectID]
  if not cfg then
    Log.exception(self._className, "找不到特效：", tostring(effectID), "\n", Log.traceback())
    return
  end
  return {
    cfg.ResPath,
    cacheCount
  }
end

function SkillPhaseParamBase:_TransID(nID)
  local listID = {}
  if type(nID) == "table" then
    listID = nID
  elseif nID then
    table.insert(listID, nID)
  end
  return listID
end

function SkillPhaseParamBase:_CalcScopeRangeGridNum(scopeType, scopeParam)
  local gridNum = 1
  if scopeType == SkillScopeType.NRowsMColumns then
    local skillNRowsMColumnsScopeParam = scopeParam
    local columns = skillNRowsMColumnsScopeParam:GetSkillScopeColumns()
    local rows = skillNRowsMColumnsScopeParam:GetSkillScopeRows()
    local yMoveCount = math.floor((rows - 1) / 2 + 0.5)
    local xMoveCount = math.floor((columns - 1) / 2 + 0.5)
    local yNum = yMoveCount * 2 + 1
    if 9 < yNum then
      yNum = 9
    end
    local xNum = xMoveCount * 2 + 1
    if 9 < xNum then
      xNum = 9
    end
    gridNum = xNum * yNum
  else
  end
  return gridNum
end

function SkillPhaseParamBase:GetEffectResCacheInfo(effectID, count)
  count = count or 1
  if not effectID then
    return nil
  end
  if not Cfg.cfg_effect[effectID] then
    Log.exception(self._className, "effectID not found: ", tostring(effectID))
    return nil
  end
  local resPath = Cfg.cfg_effect[effectID].ResPath
  if not ResourceManager:GetInstance():HasResource(resPath) then
    Log.exception(self._className, "res not found: ", tostring(resPath))
    return nil
  end
  return {resPath, count}
end
