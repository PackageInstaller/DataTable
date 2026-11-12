local RapidJson = require("rapidjson")
local LocalData = require("GameCore.Data.LocalData")
local CharacterAttrData = require("GameCore.Data.DataClass.CharacterAttrData")
local PlayerCharData = class("PlayerCharData")
local ConfigData = require("GameCore.Data.ConfigData")
local AttrConfig = require("GameCore.Common.AttrConfig")
local TimerManager = require("GameCore.Timer.TimerManager")

function PlayerCharData:Init()
  self._mapChar = nil
  self._mapTrialChar = {}
  self._mapLimitedTrialChar = {}
  if LocalData.GetLocalData("Char_", "CharPanel_IsSimpleDesc") == nil then
    local defaultValue = ConfigTable.GetConfigValue("SkillShowDetail")
    self.bCharPanel_IsSimpleDesc = defaultValue ~= "1"
  else
    self.bCharPanel_IsSimpleDesc = LocalData.GetLocalData("Char_", "CharPanel_IsSimpleDesc")
  end
  if LocalData.GetLocalData("Char_", "TipsPanel_IsSimpleDesc") == nil then
    local defaultValue = ConfigTable.GetConfigValue("SkillShowDetail")
    self.bTipsPanel_IsSimpleDesc = defaultValue ~= "1"
  else
    self.bTipsPanel_IsSimpleDesc = LocalData.GetLocalData("Char_", "TipsPanel_IsSimpleDesc")
  end
  self:ProcessTableData()
  self:ProcessCharExpItem()
end

function PlayerCharData:ProcessTableData()
  self._CharSkillUpgrade = {}
  
  local function func_ForEach_Node(mapLineData)
    if self._CharSkillUpgrade[mapLineData.Group] == nil then
      self._CharSkillUpgrade[mapLineData.Group] = {}
    end
    table.insert(self._CharSkillUpgrade[mapLineData.Group], {
      nId = mapLineData.Id,
      nReqCharAdvNum = mapLineData.AdvanceNum,
      nReqGold = mapLineData.GoldQty,
      tbReqItem = {
        {
          mapLineData.Tid1,
          mapLineData.Qty1
        },
        {
          mapLineData.Tid2,
          mapLineData.Qty2
        },
        {
          mapLineData.Tid3,
          mapLineData.Qty3
        },
        {
          mapLineData.Tid4,
          mapLineData.Qty4
        }
      }
    })
  end
  
  ForEachTableLine(DataTable.CharacterSkillUpgrade, func_ForEach_Node)
  for nGroupId, tbUpgradeReq in pairs(self._CharSkillUpgrade) do
    table.sort(self._CharSkillUpgrade[nGroupId], function(a, b)
      return a.nId < b.nId
    end)
  end
  
  local function func_ForEach_CharSkill(mapLineData)
    CacheTable.SetField("_TalentSkillAI", mapLineData.ActorId, mapLineData.TalentId, {
      NormalAtkId = mapLineData.NormalAtkId,
      DodgeId = mapLineData.DodgeId,
      SpecialSkillId = mapLineData.SpecialSkillId,
      UltimateId = mapLineData.UltimateId,
      aiId = mapLineData.AiId,
      SkillId = mapLineData.SkillId
    })
  end
  
  ForEachTableLine(DataTable.TalentSkillAI, func_ForEach_CharSkill)
  
  local function func_ForEach_EffectDesc(mapData)
    CacheTable.SetData("_AttributeDesc", mapData.Attribute, mapData)
    if nil ~= mapData.Attribute and "" ~= mapData.Attribute then
      CacheTable.SetData("_AttributeDescByType", mapData.TypeID, mapData)
    end
  end
  
  ForEachTableLine(DataTable.EffectDesc, func_ForEach_EffectDesc)
  
  local function foreachCG(mapData)
    if mapData.UnlockPlot ~= 0 then
      CacheTable.SetData("_CharacterCG", mapData.UnlockPlot, mapData.Id)
    end
  end
  
  ForEachTableLine(DataTable.CharacterCG, foreachCG)
  
  local function forEachAffinityLevel(mapData)
    CacheTable.SetField("_AffinityLevel", mapData.TemplateId, mapData.AffinityLevel, mapData)
  end
  
  ForEachTableLine(DataTable.AffinityLevel, forEachAffinityLevel)
  
  local function forEachRaritySequence(mapData)
    CacheTable.SetField("_CharRaritySequence", mapData.Grade, mapData.AdvanceLvl, mapData)
  end
  
  ForEachTableLine(DataTable.CharRaritySequence, forEachRaritySequence)
  self._tbArchiveUpdate = {}
  
  local function foreachCharArchive(mapData)
    local nContentId = mapData.RecordId
    local nCharId = mapData.CharacterId
    if self._tbArchiveUpdate[nCharId] == nil then
      self._tbArchiveUpdate[nCharId] = {}
    end
    local contentCfg = ConfigTable.GetData("CharacterArchiveContent", nContentId)
    if contentCfg ~= nil then
      self._tbArchiveUpdate[nCharId][nContentId] = {}
      self._tbArchiveUpdate[nCharId][nContentId].UpdateAff1 = contentCfg.UpdateAff1
      self._tbArchiveUpdate[nCharId][nContentId].UpdatePlot1 = contentCfg.UpdatePlot1
      self._tbArchiveUpdate[nCharId][nContentId].UpdateStory1 = contentCfg.UpdateStory1
      if contentCfg.UpdateContent1 ~= "" then
        local nValue = 0
        if contentCfg.UpdateAff1 == 0 then
          nValue = 1
        end
        if contentCfg.UpdatePlot1 == 0 then
          nValue = 2 | nValue
        end
        if contentCfg.UpdateStory1 == 0 then
          nValue = 4 | nValue
        end
        self._tbArchiveUpdate[nCharId][nContentId].nValue = nValue
      else
        self._tbArchiveUpdate[nCharId][nContentId].nValue = -1
      end
    end
  end
  
  ForEachTableLine(ConfigTable.Get("CharacterArchive"), foreachCharArchive)
  self._tbArchiveBaseUpdate = {}
  
  local function foreachCharArchiveBaseInfo(mapData)
    local nCharId = mapData.CharacterId
    if self._tbArchiveBaseUpdate[nCharId] == nil then
      self._tbArchiveBaseUpdate[nCharId] = {}
    end
    self._tbArchiveBaseUpdate[nCharId][mapData.Id] = {}
    self._tbArchiveBaseUpdate[nCharId][mapData.Id].UpdateAff1 = mapData.UpdateAff1
    self._tbArchiveBaseUpdate[nCharId][mapData.Id].UpdatePlot1 = mapData.UpdatePlot1
    self._tbArchiveBaseUpdate[nCharId][mapData.Id].UpdateStory1 = mapData.UpdateStory1
    if mapData.UpdateContent1 ~= "" then
      local nValue = 0
      if mapData.UpdateAff1 == 0 then
        nValue = 1
      end
      if mapData.UpdatePlot1 == 0 then
        nValue = 2 | nValue
      end
      if mapData.UpdateStory1 == 0 then
        nValue = 4 | nValue
      end
      self._tbArchiveBaseUpdate[nCharId][mapData.Id].nValue = nValue
    else
      self._tbArchiveBaseUpdate[nCharId][mapData.Id].nValue = -1
    end
  end
  
  ForEachTableLine(ConfigTable.Get("CharacterArchiveBaseInfo"), foreachCharArchiveBaseInfo)
  
  local function foreachPlot(mapData)
    if nil == CacheTable.GetData("_Plot", mapData.Char) then
      CacheTable.SetData("_Plot", mapData.Char, {})
    end
    CacheTable.InsertData("_Plot", mapData.Char, mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("Plot"), foreachPlot)
  self._tbCharPotential = {}
  
  local function foreachPotential(mapData)
    local nCharId = mapData.Id
    self._tbCharPotential[nCharId] = {}
    self._tbCharPotential[nCharId].master = {}
    self._tbCharPotential[nCharId].assist = {}
    
    local function addPotential(tbPotentialId, insertTb)
      for _, v in ipairs(tbPotentialId) do
        local mapCfg = ConfigTable.GetData("Potential", v)
        local mapItemCfg = ConfigTable.GetData("Item", v)
        if mapCfg ~= nil and mapItemCfg ~= nil then
          if insertTb[mapCfg.Build] == nil then
            insertTb[mapCfg.Build] = {}
          end
          local data = {
            nId = v,
            nSpecial = mapItemCfg.Stype == GameEnum.itemStype.SpecificPotential and 1 or 0,
            nRarity = mapItemCfg.Rarity
          }
          table.insert(insertTb[mapCfg.Build], data)
        end
      end
    end
    
    addPotential(mapData.MasterSpecificPotentialIds, self._tbCharPotential[nCharId].master)
    addPotential(mapData.AssistSpecificPotentialIds, self._tbCharPotential[nCharId].assist)
    addPotential(mapData.CommonPotentialIds, self._tbCharPotential[nCharId].master)
    addPotential(mapData.CommonPotentialIds, self._tbCharPotential[nCharId].assist)
    addPotential(mapData.MasterNormalPotentialIds, self._tbCharPotential[nCharId].master)
    addPotential(mapData.AssistNormalPotentialIds, self._tbCharPotential[nCharId].assist)
    for _, data in pairs(self._tbCharPotential[nCharId]) do
      for nType, list in pairs(data) do
        table.sort(list, function(a, b)
          if a.nSpecial == b.nSpecial then
            if a.nRarity == b.nRarity then
              return a.nId < b.nId
            end
            return a.nRarity < b.nRarity
          end
          return a.nSpecial > b.nSpecial
        end)
      end
    end
  end
  
  ForEachTableLine(ConfigTable.Get("CharPotential"), foreachPotential)
  self.tbHonorTitle = {}
  
  local function foreachHonorCharacter(mapData)
    if self.tbHonorTitle[mapData.CharId] == nil then
      self.tbHonorTitle[mapData.CharId] = {}
    end
    table.insert(self.tbHonorTitle[mapData.CharId], mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("HonorCharacter"), foreachHonorCharacter)
end

function PlayerCharData:ProcessCharExpItem()
  self.tbItemExp = {}
  
  local function foreachCharacterItemExp(mapData)
    table.insert(self.tbItemExp, {
      nItemId = mapData.ItemId,
      nExpValue = mapData.ExpValue
    })
  end
  
  ForEachTableLine(DataTable.CharItemExp, foreachCharacterItemExp)
  
  local function sort(a, b)
    return a.nExpValue > b.nExpValue
  end
  
  table.sort(self.tbItemExp, sort)
  for key, value in pairs(self.tbItemExp) do
  end
  self.goldperExp = ConfigTable.GetConfigNumber("CharUpgradeGoldPerExp") / 1000
end

function PlayerCharData:CreateNewChar(msgData)
  local charData = {}
  local nCharId = msgData.Tid
  local tbTempUseSkill = self.tbTempSaveCharSkill[tostring(nCharId)]
  if tbTempUseSkill == nil then
    self.tbTempSaveCharSkill[tostring(nCharId)] = {bBranch1 = false, bBranch2 = false}
    tbTempUseSkill = self.tbTempSaveCharSkill[tostring(nCharId)]
  end
  if msgData.AffinityQuests ~= nil and msgData.AffinityQuests.List ~= nil and #msgData.AffinityQuests.List > 0 then
    PlayerData.Quest:CacheAllQuest(msgData.AffinityQuests.List)
  end
  charData = {
    nId = nCharId,
    nRankExp = msgData.Exp,
    tbDatingEventIds = msgData.DatingEventIds,
    tbDatingEventRewardIds = msgData.DatingEventRewardIds,
    nFavor = msgData.Favor,
    nSkinId = msgData.Skin,
    nLevel = msgData.Level,
    nCreateTime = msgData.CreateTime,
    nAdvance = msgData.Advance,
    tbSkillLvs = msgData.SkillLvs,
    bUseSkillWhenActive_Branch1 = tbTempUseSkill.bBranch1,
    bUseSkillWhenActive_Branch2 = tbTempUseSkill.bBranch2,
    tbPlot = msgData.Plots,
    nAffinityExp = msgData.AffinityExp,
    nAffinityLevel = msgData.AffinityLevel,
    tbAffinityQuests = msgData.AffinityQuests,
    tbArchiveRewardIds = msgData.ArchiveRewardIds or {},
    bIsFavorite = msgData.IsFavorite
  }
  if msgData.DatingEventIds ~= nil and msgData.DatingEventRewardIds ~= nil then
    PlayerData.Dating:RefreshLimitedEventList(nCharId, msgData.DatingEventIds, msgData.DatingEventRewardIds)
  end
  self:InitCharArchiveContentUpdateRedDot(nCharId)
  return charData
end

function PlayerCharData:CacheCharacters(mapData)
  if self._mapChar == nil then
    self._mapChar = {}
  end
  local tb = decodeJson(LocalData.GetPlayerLocalData("TempSaveCharSkill"))
  if tb ~= nil then
    self.tbTempSaveCharSkill = tb
  else
    self.tbTempSaveCharSkill = {}
  end
  if mapData == nil then
    return
  end
  for _, mapCharInfo in ipairs(mapData) do
    local nCharId = mapCharInfo.Tid
    self._mapChar[nCharId] = self:CreateNewChar(mapCharInfo)
  end
  PlayerData.Talent:CacheTalentData(mapData)
  PlayerData.Equipment:CacheEquipmentData(mapData)
end

function PlayerCharData:GetCharUsedSkinId(nCharId)
  if self._mapChar[nCharId] == nil then
    return 0
  end
  return self._mapChar[nCharId].nSkinId
end

function PlayerCharData:GetCreateTime(nCharId)
  return self._mapChar[nCharId].nCreateTime
end

function PlayerCharData:GetSkillIds(nCharId)
  local tbSkillList = {}
  local charCfgData = ConfigTable.GetData_Character(nCharId)
  if charCfgData == nil then
    return tbSkillList
  end
  tbSkillList[1] = charCfgData.NormalAtkId
  tbSkillList[2] = charCfgData.SkillId
  tbSkillList[3] = charCfgData.AssistSkillId
  tbSkillList[4] = charCfgData.UltimateId
  return tbSkillList
end

function PlayerCharData:GetSkillLevel(nCharId)
  local mapTrialInfo
  for _, v in pairs(self._mapTrialChar) do
    if v.nId == nCharId then
      mapTrialInfo = v
      break
    end
  end
  local mapChar
  if mapTrialInfo then
    mapChar = mapTrialInfo
  else
    mapChar = self._mapChar[nCharId]
  end
  local tbList = {}
  tbList[GameEnum.skillSlotType.NORMAL] = mapChar and mapChar.tbSkillLvs[1] or 1
  tbList[GameEnum.skillSlotType.B] = mapChar and mapChar.tbSkillLvs[2] or 1
  tbList[GameEnum.skillSlotType.C] = mapChar and mapChar.tbSkillLvs[3] or 1
  tbList[GameEnum.skillSlotType.D] = mapChar and mapChar.tbSkillLvs[4] or 1
  return tbList
end

function PlayerCharData:GetTalentSkillId(nCharId)
  local charCfgData = ConfigTable.GetData_Character(nCharId)
  if nil ~= charCfgData then
    return charCfgData.TalentSkillId
  end
end

function PlayerCharData:GetUseSkillWhenActive(nCharId, nBranchIndex)
  local mapData = self._mapChar[nCharId]
  if nBranchIndex == nil then
    nBranchIndex = self:CalcCharBranchIndex(nCharId)
  end
  if nBranchIndex == 1 then
    return mapData.bUseSkillWhenActive_Branch1
  elseif nBranchIndex == 2 then
    return mapData.bUseSkillWhenActive_Branch2
  end
end

function PlayerCharData:SetUseSkillWhenActive(nCharId, nBranchIndex, bUse)
  local mapData = self._mapChar[nCharId]
  if nBranchIndex == 1 then
    mapData.bUseSkillWhenActive_Branch1 = bUse
    self.tbTempSaveCharSkill[tostring(nCharId)].bBranch1 = bUse
  elseif nBranchIndex == 2 then
    mapData.bUseSkillWhenActive_Branch2 = bUse
    self.tbTempSaveCharSkill[tostring(nCharId)].bBranch2 = bUse
  end
  LocalData.SetPlayerLocalData("TempSaveCharSkill", RapidJson.encode(self.tbTempSaveCharSkill))
end

function PlayerCharData:GetCharSkillUpgradeData(nCharId)
  local tbSkillList = {}
  local tbSkillIds = self:GetSkillIds(nCharId)
  local mapCfgData_Character = ConfigTable.GetData_Character(nCharId)
  if mapCfgData_Character == nil then
    return tbSkillList
  end
  local mapTalentEnhanceSkill = PlayerData.Talent:GetEnhancedSkill(nCharId)
  local mapEquipmentEnhanceSkill = PlayerData.Equipment:GetEnhancedSkill(nCharId)
  for i = 1, 4 do
    local nAdd = 0
    if mapTalentEnhanceSkill and mapTalentEnhanceSkill[tbSkillIds[i]] then
      nAdd = nAdd + mapTalentEnhanceSkill[tbSkillIds[i]]
    end
    if mapEquipmentEnhanceSkill and mapEquipmentEnhanceSkill[tbSkillIds[i]] then
      nAdd = nAdd + mapEquipmentEnhanceSkill[tbSkillIds[i]]
    end
    local skill = {}
    skill.nId = tbSkillIds[i]
    local nLv = 1
    if self._mapChar[nCharId] ~= nil and self._mapChar[nCharId].tbSkillLvs[i] ~= nil then
      nLv = self._mapChar[nCharId].tbSkillLvs[i]
    end
    skill.nLv = nLv
    skill.nAddLv = nAdd
    local nUpgradeGroup = mapCfgData_Character.SkillsUpgradeGroup[i]
    skill.nMaxLv = table.nums(self._CharSkillUpgrade[nUpgradeGroup])
    skill.mapReq = nLv + 1 > skill.nMaxLv and -1 or self._CharSkillUpgrade[nUpgradeGroup][nLv + 1]
    tbSkillList[i] = skill
  end
  return tbSkillList
end

function PlayerCharData:GetCharPotentialList(nCharId)
  return self._tbCharPotential[nCharId]
end

function PlayerCharData:GetCharEnhancedPotential(nCharId)
  local mapAddLevel = {}
  
  local function add(mapAdd)
    if not mapAdd then
      return
    end
    for nPotentialId, nAdd in pairs(mapAdd) do
      if not mapAddLevel[nPotentialId] then
        mapAddLevel[nPotentialId] = 0
      end
      mapAddLevel[nPotentialId] = mapAddLevel[nPotentialId] + nAdd
    end
  end
  
  local mapTalentAddLevel = PlayerData.Talent:GetEnhancedPotential(nCharId)
  local mapEquipmentAddLevel = PlayerData.Equipment:GetEnhancedPotential(nCharId)
  add(mapTalentAddLevel)
  add(mapEquipmentAddLevel)
  return mapAddLevel
end

function PlayerCharData:GetCharSkillMaxLevel(nCharId, nSlot)
  local maxLevel = 0
  local mapCfgData_Character = ConfigTable.GetData_Character(nCharId)
  if mapCfgData_Character == nil then
    return maxLevel
  end
  local nUpgradeGroup = mapCfgData_Character.SkillsUpgradeGroup[nSlot]
  if nil ~= nUpgradeGroup then
    maxLevel = table.nums(self._CharSkillUpgrade[nUpgradeGroup])
  end
  return maxLevel
end

function PlayerCharData:GetCharSkillAddedLevel(nCharId)
  local mapChar = self._mapChar[nCharId]
  if mapChar == nil then
    printError("没有该角色数据" .. nCharId)
    mapChar = {
      nLevel = 1,
      nAdvance = 0,
      tbSkillLvs = {
        1,
        1,
        1,
        1
      }
    }
  end
  local tbSkillLevel = {}
  local tbSkillIds = self:GetSkillIds(nCharId)
  local mapTalentEnhanceSkill = PlayerData.Talent:GetEnhancedSkill(nCharId)
  local mapEquipmentEnhanceSkill = PlayerData.Equipment:GetEnhancedSkill(nCharId)
  for i = 1, 4 do
    local nSkillId = tbSkillIds[i]
    local nAdd = 0
    if mapTalentEnhanceSkill and mapTalentEnhanceSkill[nSkillId] then
      nAdd = nAdd + mapTalentEnhanceSkill[nSkillId]
    end
    if mapEquipmentEnhanceSkill and mapEquipmentEnhanceSkill[nSkillId] then
      nAdd = nAdd + mapEquipmentEnhanceSkill[nSkillId]
    end
    local nLv = mapChar.tbSkillLvs[i] + nAdd
    table.insert(tbSkillLevel, nLv)
  end
  return tbSkillLevel
end

function PlayerCharData:GetTrialCharSkillAddedLevel(nTrialId)
  local mapChar = self._mapTrialChar[nTrialId]
  if mapChar == nil then
    printError("没有该角色数据" .. nTrialId)
    return {
      1,
      1,
      1,
      1
    }
  end
  local nCharId = mapChar.nId
  local tbSkillLevel = {}
  local tbSkillIds = self:GetSkillIds(nCharId)
  local mapTalentEnhanceSkill = PlayerData.Talent:GetTrialEnhancedSkill(nTrialId)
  for i = 1, 4 do
    local nSkillId = tbSkillIds[i]
    local nAdd = 0
    if mapTalentEnhanceSkill then
      nAdd = mapTalentEnhanceSkill[nSkillId]
    end
    local nLv = mapChar.tbSkillLvs[i] + nAdd
    table.insert(tbSkillLevel, nLv)
  end
  return tbSkillLevel
end

function PlayerCharData:EnterCharPlotAvg(nCharId, nPlotId, callback, bShowReward)
  local bGetReward = self:IsCharPlotFinish(nCharId, nPlotId)
  local mapPlot = ConfigTable.GetData("Plot", nPlotId)
  if mapPlot == nil then
    return
  end
  
  local function Callback()
    if not bGetReward then
      local function finishCallBack(mapMsgData, nCharId)
        if bShowReward then
          local tabEvent = {}
          
          table.insert(tabEvent, {
            "story_id",
            tostring(nPlotId)
          })
          local _skip = PlayerData.Avg.bSkip == true and "1" or "0"
          table.insert(tabEvent, {"is_skip", _skip})
          table.insert(tabEvent, {
            "role_id",
            tostring(PlayerData.Base._nPlayerId)
          })
          NovaAPI.UserEventUpload("character_favor_story", tabEvent)
          TimerManager.Add(1, 1.3, self, function()
            local function rewardFunc()
              local bHasReward = mapMsgData and mapMsgData.Props and #mapMsgData.Props > 0
              
              local tbItem = {}
              if bHasReward then
                local sRewardDisplay = mapPlot.Rewards
                local tbRewardDisplay = decodeJson(sRewardDisplay)
                for k, v in pairs(tbRewardDisplay) do
                  table.insert(tbItem, {
                    Tid = tonumber(k),
                    Qty = v,
                    rewardType = AllEnum.RewardType.First
                  })
                end
                UTILS.OpenReceiveByDisplayItem(tbItem, mapMsgData)
              end
            end
            
            if nil ~= CacheTable.GetData("_CharacterCG", mapPlot.Id) then
              local tbRewardList = {}
              table.insert(tbRewardList, {
                nId = CacheTable.GetData("_CharacterCG", mapPlot.Id),
                nCharId = nCharId,
                bNew = true,
                tbItemList = {},
                bCG = true,
                callBack = rewardFunc
              })
              EventManager.Hit(EventId.OpenPanel, PanelId.ReceiveSpecialReward, tbRewardList)
            else
              rewardFunc()
            end
          end, true, true)
        end
        if nil ~= callback then
          callback(nCharId)
        end
      end
      
      self:CharPlotFinish(nCharId, nPlotId, finishCallBack)
    elseif nil ~= callback then
      callback(nCharId)
    end
  end
  
  local mapData = {
    nType = AllEnum.StoryAvgType.Plot,
    sAvgId = mapPlot.AvgId,
    nNodeId = nil,
    callback = Callback
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.PureAvgStory, mapData)
end

function PlayerCharData:IsCharPlotFinish(nCharId, nPlotId)
  local mapChar = self._mapChar[nCharId]
  if mapChar == nil then
    return false
  end
  if mapChar.tbPlot == nil then
    return false
  end
  return table.indexof(mapChar.tbPlot, nPlotId) > 0
end

function PlayerCharData:GetNewChar(mapData)
  if mapData == nil then
    return
  end
  
  local function func_ForEach_InsertNewChar(ChangeInfo)
    local charID = ChangeInfo.Tid
    if self._mapChar[charID] ~= nil then
      printLog("获取重复角色:" .. charID)
      return
    end
    local nCharId = charID
    self._mapChar[nCharId] = self:CreateNewChar(ChangeInfo)
  end
  
  for _, charData in pairs(mapData) do
    func_ForEach_InsertNewChar(charData)
  end
  PlayerData.Talent:CacheTalentData(mapData)
  PlayerData.Equipment:CacheEquipmentData(mapData)
end

function PlayerCharData:GetCharByEET(tbEET)
  local tbChar = {}
  local ntbEETLength = #tbEET
  for nCharId, data in pairs(self._mapChar) do
    if table.indexof(tbEET, ConfigTable.GetData_Character(nCharId).EET) > 0 or ntbEETLength == 0 then
      table.insert(tbChar, data)
    end
  end
  return tbChar
end

function PlayerCharData:GetAdvanceLevelTable()
  if self._AdvanceLevelConfig == nil then
    self._AdvanceLevelConfig = {}
    
    local function foreachCharRaritySequence(mapData)
      local grade = mapData.Grade
      if self._AdvanceLevelConfig[grade] == nil then
        self._AdvanceLevelConfig[grade] = {}
      end
      table.insert(self._AdvanceLevelConfig[grade], tonumber(mapData.LvLimit))
    end
    
    ForEachTableLine(DataTable.CharRaritySequence, foreachCharRaritySequence)
  end
  return self._AdvanceLevelConfig
end

function PlayerCharData:GetCharAdvancePreview(nCharId, nAdvance)
  local mapAdvancePre = {}
  local mapCharCfg = ConfigTable.GetData_Character(nCharId)
  if mapCharCfg ~= nil then
    local nGrade = mapCharCfg.Grade
    local mapRaritySequence = CacheTable.GetData("_CharRaritySequence", nGrade)
    if mapRaritySequence ~= nil and mapRaritySequence[nAdvance] ~= nil then
      local nMaxLevel = mapRaritySequence[nAdvance].LvLimit
      table.insert(mapAdvancePre, {
        nType = AllEnum.CharAdvancePreview.LevelMax,
        nMaxLevel = nMaxLevel
      })
    end
    local nUpgradeGroup = mapCharCfg.SkillsUpgradeGroup[1]
    local nMaxSkillLevel = 0
    for i = #self._CharSkillUpgrade[nUpgradeGroup], 1, -1 do
      if self._CharSkillUpgrade[nUpgradeGroup][i].nReqCharAdvNum == nAdvance then
        nMaxSkillLevel = i
        break
      end
    end
    if 0 < nMaxSkillLevel then
      table.insert(mapAdvancePre, {
        nType = AllEnum.CharAdvancePreview.SkillLevelMax,
        nMaxSkillLevel = nMaxSkillLevel
      })
    end
    if mapCharCfg.AdvanceSkinUnlockLevel == nAdvance then
      table.insert(mapAdvancePre, {
        nType = AllEnum.CharAdvancePreview.SkinUnlock
      })
    end
  end
  return mapAdvancePre
end

function PlayerCharData:CreateTrialChar(tbTrialId)
  for _, nTrialId in ipairs(tbTrialId) do
    if 0 < nTrialId then
      local mapTrialData = ConfigTable.GetData("TrialCharacter", nTrialId)
      if mapTrialData == nil then
        printError("体验角色数据没有找到：" .. nTrialId)
        return
      end
      self._mapTrialChar[nTrialId] = {
        nId = mapTrialData.CharId,
        nTrialId = nTrialId,
        sName = mapTrialData.Name,
        nSkinId = mapTrialData.CharacterSkin,
        nLevel = mapTrialData.Level,
        nAdvance = mapTrialData.Break,
        tbSkillLvs = mapTrialData.SkillLevel
      }
    end
  end
  PlayerData.Talent:CreateTrialData(tbTrialId)
  return self._mapTrialChar
end

function PlayerCharData:DeleteTrialChar()
  self._mapTrialChar = {}
  PlayerData.Talent:DeleteTrialData()
end

function PlayerCharData:GetTrialCharById(nTrialId)
  local mapTrialChar = self._mapTrialChar[nTrialId]
  if mapTrialChar == nil then
    printError("没有该试用角色数据:" .. nTrialId)
  end
  return mapTrialChar
end

function PlayerCharData:GetTrialCharByCharId(nCharId)
  for _, v in pairs(self._mapTrialChar) do
    if v.nId == nCharId then
      return v
    end
  end
end

function PlayerCharData:CreateLimitedTrialChar(tbTrialId)
  for _, nTrialId in ipairs(tbTrialId) do
    if 0 < nTrialId then
      local mapTrialData = ConfigTable.GetData("TrialCharacter", nTrialId)
      if mapTrialData == nil then
        printError("限时试用角色数据没有找到：" .. nTrialId)
        return
      end
      self._mapLimitedTrialChar[nTrialId] = {
        nId = mapTrialData.CharId,
        nTrialId = nTrialId,
        sName = mapTrialData.Name,
        nSkinId = mapTrialData.CharacterSkin,
        nLevel = mapTrialData.Level,
        nAdvance = mapTrialData.Break,
        tbSkillLvs = mapTrialData.SkillLevel
      }
    end
  end
  PlayerData.Talent:CreateLimitedTrialData(tbTrialId)
  return self._mapLimitedTrialChar
end

function PlayerCharData:DeleteLimitedTrialChar()
  self._mapLimitedTrialChar = {}
  PlayerData.Talent:DeleteLimitedTrialData()
end

function PlayerCharData:GetLimitedTrialCharById(nTrialId)
  local mapTrialChar = self._mapLimitedTrialChar[nTrialId]
  if mapTrialChar == nil then
    printError("没有该限时试用角色数据:" .. nTrialId)
  end
  return mapTrialChar
end

function PlayerCharData:GetLimitedTrialCharSkillAddedLevel(nTrialId)
  local mapChar = self._mapLimitedTrialChar[nTrialId]
  if mapChar == nil then
    printError("没有该限时试用角色数据" .. nTrialId)
    return {
      1,
      1,
      1,
      1
    }
  end
  local nCharId = mapChar.nId
  local tbSkillLevel = {}
  local tbSkillIds = self:GetSkillIds(nCharId)
  local mapTalentEnhanceSkill = PlayerData.Talent:GetLimitedTrialEnhancedSkill(nTrialId)
  for i = 1, 4 do
    local nSkillId = tbSkillIds[i]
    local nAdd = 0
    if mapTalentEnhanceSkill then
      nAdd = mapTalentEnhanceSkill[nSkillId]
    end
    local nLv = mapChar.tbSkillLvs[i] + nAdd
    table.insert(tbSkillLevel, nLv)
  end
  return tbSkillLevel
end

function PlayerCharData:GetCharPlotDataById(charId)
  return CacheTable.GetData("_Plot", charId)
end

function PlayerCharData:IsPlotUnlock(plotId, charId)
  if not self:CheckCharUnlock(charId) then
    return true, ""
  end
  local data = ConfigTable.GetData("Plot", plotId)
  local bLock = false
  local locktxt = ""
  if data == nil then
    return bLock, locktxt
  end
  for _, nMainlineId in ipairs(data.Mainlines) do
    local nStar = PlayerData.Mainline:GetMianlineLevelStar(nMainlineId)
    if nStar <= 0 then
      local mapMainline = ConfigTable.GetData_Mainline(nMainlineId)
      locktxt = orderedFormat(ConfigTable.GetUIText("Plot_Limit_MainLine") or "", mapMainline.Name)
      bLock = true
      break
    end
  end
  if not bLock then
    local mapCharAdvanceCond = decodeJson(data.CharAdvanceCond)
    if mapCharAdvanceCond ~= nil then
      for sCharId, nAdvance in pairs(mapCharAdvanceCond) do
        local mapCondChar = self:GetCharDataByTid(tonumber(sCharId))
        if mapCondChar ~= nil and nAdvance > mapCondChar.nAdvance then
          local sName = ConfigTable.GetData_Character(tonumber(sCharId)).Name
          locktxt = orderedFormat(ConfigTable.GetUIText("Plot_Limit_Advance") or "", sName, nAdvance)
          bLock = true
          break
        end
      end
    end
  end
  if not bLock then
    local mapAffinityData = self:GetCharAffinityData(charId)
    if mapAffinityData ~= nil then
      bLock = data.UnlockAffinityLevel > mapAffinityData.Level
    else
      bLock = true
    end
    if bLock then
      locktxt = orderedFormat(ConfigTable.GetUIText("Affinity_UnLock_Level") or "", data.UnlockAffinityLevel)
    end
  end
  if not bLock and data.PrePlot ~= nil and data.PrePlot ~= 0 then
    bLock = not self:IsCharPlotFinish(charId, data.PrePlot)
    if bLock then
      local nIndex = 0
      local nType = data.PlotType
      local nParam = 0
      if nType == GameEnum.CharPlotType.SkinPlot then
        nParam = data.UnlockSkinId
      end
      local plotData = self:GetCharPlotDataById(charId)
      table.sort(plotData, function(a, b)
        if a.PlotType == b.PlotType then
          return a.Id < b.Id
        end
        return a.PlotType < b.PlotType
      end)
      local nCurIndex = 0
      for k, v in ipairs(plotData) do
        if v.PlotType == nType then
          if v.PlotType == GameEnum.CharPlotType.SkinPlot then
            if v.UnlockSkinId == nParam then
              nCurIndex = nCurIndex + 1
            end
          else
            nCurIndex = nCurIndex + 1
          end
        end
        if v.Id == data.PrePlot then
          nIndex = nCurIndex
          break
        end
      end
      if nType == GameEnum.CharPlotType.CharPlot then
        locktxt = orderedFormat(ConfigTable.GetUIText("Affinity_UnLock_PrePlot") or "", nIndex)
      elseif nType == GameEnum.CharPlotType.SkinPlot then
        local mapSkinCfg = ConfigTable.GetData("CharacterSkin", nParam)
        if mapSkinCfg ~= nil then
          locktxt = orderedFormat(ConfigTable.GetUIText("Affinity_UnLock_PrePlot_Skin") or "", mapSkinCfg.Name, nIndex)
        end
      end
    end
  end
  if not bLock and data.UnlockSkinId ~= nil and data.UnlockSkinId ~= 0 then
    bLock = not PlayerData.CharSkin:CheckSkinUnlock(data.UnlockSkinId)
  end
  return bLock, locktxt
end

function PlayerCharData:GetCharAffinityData(charId)
  local mapData = self._mapChar[charId]
  if mapData == nil then
    return nil
  end
  local data = {}
  data.Exp = mapData.nAffinityExp
  data.Level = mapData.nAffinityLevel
  data.Quest = mapData.tbAffinityQuests
  return data
end

function PlayerCharData:ChangeCharAffinityValue(msgData)
  local blevelUp = false
  if msgData ~= nil and self._mapChar[msgData.CharId] ~= nil then
    local lastLevel = self._mapChar[msgData.CharId].nAffinityLevel
    if self._mapChar[msgData.CharId].nAffinityLevel < msgData.AffinityLevel then
      blevelUp = true
    end
    local lastExp = self._mapChar[msgData.CharId].nAffinityExp
    self._mapChar[msgData.CharId].nAffinityExp = msgData.AffinityExp
    self._mapChar[msgData.CharId].nAffinityLevel = msgData.AffinityLevel
    if blevelUp then
      self:UpdateCharRecordInfoReddot(msgData.CharId, false, lastLevel, msgData.AffinityLevel)
      self:UpdateCharArchiveContentUpdateRedDot(msgData.CharId, 1, msgData.AffinityLevel, lastLevel)
    end
    if lastLevel < msgData.AffinityLevel then
      self._mapChar[msgData.CharId].bNeedShowAffinityLevelUp = true
      self._mapChar[msgData.CharId].nAffinityLastLevel = lastLevel
      self._mapChar[msgData.CharId].nAffinityLastExp = lastExp
    elseif lastExp ~= msgData.AffinityExp then
      self._mapChar[msgData.CharId].bAffinityExpUp = true
    end
    EventManager.Hit(EventId.AffinityChange, msgData.CharId, msgData.AffinityLevel, lastLevel, msgData.AffinityExp, lastExp)
    if lastLevel >= msgData.AffinityLevel and PanelManager.CheckPanelOpen(PanelId.CharFavourLevelUp) == false then
      PlayerData.SideBanner:AddFavour(msgData.CharId)
    end
  end
end

function PlayerCharData:GetIsNeedShowAffinityLevelUp(charId)
  local mapData = self._mapChar[charId]
  if mapData ~= nil and mapData.bNeedShowAffinityLevelUp ~= nil and mapData.bNeedShowAffinityLevelUp == true then
    return mapData.nAffinityLastLevel, mapData.nAffinityLastExp
  end
  return -1
end

function PlayerCharData:ChangeShowAffinityLevelUpState(charId)
  local mapData = self._mapChar[charId]
  if mapData ~= nil and mapData.bNeedShowAffinityLevelUp ~= nil then
    mapData.bNeedShowAffinityLevelUp = false
  end
end

function PlayerCharData:GetIsAffinityExpUp(charId)
  local mapData = self._mapChar[charId]
  if mapData ~= nil and mapData.bAffinityExpUp ~= nil and mapData.bAffinityExpUp == true then
    mapData.bAffinityExpUp = false
    return true
  end
  return false
end

function PlayerCharData:GetMaxAffinityLevel(templateId)
  local maxLevel = 0
  for k, v in pairs(CacheTable.GetData("_AffinityLevel", templateId) or {}) do
    if maxLevel < v.AffinityLevel then
      maxLevel = v.AffinityLevel
    end
  end
  return maxLevel
end

function PlayerCharData:CheckCharArchiveBaseContentUpdate(nCharId, nBaseInfoId)
  local bUpdate = false
  local nValue = 0
  local contentData = ConfigTable.GetData("CharacterArchiveBaseInfo", nBaseInfoId)
  if contentData ~= nil and contentData.UpdateContent1 ~= "" then
    bUpdate = true
    if contentData.UpdateAff1 ~= 0 then
      local mapData = self:GetCharAffinityData(nCharId)
      local nCurLevel = mapData ~= nil and mapData.Level or 0
      bUpdate = bUpdate and nCurLevel >= contentData.UpdateAff1
      if nCurLevel >= contentData.UpdateAff1 then
        nValue = nValue | 1
      end
    else
      nValue = nValue | 1
    end
    if contentData.UpdatePlot1 ~= 0 then
      local bUnlock = self:IsCharPlotFinish(nCharId, contentData.UpdatePlot1)
      bUpdate = bUpdate and bUnlock
      if bUnlock then
        nValue = 2 | nValue
      end
    else
      nValue = 2 | nValue
    end
    if contentData.UpdateStory1 ~= 0 then
      local bReaded = PlayerData.Avg:IsStoryReaded(contentData.UpdateStory1)
      bUpdate = bUpdate and bReaded
      if bReaded then
        nValue = 4 | nValue
      end
    else
      nValue = 4 | nValue
    end
  end
  return bUpdate, nValue
end

function PlayerCharData:CheckCharArchiveContentUpdate(nCharId, nArchiveContentId)
  local bUpdate = false
  local nValue = 0
  local contentData = ConfigTable.GetData("CharacterArchiveContent", nArchiveContentId)
  if contentData ~= nil and contentData.UpdateContent1 ~= "" then
    bUpdate = true
    if contentData.UpdateAff1 ~= 0 then
      local mapData = self:GetCharAffinityData(nCharId)
      local nCurLevel = mapData ~= nil and mapData.Level or 0
      bUpdate = bUpdate and nCurLevel >= contentData.UpdateAff1
      if nCurLevel >= contentData.UpdateAff1 then
        nValue = nValue | 1
      end
    else
      nValue = nValue | 1
    end
    if contentData.UpdatePlot1 ~= 0 then
      local bUnlock = self:IsCharPlotFinish(nCharId, contentData.UpdatePlot1)
      bUpdate = bUpdate and bUnlock
      if bUnlock then
        nValue = 2 | nValue
      end
    else
      nValue = 2 | nValue
    end
    if contentData.UpdateStory1 ~= 0 then
      local bReaded = PlayerData.Avg:IsStoryReaded(contentData.UpdateStory1)
      bUpdate = bUpdate and bReaded
      if bReaded then
        nValue = 4 | nValue
      end
    else
      nValue = 4 | nValue
    end
  end
  return bUpdate, nValue
end

function PlayerCharData:CheckCharUnlock(nCharId)
  return self._mapChar[nCharId] ~= nil
end

function PlayerCharData:CheckCharArchiveReward(nCharId, nArchiveId)
  local bReceived = false
  if self._mapChar[nCharId] ~= nil then
    local tbReceivedIds = self._mapChar[nCharId].tbArchiveRewardIds
    for _, v in ipairs(tbReceivedIds) do
      if v == nArchiveId then
        bReceived = true
        break
      end
    end
  end
  return bReceived
end

function PlayerCharData:GetCharHonorTitleData(charId)
  if self.tbHonorTitle[charId] == nil then
    return nil
  end
  local tbData = {}
  local maxLevel = 0
  for k, v in ipairs(self.tbHonorTitle[charId]) do
    tbData[v.Level] = v
    if maxLevel < v.Level then
      maxLevel = v.Level
    end
  end
  return tbData, maxLevel
end

function PlayerCharData:TempCreateCharDataForBattleTest(tbTeamCharId, advances, cLevels)
  if self._mapChar == nil then
    self._mapChar = {}
  end
  for i, nCharId in ipairs(tbTeamCharId) do
    self._mapChar[nCharId] = {
      nRankExp = 0,
      nFavor = 1,
      nSkinId = nil,
      nCreateTime = 0,
      nLevel = 1,
      nAdvance = 0,
      tbSkillLvs = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 1
      }
    }
    if advances ~= nil then
      self._mapChar[nCharId].nAdvance = advances[i]
    end
    if cLevels ~= nil and cLevels[i] ~= 0 then
      self._mapChar[nCharId].nLevel = cLevels[i]
    end
  end
end

function PlayerCharData:TempGetCharInfoData()
  return self.nTempCharInfoData
end

function PlayerCharData:TempSetCharInfoData(nTempCharId)
  self.nTempCharInfoData = nTempCharId
end

function PlayerCharData:TempClearCharInfoData()
  self.nTempCharInfoData = nil
end

function PlayerCharData:GetCharDataByTid(nTid)
  if self._mapChar[nTid] == nil then
    return nil
  else
    return self._mapChar[nTid]
  end
end

function PlayerCharData:GetCharIdList()
  local tbChar = {}
  for nCharId, data in pairs(self._mapChar) do
    table.insert(tbChar, data)
  end
  table.sort(tbChar, function(dataA, dataB)
    return dataA.nId < dataB.nId
  end)
  return tbChar
end

function PlayerCharData:GetCharCfgAttr(tbPropertyIndexList, nCharId, nAdvance, nLevel)
  local mapAttr = {}
  local nAttrBaseId = UTILS.GetCharacterAttributeId(nCharId, nAdvance, nLevel)
  local mapAttribute = ConfigTable.GetData_Attribute(tostring(nAttrBaseId))
  if type(mapAttribute) == "table" then
    for i = 1, #tbPropertyIndexList do
      local nindex = tbPropertyIndexList[i]
      local mapCharAttr = AllEnum.CharAttr[nindex]
      local nParamValue = mapAttribute[mapCharAttr.sKey] or 0
      mapAttr[mapCharAttr.sKey] = {
        Key = mapCharAttr.sKey,
        Value = mapCharAttr.bPercent and nParamValue * ConfigData.IntFloatPrecision * 100 or nParamValue,
        CfgValue = mapAttribute[mapCharAttr.sKey] or 0
      }
    end
  else
    printError("角色属性配置错误：" .. nAttrBaseId)
    for i = 1, #tbPropertyIndexList do
      local nindex = tbPropertyIndexList[i]
      local mapCharAttr = AllEnum.CharAttr[nindex]
      mapAttr[mapCharAttr.sKey] = {
        Key = mapCharAttr.sKey,
        Value = 0,
        CfgValue = 0
      }
    end
  end
  return mapAttr
end

function PlayerCharData:GetUpgradeMatList()
  local tbMat = {}
  for _, value in ipairs(self.tbItemExp) do
    table.insert(tbMat, {
      nItemId = value.nItemId,
      nExpValue = value.nExpValue,
      nCost = 0
    })
  end
  table.sort(tbMat, function(a, b)
    return a.nExpValue > b.nExpValue
  end)
  return tbMat
end

function PlayerCharData:CalCostProportion(nTarget, tbMatType, tbHas)
  local nTypeCount = #tbMatType
  
  local function GetProportionedSum(tbProportioned)
    local nSum = 0
    for i = 1, nTypeCount do
      nSum = nSum + tbMatType[i] * tbProportioned[i]
    end
    return nSum
  end
  
  local tbCost = tbHas
  local nMinTarget = GetProportionedSum(tbHas)
  if nTarget >= nMinTarget then
    return tbHas
  end
  local tbSumOfTypeFollowing = {}
  tbSumOfTypeFollowing[nTypeCount + 1] = 0
  for i = nTypeCount, 1, -1 do
    local nCurTypeSum = tbMatType[i] * tbHas[i]
    tbSumOfTypeFollowing[i] = nCurTypeSum + tbSumOfTypeFollowing[i + 1]
  end
  
  local function GetLargeFaceValue(tbCost1, tbCost2)
    for i = 1, #tbCost1 do
      if tbCost1[i] > tbCost2[i] then
        return tbCost1
      elseif tbCost1[i] < tbCost2[i] then
        return tbCost2
      end
    end
    return tbCost1
  end
  
  local function Proportion(tbProportioned, nCurMatType, nRemain)
    if nCurMatType > nTypeCount or nRemain <= 0 then
      local nSum = GetProportionedSum(tbProportioned)
      if nSum >= nTarget then
        if nSum < nMinTarget then
          nMinTarget = nSum
          tbCost = tbProportioned
        elseif nSum == nMinTarget then
          tbCost = GetLargeFaceValue(tbCost, tbProportioned)
        end
      end
    else
      local nMaxUse = math.ceil(nRemain / tbMatType[nCurMatType])
      nMaxUse = math.min(nMaxUse, tbHas[nCurMatType])
      local nMinUse = math.max(nMaxUse - 1, 0)
      for i = nMaxUse, nMinUse, -1 do
        local tbCopy = {
          table.unpack(tbProportioned)
        }
        tbCopy[nCurMatType] = i
        local nSum = GetProportionedSum(tbCopy)
        if nSum > nMinTarget then
          return
        end
        local nNextRemain = nRemain - i * tbMatType[nCurMatType]
        Proportion(tbCopy, nCurMatType + 1, nNextRemain)
      end
    end
  end
  
  local tbProportioned = {}
  for i = 1, nTypeCount do
    tbProportioned[i] = 0
  end
  Proportion(tbProportioned, 1, nTarget)
  return tbCost
end

function PlayerCharData:CalUpgradeExp(Grade, nStartLevel, nTargetLevel, nStartExp)
  local nTotalExp = 0
  for i = nStartLevel, nTargetLevel - 1 do
    local nUpgradeId = 10000 + Grade * 1000 + i + 1
    local mapUpgrade = ConfigTable.GetData("CharacterUpgrade", nUpgradeId, true)
    local nExp = 0
    if mapUpgrade then
      nExp = mapUpgrade.Exp
    end
    nTotalExp = nTotalExp + nExp
  end
  nTotalExp = nTotalExp - nStartExp
  return nTotalExp
end

function PlayerCharData:CalUpgradeMat(nTargetExp)
  local tbMatType, tbHas = {}, {}
  for _, value in ipairs(self.tbItemExp) do
    table.insert(tbMatType, value.nExpValue)
    table.insert(tbHas, PlayerData.Item:GetItemCountByID(value.nItemId))
  end
  local tbCostCount = self:CalCostProportion(nTargetExp, tbMatType, tbHas)
  local tbMat = {}
  for nIndex, value in ipairs(self.tbItemExp) do
    table.insert(tbMat, {
      nItemId = value.nItemId,
      nExpValue = value.nExpValue,
      nCost = tbCostCount[nIndex]
    })
  end
  return tbMat
end

function PlayerCharData:GetCustomizeLevelExp(nCharId, nLevel)
  local mapChar = self._mapChar[nCharId]
  if not mapChar then
    return 0
  end
  local Grade = ConfigTable.GetData_Character(nCharId).Grade
  local nNextExp = self:CalUpgradeExp(Grade, mapChar.nLevel, nLevel, mapChar.nRankExp)
  return nNextExp
end

function PlayerCharData:GetMaxLevelExp(nCharId, MaxLevel)
  local mapChar = self._mapChar[nCharId]
  if not mapChar then
    return 0
  end
  local Grade = ConfigTable.GetData_Character(nCharId).Grade
  local nNextExp = self:CalUpgradeExp(Grade, mapChar.nLevel, MaxLevel, mapChar.nRankExp)
  return nNextExp
end

function PlayerCharData:GetMaxMatCost(nCharId, tbMat, mapMat, MaxLevel)
  local nMatExp = mapMat.nExpValue
  local nMaxExp = self:GetMaxLevelExp(nCharId, MaxLevel)
  local nHasExp = self:GetMatExp(tbMat)
  local nCount = math.ceil((nMaxExp - nHasExp) / nMatExp)
  return nCount
end

function PlayerCharData:GetMatExp(tbMat)
  local nTotalExp = 0
  for _, mapMat in ipairs(tbMat) do
    nTotalExp = nTotalExp + mapMat.nExpValue * mapMat.nCost
  end
  return nTotalExp
end

function PlayerCharData:GetCustomizeLevelDataAndCost(nCharId, nLevel, nMaxLevel)
  local nTargetExp = self:GetCustomizeLevelExp(nCharId, nLevel)
  local tbMat = self:CalUpgradeMat(nTargetExp)
  local mapTargetLevel, nGoldCost = self:GetLevelDataAndCostByMat(nCharId, tbMat, nMaxLevel)
  return mapTargetLevel, tbMat, nGoldCost
end

function PlayerCharData:GetMaxLevelDataAndCost(nCharId, nMaxLevel)
  local nTargetExp = self:GetMaxLevelExp(nCharId, nMaxLevel)
  local tbMat = self:CalUpgradeMat(nTargetExp)
  local mapTargetLevel, nGoldCost = self:GetLevelDataAndCostByMat(nCharId, tbMat, nMaxLevel)
  return mapTargetLevel, tbMat, nGoldCost
end

function PlayerCharData:GetLevelDataAndCostByMat(nCharId, tbMat, nMaxLevel)
  local mapChar = self._mapChar[nCharId]
  if not mapChar then
    return nil
  end
  local nMatExp = self:GetMatExp(tbMat)
  local nGoldCost = nMatExp * self.goldperExp
  local nTotalExp = nMatExp + mapChar.nRankExp
  local Grade = ConfigTable.GetData_Character(nCharId).Grade
  local nStartLevel = mapChar.nLevel
  local nTargetLevel = nStartLevel
  for i = nStartLevel, nMaxLevel - 1 do
    local nUpgradeId = 10000 + Grade * 1000 + i + 1
    local mapUpgrade = ConfigTable.GetData("CharacterUpgrade", nUpgradeId, true)
    local nExp = 0
    if mapUpgrade then
      nExp = mapUpgrade.Exp
    end
    if nTotalExp >= nExp then
      nTotalExp = nTotalExp - nExp
      nTargetLevel = nTargetLevel + 1
    else
      break
    end
  end
  if nTargetLevel == nMaxLevel then
    nGoldCost = nGoldCost - nTotalExp * self.goldperExp
    nMatExp = nMatExp - nTotalExp
    nTotalExp = 0
  end
  local mapLevelData = {
    nLevel = nTargetLevel,
    nExp = nTotalExp,
    nMaxLevel = nMaxLevel,
    nMaxExp = self:GetMaxExp(Grade, nTargetLevel),
    nMatExp = nMatExp
  }
  self.nMaxLevel = nMaxLevel
  return mapLevelData, nGoldCost
end

function PlayerCharData:GetMaxExp(Grade, nTargetLevel)
  local retExp = 99999
  local nUpgradeId = 10000 + Grade * 1000 + nTargetLevel + 1
  local mapUpgrade = ConfigTable.GetData("CharacterUpgrade", nUpgradeId, true)
  if mapUpgrade == nil then
    return retExp
  end
  return mapUpgrade.Exp
end

function PlayerCharData:GetAllCharCount()
  local nChar = 0
  for _, _ in pairs(self._mapChar) do
    nChar = nChar + 1
  end
  return nChar
end

function PlayerCharData:GetDataForCharList()
  local mapChar = {}
  for nCharId, data in pairs(self._mapChar) do
    local mapCfg = ConfigTable.GetData_Character(nCharId)
    if mapCfg ~= nil then
      mapChar[nCharId] = {}
      mapChar[nCharId].nId = nCharId
      mapChar[nCharId].Name = mapCfg.Name
      mapChar[nCharId].Rare = mapCfg.Grade
      mapChar[nCharId].Class = mapCfg.Class
      mapChar[nCharId].EET = mapCfg.EET
      mapChar[nCharId].Level = self:GetCharLv(nCharId)
      mapChar[nCharId].CreateTime = data.nCreateTime
      mapChar[nCharId].Advance = self:GetCharAdvance(nCharId)
      mapChar[nCharId].Favorability = self:GetCharAffinityData(nCharId).Level
      mapChar[nCharId].IsFavorite = self:GetCharFavoriteState(nCharId)
    else
      printError(nCharId .. "角色数据不存在")
    end
  end
  return mapChar
end

function PlayerCharData:GetCharDataById(nCharId)
  local tbCharData = {}
  local cfgChar = ConfigTable.GetData_Character(nCharId)
  if nil ~= self._mapChar[nCharId] and nil ~= cfgChar then
    tbCharData.nId = nCharId
    tbCharData.Name = cfgChar.Name
    tbCharData.Rare = cfgChar.Grade
    tbCharData.Class = cfgChar.Class
    tbCharData.EET = cfgChar.EET
    tbCharData.Level = self:GetCharLv(nCharId)
    tbCharData.CreateTime = self._mapChar[nCharId].nCreateTime
    tbCharData.Advance = self:GetCharAdvance(nCharId)
    tbCharData.Favorability = self:GetCharAffinityData(nCharId).Level
    tbCharData.IsFavorite = self:GetCharFavoriteState(nCharId)
  end
  return tbCharData
end

function PlayerCharData:GetCharLv(nCharId)
  local mapTrialInfo
  for k, v in pairs(self._mapTrialChar) do
    local mapCfgData_TrialCharacter = ConfigTable.GetData("TrialCharacter", k)
    if mapCfgData_TrialCharacter ~= nil and mapCfgData_TrialCharacter.CharId == nCharId then
      mapTrialInfo = v
      break
    end
  end
  if mapTrialInfo == nil then
    local mapCharInfo = self._mapChar[nCharId]
    if mapCharInfo == nil then
      return nil
    else
      if type(mapCharInfo.nLevel) ~= "number" then
        mapCharInfo.nLevel = 1
      end
      return mapCharInfo.nLevel
    end
  else
    return mapTrialInfo.nLevel
  end
end

function PlayerCharData:CalCharMaxLevel(nCharId, nAdvance)
  local mapCharInfo = self._mapTrialChar[nCharId]
  if mapCharInfo == nil then
    mapCharInfo = self._mapChar[nCharId]
    if mapCharInfo == nil then
      return nil
    end
  end
  if nAdvance == nil then
    nAdvance = mapCharInfo.nAdvance
  end
  local MaxLevel = 0
  local tbAdvanceLevel = self:GetAdvanceLevelTable()
  local Grade = ConfigTable.GetData_Character(nCharId).Grade
  local curGradeLevelArr = tbAdvanceLevel[Grade]
  local maxAdvance = 0
  for i = 1, #curGradeLevelArr do
    maxAdvance = maxAdvance + 1
    if nAdvance + 1 == i then
      MaxLevel = curGradeLevelArr[nAdvance + 1]
      return MaxLevel
    end
  end
  MaxLevel = mapCharInfo.nLevel
  return MaxLevel
end

function PlayerCharData:GetCharSkinId(nCharId)
  local mapTrialInfo
  for k, v in pairs(self._mapTrialChar) do
    local mapCfgData_TrialCharacter = ConfigTable.GetData("TrialCharacter", k)
    if mapCfgData_TrialCharacter ~= nil and mapCfgData_TrialCharacter.CharId == nCharId then
      mapTrialInfo = v
      break
    end
  end
  if mapTrialInfo == nil then
    local mapCharInfo = self._mapChar[nCharId]
    if mapCharInfo ~= nil then
      if type(mapCharInfo.nSkinId) ~= "number" then
        mapCharInfo.nSkinId = ConfigTable.GetData_Character(nCharId).DefaultSkinId
      end
      return mapCharInfo.nSkinId
    else
      local mapCharCfg = ConfigTable.GetData_Character(nCharId, true)
      if mapCharCfg == nil then
        return 0
      else
        return mapCharCfg.DefaultSkinId
      end
    end
  else
    return mapTrialInfo.nSkinId
  end
  return 0
end

function PlayerCharData:SetCharSkinId(nCharId, nSkinId)
  local mapCharInfo = self._mapChar[nCharId]
  if mapCharInfo == nil then
    return
  elseif type(nSkinId) == "number" then
    mapCharInfo.nSkinId = nSkinId
  else
    mapCharInfo.nSkinId = ConfigTable.GetData_Character(nCharId).DefaultSkinId
  end
  EventManager.Hit(EventId.CharacterSkinChange, nCharId, nSkinId)
end

function PlayerCharData:SetCharFavoriteState(nCharId, bOnFavorite)
  local mapChar = self._mapChar[nCharId]
  if mapChar == nil then
    printError("没有该角色数据" .. nCharId)
  end
  self._mapChar[nCharId].bIsFavorite = bOnFavorite
end

function PlayerCharData:GetCharFavoriteState(nCharId)
  local mapChar = self._mapChar[nCharId]
  if mapChar == nil then
    printError("没有该角色数据" .. nCharId)
    return false
  end
  return mapChar.bIsFavorite
end

function PlayerCharData:CalcAffinityEffect(nCharId)
  local tbEfts = PlayerData.Char:GetCharAffinityEffects(nCharId)
  if tbEfts == nil then
    return
  end
  return tbEfts
end

function PlayerCharData:CalcTalentEffect(nCharId)
  local tbEfts = PlayerData.Talent:GetTalentEffect(nCharId)
  if tbEfts == nil then
    return {1130101}
  end
  return tbEfts
end

function PlayerCharData:GetCharFavorability(nCharId)
  return 1
end

function PlayerCharData:GetCharAdvance(nCharId)
  local mapData = self._mapChar[nCharId]
  if mapData ~= nil then
    return mapData.nAdvance
  else
    return 0
  end
end

function PlayerCharData:GetCharAffinityEffects(nCharId)
  local mapData = self._mapChar[nCharId]
  local effectIds = {}
  if mapData ~= nil then
    local mapCfg = ConfigTable.GetData("CharAffinityTemplate", nCharId)
    if not mapCfg then
      return effectIds
    end
    local templateId = mapCfg.TemplateId
    
    local function forEachAffinityLevel(affinityData)
      if affinityData.TemplateId == templateId and mapData.nAffinityLevel ~= nil and affinityData.AffinityLevel == mapData.nAffinityLevel and affinityData.Effect ~= nil and #affinityData.Effect > 0 then
        for k, v in ipairs(affinityData.Effect) do
          table.insert(effectIds, v)
        end
      end
    end
    
    ForEachTableLine(DataTable.AffinityLevel, forEachAffinityLevel)
  end
  return effectIds
end

function PlayerCharData:CharUpgrade(nCharId, tbMat, mapTargetLevel, callback)
  local tbItems = {}
  for _, mapMat in pairs(tbMat) do
    if mapMat.nCost > 0 then
      table.insert(tbItems, {
        Id = 0,
        Qty = mapMat.nCost,
        Tid = mapMat.nItemId
      })
    end
  end
  local mapMsg = {CharId = nCharId, Items = tbItems}
  
  local function msgCallback(_, mapMsgData)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    self._mapChar[nCharId].nLevel = mapTargetLevel.nLevel
    self._mapChar[nCharId].nRankExp = mapTargetLevel.nExp
    if callback ~= nil then
      callback(mapMsgData.Level, mapMsgData.Exp)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_upgrade_req, mapMsg, nil, msgCallback)
end

function PlayerCharData:CharAdvance(nCharId, callback)
  local mapMsg = {Value = nCharId}
  
  local function msgCallback(_, mapMsgData)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    self._mapChar[nCharId].nAdvance = self._mapChar[nCharId].nAdvance + 1
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_advance_req, mapMsg, nil, msgCallback)
end

function PlayerCharData:CharAdvanceReward(nCharId, nAdvance, callback)
  local mapMsg = {CharId = nCharId, Advance = nAdvance}
  
  local function msgCallback(_, mapMsgData)
    if callback ~= nil then
      UTILS.OpenReceiveByChangeInfo(mapMsgData.Change)
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_advance_reward_receive_req, mapMsg, nil, msgCallback)
end

function PlayerCharData:CharPlotFinish(nCharId, nPlotId, callback)
  local mapMsg = {Value = nPlotId}
  
  local function msgCallback(_, mapMsgData)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
    self:ChangeCharPlotState(nCharId, nPlotId)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    EventManager.Hit(EventId.ClosePanel, PanelId.PureAvgStory)
    if callback ~= nil then
      callback(mapMsgData, nCharId)
    end
    self:UpdateCharPlotReddot(nCharId)
    self:UpdateCharArchiveContentUpdateRedDot(nCharId, 2, nPlotId)
    self:UpdateCharVoiceReddot(nCharId, false, nil, nil, nPlotId)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.plot_reward_receive_req, mapMsg, nil, msgCallback)
end

function PlayerCharData:ChangeCharPlotState(nCharId, nPlotId)
  if self._mapChar[nCharId] == nil then
    return
  end
  if self._mapChar[nCharId].tbPlot == nil then
    self._mapChar[nCharId].tbPlot = {}
  end
  table.insert(self._mapChar[nCharId].tbPlot, nPlotId)
end

function PlayerCharData:SendCharArchiveRewardReceive(nCharId, nArchiveId, callback)
  local mapMsg = {ArchiveId = nArchiveId}
  
  local function msgCallback(_, mapMsgData)
    if self._mapChar[nCharId] ~= nil and self._mapChar[nCharId].tbArchiveRewardIds ~= nil then
      table.insert(self._mapChar[nCharId].tbArchiveRewardIds, nArchiveId)
    end
    self:UpdateCharArchiveRewardRedDot(nCharId)
    UTILS.OpenReceiveByChangeInfo(mapMsgData)
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_archive_reward_receive_req, mapMsg, nil, msgCallback)
end

function PlayerCharData:CharSkillUpgrade(nCharId, nSkillIdx, callback)
  local mapMsg = {CharId = nCharId, Index = nSkillIdx}
  
  local function msgCallback(_, mapMsgData)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    self._mapChar[nCharId].tbSkillLvs[nSkillIdx] = self._mapChar[nCharId].tbSkillLvs[nSkillIdx] + 1
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_skill_upgrade_req, mapMsg, nil, msgCallback)
end

function PlayerCharData:ReqCharFragmentRecruit(nCharId, callBack)
  local mapMsg = {Value = nCharId}
  
  local function successCallback(_, mapChangeInfo)
    local tbSpReward = {}
    local rewardData = {
      nId = nCharId,
      nType = GameEnum.itemType.Char,
      bNew = true
    }
    table.insert(tbSpReward, rewardData)
    EventManager.Hit(EventId.OpenPanel, PanelId.ReceiveSpecialReward, tbSpReward, callBack)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_recruitment_req, mapMsg, nil, successCallback)
end

function PlayerCharData:QueryLevelInfo(nId, nType, nParam1, nParam2)
  local function useSkillLevel(tbSkillLevel)
    if nParam1 == nil then
      return tbSkillLevel[1]
    elseif nParam1 == 2 then
      if nParam2 == GameEnum.MainOrSupport.SUPPORT then
        return tbSkillLevel[3]
      else
        return tbSkillLevel[2]
      end
    elseif nParam1 == 4 then
      return tbSkillLevel[4]
    elseif nParam1 == 5 then
      return tbSkillLevel[1]
    else
      return tbSkillLevel[1]
    end
  end
  
  if nType == GameEnum.levelTypeData.None then
    return 0
  elseif nType == GameEnum.levelTypeData.Exclusive then
    return 1
  elseif nType == GameEnum.levelTypeData.Actor then
    local mapTrialChar = self:GetTrialCharByCharId(nId)
    if mapTrialChar then
      return mapTrialChar.nLevel
    end
    if self._mapChar[nId] == nil then
      return 1
    end
    return self._mapChar[nId].nLevel
  elseif nType == GameEnum.levelTypeData.SkillSlot then
    local mapTrialChar = self:GetTrialCharByCharId(nId)
    if mapTrialChar then
      local tbSkillLevel = self:GetTrialCharSkillAddedLevel(mapTrialChar.nTrialId)
      return useSkillLevel(tbSkillLevel)
    end
    if self._mapChar[nId] == nil then
      return 1
    end
    local tbSkillLevel = self:GetCharSkillAddedLevel(nId)
    return useSkillLevel(tbSkillLevel)
  elseif nType == GameEnum.levelTypeData.BreakCount then
    local mapTrialChar = self:GetTrialCharByCharId(nId)
    if mapTrialChar then
      return mapTrialChar.nAdvance + 1
    end
    if self._mapChar[nId] == nil then
      return 1
    end
    return self._mapChar[nId].nAdvance + 1
  end
  return 1
end

function PlayerCharData:GetCharDatingEvent(nChar)
  local data = {}
  if self._mapChar[nChar] ~= nil then
    data.tbDatingEventIds = self._mapChar[nChar].tbDatingEventIds or {}
    data.tbDatingEventRewardIds = self._mapChar[nChar].tbDatingEventRewardIds or {}
  end
  return data
end

function PlayerCharData:CalCharacterAttrBattle(nCharId, stAttr, bMainChar, tbDiscId, nBuildId)
  local mapChar = self._mapChar[nCharId]
  if mapChar == nil then
    printError("没有该角色数据" .. nCharId)
    mapChar = {
      nLevel = 1,
      nAdvance = 0,
      tbSkillLvs = {
        1,
        1,
        1,
        1
      }
    }
  end
  local nLevel = mapChar.nLevel
  local nAdvance = mapChar.nAdvance
  local nAttrId = UTILS.GetCharacterAttributeId(nCharId, nAdvance, nLevel)
  local mapCharAttrCfg = ConfigTable.GetData_Attribute(tostring(nAttrId))
  if mapCharAttrCfg == nil then
    printError("属性配置不存在:" .. nAttrId)
    return {}
  end
  local mapCharCfg = ConfigTable.GetData_Character(nCharId)
  if mapCharCfg == nil then
    printError("角色配置不存在:" .. nCharId)
    return {}
  end
  for _, v in ipairs(AllEnum.AttachAttr) do
    if v.bPlayer and mapCharCfg[v.sKey] ~= nil then
      mapCharAttrCfg[v.sKey] = mapCharCfg[v.sKey]
    end
  end
  local mapDiscAttr = {}
  for _, v in ipairs(AllEnum.AttachAttr) do
    mapDiscAttr[v.sKey] = {
      Key = v.sKey,
      Value = 0,
      CfgValue = 0
    }
  end
  if tbDiscId ~= nil then
    for _, nDiscId in ipairs(tbDiscId) do
      local mapDisc = PlayerData.Disc:GetDiscById(nDiscId)
      if mapDisc and mapDisc.mapAttrBase then
        for _, v in ipairs(AllEnum.AttachAttr) do
          mapDiscAttr[v.sKey].CfgValue = mapDiscAttr[v.sKey].CfgValue + mapDisc.mapAttrBase[v.sKey].CfgValue
        end
      else
        printError("星盘数据有误id:" .. nDiscId)
      end
    end
  end
  local mapBuildAttr = {}
  if nBuildId ~= nil then
    mapBuildAttr = PlayerData.Build:GetBuildAttrBase(nBuildId)
  else
    for _, v in ipairs(AllEnum.AttachAttr) do
      mapBuildAttr[v.sKey] = {
        Key = v.sKey,
        Value = 0,
        CfgValue = 0
      }
    end
  end
  local tbSkillLevel = self:GetCharSkillAddedLevel(nCharId)
  if bMainChar == true then
    table.remove(tbSkillLevel, 3)
  else
    table.remove(tbSkillLevel, 2)
  end
  local mapCharAttr = {}
  for _, v in ipairs(AllEnum.AttachAttr) do
    mapCharAttr[v.sKey] = mapCharAttrCfg[v.sKey] + mapDiscAttr[v.sKey].CfgValue + mapBuildAttr[v.sKey].CfgValue
    mapCharAttr["_" .. v.sKey] = mapCharAttr[v.sKey]
    mapCharAttr["_" .. v.sKey .. "PercentAmend"] = 0
    mapCharAttr["_" .. v.sKey .. "Amend"] = 0
  end
  
  local function AddAttrEffect_AllEffectSub(nSubType, nValue, mapAttr)
    local value = tonumber(nValue) or 0
    if nSubType == GameEnum.parameterType.BASE_VALUE then
      local nAdd = mapAttr.bPercent and value or value * ConfigData.IntFloatPrecision
      mapCharAttr["_" .. mapAttr.sKey] = mapCharAttr["_" .. mapAttr.sKey] + nAdd
    end
  end
  
  local tbRandomAttr = PlayerData.Equipment:GetCharEquipmentRandomAttr(nCharId)
  if tbRandomAttr ~= nil then
    for nAttrValueId, v in pairs(tbRandomAttr) do
      local mapAttrCfg = ConfigTable.GetData("CharGemAttrValue", nAttrValueId)
      if mapAttrCfg then
        local attrType = mapAttrCfg.AttrType
        local attrSubType1 = mapAttrCfg.AttrTypeFirstSubtype
        local attrSubType2 = mapAttrCfg.AttrTypeSecondSubtype
        local bAttrFix = attrType == GameEnum.effectType.ATTR_FIX or attrType == GameEnum.effectType.PLAYER_ATTR_FIX
        if bAttrFix then
          local mapAttr = AttrConfig.GetAttrByEffectType(attrType, attrSubType1)
          if mapAttr == nil then
            printError(string.format("【装备随机属性】lua属性配置中没找到对应配置!!! attrId = %s", nAttrValueId))
          else
            AddAttrEffect_AllEffectSub(attrSubType2, v.CfgValue, mapAttr)
          end
        end
      end
    end
  end
  for _, v in ipairs(AllEnum.AttachAttr) do
    mapCharAttr[v.sKey] = mapCharAttr["_" .. v.sKey] * (1 + mapCharAttr["_" .. v.sKey .. "PercentAmend"] / 100) + mapCharAttr["_" .. v.sKey .. "Amend"]
    mapCharAttr[v.sKey] = math.floor(mapCharAttr[v.sKey])
  end
  local tbTalent = PlayerData.Talent:GetFateTalent(nCharId)
  stAttr.actorLevel = nLevel
  stAttr.breakCount = mapChar.nAdvance
  stAttr.activeTalentInfos = tbTalent
  stAttr.Atk = mapCharAttr.Atk
  stAttr.Hp = mapCharAttr.Hp
  stAttr.Def = mapCharAttr.Def
  stAttr.CritRate = mapCharAttr.CritRate
  stAttr.CritResistance = mapCharAttr.CritResistance
  stAttr.CritPower = mapCharAttr.CritPower
  stAttr.HitRate = mapCharAttr.HitRate
  stAttr.Evd = mapCharAttr.Evd
  stAttr.DefPierce = mapCharAttr.DefPierce
  stAttr.WEP = mapCharAttr.WEP
  stAttr.FEP = mapCharAttr.FEP
  stAttr.SEP = mapCharAttr.SEP
  stAttr.AEP = mapCharAttr.AEP
  stAttr.LEP = mapCharAttr.LEP
  stAttr.DEP = mapCharAttr.DEP
  stAttr.WEE = mapCharAttr.WEE
  stAttr.FEE = mapCharAttr.FEE
  stAttr.SEE = mapCharAttr.SEE
  stAttr.AEE = mapCharAttr.AEE
  stAttr.LEE = mapCharAttr.LEE
  stAttr.DEE = mapCharAttr.DEE
  stAttr.WER = mapCharAttr.WER
  stAttr.FER = mapCharAttr.FER
  stAttr.SER = mapCharAttr.SER
  stAttr.AER = mapCharAttr.AER
  stAttr.LER = mapCharAttr.LER
  stAttr.DER = mapCharAttr.DER
  stAttr.WEI = mapCharAttr.WEI
  stAttr.FEI = mapCharAttr.FEI
  stAttr.SEI = mapCharAttr.SEI
  stAttr.AEI = mapCharAttr.AEI
  stAttr.LEI = mapCharAttr.LEI
  stAttr.DEI = mapCharAttr.DEI
  stAttr.DefIgnore = mapCharAttr.DefIgnore
  stAttr.ShieldBonus = mapCharAttr.ShieldBonus
  stAttr.IncomingShieldBonus = mapCharAttr.IncomingShieldBonus
  stAttr.SkillLevel = tbSkillLevel
  stAttr.skinId = self:GetCharSkinId(nCharId)
  stAttr.attrId = tostring(nAttrId)
  stAttr.Suppress = mapCharAttr.Suppress
  stAttr.NormalDmgRatio = mapCharAttr.NORMALDMG
  stAttr.SkillDmgRatio = mapCharAttr.SKILLDMG
  stAttr.UltraDmgRatio = mapCharAttr.ULTRADMG
  stAttr.OtherDmgRatio = mapCharAttr.OTHERDMG
  stAttr.RcdNormalDmgRatio = mapCharAttr.RCDNORMALDMG
  stAttr.RcdSkillDmgRatio = mapCharAttr.RCDSKILLDMG
  stAttr.RcdUltraDmgRatio = mapCharAttr.RCDULTRADMG
  stAttr.RcdOtherDmgRatio = mapCharAttr.RCDOTHERDMG
  stAttr.MarkDmgRatio = mapCharAttr.MARKDMG
  stAttr.SummonDmgRatio = mapCharAttr.SUMMONDMG
  stAttr.RcdSummonDmgRatio = mapCharAttr.RCDSUMMONDMG
  stAttr.ProjectileDmgRatio = mapCharAttr.PROJECTILEDMG
  stAttr.RcdProjectileDmgRatio = mapCharAttr.RCDPROJECTILEDMG
  stAttr.GENDMG = mapCharAttr.GENDMG
  stAttr.DMGPLUS = mapCharAttr.DMGPLUS
  stAttr.FINALDMG = mapCharAttr.FINALDMG
  stAttr.FINALDMGPLUS = mapCharAttr.FINALDMGPLUS
  stAttr.WEERCD = mapCharAttr.WEERCD
  stAttr.FEERCD = mapCharAttr.FEERCD
  stAttr.SEERCD = mapCharAttr.SEERCD
  stAttr.AEERCD = mapCharAttr.AEERCD
  stAttr.LEERCD = mapCharAttr.LEERCD
  stAttr.DEERCD = mapCharAttr.DEERCD
  stAttr.GENDMGRCD = mapCharAttr.GENDMGRCD
  stAttr.DMGPLUSRCD = mapCharAttr.DMGPLUSRCD
  stAttr.NormalCritRate = mapCharAttr.NormalCritRate
  stAttr.SkillCritRate = mapCharAttr.SkillCritRate
  stAttr.UltraCritRate = mapCharAttr.UltraCritRate
  stAttr.MarkCritRate = mapCharAttr.MarkCritRate
  stAttr.SummonCritRate = mapCharAttr.SummonCritRate
  stAttr.ProjectileCritRate = mapCharAttr.ProjectileCritRate
  stAttr.OtherCritRate = mapCharAttr.OtherCritRate
  stAttr.NormalCritPower = mapCharAttr.NormalCritPower
  stAttr.SkillCritPower = mapCharAttr.SkillCritPower
  stAttr.UltraCritPower = mapCharAttr.UltraCritPower
  stAttr.MarkCritPower = mapCharAttr.MarkCritPower
  stAttr.SummonCritPower = mapCharAttr.SummonCritPower
  stAttr.ProjectileCritPower = mapCharAttr.ProjectileCritPower
  stAttr.OtherCritPower = mapCharAttr.OtherCritPower
  stAttr.ToughnessDamageAdjust = mapCharAttr.ToughnessDamageAdjust
  stAttr.EnergyConvRatio = mapCharAttr.EnergyConvRatio
  stAttr.EnergyEfficiency = mapCharAttr.EnergyEfficiency
  stAttr.initHp = 0
  return 0
end

function PlayerCharData:CalCharacterLimitedTrialAttrBattle(nTrialId, stAttr, bMainChar, tbDiscId, nBuildId)
  local mapChar = self._mapLimitedTrialChar[nTrialId]
  if mapChar == nil then
    printError("没有该限时试用角色数据" .. nTrialId)
    return 0
  end
  local nCharId = mapChar.nId
  local nLevel = mapChar.nLevel
  local nAdvance = mapChar.nAdvance
  local nAttrId = UTILS.GetCharacterAttributeId(nCharId, nAdvance, nLevel)
  local mapCharAttrCfg = ConfigTable.GetData_Attribute(tostring(nAttrId))
  if mapCharAttrCfg == nil then
    printError("属性配置不存在:" .. nAttrId)
    return {}
  end
  local mapCharCfg = ConfigTable.GetData_Character(nCharId)
  if mapCharCfg == nil then
    printError("角色配置不存在:" .. nCharId)
    return {}
  end
  for _, v in ipairs(AllEnum.AttachAttr) do
    if v.bPlayer and mapCharCfg[v.sKey] ~= nil then
      mapCharAttrCfg[v.sKey] = mapCharCfg[v.sKey]
    end
  end
  local mapDiscAttr = {}
  for _, v in ipairs(AllEnum.AttachAttr) do
    mapDiscAttr[v.sKey] = {
      Key = v.sKey,
      Value = 0,
      CfgValue = 0
    }
  end
  if tbDiscId ~= nil then
    for _, nDiscId in ipairs(tbDiscId) do
      local mapDisc = PlayerData.Disc:GetLimitedTrialDiscById(nDiscId)
      for _, v in ipairs(AllEnum.AttachAttr) do
        mapDiscAttr[v.sKey].CfgValue = mapDiscAttr[v.sKey].CfgValue + mapDisc.mapAttrBase[v.sKey].CfgValue
      end
    end
  end
  local mapBuildAttr = {}
  if nBuildId ~= nil then
    mapBuildAttr = PlayerData.Build:GetBuildAttrBase(nBuildId, true, AllEnum.BuildSource.LimitedTrial)
  else
    for _, v in ipairs(AllEnum.AttachAttr) do
      mapBuildAttr[v.sKey] = {
        Key = v.sKey,
        Value = 0,
        CfgValue = 0
      }
    end
  end
  local tbSkillLevel = self:GetLimitedTrialCharSkillAddedLevel(nTrialId)
  if bMainChar == true then
    table.remove(tbSkillLevel, 3)
  else
    table.remove(tbSkillLevel, 2)
  end
  local mapCharAttr = {}
  for _, v in ipairs(AllEnum.AttachAttr) do
    mapCharAttr[v.sKey] = mapCharAttrCfg[v.sKey] + mapDiscAttr[v.sKey].CfgValue + mapBuildAttr[v.sKey].CfgValue
  end
  local tbTalent = PlayerData.Talent:GetLimitedTrialFateTalent(nTrialId)
  stAttr.actorLevel = nLevel
  stAttr.breakCount = mapChar.nAdvance
  stAttr.activeTalentInfos = tbTalent
  stAttr.Atk = mapCharAttr.Atk
  stAttr.Hp = mapCharAttr.Hp
  stAttr.Def = mapCharAttr.Def
  stAttr.CritRate = mapCharAttr.CritRate
  stAttr.CritResistance = mapCharAttr.CritResistance
  stAttr.CritPower = mapCharAttr.CritPower
  stAttr.HitRate = mapCharAttr.HitRate
  stAttr.Evd = mapCharAttr.Evd
  stAttr.DefPierce = mapCharAttr.DefPierce
  stAttr.WEP = mapCharAttr.WEP
  stAttr.FEP = mapCharAttr.FEP
  stAttr.SEP = mapCharAttr.SEP
  stAttr.AEP = mapCharAttr.AEP
  stAttr.LEP = mapCharAttr.LEP
  stAttr.DEP = mapCharAttr.DEP
  stAttr.WEE = mapCharAttr.WEE
  stAttr.FEE = mapCharAttr.FEE
  stAttr.SEE = mapCharAttr.SEE
  stAttr.AEE = mapCharAttr.AEE
  stAttr.LEE = mapCharAttr.LEE
  stAttr.DEE = mapCharAttr.DEE
  stAttr.WER = mapCharAttr.WER
  stAttr.FER = mapCharAttr.FER
  stAttr.SER = mapCharAttr.SER
  stAttr.AER = mapCharAttr.AER
  stAttr.LER = mapCharAttr.LER
  stAttr.DER = mapCharAttr.DER
  stAttr.WEI = mapCharAttr.WEI
  stAttr.FEI = mapCharAttr.FEI
  stAttr.SEI = mapCharAttr.SEI
  stAttr.AEI = mapCharAttr.AEI
  stAttr.LEI = mapCharAttr.LEI
  stAttr.DEI = mapCharAttr.DEI
  stAttr.DefIgnore = mapCharAttr.DefIgnore
  stAttr.ShieldBonus = mapCharAttr.ShieldBonus
  stAttr.IncomingShieldBonus = mapCharAttr.IncomingShieldBonus
  stAttr.SkillLevel = tbSkillLevel
  stAttr.skinId = mapChar.nSkinId
  stAttr.attrId = tostring(nAttrId)
  stAttr.Suppress = mapCharAttr.Suppress
  stAttr.NormalDmgRatio = mapCharAttr.NORMALDMG
  stAttr.SkillDmgRatio = mapCharAttr.SKILLDMG
  stAttr.UltraDmgRatio = mapCharAttr.ULTRADMG
  stAttr.OtherDmgRatio = mapCharAttr.OTHERDMG
  stAttr.RcdNormalDmgRatio = mapCharAttr.RCDNORMALDMG
  stAttr.RcdSkillDmgRatio = mapCharAttr.RCDSKILLDMG
  stAttr.RcdUltraDmgRatio = mapCharAttr.RCDULTRADMG
  stAttr.RcdOtherDmgRatio = mapCharAttr.RCDOTHERDMG
  stAttr.MarkDmgRatio = mapCharAttr.MARKDMG
  stAttr.SummonDmgRatio = mapCharAttr.SUMMONDMG
  stAttr.RcdSummonDmgRatio = mapCharAttr.RCDSUMMONDMG
  stAttr.ProjectileDmgRatio = mapCharAttr.PROJECTILEDMG
  stAttr.RcdProjectileDmgRatio = mapCharAttr.RCDPROJECTILEDMG
  stAttr.GENDMG = mapCharAttr.GENDMG
  stAttr.DMGPLUS = mapCharAttr.DMGPLUS
  stAttr.FINALDMG = mapCharAttr.FINALDMG
  stAttr.FINALDMGPLUS = mapCharAttr.FINALDMGPLUS
  stAttr.WEERCD = mapCharAttr.WEERCD
  stAttr.FEERCD = mapCharAttr.FEERCD
  stAttr.SEERCD = mapCharAttr.SEERCD
  stAttr.AEERCD = mapCharAttr.AEERCD
  stAttr.LEERCD = mapCharAttr.LEERCD
  stAttr.DEERCD = mapCharAttr.DEERCD
  stAttr.GENDMGRCD = mapCharAttr.GENDMGRCD
  stAttr.DMGPLUSRCD = mapCharAttr.DMGPLUSRCD
  stAttr.NormalCritRate = mapCharAttr.NormalCritRate
  stAttr.SkillCritRate = mapCharAttr.SkillCritRate
  stAttr.UltraCritRate = mapCharAttr.UltraCritRate
  stAttr.MarkCritRate = mapCharAttr.MarkCritRate
  stAttr.SummonCritRate = mapCharAttr.SummonCritRate
  stAttr.ProjectileCritRate = mapCharAttr.ProjectileCritRate
  stAttr.OtherCritRate = mapCharAttr.OtherCritRate
  stAttr.NormalCritPower = mapCharAttr.NormalCritPower
  stAttr.SkillCritPower = mapCharAttr.SkillCritPower
  stAttr.UltraCritPower = mapCharAttr.UltraCritPower
  stAttr.MarkCritPower = mapCharAttr.MarkCritPower
  stAttr.SummonCritPower = mapCharAttr.SummonCritPower
  stAttr.ProjectileCritPower = mapCharAttr.ProjectileCritPower
  stAttr.OtherCritPower = mapCharAttr.OtherCritPower
  stAttr.ToughnessDamageAdjust = mapCharAttr.ToughnessDamageAdjust
  stAttr.EnergyConvRatio = mapCharAttr.EnergyConvRatio
  stAttr.EnergyEfficiency = mapCharAttr.EnergyEfficiency
  stAttr.initHp = 0
  return 0
end

function PlayerCharData:CalCharacterTrialAttrBattle(nTrialId, stAttr, bMainChar, tbDiscId, nBuildId)
  local mapChar = self._mapTrialChar[nTrialId]
  if mapChar == nil then
    printError("没有该角色数据" .. nTrialId)
    return 0
  end
  local nCharId = mapChar.nId
  local nLevel = mapChar.nLevel
  local nAdvance = mapChar.nAdvance
  local nAttrId = UTILS.GetCharacterAttributeId(nCharId, nAdvance, nLevel)
  local mapCharAttrCfg = ConfigTable.GetData_Attribute(tostring(nAttrId))
  if mapCharAttrCfg == nil then
    printError("属性配置不存在:" .. nAttrId)
    return {}
  end
  local mapCharCfg = ConfigTable.GetData_Character(nCharId)
  if mapCharCfg == nil then
    printError("角色配置不存在:" .. nCharId)
    return {}
  end
  for _, v in ipairs(AllEnum.AttachAttr) do
    if v.bPlayer and mapCharCfg[v.sKey] ~= nil then
      mapCharAttrCfg[v.sKey] = mapCharCfg[v.sKey]
    end
  end
  local mapDiscAttr = {}
  for _, v in ipairs(AllEnum.AttachAttr) do
    mapDiscAttr[v.sKey] = {
      Key = v.sKey,
      Value = 0,
      CfgValue = 0
    }
  end
  if tbDiscId ~= nil then
    for _, nDiscId in ipairs(tbDiscId) do
      local mapDisc = PlayerData.Disc:GetTrialDiscById(nDiscId)
      for _, v in ipairs(AllEnum.AttachAttr) do
        mapDiscAttr[v.sKey].CfgValue = mapDiscAttr[v.sKey].CfgValue + mapDisc.mapAttrBase[v.sKey].CfgValue
      end
    end
  end
  local mapBuildAttr = {}
  if nBuildId ~= nil then
    mapBuildAttr = PlayerData.Build:GetBuildAttrBase(nBuildId, true)
  else
    for _, v in ipairs(AllEnum.AttachAttr) do
      mapBuildAttr[v.sKey] = {
        Key = v.sKey,
        Value = 0,
        CfgValue = 0
      }
    end
  end
  local tbSkillLevel = self:GetTrialCharSkillAddedLevel(nTrialId)
  if bMainChar == true then
    table.remove(tbSkillLevel, 3)
  else
    table.remove(tbSkillLevel, 2)
  end
  local mapCharAttr = {}
  for _, v in ipairs(AllEnum.AttachAttr) do
    mapCharAttr[v.sKey] = mapCharAttrCfg[v.sKey] + mapDiscAttr[v.sKey].CfgValue + mapBuildAttr[v.sKey].CfgValue
  end
  local tbTalent = PlayerData.Talent:GetTrialFateTalent(nTrialId)
  stAttr.actorLevel = nLevel
  stAttr.breakCount = mapChar.nAdvance
  stAttr.activeTalentInfos = tbTalent
  stAttr.Atk = mapCharAttr.Atk
  stAttr.Hp = mapCharAttr.Hp
  stAttr.Def = mapCharAttr.Def
  stAttr.CritRate = mapCharAttr.CritRate
  stAttr.CritResistance = mapCharAttr.CritResistance
  stAttr.CritPower = mapCharAttr.CritPower
  stAttr.HitRate = mapCharAttr.HitRate
  stAttr.Evd = mapCharAttr.Evd
  stAttr.DefPierce = mapCharAttr.DefPierce
  stAttr.WEP = mapCharAttr.WEP
  stAttr.FEP = mapCharAttr.FEP
  stAttr.SEP = mapCharAttr.SEP
  stAttr.AEP = mapCharAttr.AEP
  stAttr.LEP = mapCharAttr.LEP
  stAttr.DEP = mapCharAttr.DEP
  stAttr.WEE = mapCharAttr.WEE
  stAttr.FEE = mapCharAttr.FEE
  stAttr.SEE = mapCharAttr.SEE
  stAttr.AEE = mapCharAttr.AEE
  stAttr.LEE = mapCharAttr.LEE
  stAttr.DEE = mapCharAttr.DEE
  stAttr.WER = mapCharAttr.WER
  stAttr.FER = mapCharAttr.FER
  stAttr.SER = mapCharAttr.SER
  stAttr.AER = mapCharAttr.AER
  stAttr.LER = mapCharAttr.LER
  stAttr.DER = mapCharAttr.DER
  stAttr.WEI = mapCharAttr.WEI
  stAttr.FEI = mapCharAttr.FEI
  stAttr.SEI = mapCharAttr.SEI
  stAttr.AEI = mapCharAttr.AEI
  stAttr.LEI = mapCharAttr.LEI
  stAttr.DEI = mapCharAttr.DEI
  stAttr.DefIgnore = mapCharAttr.DefIgnore
  stAttr.ShieldBonus = mapCharAttr.ShieldBonus
  stAttr.IncomingShieldBonus = mapCharAttr.IncomingShieldBonus
  stAttr.SkillLevel = tbSkillLevel
  stAttr.skinId = self:GetCharSkinId(nCharId)
  stAttr.attrId = tostring(nAttrId)
  stAttr.Suppress = mapCharAttr.Suppress
  stAttr.NormalDmgRatio = mapCharAttr.NORMALDMG
  stAttr.SkillDmgRatio = mapCharAttr.SKILLDMG
  stAttr.UltraDmgRatio = mapCharAttr.ULTRADMG
  stAttr.OtherDmgRatio = mapCharAttr.OTHERDMG
  stAttr.RcdNormalDmgRatio = mapCharAttr.RCDNORMALDMG
  stAttr.RcdSkillDmgRatio = mapCharAttr.RCDSKILLDMG
  stAttr.RcdUltraDmgRatio = mapCharAttr.RCDULTRADMG
  stAttr.RcdOtherDmgRatio = mapCharAttr.RCDOTHERDMG
  stAttr.MarkDmgRatio = mapCharAttr.MARKDMG
  stAttr.SummonDmgRatio = mapCharAttr.SUMMONDMG
  stAttr.RcdSummonDmgRatio = mapCharAttr.RCDSUMMONDMG
  stAttr.ProjectileDmgRatio = mapCharAttr.PROJECTILEDMG
  stAttr.RcdProjectileDmgRatio = mapCharAttr.RCDPROJECTILEDMG
  stAttr.GENDMG = mapCharAttr.GENDMG
  stAttr.DMGPLUS = mapCharAttr.DMGPLUS
  stAttr.FINALDMG = mapCharAttr.FINALDMG
  stAttr.FINALDMGPLUS = mapCharAttr.FINALDMGPLUS
  stAttr.WEERCD = mapCharAttr.WEERCD
  stAttr.FEERCD = mapCharAttr.FEERCD
  stAttr.SEERCD = mapCharAttr.SEERCD
  stAttr.AEERCD = mapCharAttr.AEERCD
  stAttr.LEERCD = mapCharAttr.LEERCD
  stAttr.DEERCD = mapCharAttr.DEERCD
  stAttr.GENDMGRCD = mapCharAttr.GENDMGRCD
  stAttr.DMGPLUSRCD = mapCharAttr.DMGPLUSRCD
  stAttr.NormalCritRate = mapCharAttr.NormalCritRate
  stAttr.SkillCritRate = mapCharAttr.SkillCritRate
  stAttr.UltraCritRate = mapCharAttr.UltraCritRate
  stAttr.MarkCritRate = mapCharAttr.MarkCritRate
  stAttr.SummonCritRate = mapCharAttr.SummonCritRate
  stAttr.ProjectileCritRate = mapCharAttr.ProjectileCritRate
  stAttr.OtherCritRate = mapCharAttr.OtherCritRate
  stAttr.NormalCritPower = mapCharAttr.NormalCritPower
  stAttr.SkillCritPower = mapCharAttr.SkillCritPower
  stAttr.UltraCritPower = mapCharAttr.UltraCritPower
  stAttr.MarkCritPower = mapCharAttr.MarkCritPower
  stAttr.SummonCritPower = mapCharAttr.SummonCritPower
  stAttr.ProjectileCritPower = mapCharAttr.ProjectileCritPower
  stAttr.OtherCritPower = mapCharAttr.OtherCritPower
  stAttr.ToughnessDamageAdjust = mapCharAttr.ToughnessDamageAdjust
  stAttr.EnergyConvRatio = mapCharAttr.EnergyConvRatio
  stAttr.EnergyEfficiency = mapCharAttr.EnergyEfficiency
  stAttr.initHp = 0
  return 0
end

function PlayerCharData:UpdateAllCharRecordInfoRedDot()
  for charId, v in pairs(self._mapChar) do
    self:UpdateCharRecordInfoReddot(charId, false)
  end
end

function PlayerCharData:UpdateCharRecordReddot(nCharId, bReset, lastLevel, curLevel)
  local bNew = false
  if lastLevel ~= nil and curLevel ~= nil and lastLevel < curLevel then
    bNew = true
    LocalData.SetPlayerLocalData("CharacterArchive" .. nCharId, lastLevel)
  else
    bNew = not bReset
    if bNew then
      lastLevel = LocalData.GetPlayerLocalData("CharacterArchive" .. nCharId)
      local mapData = self:GetCharAffinityData(nCharId)
      curLevel = mapData ~= nil and mapData.Level or nil
    else
      LocalData.DelPlayerLocalData("CharacterArchive" .. nCharId)
    end
  end
  
  local function foreachCharacterArchive(mapData)
    if mapData.CharacterId == nCharId then
      if not bNew then
        RedDotManager.SetValid(RedDotDefine.Role_Record_Info_Item, {
          nCharId,
          mapData.Id
        }, false)
      elseif lastLevel ~= nil and curLevel ~= nil and curLevel > lastLevel and mapData.UnlockAffinityLevel > 0 and mapData.UnlockAffinityLevel > lastLevel and mapData.UnlockAffinityLevel <= curLevel then
        RedDotManager.SetValid(RedDotDefine.Role_Record_Info_Item, {
          nCharId,
          mapData.Id
        }, true)
      end
    end
  end
  
  ForEachTableLine(DataTable.CharacterArchive, foreachCharacterArchive)
end

function PlayerCharData:UpdateCharSkinTrialRedDot(sId)
  local sKey = tostring(sId) .. "SkinTrial"
  local bIsFirst = LocalData.GetPlayerLocalData(sKey)
  if bIsFirst == nil then
    bIsFirst = true
  else
    bIsFirst = false
  end
  RedDotManager.SetValid(RedDotDefine.Mall_CharSkinTrial, {sId}, bIsFirst)
end

function PlayerCharData:SetCharSkinTrialRedDot(sId)
  local sKey = tostring(sId) .. "SkinTrial"
  LocalData.SetPlayerLocalData(sKey, false)
  RedDotManager.SetValid(RedDotDefine.Mall_CharSkinTrial, {sId}, false)
end

function PlayerCharData:ClearCharSkinTrialRedDot(sId)
  local sKey = tostring(sId) .. "SkinTrial"
  if LocalData.GetPlayerLocalData(sKey) ~= nil then
    LocalData.DelPlayerLocalData(sKey)
  end
end

function PlayerCharData:UpdateCharVoiceReddot(nCharId, bReset, lastLevel, curLevel, nPlotId)
  local bNew = false
  if lastLevel ~= nil and curLevel ~= nil and lastLevel < curLevel then
    bNew = true
    LocalData.SetPlayerLocalData("CharacterArchiveVoice" .. nCharId, lastLevel)
  else
    bNew = not bReset
    if bNew then
      lastLevel = LocalData.GetPlayerLocalData("CharacterArchiveVoice" .. nCharId)
      local mapData = self:GetCharAffinityData(nCharId)
      curLevel = mapData ~= nil and mapData.Level or nil
    else
      LocalData.DelPlayerLocalData("CharacterArchiveVoice" .. nCharId)
    end
  end
  
  local function foreachCharacterArchiveVoice(mapData)
    if mapData.CharacterId == nCharId then
      if not bNew then
        RedDotManager.SetValid(RedDotDefine.Role_Record_Voice_Item, {
          nCharId,
          mapData.Id
        }, false)
      else
        if lastLevel ~= nil and curLevel ~= nil and curLevel > lastLevel and mapData.UnlockAffinityLevel > 0 and mapData.UnlockAffinityLevel > lastLevel and mapData.UnlockAffinityLevel <= curLevel then
          RedDotManager.SetValid(RedDotDefine.Role_Record_Voice_Item, {
            nCharId,
            mapData.Id
          }, true)
        end
        if nPlotId ~= nil and nPlotId == mapData.UnlockPlot then
          RedDotManager.SetValid(RedDotDefine.Role_Record_Voice_Item, {
            nCharId,
            mapData.Id
          }, true)
        end
      end
    end
  end
  
  ForEachTableLine(DataTable.CharacterArchiveVoice, foreachCharacterArchiveVoice)
end

function PlayerCharData:UpdateCharSkinVoiceReddot(bReset, nCharId, nSkinId)
  local mapData = self:GetCharAffinityData(nCharId)
  local curLevel = mapData ~= nil and mapData.Level or 0
  
  local function foreachCharacterArchiveVoice(mapData)
    if mapData.CharacterId == nCharId and mapData.ArchVoiceType == GameEnum.ArchVoiceType.SkinVoice and mapData.UnlockSkinId == nSkinId then
      if bReset then
        RedDotManager.SetValid(RedDotDefine.Role_Record_Voice_Item, {
          nCharId,
          mapData.Id
        }, false)
      else
        local bAffinityLevel = mapData.UnlockAffinityLevel > 0 and mapData.UnlockAffinityLevel <= curLevel or mapData.UnlockAffinityLevel == 0
        local bPlot = 0 < mapData.UnlockPlot and mapData.UnlockAffinityLevel <= curLevel or mapData.UnlockPlot == 0
        if bAffinityLevel and bPlot then
          RedDotManager.SetValid(RedDotDefine.Role_Record_Voice_Item, {
            nCharId,
            mapData.Id
          }, true)
        end
      end
    end
  end
  
  ForEachTableLine(DataTable.CharacterArchiveVoice, foreachCharacterArchiveVoice)
end

function PlayerCharData:UpdateCharPlotReddot(nCharId)
  local tbPlot = CacheTable.GetData("_Plot", nCharId)
  if tbPlot ~= nil then
    for _, v in ipairs(tbPlot) do
      local bValid = false
      local bLocked, txt = self:IsPlotUnlock(v.Id, nCharId)
      if not bLocked then
        bValid = not self:IsCharPlotFinish(nCharId, v.Id)
      end
      RedDotManager.SetValid(RedDotDefine.Role_AffinityPlotItem, {
        nCharId,
        v.Id
      }, bValid)
    end
  end
end

function PlayerCharData:UpdateCharArchiveRewardRedDot(nCharId)
  local affinityData = self:GetCharAffinityData(nCharId)
  if affinityData == nil then
    return
  end
  local nCurFavorLevel = affinityData.Level
  
  local function foreachCharacterArchive(mapData)
    if mapData.CharacterId == nCharId then
      local bReward = false
      if mapData.UnlockAffinityLevel <= nCurFavorLevel and mapData.ArchType == GameEnum.ArchType.SpecialType and mapData.ArchReward ~= 0 then
        bReward = not self:CheckCharArchiveReward(nCharId, mapData.Id)
      end
      RedDotManager.SetValid(RedDotDefine.Role_RecordRewardItem, {
        nCharId,
        mapData.Id
      }, bReward)
    end
  end
  
  ForEachTableLine(DataTable.CharacterArchive, foreachCharacterArchive)
end

function PlayerCharData:UpdateCharRecordInfoReddot(nCharId, bReset, lastLevel, curLevel)
  self:UpdateCharPlotReddot(nCharId)
  self:UpdateCharRecordReddot(nCharId, bReset, lastLevel, curLevel)
  self:UpdateCharVoiceReddot(nCharId, bReset, lastLevel, curLevel)
  self:UpdateCharArchiveRewardRedDot(nCharId)
end

function PlayerCharData:InitCharArchiveContentUpdateRedDot(nCharId)
  local tbContentList = self._tbArchiveUpdate[nCharId]
  if tbContentList ~= nil then
    for nId, v in pairs(tbContentList) do
      local bUpdate, nValue = self:CheckCharArchiveContentUpdate(nCharId, nId)
      self._tbArchiveUpdate[nCharId][nId].nValue = bUpdate and -1 or nValue
    end
  end
  local tbBaseContentList = self._tbArchiveBaseUpdate[nCharId]
  if tbBaseContentList ~= nil then
    for nId, v in pairs(tbBaseContentList) do
      local bUpdate, nValue = self:CheckCharArchiveBaseContentUpdate(nCharId, nId)
      self._tbArchiveBaseUpdate[nCharId][nId].nValue = bUpdate and -1 or nValue
    end
  end
end

function PlayerCharData:UpdateCharArchiveContentUpdateRedDot(nCharId, nIndex, nNewValue, nLastValue)
  local affinityData = PlayerData.Char:GetCharAffinityData(nCharId)
  if affinityData == nil then
    return
  end
  local nCurFavourLevel = affinityData.Level
  local tbContentList = self._tbArchiveUpdate[nCharId]
  if tbContentList ~= nil then
    for nId, v in pairs(tbContentList) do
      if v.nValue ~= -1 then
        local bUpdate = false
        if nIndex == 1 and v.UpdateAff1 > 0 and v.nValue & 1 == 0 then
          bUpdate = nLastValue < v.UpdateAff1 and nNewValue >= v.UpdateAff1
        elseif nIndex == 2 and 0 < v.UpdatePlot1 and v.nValue >> 1 & 1 == 0 then
          bUpdate = v.UpdatePlot1 == nNewValue
        elseif nIndex == 3 and 0 < v.UpdateStory1 and v.nValue >> 2 & 1 == 0 then
          bUpdate = PlayerData.Avg:IsStoryReaded(v.UpdateStory1)
        end
        if bUpdate then
          self._tbArchiveUpdate[nCharId][nId].nValue = 1 << nIndex - 1 | v.nValue
        end
      end
      local mapCfg = ConfigTable.GetData("CharacterArchive", nId)
      local bUnlock = false
      if mapCfg ~= nil then
        bUnlock = nCurFavourLevel >= mapCfg.UnlockAffinityLevel
      end
      RedDotManager.SetValid(RedDotDefine.Role_Record_InfoUpdate_Item, {nCharId, nId}, self._tbArchiveUpdate[nCharId][nId].nValue == 7 and bUnlock)
    end
  end
  local tbBaseContentList = self._tbArchiveBaseUpdate[nCharId]
  if tbBaseContentList ~= nil then
    local bBaseInfoUpdate = false
    for nId, v in pairs(tbBaseContentList) do
      if v.nValue ~= -1 then
        local bUpdate = false
        if nIndex == 1 and v.UpdateAff1 > 0 and v.nValue & 1 == 0 then
          bUpdate = nLastValue < v.UpdateAff1 and nNewValue >= v.UpdateAff1
        elseif nIndex == 2 and 0 < v.UpdatePlot1 and v.nValue >> 1 & 1 == 0 then
          bUpdate = v.UpdatePlot1 == nNewValue
        elseif nIndex == 3 and 0 < v.UpdateStory1 and v.nValue >> 2 & 1 == 0 then
          bUpdate = PlayerData.Avg:IsStoryReaded(v.UpdateStory1)
        end
        bBaseInfoUpdate = bBaseInfoUpdate or bUpdate
        if bUpdate then
          self._tbArchiveBaseUpdate[nCharId][nId].nValue = 1 << nIndex - 1 | v.nValue
        end
      end
      RedDotManager.SetValid(RedDotDefine.Role_Record_BaseInfoUpdate_Item, nCharId, bBaseInfoUpdate)
    end
  end
end

function PlayerCharData:StoryPass(tbStoryId)
  if 0 < #tbStoryId then
    for nCharId, v in pairs(self._tbArchiveUpdate) do
      for _, nStoryId in ipairs(tbStoryId) do
        self:UpdateCharArchiveContentUpdateRedDot(nCharId, 3, nStoryId)
      end
    end
  end
end

function PlayerCharData:ResetArchiveContentUpdateRedDot(nCharId)
  local tbContentList = self._tbArchiveUpdate[nCharId]
  if tbContentList ~= nil then
    for nId, v in pairs(tbContentList) do
      if v.nValue == 7 then
        v.nValue = -1
        RedDotManager.SetValid(RedDotDefine.Role_Record_InfoUpdate_Item, {nCharId, nId}, false)
      end
      RedDotManager.SetValid(RedDotDefine.Role_Record_BaseInfoUpdate_Item, nCharId, false)
    end
  end
end

function PlayerCharData:GetCharPanelSkillDescType(...)
  return self.bCharPanel_IsSimpleDesc
end

function PlayerCharData:SetCharPanelSkillDescType(bIsSimple)
  self.bCharPanel_IsSimpleDesc = bIsSimple
  LocalData.SetLocalData("Char_", "CharPanel_IsSimpleDesc", self.bCharPanel_IsSimpleDesc)
end

function PlayerCharData:GetTipsPanelSkillDescType(...)
  return self.bTipsPanel_IsSimpleDesc
end

function PlayerCharData:SetTipsPanelSkillDescType(bIsSimple)
  self.bTipsPanel_IsSimpleDesc = bIsSimple
  LocalData.SetLocalData("Char_", "TipsPanel_IsSimpleDesc", self.bTipsPanel_IsSimpleDesc)
end

local tbSortNameTextCfg = {
  "CharList_Sort_Toggle_Level",
  "CharList_Sort_Toggle_Rare",
  "CharList_Sort_Toggle_Skill",
  "CharList_Sort_Toggle_Affinity",
  "CharList_Sort_Toggle_Time"
}
local tbSortType = {
  [1] = AllEnum.SortType.Level,
  [2] = AllEnum.SortType.Rarity,
  [3] = AllEnum.SortType.Skill,
  [4] = AllEnum.SortType.Affinity,
  [5] = AllEnum.SortType.Time,
  [100] = AllEnum.SortType.ElementType,
  [101] = AllEnum.SortType.Id
}
local tbDefaultSortField = {
  "Level",
  "Rare",
  "EET",
  "nId"
}

function PlayerCharData:GetCharSortNameTextCfg()
  return tbSortNameTextCfg
end

function PlayerCharData:GetCharSortType()
  return tbSortType
end

function PlayerCharData:GetCharSortField()
  return tbDefaultSortField
end

return PlayerCharData
