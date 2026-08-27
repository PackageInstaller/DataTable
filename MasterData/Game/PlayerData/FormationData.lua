local FormationData = class("FormationData")
local CSTUtil = require("Game.CommanderSkill.CSTUtil")

function FormationData:ctor()
end

function FormationData.FromUserData(userFormation)
  local formation = FormationData.New()
  formation.id = userFormation.id
  formation.data = userFormation.data
  formation.name = userFormation.name
  formation.tree = userFormation.tree
  formation.commandTrees = userFormation.commandTrees
  for cstId, data in pairs(formation.commandTrees) do
    if data.id ~= cstId then
      error("非法的指挥官技能树数据! id不匹配 返回默认数据")
      return FormationData.CreateDefault(userFormation.id)
    end
  end
  formation.fairyUID = userFormation.fairyUid
  return formation
end

function FormationData.FromCustomData(id, data, cstId, csList)
  local formation = FormationData.New()
  formation.id = id
  formation.data = data
  formation.name = nil
  formation.userSkill = csList
  formation.commandTrees = {}
  if #csList == 0 then
    formation:__CreateDefaultCSTByFormation(cstId)
  else
    local skills = {}
    for _, skillId in pairs(csList) do
      table.insert(skills, {
        skillId = skillId,
        replaced = false,
        lv = 1
      })
    end
    formation:ModifyCSTDataOrg({
      [id] = {id = cstId, skills = skills}
    }, cstId)
  end
  return formation
end

function FormationData.CreateDefault(id)
  local fmtHeroCount = ConfigData:GetFormationHeroCount()
  local data = {}
  for k, v in ipairs(ConfigData.game_config.first_formation) do
    if k > fmtHeroCount then
      break
    end
    table.insert(data, v)
  end
  local formation = FormationData.New()
  formation.id = id
  formation.data = data
  local isCSUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  if isCSUnlock then
    formation:__CreateDefaultCSTByFormation()
  end
  return formation
end

function FormationData.Create(id)
  local formation = FormationData.New()
  formation.id = id
  formation.data = {}
  local isCSUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  if isCSUnlock then
    formation:__CreateDefaultCSTByFormation()
  end
  return formation
end

function FormationData.CreateDefultCST(formId)
  local formation = PlayerDataCenter.formationDic[formId]
  formation:__CreateDefaultCSTByFormation()
end

function FormationData:CopyCST(otherFmtData)
  if otherFmtData.commandTrees ~= nil then
    self.commandTrees = table.deepCopy(otherFmtData.commandTrees)
    self.tree = otherFmtData.tree
  end
end

function FormationData:RegularFairyCSTSkill()
  local fairyReplaceSkillDic = self:GetFmtFairyReplaceCSTSkillDic() or {}
  if self.commandTrees == nil then
    return
  end
  for _, cstSavingData in pairs(self.commandTrees) do
    for _, e in pairs(cstSavingData.skills) do
      if e.replaced then
        if not table.contain(fairyReplaceSkillDic, e.skillId) then
          local sSkillId = ConfigData.fairy_skill.repalced2OrgDic[e.skillId]
          e.replaced = nil
          e.skillId = sSkillId
        end
      elseif fairyReplaceSkillDic[e.skillId] ~= nil then
        e.replaced = true
        e.skillId = fairyReplaceSkillDic[e.skillId]
      end
    end
  end
end

function FormationData:IsIllegalCST(change2Default)
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  if not isUnlock then
    return false
  end
  local illegalMark = false
  local cstSavingData, cstId
  if self.commandTrees ~= nil then
    cstSavingData = self.commandTrees[self.tree]
  end
  if cstSavingData == nil then
    illegalMark = true
  elseif type(cstSavingData) ~= "table" then
    illegalMark = true
  else
    cstId = cstSavingData.id
  end
  
  local function IsDefaultUnlock(cstId, slot)
    local defaultSkillId = ConfigData.commander_skill_unlock.slotDefaultSkillIdDic[cstId][slot]
    if defaultSkillId == nil then
      return false
    end
    return CSTUtil.IsCSTSkillUnlock(defaultSkillId), defaultSkillId
  end
  
  if not illegalMark then
    for _, skillElem in ipairs(cstSavingData.skills) do
      local realSkillId = skillElem.skillId
      local cstSkillId = ConfigData.commander_skill_unlock.realSkillId2CSTSIdDic[realSkillId]
      local isUnlock = CSTUtil.IsCSTSkillUnlock(cstSkillId)
      if not isUnlock then
        illegalMark = true
        break
      end
    end
  end
  if not illegalMark then
    local usedSlotDic = {}
    for key, skillElem in pairs(cstSavingData.skills) do
      local realSkillId = skillElem.skillId
      local cstSkillId = ConfigData.commander_skill_unlock.realSkillId2CSTSIdDic[realSkillId]
      local skillCfg = ConfigData.commander_skill_unlock[cstId][cstSkillId]
      usedSlotDic[skillCfg.place] = true
    end
    for slot, _ in pairs(ConfigData.commander_skill_unlock.slotDefaultSkillIdDic[cstId]) do
      if not usedSlotDic[slot] then
        local isUnlock = IsDefaultUnlock(cstId, slot)
        if isUnlock then
          illegalMark = true
          break
        end
      end
    end
  end
  if not illegalMark then
    return false
  end
  if change2Default then
    if cstSavingData == nil then
      self:__CreateDefaultCSTByFormation()
    else
      local usedSlotDic = {}
      for key, skillElem in pairs(cstSavingData.skills) do
        local realSkillId = skillElem.skillId
        local cstSkillId = ConfigData.commander_skill_unlock.realSkillId2CSTSIdDic[realSkillId]
        local skillCfg = ConfigData.commander_skill_unlock[cstId][cstSkillId]
        usedSlotDic[skillCfg.place] = true
      end
      for slotIndex = 1, 3 do
        if not usedSlotDic[slotIndex] then
          local isUnlock, defaultSkillId = IsDefaultUnlock(cstId, slotIndex)
          if isUnlock then
            local realSkillId = ConfigData.commander_skill_unlock[cstId][defaultSkillId].skill_id
            local replaced = ConfigData.fairy_skill.repalced2OrgDic[defaultSkillId] ~= nil
            table.insert(cstSavingData.skills, {
              skillId = realSkillId,
              replaced = replaced,
              lv = 1
            })
          end
        end
      end
    end
  end
  return true
end

function FormationData:__CreateDefaultCSTByFormation(customDefaultTreeId)
  local defaultTreeId = customDefaultTreeId or ConfigData.game_config.FormationDefaultCommanderSkillTree
  if self.commandTrees == nil then
    self.commandTrees = {}
  end
  self.commandTrees[defaultTreeId] = CSTUtil.GetDefaultSavingData(defaultTreeId)
  self.tree = defaultTreeId
  if self.id == 0 then
    return
  end
  NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill):CS_COMMANDSKILL_SaveFromFormation(self)
end

function FormationData:GetFmtCSTData(treeId)
  if treeId == nil then
    treeId = self:GetFmtCSTDataCurId()
  end
  local cstSavingData = self.commandTrees[treeId]
  if cstSavingData == nil then
    self:__CreateDefaultCSTByFormation(treeId)
    cstSavingData = self.commandTrees[treeId]
  end
  return cstSavingData
end

function FormationData:GetFmtCSTDatDic()
  return self.commandTrees
end

function FormationData:GetFmtCSTDataCurId()
  return self.tree or ConfigData.game_config.FormationDefaultCommanderSkillTree
end

function FormationData:ModifyCSTData(cstDataList, selectedTreeId)
  for _, CSTData in pairs(cstDataList) do
    local savingData = CSTData:GetCSTSavingData()
    local cstId = CSTData:GetCSTTreeId()
    self.commandTrees[cstId] = savingData
  end
  self.tree = selectedTreeId
end

function FormationData:ModifyCSTDataOrg(savingDataList, selectedTreeId)
  for _, savingData in pairs(savingDataList) do
    local cstId = savingData.id
    self.commandTrees[cstId] = savingData
  end
  self.tree = selectedTreeId
end

function FormationData:ModifyFormationData(formationData, newHeroDic)
  if formationData ~= nil then
    self:CleanFormation()
    for index, heroId in pairs(formationData:GetFormationHeroDic(true)) do
      self:SetHero2Formation(index, heroId)
    end
    self.isHaveSupport = formationData.isHaveSupport
    self.suooprtHeroData = formationData.suooprtHeroData
    self.__suooprtHeroData = formationData.__suooprtHeroData
    self.isHaveOfficialSupport = formationData.isHaveOfficialSupport
    self.officialSuppotDic = formationData.officialSuppotDic
    self:SetFmtFairyUID(formationData:GetFmtFairyUID())
  elseif newHeroDic ~= nil then
    self:CleanFormation()
    for index, heroId in pairs(newHeroDic) do
      self:SetHero2Formation(index, heroId)
    end
  end
end

function FormationData:SetHero2Formation(index, heroId)
  self:ClearFormationIdx(index)
  self.data[index] = heroId
end

function FormationData:ClearFormationIdx(index)
  if self.isHaveSupport and self.suooprtHeroData.formIdx == index then
    self:CleanSupportData()
  end
  if self.isHaveOfficialSupport and self.officialSuppotDic[index] ~= nil then
    self.officialSuppotDic[index] = nil
    if table.IsEmptyTable(self.officialSuppotDic) then
      self:CleanOfficialSupportData()
    end
  end
  self.data[index] = nil
end

function FormationData:Exchange2Hero(index1, index2)
  local function exchangeNN(index1, index2)
    self.data[index2], self.data[index1] = self.data[index1], self.data[index2]
  end
  
  local function exchangeSN(supportIndex, normalIndex)
    self.data[supportIndex] = self.data[normalIndex]
    self.data[normalIndex] = nil
    self.suooprtHeroData.formIdx = normalIndex
  end
  
  local function exchangeNO(officialIndex, normalIndex)
    self.data[officialIndex] = self.data[normalIndex]
    self.data[normalIndex] = nil
    self.officialSuppotDic[normalIndex] = self.officialSuppotDic[officialIndex]
    self.officialSuppotDic[officialIndex] = nil
  end
  
  local function exchangeSO(supportIndex, officialIndex)
    self.officialSuppotDic[supportIndex] = self.officialSuppotDic[officialIndex]
    self.officialSuppotDic[officialIndex] = nil
    self.suooprtHeroData.formIdx = officialIndex
  end
  
  local function exchangeOO(index1, index2)
    self.officialSuppotDic[index2], self.officialSuppotDic[index1] = self.officialSuppotDic[index1], self.officialSuppotDic[index2]
  end
  
  if self.isHaveSupport then
    if self.suooprtHeroData.formIdx == index1 then
      if self.data[index2] ~= nil then
        exchangeSN(index1, index2)
      elseif self.isHaveOfficialSupport and self.officialSuppotDic[index2] ~= nil then
        exchangeSO(index1, index2)
      else
        exchangeSN(index1, index2)
      end
      return
    end
    if self.suooprtHeroData.formIdx == index2 then
      if self.data[index1] ~= nil then
        exchangeSN(index2, index1)
      elseif self.isHaveOfficialSupport and self.officialSuppotDic[index1] ~= nil then
        exchangeSO(index2, index1)
      else
        exchangeSN(index2, index1)
      end
      return
    end
  end
  if self.isHaveOfficialSupport then
    if self.officialSuppotDic[index1] ~= nil and self.officialSuppotDic[index2] then
      exchangeOO(index1, index2)
      return
    else
      if self.officialSuppotDic[index1] ~= nil then
        exchangeNO(index1, index2)
        return
      end
      if self.officialSuppotDic[index2] ~= nil then
        exchangeNO(index2, index1)
        return
      end
    end
  end
  exchangeNN(index1, index2)
end

function FormationData:CleanFormation()
  self:CleanSupportData()
  self:CleanOfficialSupportData()
  self:SetFmtFairyUID(nil)
  self.data = {}
end

function FormationData:GetFormationHeroDic(isNotNeedExtra)
  if self._fixedHeroIdList ~= nil and not isNotNeedExtra then
    local data = {}
    for key, value in pairs(self._fixedHeroIdList) do
      data[key] = value
    end
    for key, value in pairs(self.data) do
      data[key] = value
    end
    return data
  end
  if not isNotNeedExtra then
    local data = {}
    for key, value in pairs(self.data) do
      data[key] = value
    end
    data = self:_GetExcludeHeroList(data)
    if self.isHaveSupport then
      data[self.suooprtHeroData.formIdx] = self.suooprtHeroData.heroId
    end
    if self.isHaveOfficialSupport then
      for formIdx, officialSuppotData in pairs(self.officialSuppotDic) do
        data[formIdx] = officialSuppotData.heroId
      end
    end
    return data
  end
  return self:_GetExcludeHeroList(self.data)
end

function FormationData:_GetExcludeHeroList(heroIdxDic)
  if self._excludeHeroIdDic == nil then
    return heroIdxDic
  end
  local data = {}
  for idx, heroId in pairs(heroIdxDic) do
    if self._excludeHeroIdDic[heroId] == nil then
      data[idx] = heroId
    end
  end
  return data
end

function FormationData:GetFormationHeroData(index)
  local heroId
  if self.isHaveSupport and self.suooprtHeroData.formIdx == index then
    return self.__suooprtHeroData
  elseif self.isHaveOfficialSupport and self.officialSuppotDic[index] ~= nil then
    return self.officialSuppotDic[index].o_heroData
  else
    heroId = self.data[index]
  end
  if heroId == nil then
    if self._fixedHeroList ~= nil then
      return self._fixedHeroList[index]
    end
    return nil
  end
  if self._excludeHeroIdDic ~= nil and self._excludeHeroIdDic[heroId] ~= nil then
    return nil
  end
  if self.specialRuleGenerator ~= nil then
    return self.specialRuleGenerator:GetSpecificHeroData(heroId, self.specificHeroDataRuler)
  end
  return PlayerDataCenter:GetHeroData(heroId)
end

function FormationData:SetSupportHeroData(suooprtHeroData, index, useLast)
  self:ClearFormationIdx(index)
  if self.suooprtHeroData == nil then
    self.suooprtHeroData = {}
  end
  self.isHaveSupport = true
  self.__suooprtHeroData = suooprtHeroData
  self.suooprtHeroData.formIdx = index
  if not useLast then
    self.suooprtHeroData.uid = suooprtHeroData:GetUserInfo():GetUserUID()
  end
  self.suooprtHeroData.heroId = suooprtHeroData.dataId
end

function FormationData:GetSupportHeroData()
  if self.isHaveSupport then
    return self.suooprtHeroData
  end
end

function FormationData:GetRealSupportHeroData()
  if self.isHaveSupport then
    return self.__suooprtHeroData
  end
end

function FormationData:CleanSupportData()
  self.isHaveSupport = false
  self.__suooprtHeroData = nil
  self.suooprtHeroData = nil
end

function FormationData:SetOfficialSupportHeroData(officialSuppotData, index)
  self:ClearFormationIdx(index)
  if self.officialSuppotDic == nil then
    self.officialSuppotDic = {}
  end
  self.isHaveOfficialSupport = true
  local officialSupportCfgId = officialSuppotData:GetOfficialSupportCfgId()
  self.officialSuppotDic[index] = {
    o_heroData = officialSuppotData,
    heroId = officialSuppotData.dataId,
    cfgId = officialSupportCfgId
  }
end

function FormationData:CleanOfficialSupportData()
  self.isHaveOfficialSupport = false
  self.officialSuppotDic = nil
end

function FormationData:GetIsHaveOfficialSupport()
  return self.isHaveOfficialSupport
end

function FormationData:GetIsHaveOfficialSupportDic()
  return self.officialSuppotDic
end

function FormationData:GetFmtOfficeAssistData()
  if not self:GetIsHaveOfficialSupport() then
    return
  end
  local teamId
  local assistElem = {}
  local dic = self:GetIsHaveOfficialSupportDic()
  for fmtIdx, officialSuppotData in pairs(dic) do
    if teamId == nil then
      teamId = officialSuppotData.cfgId
    elseif teamId ~= officialSuppotData.cfgId then
      error("offical support team id not same, pls check")
    end
    table.insert(assistElem, {
      heroId = officialSuppotData.heroId,
      formIdx = fmtIdx
    })
  end
  return {teamId = teamId, assistElem = assistElem}
end

function FormationData:GetIsOnlyHaveSupportHero()
  if not self.isHaveSupport then
    return false
  end
  local count = 0
  for _, _ in pairs(self:GetFormationHeroDic()) do
    count = count + 1
    if 2 <= count then
      return false
    end
  end
  return true
end

function FormationData:SetFmtFixedHeroList(heroList, heroIdList)
  self._fixedHeroList = heroList
  self._fixedHeroIdList = heroIdList
end

function FormationData:ClearFmtFixedHero()
  self._fixedHeroList = nil
  self._fixedHeroIdList = nil
end

function FormationData:SetFmtExcludeHeroIdDic(excludeHeroIdDic)
  self._excludeHeroIdDic = excludeHeroIdDic
end

function FormationData:ClearFmtExcludeHeroIdDic()
  self._excludeHeroIdDic = nil
end

function FormationData:SetFmtFairyUID(fairyUID)
  self.fairyUID = fairyUID
end

function FormationData:GetFmtFairyUID()
  return self.fairyUID
end

function FormationData:SetFmtFakeFairyData(fakeFairyData)
  self.fakeFairyData = fakeFairyData
end

function FormationData:RegularFormationFairy()
  local fairyUID = self:GetFmtFairyUID()
  if fairyUID == nil or fairyUID == 0 then
    return false
  end
  local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  local fairyData = fairyCtrl:GetFairyDataByUID(fairyUID)
  if fairyData == nil then
    self.fairyUID = nil
    return true
  end
end

function FormationData:GetFmtFairyData()
  local fairyUID = self:GetFmtFairyUID()
  if fairyUID == nil or fairyUID == 0 then
    return nil
  end
  local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  if fairyCtrl == nil then
    return nil
  end
  local fairyData = fairyCtrl:GetFairyDataByUID(fairyUID)
  if fairyData == nil then
    return self.fakeFairyData
  end
  return fairyData
end

function FormationData:GetFmtFairyReplaceCSTSkillDic()
  local fairyData = self:GetFmtFairyData()
  if fairyData == nil then
    return nil
  end
  return fairyData:GetFairyReplacedCommanderSkill()
end

function FormationData:GetHeroDataInFmt(heroId)
  if PlayerDataCenter.heroDic[heroId] ~= nil then
    return PlayerDataCenter.heroDic[heroId]
  end
  if self.isHaveSupport and self.suooprtHeroData.heroId == heroId then
    return self.__suooprtHeroData
  end
  if self.isHaveOfficialSupport then
    for k, v in pairs(self.officialSuppotDic) do
      if v.heroId == heroId then
        return v.o_heroData
      end
    end
  end
  if self.specialRuleGenerator ~= nil then
    return self.specialRuleGenerator:GetSpecificHeroData(heroId, self.specificHeroDataRuler)
  end
  return nil
end

function FormationData:IsFixedHero(heroId)
  if self._fixedHeroList ~= nil then
    for k, v in pairs(self._fixedHeroList) do
      if v.dataId == heroId then
        return true
      end
    end
  end
  return false
end

function FormationData:DeepCopyFmtData()
  local fntData = DeepCopy(self)
  fntData.__suooprtHeroData = self.__suooprtHeroData
  return fntData
end

return FormationData
