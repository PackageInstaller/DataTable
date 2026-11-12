local PlayerTalentData = class("PlayerTalentData")
local TimerManager = require("GameCore.Timer.TimerManager")

function PlayerTalentData:Init()
  self._tbCharTalentGroup = {}
  self._tbCharTalentNode = {}
  self._tbCharEnhancedSkill = {}
  self._tbCharEnhancedPotential = {}
  self._tbCharFateTalent = {}
  self._tbLimitedTrialTalentNode = {}
  self._tbLimitedTrialEnhancedSkill = {}
  self._tbLimitedTrialEnhancedPotential = {}
  self._tbLimitedTrialFateTalent = {}
  self._tbTalentBgIndex = {}
  self:ProcessTableData()
end

function PlayerTalentData:ProcessTableData()
  local function func_ForEach_Group(mapData)
    CacheTable.SetField("_TalentGroup", mapData.CharId, mapData.Id, mapData)
  end
  
  ForEachTableLine(DataTable.TalentGroup, func_ForEach_Group)
  
  local function func_ForEach_Line(mapData)
    CacheTable.SetField("_Talent", mapData.GroupId, mapData.Id, mapData)
    local nCharId = ConfigTable.GetData("TalentGroup", mapData.GroupId).CharId
    CacheTable.SetField("_TalentByIndex", nCharId, mapData.Index, mapData)
  end
  
  ForEachTableLine(DataTable.Talent, func_ForEach_Line)
  self.FragmentsToChar = {}
  
  local function func_ForEach_Char(mapData)
    self.FragmentsToChar[mapData.FragmentsId] = mapData.Id
  end
  
  ForEachTableLine(DataTable.Character, func_ForEach_Char)
end

function PlayerTalentData:CreateNewTalentData(nCharId, tbActive)
  local tbActiveTalent = {}
  local nMaxNormalCount = 0
  local groupData = {}
  local nFirstGroup = 0
  local tbGroupCfg = CacheTable.GetData("_TalentGroup", nCharId)
  if not tbGroupCfg then
    printError("TalentGroup表找不到该角色" .. nCharId)
    tbGroupCfg = {}
  end
  for nGroupId, mapGroup in pairs(tbGroupCfg) do
    local mapCurGroup = groupData[nGroupId] or self:CreateTalentGroup(nGroupId)
    groupData[nGroupId] = mapCurGroup
    if mapGroup.PreGroup ~= 0 then
      local mapPreGroup = groupData[mapGroup.PreGroup]
      if not mapPreGroup then
        mapPreGroup = self:CreateTalentGroup(mapGroup.PreGroup)
        groupData[mapGroup.PreGroup] = mapPreGroup
      end
      mapPreGroup.nNext = nGroupId
    else
      nFirstGroup = nGroupId
    end
    nMaxNormalCount = nMaxNormalCount + mapGroup.NodeLimit
    local tbTalent = CacheTable.GetData("_Talent", nGroupId) or {}
    for _, v in pairs(tbTalent) do
      if v.Type == GameEnum.talentType.KeyNode then
        groupData[nGroupId].nKeyTalent = v.Id
        break
      end
    end
  end
  if type(tbActive) == "table" then
    for _, nTalentId in pairs(tbActive) do
      tbActiveTalent[nTalentId] = true
      local mapCfg = ConfigTable.GetData("Talent", nTalentId)
      local nType = mapCfg.Type
      if nType == GameEnum.talentType.OrdinaryNode then
        groupData[mapCfg.GroupId].nNormalCount = groupData[mapCfg.GroupId].nNormalCount + 1
      end
    end
  end
  local nAllCount = 0
  for _, v in pairs(groupData) do
    nAllCount = nAllCount + v.nNormalCount
  end
  local talentData = {
    nMaxNormalCount = nMaxNormalCount,
    nFirstGroup = nFirstGroup,
    tbActiveTalent = tbActiveTalent,
    nAllNormalCount = nAllCount
  }
  return talentData, groupData
end

function PlayerTalentData:CreateTalentGroup(nId)
  return {
    nId = nId,
    nNext = 0,
    nKeyTalent = 0,
    bLock = true,
    nNormalCount = 0
  }
end

function PlayerTalentData:UpdateTalentGroupLock(nCharId)
  local bPreGroupLock = false
  local bPreKeyLock = false
  local nGroupId = self._tbCharTalentNode[nCharId].nFirstGroup
  local mapCurGroup = self._tbCharTalentGroup[nCharId][nGroupId]
  while mapCurGroup do
    local nKeyTalent = mapCurGroup.nKeyTalent
    local bLock = bPreGroupLock or bPreKeyLock
    self._tbCharTalentGroup[nCharId][mapCurGroup.nId].bLock = bLock
    mapCurGroup = self._tbCharTalentGroup[nCharId][mapCurGroup.nNext]
    bPreKeyLock = not self._tbCharTalentNode[nCharId].tbActiveTalent[nKeyTalent]
    bPreGroupLock = bLock
  end
end

function PlayerTalentData:CreateEnhancedSkill(nCharId, tbTalentId)
  local charCfgData = ConfigTable.GetData_Character(nCharId)
  if not charCfgData then
    printError("Character表找不到该角色" .. nCharId)
    return {}
  end
  local mapSkill = {
    [charCfgData.NormalAtkId] = 0,
    [charCfgData.SkillId] = 0,
    [charCfgData.AssistSkillId] = 0,
    [charCfgData.UltimateId] = 0
  }
  for _, v in pairs(tbTalentId) do
    local mapCfg = ConfigTable.GetData("Talent", v)
    local nSkillId = mapCfg.EnhanceSkillId
    if 0 < nSkillId and mapSkill[nSkillId] then
      mapSkill[nSkillId] = mapSkill[nSkillId] + mapCfg.EnhanceSkillLevel
    end
  end
  return mapSkill
end

function PlayerTalentData:CreateEnhancedPotential(tbTalentId)
  local mapPotential = {}
  for _, v in pairs(tbTalentId) do
    local mapCfg = ConfigTable.GetData("Talent", v)
    local nPotentialId = mapCfg.EnhancePotentialId
    if 0 < nPotentialId then
      if not mapPotential[nPotentialId] then
        mapPotential[nPotentialId] = 0
      end
      mapPotential[nPotentialId] = mapPotential[nPotentialId] + mapCfg.EnhancePotentialLevel
    end
  end
  return mapPotential
end

function PlayerTalentData:CreateFateTalent(tbAllTalent)
  local nFateCount = 0
  local tbFateTypeTalent = {}
  for nIndex, v in pairs(tbAllTalent) do
    if v.Type == GameEnum.talentType.KeyNode and 0 < v.SubType then
      nFateCount = nFateCount + 1
      tbFateTypeTalent[v.SubType] = v.Id
    end
  end
  local tbFateTalent = {}
  for i = 1, nFateCount do
    local nId = tbFateTypeTalent[GameEnum.talentSubType["Fate" .. i]]
    tbFateTalent[i] = nId
  end
  return tbFateTalent
end

function PlayerTalentData:CacheTalentData(mapMsgData, nTalentResetTime)
  if self._tbCharTalentNode == nil then
    self._tbCharTalentNode = {}
  end
  if self._tbCharTalentGroup == nil then
    self._tbCharTalentGroup = {}
  end
  for _, mapCharInfo in ipairs(mapMsgData) do
    local nCharId = mapCharInfo.Tid
    local tbTalent = CacheTable.GetData("_TalentByIndex", nCharId)
    if tbTalent == nil then
      printError("Talent表找不到该角色" .. nCharId)
      tbTalent = {}
    end
    local tbActive = {}
    local tbNodes = UTILS.ParseByteString(mapCharInfo.TalentNodes)
    for nIndex, v in pairs(tbTalent) do
      local bActive = UTILS.IsBitSet(tbNodes, nIndex)
      if bActive then
        table.insert(tbActive, v.Id)
      end
    end
    local talentData, groupData = self:CreateNewTalentData(nCharId, tbActive)
    self._tbCharTalentNode[nCharId] = talentData
    self._tbCharTalentGroup[nCharId] = groupData
    self._tbCharEnhancedSkill[nCharId] = self:CreateEnhancedSkill(nCharId, tbActive)
    self._tbCharEnhancedPotential[nCharId] = self:CreateEnhancedPotential(tbActive)
    self._tbCharFateTalent[nCharId] = self:CreateFateTalent(tbTalent)
    self._tbTalentBgIndex[nCharId] = mapCharInfo.TalentBackground
    self:UpdateTalentGroupLock(nCharId)
  end
end

function PlayerTalentData:ResetTalentEnhanceLevel(nCharId, mapCfg)
  local nSkillId = mapCfg.EnhanceSkillId
  if 0 < nSkillId and self._tbCharEnhancedSkill[nCharId][nSkillId] then
    self._tbCharEnhancedSkill[nCharId][nSkillId] = self._tbCharEnhancedSkill[nCharId][nSkillId] - mapCfg.EnhanceSkillLevel
  end
  local nPotentialId = mapCfg.EnhancePotentialId
  if 0 < nPotentialId and self._tbCharEnhancedPotential[nCharId][nPotentialId] then
    self._tbCharEnhancedPotential[nCharId][nPotentialId] = self._tbCharEnhancedPotential[nCharId][nPotentialId] - mapCfg.EnhancePotentialLevel
  end
end

function PlayerTalentData:ResetTalentNode(nCharId, nTalentId, bResetKey)
  self._tbCharTalentNode[nCharId].nAllNormalCount = self._tbCharTalentNode[nCharId].nAllNormalCount - 1
  local mapCfg = ConfigTable.GetData("Talent", nTalentId)
  local nGroupId = mapCfg.GroupId
  self._tbCharTalentGroup[nCharId][nGroupId].nNormalCount = self._tbCharTalentGroup[nCharId][nGroupId].nNormalCount - 1
  if self._tbCharTalentNode[nCharId].tbActiveTalent[nTalentId] then
    self._tbCharTalentNode[nCharId].tbActiveTalent[nTalentId] = false
    self:ResetTalentEnhanceLevel(nCharId, mapCfg)
  end
  if bResetKey then
    local tbTalent = CacheTable.GetData("_Talent", nGroupId)
    for k, v in pairs(tbTalent) do
      if v.Type == GameEnum.talentType.KeyNode and self._tbCharTalentNode[nCharId].tbActiveTalent[k] then
        self._tbCharTalentNode[nCharId].tbActiveTalent[k] = false
        self:ResetTalentEnhanceLevel(nCharId, v)
      end
    end
  end
  self:UpdateTalentGroupLock(nCharId)
end

function PlayerTalentData:ResetTalent(nCharId, nGroupId)
  local tbTalent = CacheTable.GetData("_Talent", nGroupId)
  self._tbCharTalentNode[nCharId].nAllNormalCount = self._tbCharTalentNode[nCharId].nAllNormalCount - self._tbCharTalentGroup[nCharId][nGroupId].nNormalCount
  self._tbCharTalentGroup[nCharId][nGroupId].nNormalCount = 0
  for nTalentId, v in pairs(tbTalent) do
    if self._tbCharTalentNode[nCharId].tbActiveTalent[nTalentId] then
      self._tbCharTalentNode[nCharId].tbActiveTalent[nTalentId] = false
      self:ResetTalentEnhanceLevel(nCharId, v)
    end
  end
  self:UpdateTalentGroupLock(nCharId)
end

function PlayerTalentData:ResetAllTalent(nCharId)
  local tbGroup = CacheTable.GetData("_TalentGroup", nCharId)
  self._tbCharTalentNode[nCharId].nAllNormalCount = 0
  self._tbCharTalentNode[nCharId].tbActiveTalent = {}
  for nId, _ in pairs(tbGroup) do
    self._tbCharTalentGroup[nCharId][nId].nNormalCount = 0
  end
  self:UpdateTalentGroupLock(nCharId)
  for k, _ in pairs(self._tbCharEnhancedSkill[nCharId]) do
    self._tbCharEnhancedSkill[nCharId][k] = 0
  end
  for k, _ in pairs(self._tbCharEnhancedPotential[nCharId]) do
    self._tbCharEnhancedPotential[nCharId][k] = 0
  end
end

function PlayerTalentData:UnlockTalent(nCharId, nTalentId)
  self._tbCharTalentNode[nCharId].tbActiveTalent[nTalentId] = true
  local mapCfg = ConfigTable.GetData("Talent", nTalentId)
  local nGroupId = mapCfg.GroupId
  if mapCfg.Type == GameEnum.talentType.KeyNode then
    self:UpdateTalentGroupLock(nCharId)
  else
    self._tbCharTalentGroup[nCharId][nGroupId].nNormalCount = self._tbCharTalentGroup[nCharId][nGroupId].nNormalCount + 1
    self._tbCharTalentNode[nCharId].nAllNormalCount = self._tbCharTalentNode[nCharId].nAllNormalCount + 1
  end
  local nSkillId = mapCfg.EnhanceSkillId
  if 0 < nSkillId then
    if not self._tbCharEnhancedSkill[nCharId][nSkillId] then
      self._tbCharEnhancedSkill[nCharId][nSkillId] = 0
    end
    self._tbCharEnhancedSkill[nCharId][nSkillId] = self._tbCharEnhancedSkill[nCharId][nSkillId] + mapCfg.EnhanceSkillLevel
  end
  local nPotentialId = mapCfg.EnhancePotentialId
  if 0 < nPotentialId then
    if not self._tbCharEnhancedPotential[nCharId][nPotentialId] then
      self._tbCharEnhancedPotential[nCharId][nPotentialId] = 0
    end
    self._tbCharEnhancedPotential[nCharId][nPotentialId] = self._tbCharEnhancedPotential[nCharId][nPotentialId] + mapCfg.EnhancePotentialLevel
  end
end

function PlayerTalentData:SetTimer(nTime)
  if nTime <= 0 then
    return
  end
  
  local function stopcd()
    if self.timercd ~= nil then
      self.timercd:Cancel(false)
      self.timercd = nil
    end
    self.nCd = 0
  end
  
  self.bTalentResetCD = true
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
    stopcd()
  end
  self.nCd = nTime
  self.timer = TimerManager.Add(1, nTime, self, function()
    self.bTalentResetCD = false
    stopcd()
  end, true, true, false)
  self.timercd = TimerManager.Add(0, 1, self, function()
    self.nCd = self.nCd - 1
  end, true, true, false)
end

function PlayerTalentData:GetTalentNode(nCharId)
  return self._tbCharTalentNode[nCharId]
end

function PlayerTalentData:GetTalentGroup(nCharId)
  return self._tbCharTalentGroup[nCharId]
end

function PlayerTalentData:GetTalentBg(nCharId)
  return self._tbTalentBgIndex[nCharId]
end

function PlayerTalentData:GetSortedTalentGroup(nCharId)
  local tbSorted = {}
  local nFirstGroup = self._tbCharTalentNode[nCharId].nFirstGroup
  local mapCurGroup = self._tbCharTalentGroup[nCharId][nFirstGroup]
  while mapCurGroup do
    table.insert(tbSorted, mapCurGroup)
    mapCurGroup = self._tbCharTalentGroup[nCharId][mapCurGroup.nNext]
  end
  return tbSorted
end

function PlayerTalentData:GetEnhancedSkill(nCharId)
  return self._tbCharEnhancedSkill[nCharId]
end

function PlayerTalentData:GetEnhancedPotential(nCharId)
  return self._tbCharEnhancedPotential[nCharId]
end

function PlayerTalentData:GetFateTalent(nCharId)
  local tbFate = {}
  if not self._tbCharFateTalent[nCharId] then
    return tbFate
  end
  for i, v in ipairs(self._tbCharFateTalent[nCharId]) do
    tbFate[i] = self:CheckTalentActive(nCharId, v)
  end
  return tbFate
end

function PlayerTalentData:GetFateTalentByTalentNodes(nCharId, tbActive)
  local tbFate = {}
  if not self._tbCharFateTalent[nCharId] then
    return tbFate
  end
  for i, v in ipairs(self._tbCharFateTalent[nCharId]) do
    tbFate[i] = table.indexof(tbActive, v) > 0
  end
  return tbFate
end

function PlayerTalentData:GetFragmentsToChar(nFragmentsId)
  return self.FragmentsToChar[nFragmentsId]
end

function PlayerTalentData:GetOverFragments(nCharId)
  local mapCharCfg = ConfigTable.GetData_Character(nCharId)
  local mapGradeCfg = ConfigTable.GetData("CharGrade", mapCharCfg.Grade)
  local mapChar = PlayerData.Char:GetCharDataByTid(nCharId)
  local nCompositeFragments = 0
  if mapChar == nil then
    nCompositeFragments = mapCharCfg.RecruitmentQty
  end
  local nNodeFragments = mapGradeCfg.FragmentsQty
  local mapTalent = self._tbCharTalentNode[nCharId]
  local nNodeCount = 0
  if mapTalent then
    nNodeCount = mapTalent.nMaxNormalCount - mapTalent.nAllNormalCount
  end
  local nHas = PlayerData.Item:GetItemCountByID(mapCharCfg.FragmentsId)
  local nOverflow = nHas - nNodeCount * nNodeFragments - nCompositeFragments
  return 0 < nOverflow and nOverflow or 0
end

function PlayerTalentData:GetRemainFragments(nCharId, nHas)
  local mapCharCfg = ConfigTable.GetData_Character(nCharId)
  local mapGradeCfg = ConfigTable.GetData("CharGrade", mapCharCfg.Grade)
  local nNodeFragments = mapGradeCfg.FragmentsQty
  local nMaxNormalCount = 0
  local tbGroupCfg = CacheTable.GetData("_TalentGroup", nCharId)
  if not tbGroupCfg then
    printError("TalentGroup表找不到该角色" .. nCharId)
    tbGroupCfg = {}
  end
  for _, mapGroup in pairs(tbGroupCfg) do
    nMaxNormalCount = nMaxNormalCount + mapGroup.NodeLimit
  end
  nHas = nHas or PlayerData.Item:GetItemCountByID(mapCharCfg.FragmentsId)
  local mapTalent = self:GetTalentNode(nCharId)
  local nCompositeFragments = mapCharCfg.RecruitmentQty
  local nRemain = mapTalent and (nMaxNormalCount - mapTalent.nAllNormalCount) * nNodeFragments - nHas or nMaxNormalCount * nNodeFragments + nCompositeFragments - nHas
  return nRemain, mapTalent == nil
end

function PlayerTalentData:CheckTalentActive(nCharId, nTalentId)
  if self._tbCharTalentNode[nCharId] and self._tbCharTalentNode[nCharId].tbActiveTalent[nTalentId] then
    return true
  end
  return false
end

function PlayerTalentData:GetTalentEffect(nCharId)
  local mapTalent = self._tbCharTalentNode[nCharId]
  local tbEffect = {}
  if mapTalent then
    for nTalentId, bActive in pairs(mapTalent.tbActiveTalent) do
      if bActive then
        local mapCfg = ConfigTable.GetData("Talent", nTalentId)
        for _, nEffectId in pairs(mapCfg.EffectId) do
          table.insert(tbEffect, nEffectId)
        end
      end
    end
  end
  return tbEffect
end

function PlayerTalentData:GetTalentAttributeDesc(nTalentId)
  local mapCfg = ConfigTable.GetData("Talent", nTalentId)
  local tbDesc = {}
  for _, nEffectId in pairs(mapCfg.EffectId) do
    local configEffect = ConfigTable.GetData_Effect(nEffectId)
    local config = ConfigTable.GetData("EffectValue", nEffectId)
    local bAttrFix = config.EffectType == GameEnum.effectType.ATTR_FIX or config.EffectType == GameEnum.effectType.PLAYER_ATTR_FIX
    if bAttrFix and configEffect.Trigger == GameEnum.trigger.NOTHING then
      local nEffectDescId = GameEnum.effectType.ATTR_FIX * 10000 + config.EffectTypeFirstSubtype * 10 + config.EffectTypeSecondSubtype
      local configDesc = ConfigTable.GetData("EffectDesc", nEffectDescId)
      local nValue = tonumber(config.EffectTypeParam1) or 0
      table.insert(tbDesc, {nEftDescId = nEffectDescId, nValueNum = nValue})
    end
  end
  return tbDesc
end

function PlayerTalentData:UpdateAllCharTalentRedDot()
  for charId, v in pairs(self._tbCharTalentNode) do
    self:UpdateCharTalentRedDot(charId)
  end
end

function PlayerTalentData:UpdateCharTalentRedDotByItem(mapChange)
  for _, v in ipairs(mapChange) do
    local charId = self.FragmentsToChar[v.Tid]
    if charId then
      self:UpdateCharTalentRedDot(charId)
    end
  end
end

function PlayerTalentData:UpdateCharTalentRedDot(nCharId)
  local mapTalent = self._tbCharTalentNode[nCharId]
  if not mapTalent then
    return
  end
  local bValid = false
  if mapTalent.nMaxNormalCount > mapTalent.nAllNormalCount then
    local mapCharCfg = ConfigTable.GetData_Character(nCharId)
    local mapGradeCfg = ConfigTable.GetData("CharGrade", mapCharCfg.Grade)
    local nFragmentCount = PlayerData.Item:GetItemCountByID(mapCharCfg.FragmentsId)
    if nFragmentCount >= mapGradeCfg.FragmentsQty then
      bValid = true
    end
  end
  RedDotManager.SetValid(RedDotDefine.Role_Talent, nCharId, bValid)
end

function PlayerTalentData:SendTalentUnlockReq(nCharId, nTalentId, callback)
  local msgData = {Value = nTalentId}
  
  local function successCallback(_, mapMainData)
    local bKey = false
    if mapMainData.TalentId and mapMainData.TalentId > 0 then
      self:UnlockTalent(nCharId, mapMainData.TalentId)
      bKey = true
      local mapCfg = ConfigTable.GetData("Talent", nTalentId)
      if mapCfg then
        local mapGroup = ConfigTable.GetData("TalentGroup", mapCfg.GroupId)
        if mapGroup then
          self._tbTalentBgIndex[nCharId] = mapGroup.Background
        end
      end
    end
    self:UnlockTalent(nCharId, nTalentId)
    self:UpdateCharTalentRedDot(nCharId)
    callback(bKey)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.talent_unlock_req, msgData, nil, successCallback)
end

function PlayerTalentData:SendTalentResetReq(nCharId, nGroupId, callback)
  if self.bTalentResetCD then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("CharTalent_CD"), self.nCd))
    return
  end
  local msgData = {CharId = nCharId, GroupId = nGroupId}
  
  local function successCallback(_, mapMainData)
    self:SetTimer(ConfigTable.GetConfigNumber("TalentResetTimeInterval") * 60)
    if nGroupId == 0 then
      self:ResetAllTalent(nCharId)
    else
      self:ResetTalent(nCharId, nGroupId)
    end
    self:UpdateCharTalentRedDot(nCharId)
    UTILS.OpenReceiveByChangeInfo(mapMainData, nil, ConfigTable.GetUIText("CharTalent_ResetReceiveTip"))
    callback()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.talent_reset_req, msgData, nil, successCallback)
end

function PlayerTalentData:SendTalentNodeResetReq(nCharId, nId, callback)
  local msgData = {Value = nId}
  
  local function successCallback(_, mapMainData)
    self:ResetTalentNode(nCharId, nId, mapMainData.ResetKeyNode)
    self:UpdateCharTalentRedDot(nCharId)
    UTILS.OpenReceiveByChangeInfo(mapMainData.Change, callback, ConfigTable.GetUIText("CharTalent_ResetReceiveTip"))
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.talent_node_reset_req, msgData, nil, successCallback)
end

function PlayerTalentData:SendTalentBackgroundSetReq(nCharId, nGroupId, callback)
  local msgData = {GroupId = nGroupId, CharId = nCharId}
  if nGroupId ~= 0 then
    msgData.CharId = 0
  end
  
  local function successCallback(_, mapMainData)
    if nGroupId == 0 then
      self._tbTalentBgIndex[nCharId] = 0
    else
      local mapGroup = ConfigTable.GetData("TalentGroup", nGroupId)
      if mapGroup then
        self._tbTalentBgIndex[nCharId] = mapGroup.Background
      end
    end
    callback()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.talent_background_set_req, msgData, nil, successCallback)
end

function PlayerTalentData:SendTalentGroupUnlockSetReq(nCharId, nGroupId, callback)
  local msgData = {Value = nGroupId}
  
  local function successCallback(_, mapMainData)
    local mapGroup = ConfigTable.GetData("TalentGroup", nGroupId)
    if mapGroup then
      self._tbTalentBgIndex[nCharId] = mapGroup.Background
    end
    for _, v in pairs(mapMainData.Nodes) do
      self:UnlockTalent(nCharId, v)
    end
    self:UpdateCharTalentRedDot(nCharId)
    callback()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.talent_group_unlock_req, msgData, nil, successCallback)
end

function PlayerTalentData:CreateTrialData(tbTrialId)
  self._tbTrialTalentNode = {}
  self._tbTrialEnhancedSkill = {}
  self._tbTrialEnhancedPotential = {}
  self._tbTrialFateTalent = {}
  for _, nTrialId in ipairs(tbTrialId) do
    local mapCfg = ConfigTable.GetData("TrialCharacter", nTrialId)
    if mapCfg == nil then
      printError("体验角色数据没有找到：" .. nTrialId)
      return
    end
    local nCharId = mapCfg.CharId
    local tbActive = mapCfg.Talent
    self._tbTrialTalentNode[nTrialId] = {}
    for _, v in ipairs(tbActive) do
      self._tbTrialTalentNode[nTrialId][v] = true
    end
    self._tbTrialEnhancedSkill[nTrialId] = self:CreateEnhancedSkill(nCharId, tbActive)
    self._tbTrialEnhancedPotential[nTrialId] = self:CreateEnhancedPotential(tbActive)
    local tbTalent = CacheTable.GetData("_TalentByIndex", nCharId)
    if tbTalent == nil then
      printError("Talent表找不到该角色" .. nCharId)
      tbTalent = {}
    end
    self._tbTrialFateTalent[nTrialId] = self:CreateFateTalent(tbTalent)
  end
end

function PlayerTalentData:DeleteTrialData()
  self._tbTrialTalentNode = {}
  self._tbTrialEnhancedSkill = {}
  self._tbTrialEnhancedPotential = {}
  self._tbTrialFateTalent = {}
end

function PlayerTalentData:GetTrialEnhancedSkill(nTrialId)
  return self._tbTrialEnhancedSkill[nTrialId]
end

function PlayerTalentData:GetTrialEnhancedPotential(nTrialId)
  return self._tbTrialEnhancedPotential[nTrialId]
end

function PlayerTalentData:GetTrialFateTalent(nTrialId)
  local tbFate = {}
  if not self._tbTrialFateTalent[nTrialId] then
    return tbFate
  end
  for i, v in ipairs(self._tbTrialFateTalent[nTrialId]) do
    if self._tbTrialTalentNode[nTrialId] and self._tbTrialTalentNode[nTrialId][v] then
      tbFate[i] = true
    else
      tbFate[i] = false
    end
  end
  return tbFate
end

function PlayerTalentData:CreateLimitedTrialData(tbTrialId)
  for _, nTrialId in ipairs(tbTrialId) do
    local mapCfg = ConfigTable.GetData("TrialCharacter", nTrialId)
    if mapCfg == nil then
      printError("限时试用角色数据没有找到：" .. nTrialId)
      return
    end
    local nCharId = mapCfg.CharId
    local tbActive = mapCfg.Talent
    self._tbLimitedTrialTalentNode[nTrialId] = {}
    for _, v in ipairs(tbActive) do
      self._tbLimitedTrialTalentNode[nTrialId][v] = true
    end
    self._tbLimitedTrialEnhancedSkill[nTrialId] = self:CreateEnhancedSkill(nCharId, tbActive)
    self._tbLimitedTrialEnhancedPotential[nTrialId] = self:CreateEnhancedPotential(tbActive)
    local tbTalent = CacheTable.GetData("_TalentByIndex", nCharId)
    if tbTalent == nil then
      printError("Talent表找不到该角色" .. nCharId)
      tbTalent = {}
    end
    self._tbLimitedTrialFateTalent[nTrialId] = self:CreateFateTalent(tbTalent)
  end
end

function PlayerTalentData:DeleteLimitedTrialData()
  self._tbLimitedTrialTalentNode = {}
  self._tbLimitedTrialEnhancedSkill = {}
  self._tbLimitedTrialEnhancedPotential = {}
  self._tbLimitedTrialFateTalent = {}
end

function PlayerTalentData:GetLimitedTrialEnhancedSkill(nTrialId)
  return self._tbLimitedTrialEnhancedSkill[nTrialId]
end

function PlayerTalentData:GetLimitedTrialEnhancedPotential(nTrialId)
  return self._tbLimitedTrialEnhancedPotential[nTrialId]
end

function PlayerTalentData:GetLimitedTrialFateTalent(nTrialId)
  local tbFate = {}
  if not self._tbLimitedTrialFateTalent[nTrialId] then
    return tbFate
  end
  for i, v in ipairs(self._tbLimitedTrialFateTalent[nTrialId]) do
    if self._tbLimitedTrialTalentNode[nTrialId] and self._tbLimitedTrialTalentNode[nTrialId][v] then
      tbFate[i] = true
    else
      tbFate[i] = false
    end
  end
  return tbFate
end

function PlayerTalentData:GetLimitedTrialTalentEffect(nTrialId)
  local mapTalent = self._tbLimitedTrialTalentNode[nTrialId]
  local tbEffect = {}
  if mapTalent then
    for nTalentId, bActive in pairs(mapTalent) do
      if bActive then
        local mapCfg = ConfigTable.GetData("Talent", nTalentId)
        for _, nEffectId in pairs(mapCfg.EffectId) do
          table.insert(tbEffect, nEffectId)
        end
      end
    end
  end
  return tbEffect
end

function PlayerTalentData:GetTrialTalentEffect(nTrialId)
  local mapTalent = self._tbTrialTalentNode[nTrialId]
  local tbEffect = {}
  if mapTalent then
    for nTalentId, bActive in pairs(mapTalent) do
      if bActive then
        local mapCfg = ConfigTable.GetData("Talent", nTalentId)
        for _, nEffectId in pairs(mapCfg.EffectId) do
          table.insert(tbEffect, nEffectId)
        end
      end
    end
  end
  return tbEffect
end

return PlayerTalentData
