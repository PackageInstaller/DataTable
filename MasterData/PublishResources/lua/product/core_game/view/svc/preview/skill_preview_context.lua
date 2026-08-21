_class("SkillPreviewContext", Object)
SkillPreviewContext = SkillPreviewContext

function SkillPreviewContext:Constructor(world, casterEntity)
  self._world = world
  self._casterEntity = casterEntity
  self._scopeResult = nil
  self._scopeGridList = nil
  self._needBreak = false
  self._effectList = {}
  self._targetEntityIDList = {}
  self._hitBackDirType = nil
  self._casterDir = casterEntity:GridLocation().Direction
  self._casterPos = casterEntity:GridLocation().Position
  self._casterBodyArea = casterEntity:BodyArea()
  self._ignorePlayerBlock = false
  self._previewIndex = 0
  self._pickUpPos = nil
  self._scopeType = SkillScopeType.None
  self._effectScopeList = {}
  self._effectParamList = {}
  self._rotateGhost = nil
  self._scopeCenterPosList = {}
  self._activeSkillID = 0
end

function SkillPreviewContext:SetEffectList(effectList)
  self._effectList = effectList
end

function SkillPreviewContext:GetEffect(previewEffectType)
  local retResultList = {}
  for k, v in pairs(self._effectList) do
    if v.effectType == previewEffectType then
      return v
    end
  end
end

function SkillPreviewContext:GetEffectsByType(previewEffectType)
  local retResultList = {}
  for k, v in ipairs(self._effectList) do
    if v.effectType == previewEffectType then
      table.insert(retResultList, v)
    end
  end
  return retResultList
end

function SkillPreviewContext:IsNeedBreak()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local nowPreviewIndex = previewActiveSkillService:GetPreviewIndex()
  return self._needBreak or nowPreviewIndex ~= self:_GetPreviewIndex()
end

function SkillPreviewContext:SetBreakState(needBreak)
  self._needBreak = needBreak
end

function SkillPreviewContext:SetScopeResult(scopeResult)
  self._scopeResult = scopeResult
end

function SkillPreviewContext:GetScopeResult(effectType)
  return self._scopeResult
end

function SkillPreviewContext:SetEffectParam(effectType, effectParam)
  self._effectParamList[effectType] = effectParam
end

function SkillPreviewContext:GetEffectParam(effectType)
  return self._effectParamList[effectType]
end

function SkillPreviewContext:SetTargetEntityIDList(list)
  self._targetEntityIDList = list
end

function SkillPreviewContext:GetTargetEntityIDList(effectType)
  return self._targetEntityIDList
end

function SkillPreviewContext:GetWorld()
  return self._world
end

function SkillPreviewContext:SetCasterDir(dir)
  self._casterDir = dir
end

function SkillPreviewContext:GetCasterDir()
  return self._casterDir
end

function SkillPreviewContext:SetCasterPos(pos)
  self._casterPos = pos
end

function SkillPreviewContext:GetCasterPos()
  return self._casterPos
end

function SkillPreviewContext:IsIgnorePlayerBlock()
  return self._ignorePlayerBlock
end

function SkillPreviewContext:SetIgnorePlayerBlockState(state)
  self._ignorePlayerBlock = state
end

function SkillPreviewContext:GetCasterBodyArea()
  return self._casterBodyArea
end

function SkillPreviewContext:GetHitBackDirType()
  return self._hitBackDirType
end

function SkillPreviewContext:SetHitBackDirType(dirType)
  self._hitBackDirType = dirType
end

function SkillPreviewContext:SetPreviewIndex(index)
  self._previewIndex = index
end

function SkillPreviewContext:_GetPreviewIndex()
  return self._previewIndex
end

function SkillPreviewContext:SetPickUpPos(pos)
  self._pickUpPos = pos
end

function SkillPreviewContext:GetPickUpPos()
  return self._pickUpPos
end

function SkillPreviewContext:SetScopeType(scopeType)
  self._scopeType = scopeType
end

function SkillPreviewContext:GetScopeType()
  return self._scopeType
end

function SkillPreviewContext:SetConfigData(configData)
  self._configData = configData
end

function SkillPreviewContext:GetConfigData()
  return self._configData
end

function SkillPreviewContext:SetScopeCenterPos(posList)
  if posList._className then
    self._scopeCenterPosList = {posList}
  else
    self._scopeCenterPosList = posList
  end
end

function SkillPreviewContext:GetScopeCenterPosList()
  return self._scopeCenterPosList
end

function SkillPreviewContext:SetPreviewActiveSkillID(skillID)
  self._activeSkillID = skillID
end

function SkillPreviewContext:GetPreviewActiveSkillID()
  return self._activeSkillID
end
