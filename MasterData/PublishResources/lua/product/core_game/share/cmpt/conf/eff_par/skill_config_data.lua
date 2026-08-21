require("skill_scope_filter_param")
_class("SkillConfigData", Object)
SkillConfigData = SkillConfigData

function SkillConfigData:Constructor(scopeParamParser, effectParamParser, viewParamParser, previewParamParser)
  self._skillName = ""
  self._skillDesc = ""
  self._subSkillIDList = {}
  self._triggerType = SkillTriggerType.None
  self._triggerParam = nil
  self._triggerExtraParam = nil
  self._skillType = nil
  self._targetType = SkillTargetType.Monster
  self._targetTypeParam = nil
  self._scopeType = SkillScopeType.Cross
  self._scopeParamData = nil
  self._pickUpType = SkillPickUpType.None
  self._pickUpParam = nil
  self._skillEffectArray = {}
  self._scopeParamParser = scopeParamParser
  self._effectParamParser = effectParamParser
  self._previewType = SkillPreviewType.Scope
  self._viewParamParser = viewParamParser
  self._skillPhaseArray = {}
  self._pickUpValidScopeList = {}
  self._pickUpInvalidScopeList = {}
  self._previewParamList = {}
  self._previewParamParser = previewParamParser
end

function SkillConfigData:ParseSkillConfig(skillID)
  local skillConfig = BattleSkillCfg(skillID)
  if skillConfig == nil then
    Log.fatal("ParseSkillConfig skill not exist skillID=", skillID, " ", Log.traceback())
    return
  end
  self._skillID = skillConfig.ID
  self._skillIcon = skillConfig.Icon
  self._skillDesc = skillConfig.Desc
  self._skillName = skillConfig.Name
  self._skillType = skillConfig.Type
  self._subSkillIDList = skillConfig.SubSkillIDList or {}
  self._skillTag = skillConfig.Tag or {}
  self._triggerType = skillConfig.TriggerType
  self._triggerParam = skillConfig.TriggerParam
  self._triggerExtraParam = skillConfig.TriggerExtraParam
  self._targetType = skillConfig.TargetType
  self._targetTypeParam = skillConfig.TargetTypeParam
  self._scopeCenterType = skillConfig.ScopeCenterType
  self._scopeType = skillConfig.ScopeType
  self._scopeParamData = self._scopeParamParser:ParseScopeParam(skillConfig.ScopeType, skillConfig.ScopeParam)
  self._specialView = skillConfig.SpecialView or {}
  self._scopeFilterParam = SkillScopeFilterParam:New({
    scopeCasterOccupiedFilter = skillConfig.ScopeCasterOccupiedFilter,
    obstructingTrapFilter = skillConfig.ScopeObstructingTrapFilter,
    monsterOccupiedPosFilter = skillConfig.ScopeMonsterOccupiedPosFilter,
    targetSelectionMode = skillConfig.TargetSelectionMode
  })
  self._targetSelectionMode = skillConfig.TargetSelectionMode
  self._skillViewParams = skillConfig.ViewParams
  self._skillPhaseAdapter = skillConfig.ViewAdapter
  self._pickUpType = skillConfig.PickUpType
  self._pickUpParam = skillConfig.PickUpParam
  self._previewType = skillConfig.PreviewType
  self._previewParam = skillConfig.PreviewParam
  self:ParsePreview(skillConfig)
  self._skillEffectArray = self._effectParamParser:ParseSkillEffectList(skillConfig.EffectTable, nil, self._skillType)
  self._sourceSkillEffectTable = skillConfig.EffectTable
  self._skillPhaseArray[1] = self:ParseViewID(skillConfig.ViewID)
  for skinId, viewID in pairs(self._specialView) do
    self._skillPhaseArray[skinId] = self:ParseViewID(viewID)
  end
  self:ParseAutoFightCondition(skillConfig.AutoFightCondition)
  self._autoFightPickPosPolicyParam = skillConfig.AutoFightPickPosPolicyParam
  self._autoFightSkillScopeTypeAndTargetType = skillConfig.AutoFightSkillScopeTypeAndTargetType
  self._autoFightPickPosPolicy = skillConfig.AutoFightPickPosPolicy or PickPosPolicy.MaxTargetCount
  self._autoFightSkillOrder = skillConfig.AutoFightSkillOrder
  self._autoFightChainSkillTag = skillConfig.ChainSkillTag
  self._metaEffectTableArray = skillConfig.EffectTable
end

function SkillConfigData:GetID()
  return self._skillID
end

function SkillConfigData:GetSkillIcon()
  return self._skillIcon
end

function SkillConfigData:GetSkillViewParams()
  return self._skillViewParams
end

function SkillConfigData:GetSkillName()
  return self._skillName
end

function SkillConfigData:GetSkillDesc()
  return self._skillDesc
end

function SkillConfigData:GetPetSkillDes(forceParam)
  if forceParam and 0 < #forceParam then
    return StringTable.Get(self._skillDesc, table.unpack(forceParam))
  end
  if self._skillEffectArray == nil or 0 >= #self._skillEffectArray then
    return StringTable.Get(self._skillDesc)
  end
  local damageEffectParam
  for i = 1, #self._skillEffectArray do
    local skillEffect = self._skillEffectArray[i]
    if skillEffect:GetEffectType() == SkillEffectType.Damage or skillEffect:GetEffectType() == SkillEffectType.StampDamage then
      damageEffectParam = skillEffect
      break
    end
  end
  if not damageEffectParam then
    return StringTable.Get(self._skillDesc)
  end
  local percent = damageEffectParam:GetDamagePercent()
  if percent == nil or 0 >= table.count(percent) then
    return StringTable.Get(self._skillDesc)
  end
  local des
  local percentCount = table.count(percent)
  if percentCount == 1 then
    local value = math.floor(percent[1] * 100 + 0.5)
    des = StringTable.Get(self._skillDesc, tostring(value))
  elseif percentCount == 2 then
    local value1 = math.floor(percent[1] * 100 + 0.5)
    local value2 = math.floor(percent[2] * 100 + 0.5)
    des = StringTable.Get(self._skillDesc, tostring(value1), tostring(value2))
  else
    local value1 = math.floor(percent[1] * 100 + 0.5)
    local value2 = math.floor(percent[2] * 100 + 0.5)
    local value3 = math.floor(percent[3] * 100 + 0.5)
    des = StringTable.Get(self._skillDesc, tostring(value1), tostring(value2), tostring(value3))
  end
  return des
end

function SkillConfigData:GetSkillType()
  return self._skillType
end

function SkillConfigData:GetSkillTargetType()
  return self._targetType
end

function SkillConfigData:GetSkillTargetTypeParam()
  return self._targetTypeParam
end

function SkillConfigData:GetSkillScopeCenterType()
  return self._scopeCenterType
end

function SkillConfigData:GetSkillScopeType()
  return self._scopeType
end

function SkillConfigData:GetSkillScopeParam()
  return self._scopeParamData
end

function SkillConfigData:GetSkillEffect()
  return self._skillEffectArray
end

function SkillConfigData:GetSkillSourceEffectTable()
  return self._sourceSkillEffectTable
end

function SkillConfigData:GetSkillPhaseArray(skinID)
  skinID = skinID or 1
  local ret = self._skillPhaseArray[skinID]
  ret = ret or self._skillPhaseArray[1]
  return ret
end

function SkillConfigData:GetSkillPreviewType()
  return self._previewType
end

function SkillConfigData:GetSkillPreviewParam()
  return self._previewParam
end

function SkillConfigData:GetSkillPickType()
  return self._pickUpType
end

function SkillConfigData:GetSkillPickParam()
  return self._pickUpParam
end

function SkillConfigData:GetSkillTriggerType()
  return self._triggerType
end

function SkillConfigData:GetSkillTriggerParam()
  return self._triggerParam
end

function SkillConfigData:GetSkillTriggerExtraParam()
  return self._triggerExtraParam
end

function SkillConfigData:GetSkillPhaseAdapter()
  return self._skillPhaseAdapter
end

function SkillConfigData:GetScopeFilterParam()
  return self._scopeFilterParam
end

function SkillConfigData:ParseScopeParam(nScopeType, scopeParam)
  return self._scopeParamParser:ParseScopeParam(nScopeType, scopeParam)
end

function SkillConfigData:IsHaveEffect_Common(pCallBack)
  local nEffectCount = table.count(self._skillEffectArray)
  for i = 1, nEffectCount do
    local effectData = self._skillEffectArray[i]
    if effectData then
      local nEffectType = effectData:GetEffectType()
      local bFind = pCallBack(self, nEffectType)
      if bFind then
        return true
      end
    end
  end
  return false
end

function SkillConfigData:_IsHaveEffect_HitBack(nEffectType)
  if SkillEffectType.HitBack == nEffectType then
    return true
  end
  return false
end

function SkillConfigData:_IsHaveEffect_Convert(nEffectType)
  if SkillEffectType.ConvertGridElement == nEffectType or SkillEffectType.ManualConvert == nEffectType or SkillEffectType.IslandConvert == nEffectType then
    return true
  end
  return false
end

function SkillConfigData:_IsHaveEffect_Teleport(nEffectType)
  if SkillEffectType.Teleport == nEffectType then
    return true
  end
  return false
end

function SkillConfigData:_IsHaveEffect_Damage(nEffectType)
  return nEffectType == SkillEffectType.Damage or nEffectType == SkillEffectType.DamageOnTargetCount or nEffectType == SkillEffectType.StampDamage
end

function SkillConfigData:IsHaveEffect_HitBack()
  return self:IsHaveEffect_Common(self._IsHaveEffect_HitBack)
end

function SkillConfigData:IsHaveEffect_Convert()
  return self:IsHaveEffect_Common(self._IsHaveEffect_Convert)
end

function SkillConfigData:IsHaveEffect_Teleport()
  return self:IsHaveEffect_Common(self._IsHaveEffect_Teleport)
end

function SkillConfigData:IsHaveEffect_Damage()
  return self:IsHaveEffect_Common(self._IsHaveEffect_Damage)
end

function SkillConfigData:GetSkillTag()
  return self._skillTag
end

function SkillConfigData:ParseViewID(viewID)
  local ret
  if self._viewParamParser then
    ret = self._viewParamParser:ParseSkillView(viewID, self:GetSkillViewParams())
  end
  if not ret and EDITOR then
    Log.warn("no skill view, skillViewID = ", viewID)
  end
  return ret
end

function SkillConfigData:GetSkillViewID(skinID)
  return self._skillViewID
end

function SkillConfigData:ParsePreview(skillConfig)
  if skillConfig.PickUpScopeType then
    self._pickUpValidScopeList = {}
    for _, v in ipairs(skillConfig.PickUpScopeType) do
      local pickUpScopeParam = SkillPreviewScopeParam:New(v)
      local scopeParamData = self._scopeParamParser:ParseScopeParam(v.ScopeType, v.ScopeParam)
      pickUpScopeParam:SetScopeParamData(scopeParamData)
      table.insert(self._pickUpValidScopeList, pickUpScopeParam)
    end
  end
  if skillConfig.PickUpInvalidScopeList then
    self._pickUpInvalidScopeList = {}
    for _, v in pairs(skillConfig.PickUpInvalidScopeList) do
      local pickUpInvalidScopeParam = SkillPreviewScopeParam:New(v)
      local pickUpScopeParamData = self._scopeParamParser:ParseScopeParam(v.ScopeType, v.ScopeParam)
      pickUpInvalidScopeParam:SetScopeParamData(pickUpScopeParamData)
      table.insert(self._pickUpInvalidScopeList, pickUpInvalidScopeParam)
    end
  end
  if self._previewParamParser and skillConfig.PreviewList then
    self._previewParamList = self._previewParamParser:ParseSkillPreviewList(skillConfig.PreviewList)
  end
end

function SkillConfigData:ParseAutoFightCondition(condition)
  if not condition then
    return
  end
  self._autoFightCondition = {
    conds = {},
    callback = function(t)
      local code = string.gsub(condition, "%a+", function(s)
        return t.conds[s]
      end)
      code = string.gsub(code, "&", " and ")
      code = string.gsub(code, "|", " or ")
      code = "return " .. code
      local f = load(code)
      if not f then
        Log.error("code:", code)
      end
      return f()
    end
  }
  for cond in string.gmatch(condition, "%a+") do
    self._autoFightCondition.conds[cond] = 0
  end
end

function SkillConfigData:GetAutoFightCondition()
  return self._autoFightCondition
end

function SkillConfigData:GetAutoFightSkillScopeTypeAndTargetType()
  return self._autoFightSkillScopeTypeAndTargetType
end

function SkillConfigData:GetAutoFightPickPosPolicy()
  return self._autoFightPickPosPolicy
end

function SkillConfigData:GetAutoFightSkillOrder()
  return self._autoFightSkillOrder
end

function SkillConfigData:GetAutoFightChainSkillTag()
  return self._autoFightChainSkillTag
end

function SkillConfigData:GetMetaEffectTableArray()
  return self._metaEffectTableArray
end

function SkillConfigData:GetSpecialView(key)
end

function SkillConfigData:GetPickUpValidScopeConfig()
  return self._pickUpValidScopeList
end

function SkillConfigData:GetPickUpInvalidScopeConfig()
  return self._pickUpInvalidScopeList
end

function SkillConfigData:GetTargetSelectionModeConfig()
  return self._targetSelectionMode
end

function SkillConfigData:GetSkillEffectByIndex(index)
  return self._skillEffectArray[index]
end

function SkillConfigData:GetSubSkillIDList()
  return self._subSkillIDList
end

function SkillConfigData:GetAutoFightPickPosPolicyParam()
  return self._autoFightPickPosPolicyParam
end
