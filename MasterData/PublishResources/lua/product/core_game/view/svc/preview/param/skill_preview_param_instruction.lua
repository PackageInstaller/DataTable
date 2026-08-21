_class("SkillPreviewParamInstruction", SkillPreviewParamBase)
SkillPreviewParamInstruction = SkillPreviewParamInstruction

function SkillPreviewParamInstruction:Constructor(t)
  self._previewType = t.PreviewType
  self._param = t.Param
  self._previewList = self:ParseParam()
end

function SkillPreviewParamInstruction:GetPreviewType()
  return self._previewType
end

function SkillPreviewParamInstruction:GetPreviewParam()
  return self._param
end

function SkillPreviewParamInstruction:ParseParam()
  local idList = string.split(self._param, ",")
  local previewContextList = {}
  for _, strID in pairs(idList) do
    local id = tonumber(strID)
    local skillPreviewContext = self:ParsePreviewID(id)
    table.insert(previewContextList, skillPreviewContext)
  end
  return previewContextList
end

function SkillPreviewParamInstruction:ParsePreviewID(id)
  local config = Cfg.cfg_active_skill_preview[id]
  if not config then
    Log.fatal("GetPreviewConfig Failed PreviewID:", id)
    return
  end
  local scopeParamParser = SkillScopeParamParser:New()
  local previewConfigData = SkillPreviewConfigData:New()
  local previewScopeParam = SkillPreviewScopeParam:New(config)
  local scopeParamData = scopeParamParser:ParseScopeParam(config.ScopeType, config.ScopeParam)
  previewScopeParam:SetScopeParamData(scopeParamData)
  previewConfigData:SetPreviewScopeParam(previewScopeParam)
  previewConfigData:SetPreviewEffectList(config.PreviewEffectType)
  previewConfigData:SetID(config.ID)
  if config.OnStart and config.OnStart ~= 0 then
    previewConfigData:SetOnStartInstructionSet(self:_ParseInstructionSet(config.OnStart))
  end
  if config.OnSelectValid and config.OnSelectValid ~= 0 then
    previewConfigData:SetOnSelectValidInstructionSet(self:_ParseInstructionSet(config.OnSelectValid))
  end
  if config.OnSelectCancel and config.OnSelectCancel ~= 0 then
    previewConfigData:SetOnSelectCancelInstructionSet(self:_ParseInstructionSet(config.OnSelectCancel))
  end
  if config.OnSelectEmpty and config.OnSelectEmpty ~= 0 then
    previewConfigData:SetOnSelectEmptyInstructionSet(self:_ParseInstructionSet(config.OnSelectEmpty))
  end
  if config.OnSelectInvalid and config.OnSelectInvalid ~= 0 then
    previewConfigData:SetOnSelectInvalidInstructionSet(self:_ParseInstructionSet(config.OnSelectInvalid))
  end
  if config.OnCancelPreview and config.OnCancelPreview ~= 0 then
    previewConfigData:SetCancelPreviewInstructionSet(self:_ParseInstructionSet(config.OnCancelPreview))
  end
  if config.OnActiveSkill and config.OnActiveSkill ~= 0 then
    previewConfigData:SetActiveSkillInstructionSet(self:_ParseInstructionSet(config.OnActiveSkill))
  end
  if config.OnPreActiveSkill and config.OnPreActiveSkill ~= 0 then
    previewConfigData:SetPreActiveSkillInstructionSet(self:_ParseInstructionSet(config.OnPreActiveSkill))
  end
  return previewConfigData
end

function SkillPreviewParamInstruction:GetCacheTable()
  local t = {}
  for _, v in ipairs(self._instructionSet) do
    local insObj = v
    local resourceTable = insObj:GetCacheResource()
    if resourceTable then
      for _, res in ipairs(resourceTable) do
        table.insert(t, res)
      end
    end
  end
  return t
end

function SkillPreviewParamInstruction:GetSoundCacheTable()
  local t = {}
  for _, v in ipairs(self._instructionSet) do
    local insObj = v
    local resourceTable = insObj:GetCacheAudio()
    if resourceTable then
      for _, res in ipairs(resourceTable) do
        table.insert(t, res)
      end
    end
  end
  return t
end

function SkillPreviewParamInstruction:GetVoiceCacheTable()
  local t = {}
  for _, v in ipairs(self._instructionSet) do
    local insObj = v
    local resourceTable = insObj:GetCacheVoice()
    if resourceTable then
      for _, res in ipairs(resourceTable) do
        table.insert(t, res)
      end
    end
  end
  return t
end

function SkillPreviewParamInstruction:_ParseInstructionSet(id)
  local instructionSet = {}
  if id then
    local config = Cfg.cfg_preview_instruction_set[id]
    if not config then
      Log.fatal("Can't find previewInstructionSet ID:", id)
      return nil
    end
    local t = config.InstructionSet
    local paramString = t[1]
    local phaseInsArray = string.split(paramString, ";")
    for k, v in ipairs(phaseInsArray) do
      if 1 < string.len(v) then
        local instruction = string.split(v, ",")
        if table.count(instruction) > 0 then
          local instructionType, paramList = self:_ParseInstructionParam(instruction)
          local instructionObj = self:_CreateInstruction(instructionType, paramList)
          instructionSet[#instructionSet + 1] = instructionObj
        end
      end
    end
  end
  return instructionSet
end

function SkillPreviewParamInstruction:_CreateInstruction(instructionType, paramList)
  local insObject
  local insClassName = "SkillPreview" .. instructionType .. "Instruction"
  local insClass = Classes[insClassName]
  if insClass == nil then
    if EDITOR then
      Log.exception("Can not create instruction:", insClassName)
    else
      Log.fatal("Can not create instruction:", insClassName)
    end
  else
    insObject = insClass:New(paramList)
  end
  return insObject
end

function SkillPreviewParamInstruction:_ParseInstructionParam(insArray)
  local instructionType
  local paramList = {}
  for k, v in ipairs(insArray) do
    if k == 1 then
      instructionType = string.gsub(v, "^%s*(.-)%s*$", "%1")
    else
      local paramArray = string.split(v, "=")
      local paramName = string.gsub(paramArray[1], "^%s*(.-)%s*$", "%1")
      local paramValue = string.gsub(paramArray[2], "^%s*(.-)%s*$", "%1")
      paramList[paramName] = paramValue
    end
  end
  return instructionType, paramList
end
