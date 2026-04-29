_class("ChainSkillIDSelector", Object)
ChainSkillIDSelector = ChainSkillIDSelector

function ChainSkillIDSelector:Constructor()
  self._rules = {}
  self._current = "default"
end

function ChainSkillIDSelector:AddRule(name, value)
  self._rules[name] = value
  self._current = name
end

function ChainSkillIDSelector:RemoveRule(name)
  self._rules[name] = nil
  self._current = "default"
end

function ChainSkillIDSelector:GetRule(name)
  name = name or self._current
  return self._rules[name]
end

_class("ChainSkillStageInfo", Object)
ChainSkillStageInfo = ChainSkillStageInfo

function ChainSkillStageInfo:Constructor(chainSkillID, chainSkillStage)
  self._chainSkillID = chainSkillID
  self._chainSkillStage = chainSkillStage
end

function ChainSkillStageInfo:GetChainSkillID()
  return self._chainSkillID
end

function ChainSkillStageInfo:GetChainSkillStage()
  return self._chainSkillStage
end

_class("SkillInfoComponent", Object)
SkillInfoComponent = SkillInfoComponent

function SkillInfoComponent:Constructor(normal_skill_config_id, chain_skill_config_id, super_skill_config_id, extra_active_skill_id_list, variant_skill_info)
  self._normal_skill_config_id = normal_skill_config_id
  self._active_skill_config_id = super_skill_config_id
  self._extra_active_skill_config_id_list = extra_active_skill_id_list
  self._passive_skill_config_id = 0
  self._intensify_buff_list = nil
  self._equipIntensifyParam = nil
  self._ignore_cd_update_extra_skill_index_list = {}
  self._variantActiveSkillInfo = nil
  self._chainSkillIDSelector = ChainSkillIDSelector:New()
  self._chainSkillIDSelector:AddRule("default", chain_skill_config_id)
  self._buffOverlayChainSkillStepIndexTb = nil
  self._lockedChainSkillIndex = {}
  self._variantActiveSkillInfo = variant_skill_info
end

function SkillInfoComponent:GetNormalSkillID()
  return self._normal_skill_config_id
end

function SkillInfoComponent:SetNormalSkillID(id)
  self._normal_skill_config_id = id
end

function SkillInfoComponent:GetActiveSkillID()
  return self._active_skill_config_id
end

function SkillInfoComponent:SetActiveSkillID(activeSkillID)
  self._active_skill_config_id = activeSkillID
end

function SkillInfoComponent:GetExtraActiveSkillIDList()
  return self._extra_active_skill_config_id_list
end

function SkillInfoComponent:SetExtraActiveSkillIDList(extraActiveSkillIDList)
  self._extra_active_skill_config_id_list = extraActiveSkillIDList
end

function SkillInfoComponent:GetSkillIDByIndex(skillIndex)
  local skillID = 0
  if skillIndex then
    if skillIndex == 1 then
      skillID = self:GetActiveSkillID()
    elseif self._extra_active_skill_config_id_list then
      local extraIndex = skillIndex - 1
      if 0 < extraIndex and extraIndex <= #self._extra_active_skill_config_id_list then
        skillID = self._extra_active_skill_config_id_list[extraIndex]
      end
    end
  else
    skillID = self:GetActiveSkillID()
  end
  return skillID
end

function SkillInfoComponent:GetChainSkillIDSelector()
  return self._chainSkillIDSelector
end

function SkillInfoComponent:GetChainSkillConfigID(chain, extraChains)
  local buffOverlaySkillID, buffOverlaySkillIndex = self:_GetChainSkillConfigIDInBuffOverlay(chain)
  if buffOverlaySkillID and 0 < buffOverlaySkillID then
    return buffOverlaySkillID, buffOverlaySkillIndex
  end
  local rule = self._chainSkillIDSelector:GetRule()
  if rule then
    local len = #rule
    for i = len, 1, -1 do
      local v = rule[i]
      local requiredVal = v.Chain
      if extraChains and extraChains[v.Skill] then
        requiredVal = requiredVal - extraChains[v.Skill]
      end
      if chain >= requiredVal then
        if not table.icontains(self._lockedChainSkillIndex, i) and self:CheckColorPaletteSkill(v.Skill) then
          return v.Skill, i
        else
          Log.info("SkillInfoComponent: chain skill index [", i, "] is locked. ")
        end
      end
    end
  end
  return 0, 0
end

function SkillInfoComponent:_GetChainSkillConfigIDInBuffOverlay(chain)
  if self._buffOverlayChainSkillStepIndexTb then
    local overlayTb = self._buffOverlayChainSkillStepIndexTb
    if overlayTb then
      local len = #overlayTb
      for i = len, 1, -1 do
        local v = overlayTb[i]
        if chain >= v.Chain then
          local useIndex = v.OriChainSkillIndex
          local skillID = self:_GetOriChainSkillConfigInfoByIndex(useIndex)
          if skillID and 0 < skillID then
            return skillID, useIndex
          end
        end
      end
    end
  end
  return 0, 0
end

function SkillInfoComponent:_GetOriChainSkillConfigInfoByIndex(index)
  local rule = self._chainSkillIDSelector:GetRule()
  if rule then
    local len = #rule
    if index > len then
      for i = len, 1, -1 do
        if not table.icontains(self._lockedChainSkillIndex, i) then
          local v = rule[i]
          return v.Skill, v.Chain
        end
      end
    end
    for i = 1, len do
      local v = rule[i]
      if i == index then
        return v.Skill, v.Chain
      end
    end
  end
  return 0, 0
end

function SkillInfoComponent:GetChainSkillLevel(skillId)
  local rule = self._chainSkillIDSelector:GetRule()
  if rule then
    local len = #rule
    for i = len, 1, -1 do
      local v = rule[i]
      if v.Skill == skillId then
        return i
      end
    end
  end
  return 0
end

function SkillInfoComponent:SetPassiveSkillID(id)
  self._passive_skill_config_id = id
end

function SkillInfoComponent:GetPassiveSkillID()
  return self._passive_skill_config_id
end

function SkillInfoComponent:SetIntensifyBuffList(buffList)
  self._intensify_buff_list = buffList
end

function SkillInfoComponent:GetIntensifyBuffList()
  return self._intensify_buff_list
end

function SkillInfoComponent:SetEquipIntensifyParam(equipIntensifyParam)
  self._equipIntensifyParam = equipIntensifyParam
end

function SkillInfoComponent:GetEquipIntensifyParam()
  return self._equipIntensifyParam
end

function SkillInfoComponent:LockChainSkillIndex(index)
  if not table.icontains(self._lockedChainSkillIndex, index) then
    table.insert(self._lockedChainSkillIndex, index)
  end
end

function SkillInfoComponent:UnlockChainSkillIndex(index)
  table.removev(self._lockedChainSkillIndex, index)
end

function SkillInfoComponent:UnlockAllChainSkill()
  self._lockedChainSkillIndex = {}
end

function SkillInfoComponent:GetLockChainSkillIndex()
  return self._lockedChainSkillIndex
end

function SkillInfoComponent:SetExtraSkillIgnoreCdUpdate(extraSkillIndex, bIgnore)
  if bIgnore then
    if not table.icontains(self._ignore_cd_update_extra_skill_index_list, extraSkillIndex) then
      table.insert(self._ignore_cd_update_extra_skill_index_list, extraSkillIndex)
    end
  else
    table.removev(self._ignore_cd_update_extra_skill_index_list, extraSkillIndex)
  end
end

function SkillInfoComponent:IsExtraSkillIgnoreCdUpdate(extraSkillIndex)
  if table.icontains(self._ignore_cd_update_extra_skill_index_list, extraSkillIndex) then
    return true
  end
  return false
end

function SkillInfoComponent:BuffOverlayChainSkillByStepAndOriIndexSkill(overlayInfo)
  if overlayInfo then
    self._buffOverlayChainSkillStepIndexTb = overlayInfo
  end
end

function SkillInfoComponent:ClearBuffOverlayChainSkillInfo()
  self._buffOverlayChainSkillStepIndexTb = nil
end

function SkillInfoComponent:GetVariantActiveSkillInfo()
  return self._variantActiveSkillInfo
end

function SkillInfoComponent:SetVariantActiveSkillInfo(info)
  self._variantActiveSkillInfo = info
end

function SkillInfoComponent:SetPassiveCountBuffIDArray(t)
  self._passiveCountBuffIDArray = t
end

function SkillInfoComponent:GetPassiveCountBuffIDArray()
  return self._passiveCountBuffIDArray or {}
end

function SkillInfoComponent:IsBuffIDPassiveCount(id)
  return table.icontains(self._passiveCountBuffIDArray, id)
end

function SkillInfoComponent:SetCountActiveSkillEnergy(b)
  self._countActiveSkillEnergy = b
end

function SkillInfoComponent:IsActiveSkillEnergyCount()
  return self._countActiveSkillEnergy
end

function SkillInfoComponent:GetUnlockValidIndex(num)
  for i = num, 1, -1 do
    if not table.icontains(self._lockedChainSkillIndex, i) then
      return i
    end
  end
  return 0
end

function SkillInfoComponent:GetChainSkillConfigIDList(chain, extraChains)
  local buffOverlayList = self:_GetChainSkillConfigIDListInBuffOverlay(chain)
  if buffOverlayList and 0 < #buffOverlayList then
    return buffOverlayList
  end
  local retList = {}
  local rule = self._chainSkillIDSelector:GetRule()
  if rule then
    local len = #rule
    for i = 1, len do
      local v = rule[i]
      local requiredVal = v.Chain
      if extraChains and extraChains[v.Skill] then
        requiredVal = requiredVal - extraChains[v.Skill]
      end
      if chain >= requiredVal then
        if not table.icontains(self._lockedChainSkillIndex, i) and self:CheckColorPaletteSkill(v.Skill) then
          local chainInfo = ChainSkillStageInfo:New(v.Skill, i)
          table.insert(retList, chainInfo)
        else
          local unlockIndex = self:GetUnlockValidIndex(i)
          if 0 < unlockIndex and self:CheckColorPaletteSkill(v.Skill) then
            local skillID = rule[unlockIndex].Skill
            local chainInfo = ChainSkillStageInfo:New(skillID, i)
            table.insert(retList, chainInfo)
          end
        end
      end
    end
  end
  return retList
end

function SkillInfoComponent:CheckColorPaletteSkill(skillID)
  local configService = self._entity._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, self._entity)
  if skillConfigData and skillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
    local colorPaletteComponent = self._entity:ColorPalette()
    if colorPaletteComponent then
      return colorPaletteComponent:IsSatisfy()
    end
  end
  return true
end

function SkillInfoComponent:_GetChainSkillConfigIDListInBuffOverlay(chain)
  local retList = {}
  if self._buffOverlayChainSkillStepIndexTb then
    local overlayTb = self._buffOverlayChainSkillStepIndexTb
    if overlayTb then
      local len = #overlayTb
      for i = 1, len do
        local v = overlayTb[i]
        if chain >= v.Chain then
          local useIndex = v.OriChainSkillIndex
          local skillID = self:_GetOriChainSkillConfigInfoListByIndex(useIndex)
          if skillID and 0 < skillID then
            local chainInfo = ChainSkillStageInfo:New(skillID, useIndex)
            table.insert(retList, chainInfo)
          end
        end
      end
    end
  end
  return retList
end

function SkillInfoComponent:_GetOriChainSkillConfigInfoListByIndex(index)
  local rule = self._chainSkillIDSelector:GetRule()
  if rule then
    local len = #rule
    for i = 1, len do
      local v = rule[i]
      if i == index then
        return v.Skill, v.Chain
      end
    end
  end
  return 0, 0
end

function SkillInfoComponent:GetMaxChainSkillID()
  local rule = self._chainSkillIDSelector:GetRule()
  if rule then
    return rule[#rule].Skill
  end
  return 0
end

function Entity:SkillInfo()
  return self:GetComponent(self.WEComponentsEnum.SkillInfo)
end

function Entity:HasSkillInfo()
  return self:HasComponent(self.WEComponentsEnum.SkillInfo)
end

function Entity:AddSkillInfo(normal_skill_config_id, chain_skill_config_id, super_skill_config_id, extra_active_skill_id_list, variant_skill_info)
  local index = self.WEComponentsEnum.SkillInfo
  local component = SkillInfoComponent:New(normal_skill_config_id, chain_skill_config_id, super_skill_config_id, extra_active_skill_id_list, variant_skill_info)
  self:AddComponent(index, component)
end

function Entity:ReplaceSkillInfo(normal_skill_config_id, chain_skill_config_id, super_skill_config_id, extra_active_skill_id_list, variant_skill_info)
  local index = self.WEComponentsEnum.SkillInfo
  local component = SkillInfoComponent:New(normal_skill_config_id, chain_skill_config_id, super_skill_config_id, extra_active_skill_id_list, variant_skill_info)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveSkillInfo()
  if self:HasSkillInfo() then
    self:RemoveComponent(self.WEComponentsEnum.SkillInfo)
  end
end
