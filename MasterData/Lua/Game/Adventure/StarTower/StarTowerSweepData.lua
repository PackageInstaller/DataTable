local StarTowerSweepData = class("StarTowerSweepData")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local StarTowerAutoDecision = require("Game.Adventure.StarTower.StarTowerAutoDecision")
local TimerManager = require("GameCore.Timer.TimerManager")
local StarTowerSettingGate = require("Game.Adventure.StarTower.StarTowerSettingGate")
local AUTO_REQUEST_TIMEOUT = 30
local mapEventConfig = {
  StarTowerReward = "OnEvent_RewardPopup",
  PotentialLevelUp = "OnEvent_PotentialPopup",
  ShopStrengthFx = "OnEvent_ShopStrengthFx"
}

function StarTowerSweepData:ctor(nStarTowerId)
  self.EnumCase = {
    Battle = 1,
    OpenDoor = 2,
    PotentialSelect = 3,
    FateCardSelect = 4,
    NoteSelect = 5,
    NpcEvent = 6,
    SelectSpecialPotential = 7,
    RecoveryHP = 8,
    NpcRecoveryHP = 9,
    Hawker = 10,
    StrengthenMachine = 11,
    DoorDanger = 12,
    SyncHP = 13
  }
  self.EnumPopup = {
    Disc = 1,
    Reward = 2,
    Potential = 3,
    StrengthFx = 4,
    Affinity = 5
  }
  self:BindEvent()
  
  local function BuildStarTowerAllFloorData(nTowerId)
    local mapStarTowerCfgData = ConfigTable.GetData("StarTower", nTowerId)
    if mapStarTowerCfgData == nil then
      return {}
    end
    local ret = {}
    local levelDifficulty = mapStarTowerCfgData.Difficulty
    local difficulty = mapStarTowerCfgData.ValueDifficulty
    local tbStage = mapStarTowerCfgData.StageGroupIds
    local tbFloorNum = mapStarTowerCfgData.FloorNum
    for nIdx, nStageGroupId in ipairs(tbStage) do
      local nFloorNum = tbFloorNum[nIdx]
      if nFloorNum == nil then
        nFloorNum = 99
        printError("FloorNum Missing��" .. nTowerId .. " " .. nIdx)
      end
      for nLevel = 1, nFloorNum do
        local nStageLevelId = nStageGroupId * 100 + nLevel
        if ConfigTable.GetData("StarTowerStage", nStageLevelId) == nil then
          break
        end
        table.insert(ret, ConfigTable.GetData("StarTowerStage", nStageLevelId))
      end
    end
    return ret, difficulty, levelDifficulty
  end
  
  local function BuildStarTowerExpData(nTowerId)
    local ret = {}
    
    local function forEachExp(mapData)
      if mapData.StarTowerId == nTowerId then
        ret[mapData.Stage] = mapData
      end
    end
    
    ForEachTableLine(DataTable.StarTowerFloorExp, forEachExp)
    return ret
  end
  
  self.nTowerId = nStarTowerId
  self.nCurLevel = 1
  self.bRanking = false
  self.tbStarTowerAllLevel, self.nStarTowerDifficulty, self.nStarTowerLevelDifficulty = BuildStarTowerAllFloorData(self.nTowerId)
  self.mapFloorExp = BuildStarTowerExpData(self.nTowerId)
  self.tbStrengthMachineCost = ConfigTable.GetConfigNumberArray("StrengthenMachineGoldConsume")
  self._bAutoDecisionEnabled = false
  self._bAutoDecisionPaused = false
  self._bAutoRequestPending = false
  self._nAutoDecisionSerial = 0
  self._mapPendingAutoDecision = nil
  self._timerAutoDecision = nil
  self._timerAutoRequestTimeout = nil
  self._autoShopCompleteCallback = nil
  self._bOpenManualAfterAutoRequest = false
end

function StarTowerSweepData:BuildAutoDecisionContext()
  local mapPlan = PlayerData.StarTowerAutoPlan and PlayerData.StarTowerAutoPlan:GetSelectedDecisionPlan() or nil
  local nToken = PlayerData.StarTowerAutoPlan and PlayerData.StarTowerAutoPlan:GetTokenCount() or 0
  return StarTowerAutoDecision:BuildContext(self, mapPlan, {
    bAutoEnabled = self:IsAutoDecisionEnabled(),
    nToken = nToken,
    nTokenCost = ConfigTable.GetConfigNumber("TowerVitaEachActionConsumedEnergy"),
    mapNeedNote = self:BuildAutoNeedNoteMap()
  })
end

function StarTowerSweepData:BuildAutoNeedNoteMap()
  local mapNeedNote = {}
  for nIndex, nDiscId in ipairs(self.tbDisc or {}) do
    if 3 < nIndex then
      break
    end
    local mapDiscData = self.mapDiscData and self.mapDiscData[nDiscId] or nil
    if mapDiscData ~= nil then
      for _, nSkillGroupId in ipairs(mapDiscData.tbSubSkillGroupId or {}) do
        local tbSkillGroup = CacheTable.GetData("_SecondarySkill", nSkillGroupId)
        local nCurLayer = 0
        for nLayer = #(tbSkillGroup or {}), 1, -1 do
          if mapDiscData:CheckSubSkillActive(self._mapNote, tbSkillGroup[nLayer]) then
            nCurLayer = nLayer
            break
          end
        end
        local mapNextSkill = tbSkillGroup and tbSkillGroup[nCurLayer + 1] or nil
        if mapNextSkill ~= nil then
          local mapRequiredNote = decodeJson(mapNextSkill.NeedSubNoteSkills) or {}
          for sNoteId, nRequiredCount in pairs(mapRequiredNote) do
            local nNoteId = tonumber(sNoteId)
            nRequiredCount = tonumber(nRequiredCount) or 0
            if nNoteId ~= nil and nRequiredCount > (self._mapNote[nNoteId] or 0) then
              mapNeedNote[nNoteId] = true
            end
          end
        end
      end
    end
  end
  return mapNeedNote
end

function StarTowerSweepData:NotifyAutoDecisionState(nFailReason)
  EventManager.Hit("StarTowerAutoDecisionStateChanged", {
    bEnabled = self._bAutoDecisionEnabled == true,
    bPaused = self._bAutoDecisionPaused == true,
    bPending = self._mapPendingAutoDecision ~= nil,
    bRequesting = self._bAutoRequestPending == true,
    nActionType = self._mapPendingAutoDecision and self._mapPendingAutoDecision.nActionType or StarTowerAutoDecision.ActionType.None,
    nFailReason = nFailReason or StarTowerAutoDecision.FailReason.None,
    nToken = PlayerData.StarTowerAutoPlan and PlayerData.StarTowerAutoPlan:GetTokenCount() or 0
  })
end

function StarTowerSweepData:IsAutoDecisionEnabled()
  return self._bAutoDecisionEnabled == true and self._bAutoDecisionPaused ~= true and self.bEnd ~= true
end

function StarTowerSweepData:IsAutoDecisionBusy()
  return self._mapPendingAutoDecision ~= nil or self._bAutoRequestPending == true
end

function StarTowerSweepData:GetPendingAutoDecision()
  return self._mapPendingAutoDecision
end

function StarTowerSweepData:CancelPendingAutoDecision()
  self._nAutoDecisionSerial = self._nAutoDecisionSerial + 1
  self._mapPendingAutoDecision = nil
  if self._timerAutoDecision ~= nil then
    TimerManager.Remove(self._timerAutoDecision, false)
    self._timerAutoDecision = nil
  end
  self:NotifyAutoDecisionState()
end

function StarTowerSweepData:SetAutoDecisionPaused(bPaused)
  bPaused = bPaused == true
  if self._bAutoDecisionPaused == bPaused then
    return
  end
  self._bAutoDecisionPaused = bPaused
  if not bPaused and self._bAutoDecisionEnabled then
    self._bAutoShopFinished = false
    self._bAutoShopExhausted = false
    self._bAutoUpgradeBeforeShopSpendAll = false
  end
  self:CancelPendingAutoDecision()
  if not bPaused and self._bAutoDecisionEnabled and not self._bAutoRequestPending then
    self:HandleCases()
  end
end

function StarTowerSweepData:SetAutoDecisionEnabled(bEnabled, bOpenManual)
  bEnabled = bEnabled == true
  if bEnabled and self.bEnd then
    return false, StarTowerAutoDecision.FailReason.Disabled
  end
  if not bEnabled then
    self:StopAutoDecision(StarTowerAutoDecision.FailReason.Disabled, bOpenManual == true)
    return true
  end
  local mapPlan = PlayerData.StarTowerAutoPlan and PlayerData.StarTowerAutoPlan:GetSelectedDecisionPlan() or nil
  if mapPlan == nil or mapPlan.bEnabled ~= true then
    self:NotifyAutoDecisionState(StarTowerAutoDecision.FailReason.Disabled)
    return false, StarTowerAutoDecision.FailReason.Disabled
  end
  if not self._bAutoDecisionEnabled or self._bAutoDecisionPaused then
    self._bAutoShopFinished = false
    self._bAutoShopExhausted = false
    self._bAutoUpgradeBeforeShopSpendAll = false
  end
  self._bAutoDecisionEnabled = true
  self._bAutoDecisionPaused = false
  self._bOpenManualAfterAutoRequest = false
  self:CancelPendingAutoDecision()
  if not self._bAutoRequestPending and self.mapCases ~= nil then
    self:HandleCases()
  end
  return true
end

function StarTowerSweepData:StopAutoDecision(nReason, bOpenManual)
  local bWasEnabled = self._bAutoDecisionEnabled == true
  local bRequestPending = self._bAutoRequestPending == true
  local bHadPendingDecision = self._mapPendingAutoDecision ~= nil or self._autoShopCompleteCallback ~= nil
  local bShouldOpenManual = bOpenManual and bWasEnabled and (bRequestPending or bHadPendingDecision)
  self._bAutoDecisionEnabled = false
  self._bAutoDecisionPaused = false
  self._autoShopCompleteCallback = nil
  self._bOpenManualAfterAutoRequest = bShouldOpenManual and bRequestPending
  self:CancelPendingAutoDecision()
  self:NotifyAutoDecisionState(nReason)
  if bShouldOpenManual and not bRequestPending then
    EventManager.Hit("StarTowerAutoDecisionRequestManual")
  end
end

function StarTowerSweepData:EndExploration()
  if self.bEnd then
    return false
  end
  self.bEnd = true
  self._mapStrengthMachineRequest = nil
  self:StopAutoDecision(StarTowerAutoDecision.FailReason.Disabled, false)
  self:FinishAutoRequest(false, StarTowerAutoDecision.FailReason.Disabled)
  EventManager.Hit("StarTowerSweepEnd")
  return true
end

function StarTowerSweepData:TryOpenManualAfterAutoRequest()
  if self.bEnd or self._bOpenManualAfterAutoRequest ~= true then
    return false
  end
  self._bOpenManualAfterAutoRequest = false
  EventManager.Hit("StarTowerAutoDecisionRequestManual")
  return true
end

function StarTowerSweepData:BeginAutoRequest(nCaseId, nActionType)
  if self.bEnd or self._bAutoRequestPending then
    return false
  end
  self._bAutoRequestPending = true
  self._mapPendingAutoDecision = {nCaseId = nCaseId, nActionType = nActionType}
  self._timerAutoRequestTimeout = TimerManager.Add(1, AUTO_REQUEST_TIMEOUT, self, function()
    if self._bAutoRequestPending then
      self:StopAutoDecision(StarTowerAutoDecision.FailReason.InvalidParam, true)
      self:FinishAutoRequest(false, StarTowerAutoDecision.FailReason.InvalidParam)
      self:TryOpenManualAfterAutoRequest()
    end
  end, true, true, true)
  self:NotifyAutoDecisionState()
  return true
end

function StarTowerSweepData:FinishAutoRequest(bSuccess, nFailReason)
  if not self._bAutoRequestPending then
    return false
  end
  self._bAutoRequestPending = false
  self._mapPendingAutoDecision = nil
  if self._timerAutoRequestTimeout ~= nil then
    TimerManager.Remove(self._timerAutoRequestTimeout, false)
    self._timerAutoRequestTimeout = nil
  end
  if bSuccess then
  end
  self:NotifyAutoDecisionState(nFailReason)
  return true
end

function StarTowerSweepData:ScheduleAutoDecision(mapDecision, mapGuard, executeCallback)
  if type(mapDecision) ~= "table" or mapDecision.bSuccess ~= true then
    return false
  end
  if self:IsAutoDecisionBusy() or not self:IsAutoDecisionEnabled() then
    return false
  end
  local nSerial = self._nAutoDecisionSerial
  self._mapPendingAutoDecision = mapDecision
  self:NotifyAutoDecisionState()
  self._timerAutoDecision = TimerManager.Add(1, mapDecision.nDelay or 2, self, function()
    self._timerAutoDecision = nil
    if nSerial ~= self._nAutoDecisionSerial or not self:IsAutoDecisionEnabled() then
      return
    end
    if type(mapGuard) == "table" and type(mapGuard.isValidCallback) == "function" and not mapGuard.isValidCallback() then
      self._mapPendingAutoDecision = nil
      self:NotifyAutoDecisionState()
      if type(mapGuard.invalidCallback) == "function" then
        mapGuard.invalidCallback()
      end
      return
    end
    if mapDecision.bNeedToken == true then
      local mapContext = self:BuildAutoDecisionContext()
      local bCanConsume = StarTowerAutoDecision:CanConsumeToken(mapContext, mapDecision.nActionType)
      if not bCanConsume then
        self:StopAutoDecision(StarTowerAutoDecision.FailReason.TokenNotEnough, true)
        return
      end
    end
    self._mapPendingAutoDecision = nil
    if type(mapGuard) == "table" and mapGuard.bLocalAction == true then
      self:NotifyAutoDecisionState()
      executeCallback(true)
      return
    end
    if self:BeginAutoRequest(mapGuard and mapGuard.nCaseId, mapDecision.nActionType) then
      executeCallback(true)
    end
  end, true, true, true)
  return true
end

function StarTowerSweepData:HandleAutoDecisionFail(mapDecision, openManualCallback)
  local nFailReason = mapDecision and mapDecision.nFailReason or StarTowerAutoDecision.FailReason.InvalidParam
  if nFailReason ~= StarTowerAutoDecision.FailReason.Disabled then
    self:StopAutoDecision(nFailReason, false)
  end
  if type(openManualCallback) == "function" then
    openManualCallback()
  end
end

function StarTowerSweepData:BindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Add(nEventId, self, callback)
    end
  end
end

function StarTowerSweepData:UnBindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
end

function StarTowerSweepData:Init(mapMeta, mapRoom, mapBag)
  local function GetCharacterAttr(tbTeam, mapDisc)
    local ret = {}
    
    for idx, nTid in ipairs(tbTeam) do
      local stActorInfo = self:CalCharFixedEffect(nTid, idx == 1, mapDisc)
      ret[nTid] = stActorInfo
    end
    return ret
  end
  
  self.mapCharData, self.mapDiscData = self:BuildCharacterData(mapMeta.Chars, mapMeta.Discs)
  self._mapNote = {}
  local mapCfg = ConfigTable.GetData("StarTower", mapMeta.Id)
  if mapCfg ~= nil then
    local nDropGroup = mapCfg.SubNoteSkillDropGroupId
    local tbNoteDrop = CacheTable.GetData("_SubNoteSkillDropGroup", nDropGroup)
    if tbNoteDrop ~= nil then
      for _, v in ipairs(tbNoteDrop) do
        self._mapNote[v.SubNoteSkillId] = 0
      end
    end
  end
  self._mapPotential = {}
  self._mapFateCard = {}
  self._mapItem = {}
  self.tbTeam = {}
  self.mapPotentialAddLevel = {}
  for _, mapChar in ipairs(mapMeta.Chars) do
    table.insert(self.tbTeam, mapChar.Id)
    self._mapPotential[mapChar.Id] = {}
    local tbActive = self.mapCharData[mapChar.Id].tbActive
    local tbEquipment = self.mapCharData[mapChar.Id].tbEquipment
    self.mapPotentialAddLevel[mapChar.Id] = self:GetCharEnhancedPotential(tbActive, tbEquipment)
  end
  self.tbDisc = {}
  for _, mapDisc in ipairs(mapMeta.Discs) do
    table.insert(self.tbDisc, mapDisc.Id)
  end
  self.nTowerId = mapMeta.Id
  self.nCurLevel = mapRoom.Data.Floor
  self.tbActiveSecondaryIds = mapMeta.ActiveSecondaryIds
  self.tbGrowthNodeEffect = PlayerData.StarTower:GetClientEffectByNode(mapMeta.TowerGrowthNodes)
  self.nResurrectionCnt = mapMeta.ResurrectionCnt or 0
  self.nTeamLevel = mapMeta.TeamLevel
  self.nTeamExp = mapMeta.TeamExp
  self.nTotalTime = mapMeta.TotalTime
  if self.nRankBattleTime == nil then
    self.nRankBattleTime = 0
  end
  self.nRoomType = mapRoom.Data.RoomType == nil and -1 or mapRoom.Data.RoomType
  local mapStarTower = ConfigTable.GetData("StarTower", self.nTowerId)
  if mapStarTower then
    local nTeamIndex = PlayerData.StarTower:GetGroupFormation(mapStarTower.GroupId)
    local nPreselectionId = PlayerData.Team:GetTeamPreselectionId(nTeamIndex)
    self.mapPreselectionData = PlayerData.PotentialPreselection:GetPreselectionById(nPreselectionId)
  end
  if mapBag ~= nil then
    for _, mapFateCardEft in ipairs(mapBag.FateCard) do
      self._mapFateCard[mapFateCardEft.Tid] = {
        mapFateCardEft.Remain,
        mapFateCardEft.Room
      }
    end
    for _, mapPotential in ipairs(mapBag.Potentials) do
      local nTid = mapPotential.Tid
      local mapPotentialCfgData = ConfigTable.GetData("Potential", nTid)
      if mapPotentialCfgData == nil then
        printError("PotentialCfgData Missing" .. nTid)
      else
        local nCharId = mapPotentialCfgData.CharId
        if self._mapPotential[nCharId] == nil then
          self._mapPotential[nCharId] = {}
        end
        self._mapPotential[nCharId][nTid] = mapPotential.Level
      end
    end
    for _, mapItem in ipairs(mapBag.Items) do
      local mapItemCfgData = ConfigTable.GetData_Item(mapItem.Tid)
      if mapItemCfgData ~= nil and mapItemCfgData.Stype == GameEnum.itemStype.SubNoteSkill then
        self._mapNote[mapItem.Tid] = mapItem.Qty
      else
        self._mapItem[mapItem.Tid] = mapItem.Qty
      end
    end
    for _, mapItem in ipairs(mapBag.Res) do
      self._mapItem[mapItem.Tid] = mapItem.Qty
    end
  end
  self:InitRoom(mapRoom.Cases)
end

function StarTowerSweepData:BuildCharacterData(tbCharacterData, tbDiscData)
  local EquipmentData = require("GameCore.Data.DataClass.EquipmentDataEx")
  local DiscData = require("GameCore.Data.DataClass.DiscData")
  local mapCharacter = {}
  local mapDisc = {}
  for idx, mapChar in ipairs(tbCharacterData) do
    local tbEquipment, tbEquipmentSlot = {}, {}
    for _, starTowerEquipment in ipairs(mapChar.Gems) do
      if starTowerEquipment.Attributes then
        local bEmpty = false
        for _, v in pairs(starTowerEquipment.Attributes) do
          if v == 0 then
            bEmpty = true
            break
          end
        end
        if not bEmpty then
          local nGemId = PlayerData.Equipment:GetGemIdBySlot(mapChar.Id, starTowerEquipment.SlotId)
          local mapEquipmentInfo = {
            Lock = false,
            Attributes = starTowerEquipment.Attributes,
            AlterAttributes = {},
            OverlockCount = starTowerEquipment.OverlockCount,
            AlterOverlockCount = {}
          }
          local equipmentData = EquipmentData.new(mapEquipmentInfo, mapChar.Id, nGemId)
          table.insert(tbEquipment, equipmentData)
          tbEquipmentSlot[starTowerEquipment.SlotId] = equipmentData
        end
      end
    end
    local tbTalent = CacheTable.GetData("_TalentByIndex", mapChar.Id)
    if tbTalent == nil then
      printError("Talent���Ҳ����ý�ɫ" .. mapChar.Id)
      tbTalent = {}
    end
    local tbActive = {}
    local tbNodes = UTILS.ParseByteString(mapChar.TalentNodes)
    for nIndex, v in pairs(tbTalent) do
      local bActive = UTILS.IsBitSet(tbNodes, nIndex)
      if bActive then
        table.insert(tbActive, v.Id)
      end
    end
    
    local function GetCharSkillAddedLevel(nCharId, tbSkillLv, active, bMainChar)
      local tbSkillLevel = {}
      local tbSkillIds = {}
      local charCfgData = DataTable.Character[nCharId]
      tbSkillIds[1] = charCfgData.NormalAtkId
      tbSkillIds[2] = charCfgData.SkillId
      tbSkillIds[3] = charCfgData.AssistSkillId
      tbSkillIds[4] = charCfgData.UltimateId
      local mapTalentEnhanceSkill = PlayerData.Talent:CreateEnhancedSkill(nCharId, active)
      local mapEquipmentEnhanceSkill = {}
      for _, v in pairs(tbEquipment) do
        local tbSkill = v:GetEnhancedSkill()
        for nSkillId, nAdd in pairs(tbSkill) do
          if not mapEquipmentEnhanceSkill[nSkillId] then
            mapEquipmentEnhanceSkill[nSkillId] = 0
          end
          mapEquipmentEnhanceSkill[nSkillId] = mapEquipmentEnhanceSkill[nSkillId] + nAdd
        end
      end
      for i = 1, 4 do
        local nSkillId = tbSkillIds[i]
        local nAdd = 0
        if mapTalentEnhanceSkill and mapTalentEnhanceSkill[nSkillId] then
          nAdd = nAdd + mapTalentEnhanceSkill[nSkillId]
        end
        if mapEquipmentEnhanceSkill and mapEquipmentEnhanceSkill[nSkillId] then
          nAdd = nAdd + mapEquipmentEnhanceSkill[nSkillId]
        end
        local nLv = tbSkillLv[i] + nAdd
        table.insert(tbSkillLevel, nLv)
      end
      if bMainChar == true then
        table.remove(tbSkillLevel, 3)
      else
        table.remove(tbSkillLevel, 2)
      end
      return tbSkillLevel
    end
    
    local tbTalentEffect = {}
    for _, nTalentId in pairs(tbActive) do
      local mapCfg = ConfigTable.GetData("Talent", nTalentId)
      if mapCfg ~= nil then
        for _, nEffectId in pairs(mapCfg.EffectId) do
          table.insert(tbTalentEffect, nEffectId)
        end
      end
    end
    local tbAffinityeffectIds = {}
    local mapCfg = ConfigTable.GetData("CharAffinityTemplate", mapChar.Id)
    if mapCfg ~= nil then
      local templateId = mapCfg.TemplateId
      
      local function forEachAffinityLevel(affinityData)
        if affinityData.TemplateId == templateId and mapChar.AffinityLevel ~= nil and affinityData.AffinityLevel <= mapChar.AffinityLevel and affinityData.Effect ~= nil and #affinityData.Effect > 0 then
          for k, v in ipairs(affinityData.Effect) do
            table.insert(tbAffinityeffectIds, v)
          end
        end
      end
      
      ForEachTableLine(DataTable.AffinityLevel, forEachAffinityLevel)
    end
    local charData = {
      nId = mapChar.Id,
      nRankExp = 0,
      nFavor = 0,
      nSkinId = PlayerData.Char:GetCharUsedSkinId(mapChar.Id),
      tbEquipment = tbEquipment,
      tbEquipmentSlot = tbEquipmentSlot,
      nLevel = mapChar.Level,
      nCreateTime = 0,
      nAdvance = mapChar.Advance,
      tbSkillLvs = GetCharSkillAddedLevel(mapChar.Id, mapChar.SkillLvs, tbActive, idx == 1),
      bUseSkillWhenActive_Branch1 = false,
      bUseSkillWhenActive_Branch2 = false,
      tbPlot = {},
      nAffinityExp = 0,
      nAffinityLevel = mapChar.AffinityLevel,
      tbAffinityQuests = {},
      tbActive = tbActive,
      tbAffinityeffectIds = tbAffinityeffectIds,
      tbTalentEffect = tbTalentEffect
    }
    mapCharacter[mapChar.Id] = charData
  end
  for _, startowerDisc in ipairs(tbDiscData) do
    local mapDiscInfo = {
      Id = startowerDisc.Id,
      Level = startowerDisc.Level,
      Exp = 0,
      Phase = startowerDisc.Phase,
      Star = startowerDisc.Star,
      Read = false,
      CreatTime = 0
    }
    local discData = DiscData.new(mapDiscInfo)
    mapDisc[startowerDisc.Id] = discData
  end
  return mapCharacter, mapDisc
end

function StarTowerSweepData:GetCharEnhancedPotential(tbActiveTalent, tbEquipment)
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
  
  local mapTalentAddLevel = PlayerData.Talent:CreateEnhancedPotential(tbActiveTalent)
  local mapEquipmentAddLevel = {}
  for _, v in pairs(tbEquipment) do
    local tbPotential = v:GetEnhancedPotential()
    for nPotentialId, nAdd in pairs(tbPotential) do
      if not mapEquipmentAddLevel[nPotentialId] then
        mapEquipmentAddLevel[nPotentialId] = 0
      end
      mapEquipmentAddLevel[nPotentialId] = mapEquipmentAddLevel[nPotentialId] + nAdd
    end
  end
  add(mapTalentAddLevel)
  add(mapEquipmentAddLevel)
  return mapAddLevel
end

function StarTowerSweepData:InitRoom(tbCases)
  self:CancelPendingAutoDecision()
  self.bEnd = false
  self.tbEvent = {}
  self.roomData = {}
  self.mapCases = {}
  self.bProcessing = true
  self.nTaskType = 0
  self.mapNpc = {}
  self:SaveCase(tbCases)
  self.tbPopup = {}
  self.blockNpcBtn = false
  self._bAutoShopFinished = false
  self._bAutoShopExhausted = false
  self._bAutoMachineFinished = false
  self._bAutoUpgradeBeforeShopSpendAll = false
  self._autoShopCompleteCallback = nil
  self._bOpenManualAfterAutoRequest = false
end

function StarTowerSweepData:SaveCase(tbCases)
  for _, mapCaseData in ipairs(tbCases) do
    if mapCaseData.BattleCase ~= nil then
      print("BattleCase")
      if self.mapCases[self.EnumCase.Battle] ~= nil then
        printError("ս���¼��ظ� ���ܵ��·����¼������޷�����")
      end
      self.mapCases[self.EnumCase.Battle] = {}
      self.mapCases[self.EnumCase.Battle].Id = mapCaseData.Id
      self.mapCases[self.EnumCase.Battle].Data = mapCaseData.BattleCase
      self.mapCases[self.EnumCase.Battle].bFinish = false
    elseif mapCaseData.DoorCase ~= nil then
      if mapCaseData.DoorCase.Type == GameEnum.starTowerRoomType.DangerRoom then
        print("DangerRoomCase")
        local mapStarTower = ConfigTable.GetData("StarTower", self.nTowerId)
        local nNpcId = mapStarTower.DangerNpc
        local mapNpcCfgData = ConfigTable.GetData("NPCConfig", nNpcId)
        local nBoardNpcId = mapNpcCfgData.NPCId
        self.mapNpc[nNpcId] = mapCaseData.Id
        if self.mapCases[self.EnumCase.DoorDanger] == nil then
          self.mapCases[self.EnumCase.DoorDanger] = {}
        end
        self.mapCases[self.EnumCase.DoorDanger][mapCaseData.Id] = mapCaseData.DoorCase
        self.mapCases[self.EnumCase.DoorDanger][mapCaseData.Id].bFinish = false
        self.mapCases[self.EnumCase.DoorDanger][mapCaseData.Id].NpcId = nNpcId
      elseif mapCaseData.DoorCase.Type == GameEnum.starTowerRoomType.HorrorRoom then
        print("HorrorRoomCase")
        local mapStarTower = ConfigTable.GetData("StarTower", self.nTowerId)
        local nNpcId = mapStarTower.HorrorNpc
        self.mapNpc[nNpcId] = mapCaseData.Id
        if self.mapCases[self.EnumCase.DoorDanger] == nil then
          self.mapCases[self.EnumCase.DoorDanger] = {}
        end
        self.mapCases[self.EnumCase.DoorDanger][mapCaseData.Id] = mapCaseData.DoorCase
        self.mapCases[self.EnumCase.DoorDanger][mapCaseData.Id].bFinish = false
        self.mapCases[self.EnumCase.DoorDanger][mapCaseData.Id].NpcId = nNpcId
      else
        print("DoorCase")
        if self.mapCases[self.EnumCase.OpenDoor] == nil then
          self.mapCases[self.EnumCase.OpenDoor] = {
            mapCaseData.Id,
            mapCaseData.DoorCase.Type
          }
        end
      end
    elseif mapCaseData.SelectPotentialCase ~= nil then
      print("SelectPotentialCase")
      if self.mapCases[self.EnumCase.PotentialSelect] == nil then
        self.mapCases[self.EnumCase.PotentialSelect] = {}
      end
      self.mapCases[self.EnumCase.PotentialSelect][mapCaseData.Id] = mapCaseData.SelectPotentialCase
      self.mapCases[self.EnumCase.PotentialSelect][mapCaseData.Id].bFinish = false
    elseif mapCaseData.SelectSpecialPotentialCase ~= nil then
      print("SelectSpecialPotentialCase")
      if self.mapCases[self.EnumCase.SelectSpecialPotential] == nil then
        self.mapCases[self.EnumCase.SelectSpecialPotential] = {}
      end
      self.mapCases[self.EnumCase.SelectSpecialPotential][mapCaseData.Id] = mapCaseData.SelectSpecialPotentialCase
      self.mapCases[self.EnumCase.SelectSpecialPotential][mapCaseData.Id].bFinish = false
    elseif mapCaseData.SelectFateCardCase ~= nil then
      print("SelectFateCardCase")
      if self.mapCases[self.EnumCase.FateCardSelect] == nil then
        self.mapCases[self.EnumCase.FateCardSelect] = {}
      end
      self.mapCases[self.EnumCase.FateCardSelect][mapCaseData.Id] = mapCaseData.SelectFateCardCase
      self.mapCases[self.EnumCase.FateCardSelect][mapCaseData.Id].bFinish = false
    elseif mapCaseData.SelectNoteCase ~= nil then
      print("SelectNoteCase")
      if self.mapCases[self.EnumCase.NoteSelect] == nil then
        self.mapCases[self.EnumCase.NoteSelect] = {}
      end
      self.mapCases[self.EnumCase.NoteSelect][mapCaseData.Id] = mapCaseData.SelectNoteCase
      self.mapCases[self.EnumCase.NoteSelect][mapCaseData.Id].bFinish = false
    elseif mapCaseData.SelectOptionsEventCase ~= nil then
      print("SelectOptionsEventCase")
      if self.mapCases[self.EnumCase.NpcEvent] == nil then
        self.mapCases[self.EnumCase.NpcEvent] = {}
      end
      local mapEventCfgData = ConfigTable.GetData("StarTowerEvent", mapCaseData.SelectOptionsEventCase.EvtId)
      if mapEventCfgData ~= nil then
        local nNpcId = mapCaseData.SelectOptionsEventCase.NPCId
        local mapNpcCfgData = ConfigTable.GetData("NPCConfig", nNpcId)
        if mapNpcCfgData ~= nil then
          local nBoardNpcId = mapNpcCfgData.NPCId
          local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
          if self.mapNpc[nNpcId] ~= nil then
            printError("NpcId�ظ�" .. mapCaseData.SelectOptionsEventCase.EvtId)
          end
          self.mapNpc[nNpcId] = mapCaseData.Id
          local nActionId = mapCaseData.SelectOptionsEventCase.EvtId * 10000 + nNpcId
          if ConfigTable.GetData("StarTowerEventAction", nActionId) ~= nil then
            mapCaseData.SelectOptionsEventCase.nActionId = nActionId
          else
            printError("���¼�û�ж�Ӧ��action" .. mapCaseData.SelectOptionsEventCase.EvtId)
            mapCaseData.SelectOptionsEventCase.nActionId = 0
          end
        else
          printError("û���ҵ���ӦNPC���� " .. nNpcId)
        end
      end
      self.mapCases[self.EnumCase.NpcEvent][mapCaseData.Id] = mapCaseData.SelectOptionsEventCase
      self.mapCases[self.EnumCase.NpcEvent][mapCaseData.Id].bFinish = mapCaseData.SelectOptionsEventCase.Done
      self.mapCases[self.EnumCase.NpcEvent][mapCaseData.Id].bFirst = true
    elseif mapCaseData.RecoveryHPCase ~= nil then
      print("RecoveryHPCase")
      if self.mapCases[self.EnumCase.RecoveryHP] == nil then
        self.mapCases[self.EnumCase.RecoveryHP] = {}
      end
      self.mapCases[self.EnumCase.RecoveryHP][mapCaseData.Id] = mapCaseData.RecoveryHPCase
      self.mapCases[self.EnumCase.RecoveryHP][mapCaseData.Id].bFinish = false
    elseif mapCaseData.NpcRecoveryHPCase ~= nil then
      print("NpcRecoveryHPCase")
      local mapStarTower = ConfigTable.GetData("StarTower", self.nTowerId)
      local nNpcId = mapStarTower.ResqueNpc
      self.mapNpc[nNpcId] = mapCaseData.Id
      if self.mapCases[self.EnumCase.NpcRecoveryHP] == nil then
        self.mapCases[self.EnumCase.NpcRecoveryHP] = {}
      end
      self.mapCases[self.EnumCase.NpcRecoveryHP][mapCaseData.Id] = mapCaseData.NpcRecoveryHPCase
      self.mapCases[self.EnumCase.NpcRecoveryHP][mapCaseData.Id].bFinish = false
    elseif mapCaseData.HawkerCase ~= nil then
      print("HawkerCase")
      local nType = self.nRoomType
      local mapStarTower = ConfigTable.GetData("StarTower", self.nTowerId)
      local nNpcId = mapStarTower.ShopNpc
      if nType ~= GameEnum.starTowerRoomType.ShopRoom then
        nNpcId = mapStarTower.StandShopNpc
      end
      self.mapNpc[nNpcId] = mapCaseData.Id
      self.mapCases[self.EnumCase.Hawker] = mapCaseData.HawkerCase
      self.mapCases[self.EnumCase.Hawker].Id = mapCaseData.Id
      self.mapCases[self.EnumCase.Hawker].nNpc = nNpcId
      self.mapCases[self.EnumCase.Hawker].bFinish = false
    elseif mapCaseData.StrengthenMachineCase ~= nil then
      print("StrengthenMachineCase")
      local mapStarTower = ConfigTable.GetData("StarTower", self.nTowerId)
      local nNpcId = mapStarTower.UpgradeNpc
      self.mapNpc[nNpcId] = mapCaseData.Id
      self.mapCases[self.EnumCase.StrengthenMachine] = mapCaseData.StrengthenMachineCase
      self.mapCases[self.EnumCase.StrengthenMachine].Id = mapCaseData.Id
      self.mapCases[self.EnumCase.StrengthenMachine].bFinish = false
    elseif mapCaseData.SyncHPCase ~= nil then
      self.mapCases[self.EnumCase.SyncHP] = mapCaseData.Id
    end
  end
end

function StarTowerSweepData:SaveSelectResp(mapCaseData, nCaseId)
  if not mapCaseData or not nCaseId then
    return
  end
  if mapCaseData.SelectPotentialCase ~= nil then
    self.mapCases[self.EnumCase.PotentialSelect][nCaseId] = mapCaseData.SelectPotentialCase
    self.mapCases[self.EnumCase.PotentialSelect][nCaseId].bFinish = false
    self.mapCases[self.EnumCase.PotentialSelect][nCaseId].bReRoll = true
  elseif mapCaseData.SelectSpecialPotentialCase ~= nil then
    self.mapCases[self.EnumCase.SelectSpecialPotential][nCaseId] = mapCaseData.SelectSpecialPotentialCase
    self.mapCases[self.EnumCase.SelectSpecialPotential][nCaseId].bFinish = false
    self.mapCases[self.EnumCase.SelectSpecialPotential][nCaseId].bReRoll = true
  elseif mapCaseData.SelectFateCardCase ~= nil then
    self.mapCases[self.EnumCase.FateCardSelect][nCaseId] = mapCaseData.SelectFateCardCase
    self.mapCases[self.EnumCase.FateCardSelect][nCaseId].bFinish = false
    self.mapCases[self.EnumCase.FateCardSelect][nCaseId].bReRoll = true
  elseif mapCaseData.HawkerCase ~= nil then
    local temp = self.mapCases[self.EnumCase.Hawker]
    self.mapCases[self.EnumCase.Hawker] = mapCaseData.HawkerCase
    self.mapCases[self.EnumCase.Hawker].bFinish = false
    self.mapCases[self.EnumCase.Hawker].bReRoll = true
    self.mapCases[self.EnumCase.Hawker].Id = temp.Id
    self.mapCases[self.EnumCase.Hawker].nNpc = temp.nNpc
    self._bAutoShopFinished = false
    self._bAutoShopExhausted = false
    self._bAutoUpgradeBeforeShopSpendAll = false
  end
end

function StarTowerSweepData:OnInteractFailed(nCaseId, mapError)
  if self.bEnd then
    return
  end
  local mapDecision = self._mapPendingAutoDecision or {}
  printWarn(string.format("[StarTowerAuto] InteractFailed tower=%s floor=%s case=%s action=%s coin=%s token=%s code=%s trace=%s", tostring(self.nTowerId), tostring(self.nCurLevel), tostring(nCaseId), tostring(mapDecision.nActionType), tostring(self._mapItem and self._mapItem[AllEnum.CoinItemId.FixedRogCurrency]), tostring(PlayerData.StarTowerAutoPlan and PlayerData.StarTowerAutoPlan:GetTokenCount()), tostring(mapError and mapError.Code), tostring(mapError and mapError.TraceId)))
  self:StopAutoDecision(StarTowerAutoDecision.FailReason.InvalidParam, false)
  self:FinishAutoRequest(false, StarTowerAutoDecision.FailReason.InvalidParam)
  EventManager.Hit("StarTowerAutoDecisionRequestFailed", self)
end

function StarTowerSweepData:StarTowerInteract(mapMsgData, callback, failedCallback)
  if self.bEnd then
    return
  end
  StarTowerSettingGate.Begin()
  local mapSettingRequest = StarTowerSettingGate.BeginRequest(function(mapError)
    if failedCallback ~= nil then
      failedCallback(mapError)
    end
    self:OnInteractFailed(mapMsgData.Id, mapError)
  end)
  
  local function NetCallback(_, mapNetData)
    if self.bEnd then
      if mapNetData.Change ~= nil then
        HttpNetHandler.ProcChangeInfo(UTILS.DecodeChangeInfo(mapNetData.Change))
      end
      StarTowerSettingGate.FinishRequest(mapSettingRequest)
      return
    end
    local mapChangeNote, mapChangeSecondarySkill = self:ProcessTowerChangeData(mapNetData.Data)
    local tbChangeFateCard, mapItemChange, mapPotentialChange = self:ProcessChangeInfo(mapNetData.Change)
    if mapNetData.Change ~= nil then
      HttpNetHandler.ProcChangeInfo(UTILS.DecodeChangeInfo(mapNetData.Change))
    end
    local nExpChange = 0
    local nLevelChange = 0
    EventManager.Hit("RefreshNoteCount", self._mapNote, mapChangeNote, mapChangeSecondarySkill)
    if mapNetData.BattleEndResp ~= nil and mapNetData.BattleEndResp.Victory ~= nil then
      nExpChange = mapNetData.BattleEndResp.Victory.Exp - self.nTeamExp
      nLevelChange = mapNetData.BattleEndResp.Victory.Lv - self.nTeamLevel
      self.nTeamLevel = mapNetData.BattleEndResp.Victory.Lv
      self.nTeamExp = mapNetData.BattleEndResp.Victory.Exp
      self.nRankBattleTime = self.nRankBattleTime + mapNetData.BattleEndResp.Victory.BattleTime
    end
    EventManager.Hit("RefreshFastBattleInfo", tbChangeFateCard, mapChangeNote, mapItemChange, nLevelChange, nExpChange, mapPotentialChange)
    self:SaveCase(mapNetData.Cases)
    self:SaveSelectResp(mapNetData.SelectResp, mapMsgData.Id)
    if callback ~= nil and type(callback) == "function" then
      callback(mapNetData, tbChangeFateCard, mapChangeNote, mapItemChange, nLevelChange, nExpChange, mapPotentialChange, mapChangeSecondarySkill)
    end
    StarTowerSettingGate.FinishRequest(mapSettingRequest)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_interact_req, mapMsgData, nil, NetCallback)
end

function StarTowerSweepData:EnterRoom(nCaseId, nRoomType)
  if self.bEnd or self._bAutoRequestPending or self._mapStrengthMachineRequest ~= nil then
    return false
  end
  if self:HasPendingCases() then
    self:HandleCases()
    return false
  end
  self:CancelPendingAutoDecision()
  StarTowerSettingGate.Begin()
  if self.nCurLevel + 1 > #self.tbStarTowerAllLevel then
    self:StarTowerClear(nCaseId)
    return true
  end
  local mapSettingRequest = StarTowerSettingGate.BeginRequest()
  local floorId = 0
  local sExData = ""
  local scenePrefabId = 0
  self.nRoomType = nRoomType
  if nRoomType ~= GameEnum.starTowerRoomType.DangerRoom and nRoomType ~= GameEnum.starTowerRoomType.HorrorRoom then
    self.nCurLevel = self.nCurLevel + 1
  end
  
  local function NetCallback(_, mapNetData)
    if self.bEnd then
      StarTowerSettingGate.FinishRequest(mapSettingRequest)
      return
    end
    if mapNetData.EnterResp == nil then
      StarTowerSettingGate.FinishRequest(mapSettingRequest)
      printError("�������ݷ���Ϊ��")
      return
    end
    self:ProcessChangeInfo(mapNetData.Change)
    self:InitRoom(mapNetData.EnterResp.Room.Cases)
    EventManager.Hit("InitRoom")
    StarTowerSettingGate.FinishRequest(mapSettingRequest)
  end
  
  local EnterReq = {
    MapId = self.curMapId,
    ParamId = floorId,
    DateLen = 0,
    ClientData = "",
    MapParam = sExData,
    MapTableId = scenePrefabId
  }
  local mapMsg = {Id = nCaseId, EnterReq = EnterReq}
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_interact_req, mapMsg, nil, NetCallback)
  return true
end

function StarTowerSweepData:StarTowerLeave()
  if not self:EndExploration() then
    return
  end
  local nRecon = PlayerData.State:GetStarTowerRecon()
  local mapStateInfo = {
    Id = self.nTowerId,
    ReConnection = nRecon,
    BuildId = 0,
    CharIds = self.tbTeam,
    Floor = self.nCurLevel,
    Sweep = true
  }
  PlayerData.State:CacheStarTowerStateData(mapStateInfo)
end

function StarTowerSweepData:StarTowerClear(nCaseId)
  if self.bEnd then
    return
  end
  StarTowerSettingGate.Begin()
  local mapSettingRequest = StarTowerSettingGate.BeginRequest()
  self:StopAutoDecision(StarTowerAutoDecision.FailReason.Disabled, false)
  local EnterReq = {MapId = 0}
  local mapMsg = {Id = nCaseId, EnterReq = EnterReq}
  
  local function NetCallback(_, mapNetMsg)
    if self.bEnd then
      StarTowerSettingGate.FinishRequest(mapSettingRequest)
      return
    end
    local mapBuildInfo
    local mapChangeInfo = {}
    local tbRes = {}
    local tbItem = {}
    local nTime = 0
    local mapNpcAffinity = {}
    local tbTowerRewards = {}
    if mapNetMsg.Settle ~= nil then
      PlayerData.StarTower:CacheNpcAffinityChange(mapNetMsg.Settle.Reward, mapNetMsg.Settle.NpcInteraction)
      mapBuildInfo = mapNetMsg.Settle.Build
      mapChangeInfo = mapNetMsg.Settle.Change
      nTime = mapNetMsg.Settle.TotalTime
      mapNpcAffinity = mapNetMsg.Settle.Reward
      tbTowerRewards = mapNetMsg.Settle.TowerRewards
    end
    if mapChangeInfo ~= nil then
      local encodeInfo = UTILS.DecodeChangeInfo(mapChangeInfo)
      if encodeInfo["proto.Res"] ~= nil then
        for _, mapCoin in ipairs(encodeInfo["proto.Res"]) do
          table.insert(tbRes, {
            nTid = mapCoin.Tid,
            nCount = mapCoin.Qty
          })
          if mapCoin.Tid == AllEnum.CoinItemId.FRRewardCurrency then
            PlayerData.StarTower:AddStarTowerTicket(mapCoin.Qty)
          end
        end
      end
      if encodeInfo["proto.Item"] ~= nil then
        for _, mapItem in ipairs(encodeInfo["proto.Item"]) do
          local mapItemConfigData = ConfigTable.GetData_Item(mapItem.Tid)
          if mapItemConfigData == nil then
            return
          end
          if mapItemConfigData.Stype ~= GameEnum.itemStype.Res then
            table.insert(tbItem, {
              nTid = mapItem.Tid,
              nCount = mapItem.Qty
            })
          end
        end
      end
    end
    local nPotentialCount = 0
    for _, mapPotential in pairs(self._mapPotential) do
      for _, nCount in pairs(mapPotential) do
        nPotentialCount = nPotentialCount + nCount
      end
    end
    local mapResult = {
      nRoguelikeId = self.nTowerId,
      tbDisc = self.tbDisc,
      tbRes = tbRes,
      tbPresents = {},
      tbOutfit = {},
      tbItem = tbItem,
      tbRarityCount = {},
      bSuccess = true,
      nFloor = self.nCurLevel,
      nStage = self.tbStarTowerAllLevel[self.nCurLevel].Id,
      mapBuild = mapBuildInfo,
      nExp = 0,
      nPerkCount = nPotentialCount,
      tbBonus = {},
      nTime = nTime,
      tbAffinities = {},
      mapChangeInfo = mapChangeInfo,
      bRanking = self.bRanking,
      mapNPCAffinity = mapNpcAffinity,
      tbRewards = tbTowerRewards,
      bSweep = true
    }
    self:EndExploration()
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerResult, mapResult, self.tbTeam)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerFastBattle)
    end
    
    cs_coroutine.start(wait)
    PlayerData.State:CacheStarTowerStateData(nil)
    StarTowerSettingGate.FinishRequest(mapSettingRequest)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_interact_req, mapMsg, nil, NetCallback)
end

function StarTowerSweepData:ProcessChangeInfo(mapChangeData)
  local mapData = UTILS.DecodeChangeInfo(mapChangeData)
  local tbChangeFateCard = {}
  local mapRewardChange = {}
  local mapPotentialChange = {}
  if mapData["proto.FateCardInfo"] ~= nil then
    for _, mapFateCardData in ipairs(mapData["proto.FateCardInfo"]) do
      local nBeforeRoomCount = 0
      local nBeforeEftCount = 0
      if self._mapFateCard[mapFateCardData.Tid] ~= nil then
        nBeforeRoomCount = self._mapFateCard[mapFateCardData.Tid][2]
        nBeforeEftCount = self._mapFateCard[mapFateCardData.Tid][1]
      end
      if mapFateCardData.Qty == 0 then
        self._mapFateCard[mapFateCardData.Tid] = nil
        table.insert(tbChangeFateCard, {
          mapFateCardData.Tid,
          0,
          0,
          -1
        })
      else
        local nCountSum = 0
        if self._mapFateCard[mapFateCardData.Tid] == nil then
          nCountSum = 1
        elseif mapFateCardData.Room ~= 0 and mapFateCardData.Remain ~= 0 then
          local nBeforeCount = math.max(nBeforeEftCount, nBeforeRoomCount)
          if self._mapFateCard[mapFateCardData.Tid] ~= nil and nBeforeCount <= 0 then
            nCountSum = 2
          end
        end
        self._mapFateCard[mapFateCardData.Tid] = {
          mapFateCardData.Remain,
          mapFateCardData.Room
        }
        table.insert(tbChangeFateCard, {
          mapFateCardData.Tid,
          self._mapFateCard[mapFateCardData.Tid][1] - nBeforeEftCount,
          self._mapFateCard[mapFateCardData.Tid][2] - nBeforeRoomCount,
          nCountSum
        })
      end
    end
  end
  if mapData["proto.PotentialInfo"] ~= nil then
    for _, mapPotentialInfo in ipairs(mapData["proto.PotentialInfo"]) do
      local mapPotentialCfgData = ConfigTable.GetData("Potential", mapPotentialInfo.Tid)
      if mapPotentialCfgData == nil then
        printError("PotentialCfgData Missing" .. mapPotentialInfo.Tid)
      else
        local nCharId = mapPotentialCfgData.CharId
        if self._mapPotential[nCharId][mapPotentialInfo.Tid] == nil then
          self._mapPotential[nCharId][mapPotentialInfo.Tid] = 0
        end
        local nCurLevel = self._mapPotential[nCharId][mapPotentialInfo.Tid]
        local nNextLevel = self._mapPotential[nCharId][mapPotentialInfo.Tid] + mapPotentialInfo.Level
        mapPotentialChange[mapPotentialInfo.Tid] = {nLevel = nCurLevel, nNextLevel = nNextLevel}
        self._mapPotential[nCharId][mapPotentialInfo.Tid] = nNextLevel
      end
    end
  end
  if mapData["proto.TowerItemInfo"] ~= nil then
    for _, mapItemInfo in ipairs(mapData["proto.TowerItemInfo"]) do
      if self._mapItem[mapItemInfo.Tid] == nil then
        self._mapItem[mapItemInfo.Tid] = 0
      end
      self._mapItem[mapItemInfo.Tid] = self._mapItem[mapItemInfo.Tid] + mapItemInfo.Qty
      if mapRewardChange[mapItemInfo.Tid] == nil then
        mapRewardChange[mapItemInfo.Tid] = mapItemInfo.Qty
      else
        mapRewardChange[mapItemInfo.Tid] = mapRewardChange[mapItemInfo.Tid] + mapItemInfo.Qty
      end
    end
  end
  if mapData["proto.TowerResInfo"] ~= nil then
    for _, mapItemInfo in ipairs(mapData["proto.TowerResInfo"]) do
      if self._mapItem[mapItemInfo.Tid] == nil then
        self._mapItem[mapItemInfo.Tid] = 0
      end
      self._mapItem[mapItemInfo.Tid] = self._mapItem[mapItemInfo.Tid] + mapItemInfo.Qty
      if mapRewardChange[mapItemInfo.Tid] == nil then
        mapRewardChange[mapItemInfo.Tid] = mapItemInfo.Qty
      else
        mapRewardChange[mapItemInfo.Tid] = mapRewardChange[mapItemInfo.Tid] + mapItemInfo.Qty
      end
    end
  end
  return tbChangeFateCard, mapRewardChange, mapPotentialChange
end

function StarTowerSweepData:ProcessTowerChangeData(mapChange)
  if not mapChange then
    return {}, {}
  end
  local mapChangeNote = {}
  if mapChange.Infos and next(mapChange.Infos) ~= nil then
    for _, mapNoteInfo in ipairs(mapChange.Infos) do
      print(string.format("���������仯��%d,%d", mapNoteInfo.Tid, mapNoteInfo.Qty))
      if self._mapNote[mapNoteInfo.Tid] == nil then
        self._mapNote[mapNoteInfo.Tid] = 0
      end
      self._mapNote[mapNoteInfo.Tid] = self._mapNote[mapNoteInfo.Tid] + mapNoteInfo.Qty
      mapChangeNote[mapNoteInfo.Tid] = mapNoteInfo
    end
  end
  local mapChangeSecondarySkill = {}
  if mapChange.Secondaries and next(mapChange.Secondaries) ~= nil then
    for _, v in ipairs(mapChange.Secondaries) do
      table.insert(mapChangeSecondarySkill, v)
      if v.Active then
        table.insert(self.tbActiveSecondaryIds, v.SecondaryId)
      else
        table.removebyvalue(self.tbActiveSecondaryIds, v.SecondaryId)
      end
    end
  end
  return mapChangeNote, mapChangeSecondarySkill
end

function StarTowerSweepData:HandleNpc(nNpcId, nNpcUid)
  if self.blockNpcBtn then
    return
  end
  local nCaseId = self.mapNpc[nNpcId]
  if nCaseId == nil then
    printError("Npcû�ж�Ӧ�¼�ID:" .. nNpcId)
    return
  end
  local mapNpcCfgData = ConfigTable.GetData("NPCConfig", nNpcId)
  if mapNpcCfgData == nil then
    printError("Npc config missing:" .. nNpcId)
    return
  end
  if mapNpcCfgData.type == GameEnum.npcNewType.Narrate then
    local tbChat = ConfigTable.GetData("NPCConfig", nNpcId).Lines
    local nTalkId = tbChat[math.random(1, #tbChat)]
    if nTalkId == nil then
      nTalkId = 0
    end
    local nBoardNpcId = ConfigTable.GetData("NPCConfig", nNpcId).NPCId
    local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
    local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
    EventManager.Hit(EventId.OpenPanel, PanelId.NpcOptionPanel, 0, 0, {}, nSkinId, 1, {}, {}, nTalkId, 0, true, true, nCoin, self.nTowerId, self._mapNote, self.tbDisc)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Event then
    self:OpenNpcOptionPanel(nCaseId, nNpcId)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Resque then
    self:HandleNpcRecover(nCaseId, nNpcId)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Danger then
    self:HandleNpcDangerRoom(nCaseId, nNpcId)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Horror then
    self:HandleNpcDangerRoom(nCaseId, nNpcId)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Shop then
    self:InteractiveShop(nCaseId, nNpcId)
    return
  elseif mapNpcCfgData.type == GameEnum.npcNewType.Upgrade then
    self:InteractiveStrengthMachine(nCaseId, nNpcId)
    return
  else
    printError("�������¼�")
  end
  printError("û���ҵ��ɽ������¼�:" .. nNpcId)
end

function StarTowerSweepData:HasPendingCases()
  local mapBattle = self.mapCases[self.EnumCase.Battle]
  if mapBattle ~= nil and mapBattle.bFinish ~= true then
    return true
  end
  local tbCaseTypes = {
    self.EnumCase.RecoveryHP,
    self.EnumCase.SelectSpecialPotential,
    self.EnumCase.PotentialSelect,
    self.EnumCase.NoteSelect,
    self.EnumCase.FateCardSelect,
    self.EnumCase.NpcEvent,
    self.EnumCase.DoorDanger
  }
  for _, nCaseType in ipairs(tbCaseTypes) do
    for _, mapData in pairs(self.mapCases[nCaseType] or {}) do
      if mapData.bFinish ~= true then
        return true
      end
    end
  end
  local tbPopupTypes = {
    self.EnumPopup.StrengthFx,
    self.EnumPopup.Potential,
    self.EnumPopup.Reward,
    self.EnumPopup.Disc
  }
  for _, nPopupType in ipairs(tbPopupTypes) do
    for _, mapData in ipairs(self.tbPopup[nPopupType] or {}) do
      if not mapData.bFinish then
        return true
      end
    end
  end
  return false
end

function StarTowerSweepData:HandleCases()
  if self.bEnd then
    return false
  end
  StarTowerSettingGate.Begin()
  if self._bAutoRequestPending then
    return
  end
  if self._bAutoDecisionEnabled and self._bAutoDecisionPaused then
    if not self:HasPendingCases() then
      EventManager.Hit("EventHandleOver")
      return false
    end
    return
  end
  if self.mapCases[self.EnumCase.Battle] ~= nil and self.mapCases[self.EnumCase.Battle].bFinish ~= true then
    local msg = {}
    local nEventId = self.mapCases[self.EnumCase.Battle].Id
    msg.Id = nEventId
    msg.BattleEndReq = {}
    msg.BattleEndReq.Victory = {
      HP = 0,
      Time = 0,
      ClientData = "",
      fateCardUsage = {},
      DateLen = 0,
      Damages = {},
      Sample = {},
      Events = {
        List = {}
      }
    }
    
    local function callback(callbackMsg)
      if callbackMsg ~= nil and callbackMsg.SelectResp ~= nil then
        self.mapCases[self.EnumCase.Battle].bFinish = callbackMsg.SelectResp.Resp.OptionsResult
      else
        self.mapCases[self.EnumCase.Battle].bFinish = true
      end
      self:HandleCases()
    end
    
    self:StarTowerInteract(msg, callback)
    return
  end
  if self.tbPopup[self.EnumPopup.StrengthFx] ~= nil then
    for _, mapData in ipairs(self.tbPopup[self.EnumPopup.StrengthFx]) do
      if not mapData.bFinish then
        self:HandleShopStrengthFx(mapData)
        return
      end
    end
  end
  if self.tbPopup[self.EnumPopup.Potential] ~= nil then
    for _, mapData in ipairs(self.tbPopup[self.EnumPopup.Potential]) do
      if not mapData.bFinish then
        self:HandlePopupPotential(mapData)
        return
      end
    end
  end
  if self.tbPopup[self.EnumPopup.Reward] ~= nil then
    for _, mapData in ipairs(self.tbPopup[self.EnumPopup.Reward]) do
      if not mapData.bFinish then
        self:HandlePopupReward(mapData)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.RecoveryHP] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.RecoveryHP]) do
      if mapData.bFinish ~= true then
        self:HandleRecover(nId)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.SelectSpecialPotential] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.SelectSpecialPotential]) do
      if mapData.bFinish ~= true then
        self:OpenSelectPotential(nId, true)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.PotentialSelect] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.PotentialSelect]) do
      if mapData.bFinish ~= true then
        self:OpenSelectPotential(nId)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.NoteSelect] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.NoteSelect]) do
      if mapData.bFinish ~= true then
        self:OpenSelectNote(nId)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.FateCardSelect] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.FateCardSelect]) do
      if mapData.bFinish ~= true then
        self:OpenSelectFateCard(nId)
        return
      end
    end
  end
  if self.tbPopup[self.EnumPopup.Disc] ~= nil then
    for _, mapData in ipairs(self.tbPopup[self.EnumPopup.Disc]) do
      if not mapData.bFinish then
        self:HandlePopupDisc(mapData)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.NpcEvent] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.NpcEvent]) do
      if mapData.bFinish ~= true then
        self:HandleNpc(mapData.NPCId)
        return
      end
    end
  end
  if self.mapCases[self.EnumCase.DoorDanger] ~= nil then
    for nId, mapData in pairs(self.mapCases[self.EnumCase.DoorDanger]) do
      if mapData.bFinish ~= true then
        self:HandleNpc(mapData.NpcId)
        mapData.bFinish = true
        return
      end
    end
  end
  EventManager.Hit("EventHandleOver")
  return false
end

function StarTowerSweepData:OpenSelectPotential(nCaseId, bSpecial, bKeepPanelOpen, panelRefreshCallback)
  local function ProcessSpecialPotentialData(nId)
    local mapCaseData = self.mapCases[self.EnumCase.SelectSpecialPotential][nId]
    
    local tbPotential = {}
    local mapPotential = {}
    for _, nPotentialId in ipairs(mapCaseData.Ids) do
      table.insert(tbPotential, {
        Id = nPotentialId,
        Count = 1,
        bSpecial = true
      })
      mapPotential[nPotentialId] = 0
      local mapPotentialCfgData = ConfigTable.GetData("Potential", nPotentialId)
      if mapPotentialCfgData == nil then
        printError("PotentialCfgData Missing" .. nPotentialId)
        return
      end
      local nCharId = mapPotentialCfgData.CharId
      if self._mapPotential[nCharId][nPotentialId] ~= nil then
        mapPotential[nPotentialId] = self._mapPotential[nCharId][nPotentialId]
      end
    end
    local nType = 0
    if 0 < mapCaseData.TeamLevel then
      nType = 1
    end
    local mapRoll = {
      CanReRoll = false,
      ReRollPrice = mapCaseData.ReRollPrice
    }
    return tbPotential, mapPotential, nType, mapCaseData.TeamLevel, mapCaseData.NewIds, mapRoll
  end
  
  local function ProcessPotentialData(nId)
    local mapCaseData = self.mapCases[self.EnumCase.PotentialSelect][nId]
    local tbPotential = {}
    local mapPotential = {}
    for _, mapPotentialInfo in ipairs(mapCaseData.Infos) do
      table.insert(tbPotential, {
        Id = mapPotentialInfo.Tid,
        Count = mapPotentialInfo.Level
      })
      mapPotential[mapPotentialInfo.Tid] = 0
      local mapPotentialCfgData = ConfigTable.GetData("Potential", mapPotentialInfo.Tid)
      if mapPotentialCfgData == nil then
        printError("PotentialCfgData Missing" .. mapPotentialInfo.Tid)
        return
      end
      local nCharId = mapPotentialCfgData.CharId
      if self._mapPotential[nCharId][mapPotentialInfo.Tid] ~= nil then
        mapPotential[mapPotentialInfo.Tid] = self._mapPotential[nCharId][mapPotentialInfo.Tid]
      end
    end
    local mapRoll = {
      CanReRoll = mapCaseData.CanReRoll,
      ReRollPrice = mapCaseData.ReRollPrice
    }
    return tbPotential, mapPotential, mapCaseData.Type, mapCaseData.TeamLevel, mapCaseData.NewIds, mapRoll, mapCaseData.LuckyIds
  end
  
  local function GetUnfinishedSelect()
    if self.mapCases[self.EnumCase.SelectSpecialPotential] ~= nil then
      for nId, mapData in pairs(self.mapCases[self.EnumCase.SelectSpecialPotential]) do
        if mapData.bFinish ~= true then
          local tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll = ProcessSpecialPotentialData(nId)
          return nId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll
        end
      end
    end
    if self.mapCases[self.EnumCase.PotentialSelect] ~= nil then
      for nId, mapData in pairs(self.mapCases[self.EnumCase.PotentialSelect]) do
        if mapData.bFinish ~= true then
          local tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, tbLuckyIds = ProcessPotentialData(nId)
          return nId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, tbLuckyIds
        end
      end
    end
    return 0, {}, {}, 0
  end
  
  local function SelectCallback(nIdx, nId, panelCallback, bReRoll, bAuto)
    if nId == -1 then
      if self._bAutoRequestPending then
        self:FinishAutoRequest(true)
      end
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        if not self:TryOpenManualAfterAutoRequest() then
          self:HandleCases()
        end
      end
      
      cs_coroutine.start(wait)
      return
    end
    local msg = {}
    msg.Id = nId
    msg.SelectReq = {}
    msg.SelectReq.Auto = bAuto == true
    if bReRoll then
      msg.SelectReq.ReRoll = true
    else
      msg.SelectReq.Index = nIdx - 1
    end
    
    local function InteractiveCallback(callbackMsg)
      local Id = callbackMsg.Id
      if self.mapCases[self.EnumCase.SelectSpecialPotential] ~= nil and self.mapCases[self.EnumCase.SelectSpecialPotential][Id] ~= nil then
        if self.mapCases[self.EnumCase.SelectSpecialPotential][nId].bReRoll then
          self.mapCases[self.EnumCase.SelectSpecialPotential][nId].bReRoll = false
        else
          self.mapCases[self.EnumCase.SelectSpecialPotential][Id].bFinish = true
        end
      end
      if self.mapCases[self.EnumCase.PotentialSelect] ~= nil and self.mapCases[self.EnumCase.PotentialSelect][Id] ~= nil then
        if self.mapCases[self.EnumCase.PotentialSelect][nId].bReRoll then
          self.mapCases[self.EnumCase.PotentialSelect][nId].bReRoll = false
        else
          self.mapCases[self.EnumCase.PotentialSelect][Id].bFinish = true
        end
      end
      local caseId, tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, mapRoll, tbLuckyIds = GetUnfinishedSelect()
      local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
      local bHasPanelCallback = panelCallback ~= nil and type(panelCallback) == "function"
      if bAuto == true and caseId ~= 0 then
        self:FinishAutoRequest(true)
        if bHasPanelCallback then
          self._bOpenManualAfterAutoRequest = false
        end
        if self:IsAutoDecisionEnabled() then
          local mapSpecialCase = self.mapCases[self.EnumCase.SelectSpecialPotential]
          local bNextSpecial = mapSpecialCase ~= nil and mapSpecialCase[caseId] ~= nil
          self:OpenSelectPotential(caseId, bNextSpecial, true, panelCallback)
          return
        end
      end
      if bHasPanelCallback then
        local tbRecommend = self:GetRecommondPotential(tbPotential)
        panelCallback(caseId, tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, tbRecommend)
      elseif bAuto == true and caseId == 0 then
        self:FinishAutoRequest(true)
        if not self:TryOpenManualAfterAutoRequest() then
          self:HandleCases()
        end
      end
    end
    
    self:StarTowerInteract(msg, InteractiveCallback)
  end
  
  local tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, mapRoll, tbLuckyIds
  if bSpecial then
    tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, mapRoll = ProcessSpecialPotentialData(nCaseId)
  else
    tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, mapRoll, tbLuckyIds = ProcessPotentialData(nCaseId)
  end
  local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  local tbRecommend = self:GetRecommondPotential(tbPotential)
  
  local function OpenPotentialPanel(nAutoSelectIdx, readyCallback)
    if type(panelRefreshCallback) == "function" then
      panelRefreshCallback(nCaseId, tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, tbRecommend, nAutoSelectIdx, readyCallback)
    else
      if bKeepPanelOpen ~= true then
        EventManager.Hit("StarTowerPotentialSelect", nCaseId, tbPotential, mapPotential, nType, nTeamLevel, tbNewIds, SelectCallback, mapRoll, nCoin, tbLuckyIds, tbRecommend, nAutoSelectIdx)
      end
      if type(readyCallback) == "function" then
        readyCallback()
      end
    end
  end
  
  if not self:IsAutoDecisionEnabled() then
    OpenPotentialPanel()
    return
  end
  local mapContext = self:BuildAutoDecisionContext()
  local mapDecision = StarTowerAutoDecision:DecidePotential(mapContext, tbPotential, mapPotential, mapRoll, tbNewIds, tbLuckyIds, tbRecommend)
  if mapDecision.bSuccess ~= true then
    self:HandleAutoDecisionFail(mapDecision, OpenPotentialPanel)
    return
  end
  local nAutoSelectIdx = mapDecision.nActionType == StarTowerAutoDecision.ActionType.SelectPotential and mapDecision.nTargetIndex or nil
  local mapGuard = {
    nCaseId = nCaseId,
    isValidCallback = function()
      local mapCaseGroup = bSpecial and self.mapCases[self.EnumCase.SelectSpecialPotential] or self.mapCases[self.EnumCase.PotentialSelect]
      return mapCaseGroup ~= nil and mapCaseGroup[nCaseId] ~= nil and mapCaseGroup[nCaseId].bFinish ~= true
    end
  }
  OpenPotentialPanel(nAutoSelectIdx, function()
    self:ScheduleAutoDecision(mapDecision, mapGuard, function()
      local bReRoll = mapDecision.nActionType == StarTowerAutoDecision.ActionType.PotentialReroll
      EventManager.Hit("StarTowerAutoSelectPotential", nCaseId, mapDecision.nTargetIndex, bReRoll)
    end)
  end)
end

function StarTowerSweepData:OpenSelectNote(nCaseId)
  local function ProcessNoteData(nId)
    local mapCaseData = self.mapCases[self.EnumCase.NoteSelect][nId]
    
    local tbNoteSelect = mapCaseData.Info
    local mapNote = self._mapNote
    return tbNoteSelect, mapNote
  end
  
  local function GetUnfinishedSelect()
    if self.mapCases[self.EnumCase.NoteSelect] ~= nil then
      for nId, mapData in pairs(self.mapCases[self.EnumCase.NoteSelect]) do
        if mapData.bFinish ~= true then
          local tbPotential, mapPotential = ProcessNoteData(nId)
          return nId, tbPotential, mapPotential
        end
      end
    end
    return 0, {}, {}
  end
  
  local function SelectCallback(nIdx, nId, panelCallback)
    if nIdx == -1 then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self:HandleCases()
      end
      
      cs_coroutine.start(wait)
      return
    end
    local msg = {}
    msg.Id = nId
    msg.SelectReq = {}
    msg.SelectReq.Index = nIdx - 1
    
    local function InteractiveCallback(callbackMsg)
      local Id = callbackMsg.Id
      if self.mapCases[self.EnumCase.NoteSelect] ~= nil and self.mapCases[self.EnumCase.NoteSelect][Id] ~= nil then
        self.mapCases[self.EnumCase.NoteSelect][Id].bFinish = true
      end
      local caseId, tbNoteSelect, mapNote = GetUnfinishedSelect()
      if panelCallback ~= nil and type(panelCallback) == "function" then
        panelCallback(caseId, tbNoteSelect, mapNote)
      end
    end
    
    self:StarTowerInteract(msg, InteractiveCallback)
  end
  
  local tbNoteSelect, mapNote = ProcessNoteData(nCaseId)
  EventManager.Hit("StarTowerSelectNote", nCaseId, mapNote, tbNoteSelect, SelectCallback)
end

function StarTowerSweepData:OpenSelectFateCard(nCaseId)
  local function ProcessFateCard(nId)
    local mapCaseData = self.mapCases[self.EnumCase.FateCardSelect][nId]
    
    local tbFateCard = mapCaseData.Ids
    local tbNewIds = mapCaseData.NewIds
    local bReward = mapCaseData.Give
    local mapRoll = {
      CanReRoll = mapCaseData.CanReRoll,
      ReRollPrice = mapCaseData.ReRollPrice
    }
    return tbFateCard, tbNewIds, mapRoll, bReward
  end
  
  local function GetUnfinishedSelect()
    if self.mapCases[self.EnumCase.FateCardSelect] ~= nil then
      for nId, mapData in pairs(self.mapCases[self.EnumCase.FateCardSelect]) do
        if mapData.bFinish ~= true then
          local tbFateCard, tbNewIds, mapRoll, bReward = ProcessFateCard(nId)
          return nId, tbFateCard, tbNewIds, mapRoll, bReward
        end
      end
    end
    return 0, {}, {}
  end
  
  local function SelectCallback(nIdx, nId, panelCallback, bReRoll)
    if nIdx == -1 then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self:HandleCases()
      end
      
      cs_coroutine.start(wait)
      return
    end
    local msg = {}
    msg.Id = nId
    msg.SelectReq = {}
    if bReRoll then
      msg.SelectReq.ReRoll = true
    else
      msg.SelectReq.Index = nIdx - 1
    end
    
    local function InteractiveCallback(callbackMsg)
      local Id = callbackMsg.Id
      if self.mapCases[self.EnumCase.FateCardSelect] ~= nil and self.mapCases[self.EnumCase.FateCardSelect][nId] ~= nil then
        if self.mapCases[self.EnumCase.FateCardSelect][nId].bReRoll then
          self.mapCases[self.EnumCase.FateCardSelect][nId].bReRoll = false
        else
          self.mapCases[self.EnumCase.FateCardSelect][nId].bFinish = true
        end
      end
      local caseId, tbFateCard, tbNewIds, mapRoll, bReward = GetUnfinishedSelect()
      local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
      if panelCallback ~= nil and type(panelCallback) == "function" then
        panelCallback(caseId, tbFateCard, tbNewIds, mapRoll, nCoin, bReward)
      end
    end
    
    self:StarTowerInteract(msg, InteractiveCallback)
  end
  
  local tbFateCard, tbNewIds, mapRoll, bReward = ProcessFateCard(nCaseId)
  local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  EventManager.Hit("StarTowerSelectFateCard", nCaseId, tbFateCard, tbNewIds, SelectCallback, mapRoll, nCoin, bReward)
end

function StarTowerSweepData:OpenNpcOptionPanel(nCaseId, nNpcConfigId)
  if self.mapCases[self.EnumCase.NpcEvent] == nil then
    printError("No NpcOptionCase!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.NpcEvent][nCaseId]
  if mapCase == nil then
    printError("No NpcOptionCase! :" .. nCaseId)
    return
  end
  local nBoardNpcId = ConfigTable.GetData("NPCConfig", nNpcConfigId).NPCId
  local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
  if mapCase.bFinish then
    local tbChat = ConfigTable.GetData("NPCConfig", nNpcConfigId).Lines
    local nCount = #tbChat
    local nTalkId = tbChat[1]
    if 1 < nCount then
      nTalkId = tbChat[math.random(1, #tbChat)]
    end
    if nTalkId == nil then
      nTalkId = 0
    end
    local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
    EventManager.Hit(EventId.OpenPanel, PanelId.NpcOptionPanel, 0, 0, {}, nSkinId, 1, {}, {}, nTalkId, 0, true, true, nCoin, self.nTowerId, self._mapNote, self.tbDisc)
    return
  end
  local tbOption = mapCase.Options
  local tbUnabledOption = mapCase.FailedIdxes
  local nTableEvtId = mapCase.EvtId
  local nEventId = nCaseId
  
  local function callback(nIdx, nEvtId, bClose, bAuto)
    EventManager.Hit("InteractiveNpcFinish", nNpcConfigId)
    if bClose then
      self.mapCases[self.EnumCase.NpcEvent][nCaseId].bFinish = true
      self:HandleCases()
      return
    end
    local nOptionId = tbOption[nIdx]
    local mapOptionData = ConfigTable.GetData("EventOptions", nOptionId)
    local bJump = false
    if mapOptionData ~= nil then
      bJump = mapOptionData.IgnoreInterActive
    else
      printError("EventOptions Missing��" .. nOptionId)
    end
    local bAutoEventSelect = bAuto == true or self._bAutoRequestPending == true and self._mapPendingAutoDecision ~= nil and self._mapPendingAutoDecision.nActionType == StarTowerAutoDecision.ActionType.EventSelect
    if bJump and not bAutoEventSelect then
      self.mapCases[self.EnumCase.NpcEvent][nCaseId].bFinish = true
      self:HandleCases()
      return
    end
    local msg = {}
    msg.Id = nEvtId
    msg.SelectReq = {}
    msg.SelectReq.Index = nIdx - 1
    msg.SelectReq.Auto = bAutoEventSelect
    
    local function InteractiveCallback(callbackMsg, tbChangeFateCard, mapChangeNote, mapItemChange, nLevelChange, nExpChange, mapPotentialChange, mapChangeSecondarySkill)
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self:HandleCases()
      end
      
      local bSuccess = false
      if callbackMsg.SelectResp ~= nil and callbackMsg.SelectResp.Resp ~= nil then
        bSuccess = callbackMsg.SelectResp.Resp.OptionsResult
      end
      if bSuccess then
        self.mapCases[self.EnumCase.NpcEvent][nCaseId].bFinish = true
        local tbInfo = {}
        for _, mapChange in ipairs(callbackMsg.SelectResp.Resp.AffinityChange) do
          table.insert(tbInfo, {
            NPCId = mapChange.NPCId,
            Affinity = mapChange.Affinity
          })
          EventManager.Hit("ShowNPCAffinity", mapChange.NPCId, mapChange.Increase)
        end
        self.mapCases[self.EnumCase.NpcEvent][nCaseId].Infos = tbInfo
        EventManager.Hit("StarTowerEventInteract", clone(mapChangeNote), clone(mapItemChange), clone(mapPotentialChange), clone(tbChangeFateCard), clone(mapChangeSecondarySkill))
        if bAuto == true then
          self:FinishAutoRequest(true)
        end
        if bAuto ~= true or self:IsAutoDecisionEnabled() then
          cs_coroutine.start(wait)
        else
          self:TryOpenManualAfterAutoRequest()
        end
      else
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Startower_EventFailHint"))
        table.insert(mapCase.FailedIdxes, nIdx - 1)
        if bAuto == true then
          self:FinishAutoRequest(true)
        end
        if bAuto ~= true or self:IsAutoDecisionEnabled() then
          self:HandleNpc(nNpcConfigId)
        else
          self:TryOpenManualAfterAutoRequest()
        end
      end
      if callbackMsg.SelectResp ~= nil and callbackMsg.SelectResp.Resp ~= nil and callbackMsg.SelectResp.Resp.OptionsParamId ~= nil and callbackMsg.SelectResp.Resp.OptionsParamId ~= 0 then
        local sTextId = "EventResult_" .. tostring(callbackMsg.SelectResp.Resp.OptionsParamId)
        local sResultHint = ConfigTable.GetUIText(sTextId)
        EventManager.Hit(EventId.OpenMessageBox, sResultHint)
      end
    end
    
    self:StarTowerInteract(msg, InteractiveCallback)
  end
  
  local mapAffinity = {}
  for _, mapInfo in ipairs(mapCase.Infos) do
    mapAffinity[mapInfo.NPCId] = mapInfo.Affinity
  end
  local tbLines = ConfigTable.GetData("NPCConfig", nNpcConfigId).FirstLines
  local tbChat = {}
  for _, nTalkId in ipairs(tbLines) do
    local mapTalkCfg = ConfigTable.GetData("StarTowerTalk", nTalkId)
    if mapTalkCfg ~= nil and mapAffinity[mapTalkCfg.NPCId] ~= nil then
      local nAffinity = mapAffinity[mapTalkCfg.NPCId]
      if #mapTalkCfg.Affinity == 2 and nAffinity ~= nil and nAffinity >= mapTalkCfg.Affinity[1] and nAffinity <= mapTalkCfg.Affinity[2] then
        table.insert(tbChat, nTalkId)
      end
    end
  end
  if #tbChat < 1 then
    table.insert(tbChat, tbLines[1])
  end
  local nCount = #tbChat
  local nTalkId = tbChat[1]
  if 1 < nCount then
    nTalkId = tbChat[math.random(1, #tbChat)]
  end
  if nTalkId == nil then
    nTalkId = 0
  end
  mapCase.bFirst = false
  local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  
  local function OpenOptionPanel(mapAutoDisplay)
    EventManager.Hit(EventId.OpenPanel, PanelId.NpcOptionPanel, 1, nEventId, tbOption, nSkinId, callback, tbUnabledOption, nTableEvtId, nTalkId, mapCase.nActionId, false, true, nCoin, self.nTowerId, self._mapNote, self.tbDisc, mapAutoDisplay)
  end
  
  if not self:IsAutoDecisionEnabled() then
    OpenOptionPanel()
    return
  end
  local mapDecision = StarTowerAutoDecision:DecideEvent(self:BuildAutoDecisionContext(), tbOption, tbUnabledOption, nEventId)
  if mapDecision.bSuccess ~= true then
    self:HandleAutoDecisionFail(mapDecision, OpenOptionPanel)
    return
  end
  local mapAutoDisplay = {
    nTargetIndex = mapDecision.nTargetIndex,
    isEnabledCallback = function()
      return self:IsAutoDecisionEnabled()
    end,
    readyCallback = function()
      self:ScheduleAutoDecision(mapDecision, {
        nCaseId = nCaseId,
        isValidCallback = function()
          local mapEventCase = self.mapCases[self.EnumCase.NpcEvent]
          return mapEventCase ~= nil and mapEventCase[nCaseId] ~= nil and mapEventCase[nCaseId].bFinish ~= true
        end
      }, function()
        EventManager.Hit("StarTowerAutoSelectEvent", nEventId, mapDecision.nTargetIndex)
      end)
    end
  }
  local bOptionPanelOpen, bOptionPanelActive = PanelManager.CheckPanelOpen(PanelId.NpcOptionPanel)
  if bOptionPanelOpen and bOptionPanelActive then
    EventManager.Hit("StarTowerAutoDisplayEvent", nEventId, mapAutoDisplay)
  else
    OpenOptionPanel(mapAutoDisplay)
  end
end

function StarTowerSweepData:HandleRecover(nCaseId, nNpcConfigId)
  if self.mapCases[self.EnumCase.RecoveryHP] == nil then
    printError("No RecoveryHP!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.RecoveryHP][nCaseId]
  if mapCase == nil then
    printError("No RecoveryHP! :" .. nCaseId)
    return
  end
  if mapCase.bFinish then
    printError("Event has finished! :" .. nCaseId)
    return
  end
  local nHp = 0
  local msg = {}
  msg.Id = nCaseId
  msg.RecoveryHPReq = {}
  msg.RecoveryHPReq.Hp = nHp
  
  local function callback(_, msgData)
    self.mapCases[self.EnumCase.RecoveryHP][nCaseId].bFinish = true
    self:HandleCases()
  end
  
  self:StarTowerInteract(msg, callback)
end

function StarTowerSweepData:HandleNpcRecover(nCaseId, nNpcConfigId)
  if self.mapCases[self.EnumCase.NpcRecoveryHP] == nil then
    printError("No NpcOptionCase!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.NpcRecoveryHP][nCaseId]
  if mapCase == nil then
    printError("No NpcOptionCase! :" .. nCaseId)
    return
  end
  if mapCase.bFinish then
    local nBoardNpcId = ConfigTable.GetData("NPCConfig", nNpcConfigId).NPCId
    local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
    local tbChat = ConfigTable.GetData("NPCConfig", nNpcConfigId).Lines
    local nCount = #tbChat
    local nTalkId = tbChat[1]
    if 1 < nCount then
      nTalkId = tbChat[math.random(1, #tbChat)]
    end
    if nTalkId == nil then
      nTalkId = 0
    end
    local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
    EventManager.Hit(EventId.OpenPanel, PanelId.NpcOptionPanel, 0, 0, {}, nSkinId, 1, {}, {}, nTalkId, 0, true, true, nCoin, self.nTowerId, self._mapNote, self.tbDisc)
    return
  end
  local nHp = 0
  local msg = {}
  msg.Id = nCaseId
  msg.RecoveryHPReq = {}
  msg.RecoveryHPReq.Hp = nHp
  
  local function callback(_, msgData)
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_NpcRecoverTips"))
    EventManager.Hit("InteractiveNpcFinish", nNpcConfigId)
    self.mapCases[self.EnumCase.NpcRecoveryHP][nCaseId].bFinish = true
    self:HandleCases()
  end
  
  self:StarTowerInteract(msg, callback)
end

function StarTowerSweepData:HandleNpcDangerRoom(nCaseId, nNpcConfigId)
  if self.mapCases[self.EnumCase.DoorDanger] == nil then
    printError("No NpcOptionCase!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.DoorDanger][nCaseId]
  if mapCase == nil then
    printError("No NpcOptionCase! :" .. nCaseId)
    return
  end
  local nRoomType = mapCase.Type
  local nBoardNpcId = ConfigTable.GetData("NPCConfig", nNpcConfigId).NPCId
  local nSkinId = PlayerData.Board:GetNPCUsingSkinId(nBoardNpcId)
  
  local function callback(nIdx, nEvtId)
    EventManager.Hit("InteractiveNpcFinish", nNpcConfigId)
    if nIdx == 1 then
      EventManager.Hit("SweepEnterDangerRoom", nEvtId, nRoomType)
    else
      self:HandleCases()
    end
  end
  
  local tbChat = ConfigTable.GetData("NPCConfig", nNpcConfigId).Lines
  local nTalkId = tbChat[math.random(1, #tbChat)]
  if nTalkId == nil then
    nTalkId = 0
  end
  local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  EventManager.Hit(EventId.OpenPanel, PanelId.NpcOptionPanel, 2, nCaseId, {}, nSkinId, callback, {}, 0, nTalkId, 0, false, true, nCoin, self.nTowerId, self._mapNote, self.tbDisc)
end

function StarTowerSweepData:HandlePopupDisc(mapData)
  local function callback()
    mapData.bFinish = true
    
    self:HandleCases()
  end
  
  EventManager.Hit("StarTowerShowDiscSkill", mapData.param, clone(self._mapNote), callback)
  if self:IsAutoDecisionEnabled() then
    EventManager.Hit("StarTowerAutoAdvanceDiscSkill", callback, function()
      return self:IsAutoDecisionEnabled()
    end)
  end
end

function StarTowerSweepData:HandlePopupReward(mapData)
  local function callback()
    mapData.bFinish = true
    
    self:HandleCases()
  end
  
  EventManager.Hit("StarTowerShowReward", mapData.param, callback)
  if self:IsAutoDecisionEnabled() then
    EventManager.Hit("StarTowerAutoCloseReward", callback, function()
      return self:IsAutoDecisionEnabled()
    end)
  end
end

function StarTowerSweepData:HandlePopupPotential(mapData)
  local function callback()
    mapData.bFinish = true
    
    self:HandleCases()
  end
  
  EventManager.Hit("ShowPotentialLevelUp", mapData.param, callback)
  if self:IsAutoDecisionEnabled() then
    EventManager.Hit("StarTowerAutoClosePotentialLevelUp", callback, function()
      return self:IsAutoDecisionEnabled()
    end)
  end
end

function StarTowerSweepData:HandleShopStrengthFx(mapData)
  local function callback()
    mapData.bFinish = true
    
    self:HandleCases()
  end
  
  EventManager.Hit("ShowShopStrengthFx", mapData.param, callback)
end

function StarTowerSweepData:InteractiveShop(nCaseId, nNpcConfigId, bAuto)
  if self.mapCases[self.EnumCase.Hawker] == nil then
    printError("No Hawker Case!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.Hawker]
  if mapCase == nil then
    printError("No Hawker Case! :" .. nCaseId)
    return
  end
  
  local function BuildRollData(case)
    return {
      CanReRoll = case.CanReRoll,
      ReRollPrice = case.ReRollPrice,
      ReRollTimes = case.ReRollTimes
    }
  end
  
  local function BuildShopData(case)
    local tbShopData = {}
    for index, mapGood in ipairs(case.List) do
      tbShopData[index] = {
        Idx = mapGood.Idx,
        bSoldOut = table.indexof(case.Purchase, mapGood.Sid) > 0,
        Price = mapGood.Price,
        nDiscount = mapGood.Discount,
        nCharId = 0 < mapGood.CharPos and self.tbTeam[mapGood.CharPos] or 0,
        nSid = mapGood.Sid,
        nType = mapGood.Type,
        nGoodsId = mapGood.GoodsId
      }
    end
    return tbShopData
  end
  
  local function BuyCallback(nEvtId, nSid, callback, bReRoll, bAutoRequest)
    local msg = {}
    msg.Id = nEvtId
    msg.HawkerReq = {}
    msg.HawkerReq.Auto = bAutoRequest == true
    if bReRoll then
      msg.HawkerReq.ReRoll = true
    else
      msg.HawkerReq.Sid = nSid
    end
    
    local function InteractiveCallback(callbackMsg, tbChangeFateCard, mapChangeNote, mapItemChange, nLevelChange, nExpChange, mapPotentialChange)
      local nBagCount = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
      local mapInteractiveCase = self.mapCases[self.EnumCase.Hawker]
      if mapInteractiveCase ~= nil then
        if mapInteractiveCase.bReRoll then
          mapInteractiveCase.bReRoll = false
        elseif nSid ~= nil and 0 >= table.indexof(mapInteractiveCase.Purchase, nSid) then
          table.insert(mapInteractiveCase.Purchase, nSid)
        end
      end
      if callback ~= nil and type(callback) == "function" then
        if bReRoll and mapInteractiveCase ~= nil then
          local mapRoll = BuildRollData(mapInteractiveCase)
          local tbShopData = BuildShopData(mapInteractiveCase)
          callback(nBagCount, tbShopData, mapRoll)
        else
          callback(nBagCount)
        end
      end
      EventManager.Hit("StarTowerShopInteract", mapChangeNote)
      if bAutoRequest == true then
        self:FinishAutoRequest(true)
        if self:IsAutoDecisionEnabled() then
          self:HandleCases()
        else
          self:TryOpenManualAfterAutoRequest()
        end
      else
        self:HandleCases()
      end
    end
    
    self:StarTowerInteract(msg, InteractiveCallback)
  end
  
  local mapRoll = BuildRollData(mapCase)
  local tbShopData = BuildShopData(mapCase)
  local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  
  local function OpenShopPanel(autoStartCallback)
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerShop, tbShopData, nCoin, BuyCallback, nCaseId, mapRoll, self.tbDisc, self._mapNote, self.nTowerId, self.nCurLevel, autoStartCallback)
  end
  
  if bAuto ~= true or not self:IsAutoDecisionEnabled() then
    OpenShopPanel()
    return
  end
  local bShopPanelOpen, bShopPanelActive = PanelManager.CheckPanelOpen(PanelId.StarTowerShop)
  if not bShopPanelOpen or not bShopPanelActive then
    OpenShopPanel(function()
      if self:IsAutoDecisionEnabled() then
        self:InteractiveShop(nCaseId, nNpcConfigId, true)
      end
    end)
    return
  end
  local mapContext = self:BuildAutoDecisionContext()
  local mapMachineCase = self.mapCases[self.EnumCase.StrengthenMachine]
  mapContext.bMachine = mapMachineCase ~= nil and mapMachineCase.bFinish ~= true and self._bAutoMachineFinished ~= true
  mapContext.nMachineCost = self:GetStrengthMachineCost()
  local mapDecision = StarTowerAutoDecision:DecideShop(mapContext, tbShopData, mapRoll, nCoin)
  if mapDecision.bSuccess ~= true then
    if mapDecision.nFailReason == StarTowerAutoDecision.FailReason.CoinNotEnough or mapDecision.nFailReason == StarTowerAutoDecision.FailReason.NoOption then
      self._bAutoShopFinished = true
      self._bAutoShopExhausted = mapDecision.bShopExhausted == true
      self:CloseAutoShop(function()
        self:TryAutoShopEntry()
      end)
    else
      self._autoShopCompleteCallback = nil
      self:HandleAutoDecisionFail(mapDecision)
      EventManager.Hit("StarTowerAutoDecisionRequestManual")
    end
    return
  end
  if mapDecision.nActionType == StarTowerAutoDecision.ActionType.StrengthMachine then
    self._bAutoUpgradeBeforeShopSpendAll = true
    self:TryAutoShopEntry()
    return
  end
  self:ScheduleAutoDecision(mapDecision, {
    nCaseId = nCaseId,
    isValidCallback = function()
      return self.mapCases[self.EnumCase.Hawker] == mapCase and mapCase.bFinish ~= true
    end
  }, function()
    local bReRoll = mapDecision.nActionType == StarTowerAutoDecision.ActionType.ShopReroll
    if not bReRoll then
      local nCurrentCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
      local nFailReason = StarTowerAutoDecision.FailReason.NoOption
      for _, mapGood in ipairs(BuildShopData(mapCase)) do
        if mapGood.nSid == mapDecision.nTargetId then
          if not mapGood.bSoldOut then
            local nPrice = 0 < mapGood.nDiscount and mapGood.nDiscount or mapGood.Price
            if nCurrentCoin >= nPrice then
              nFailReason = nil
              break
            end
            nFailReason = StarTowerAutoDecision.FailReason.CoinNotEnough
          end
          break
        end
      end
      if nFailReason ~= nil then
        self:FinishAutoRequest(false, nFailReason)
        self:InteractiveShop(nCaseId, nNpcConfigId, true)
        return
      end
    end
    EventManager.Hit("StarTowerAutoShopExecute", mapDecision.nTargetId, bReRoll)
  end)
end

function StarTowerSweepData:InteractiveStrengthMachine(nCaseId, nNpcConfigId, bAuto)
  if self.bEnd or self._mapStrengthMachineRequest ~= nil then
    return
  end
  if self.mapCases[self.EnumCase.StrengthenMachine] == nil then
    printError("No StrengthMachine Case!")
    return
  end
  local mapCase = self.mapCases[self.EnumCase.StrengthenMachine]
  if mapCase == nil then
    printError("No StrengthMachine Case! :" .. nCaseId)
    return
  end
  local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency]
  if nCoin == nil then
    nCoin = 0
  end
  local bFirstFree = mapCase.FirstFree
  local nCost = self:GetStrengthMachineCost()
  if bAuto == true then
    local bCanConsume = StarTowerAutoDecision:CanConsumeToken(self:BuildAutoDecisionContext(), StarTowerAutoDecision.ActionType.StrengthMachine)
    if not bCanConsume then
      self:StopAutoDecision(StarTowerAutoDecision.FailReason.TokenNotEnough, true)
      self:FinishAutoRequest(false, StarTowerAutoDecision.FailReason.TokenNotEnough)
      self:TryOpenManualAfterAutoRequest()
      return
    end
  end
  if nCoin < nCost then
    printError("Not Enough Coin!")
    if bAuto == true then
      self:FinishAutoRequest(false, StarTowerAutoDecision.FailReason.CoinNotEnough)
      self._bAutoMachineFinished = true
      if self:IsAutoDecisionEnabled() then
        self:TryAutoShopEntry()
      else
        self:TryOpenManualAfterAutoRequest()
      end
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_NotEnoughCoin"))
    end
    return
  end
  local mapRequest = {}
  self._mapStrengthMachineRequest = mapRequest
  
  local function LogRequest(sResult)
    printLog(string.format("[StarTowerAuto] StrengthMachine result=%s tower=%s floor=%s case=%s auto=%s cost=%s coinBefore=%s coinNow=%s times=%s free=%s discount=%s token=%s", sResult, tostring(self.nTowerId), tostring(self.nCurLevel), tostring(nCaseId), tostring(bAuto == true), tostring(nCost), tostring(nCoin), tostring(self._mapItem[AllEnum.CoinItemId.FixedRogCurrency]), tostring(mapCase.Times), tostring(mapCase.FirstFree), tostring(mapCase.Discount), tostring(PlayerData.StarTowerAutoPlan and PlayerData.StarTowerAutoPlan:GetTokenCount())))
  end
  
  local function ReleaseRequest()
    if self._mapStrengthMachineRequest == mapRequest then
      self._mapStrengthMachineRequest = nil
    end
  end
  
  local function InteractiveCallback(netmsgData)
    ReleaseRequest()
    LogRequest(netmsgData.StrengthenMachineResp and netmsgData.StrengthenMachineResp.BuySucceed == false and "Rejected" or "Succeeded")
    if netmsgData.StrengthenMachineResp ~= nil and not netmsgData.StrengthenMachineResp.BuySucceed then
      if bAuto == true then
        self:FinishAutoRequest(false, StarTowerAutoDecision.FailReason.NoMatchedTarget)
        self._bAutoMachineFinished = true
      end
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_NoPotential"))
      printError("û�п�ѡ��Ǳ��")
      if bAuto == true then
        if self:IsAutoDecisionEnabled() then
          self:TryAutoShopEntry()
        else
          self:TryOpenManualAfterAutoRequest()
        end
      end
      return
    end
    if bFirstFree then
      mapCase.FirstFree = false
    else
      mapCase.Times = mapCase.Times + 1
    end
    if bAuto == true then
      self:FinishAutoRequest(true)
      if self:IsAutoDecisionEnabled() then
        self:HandleCases()
      else
        self:TryOpenManualAfterAutoRequest()
      end
    else
      self:HandleCases()
    end
    EventManager.Hit("InteractiveNpcFinish")
    EventManager.Hit("RefreshStrengthMachineCost", mapCase.Times, mapCase.FirstFree)
  end
  
  local msg = {}
  msg.Id = nCaseId
  LogRequest("Send")
  self:StarTowerInteract(msg, InteractiveCallback, function()
    ReleaseRequest()
    LogRequest("Failed")
  end)
end

function StarTowerSweepData:CalBuildScore()
  local nPotentialScore = 0
  for _, tbPotentialInfo in pairs(self._mapPotential) do
    for nPotentialId, nPotentialLevel in pairs(tbPotentialInfo) do
      local mapPotentialCfgData = ConfigTable.GetData("Potential", nPotentialId)
      if nil ~= mapPotentialCfgData and 0 < nPotentialLevel then
        nPotentialScore = nPotentialScore + mapPotentialCfgData.BuildScore[nPotentialLevel]
      end
    end
  end
  local nDiscScore = 0
  for k, nDiscId in ipairs(self.tbDisc) do
    if 0 ~= nDiscId and k <= 3 then
      nDiscScore = nDiscScore + PlayerData.Disc:GetDiscSkillScore(nDiscId, self._mapNote)
    end
  end
  local nNoteScore = 0
  for nNoteId, nNoteCount in pairs(self._mapNote) do
    if 0 < nNoteCount then
      local mapCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
      if mapCfg and next(mapCfg.Scores) ~= nil then
        local nMax = #mapCfg.Scores
        local nLevel = nNoteCount > nMax and nMax or nNoteCount
        nNoteScore = nNoteScore + mapCfg.Scores[nLevel]
      end
    end
  end
  return nPotentialScore + nDiscScore + nNoteScore
end

function StarTowerSweepData:GetDoorCase()
  if self.mapCases[self.EnumCase.OpenDoor] ~= nil then
    return self.mapCases[self.EnumCase.OpenDoor][1], self.mapCases[self.EnumCase.OpenDoor][2]
  end
  return nil
end

function StarTowerSweepData:GetShopAndMachine()
  local bShop = self.mapCases[self.EnumCase.Hawker] ~= nil
  local bMachine = self.mapCases[self.EnumCase.StrengthenMachine] ~= nil
  local nMachineCount, nDiscount, bFirstFree = 0, 0, false
  if bMachine then
    nMachineCount = self.mapCases[self.EnumCase.StrengthenMachine].Times
    nDiscount = self.mapCases[self.EnumCase.StrengthenMachine].Discount
    bFirstFree = self.mapCases[self.EnumCase.StrengthenMachine].FirstFree
  end
  return bShop, bMachine, nMachineCount, nDiscount, bFirstFree
end

function StarTowerSweepData:GetStrengthMachineCost()
  local mapCase = self.mapCases[self.EnumCase.StrengthenMachine]
  if mapCase == nil then
    return 0
  end
  local nCost = self.tbStrengthMachineCost[mapCase.Times + 1]
  if nCost == nil then
    nCost = self.tbStrengthMachineCost[#self.tbStrengthMachineCost] or 0
  end
  if mapCase.FirstFree then
    return 0
  end
  return math.max(0, nCost - (mapCase.Discount or 0))
end

function StarTowerSweepData:CloseAutoShop(completeCallback)
  if not self:IsAutoDecisionEnabled() then
    return
  end
  local nSerial = self._nAutoDecisionSerial
  
  local function callback()
    if nSerial == self._nAutoDecisionSerial and self:IsAutoDecisionEnabled() and not PanelManager.CheckPanelOpen(PanelId.StarTowerShop) and type(completeCallback) == "function" then
      completeCallback()
    end
  end
  
  local bShopPanelOpen, bShopPanelActive = PanelManager.CheckPanelOpen(PanelId.StarTowerShop)
  if bShopPanelOpen and bShopPanelActive then
    EventManager.Hit("StarTowerAutoShopComplete", callback)
  elseif not bShopPanelOpen then
    callback()
  end
end

function StarTowerSweepData:CompleteAutoShopEntry()
  self:CloseAutoShop(function()
    local callback = self._autoShopCompleteCallback
    self._autoShopCompleteCallback = nil
    if type(callback) == "function" then
      callback()
    end
  end)
end

function StarTowerSweepData:TryAutoShopEntry(completeCallback)
  local bInitial = type(completeCallback) == "function"
  if bInitial then
    self._autoShopCompleteCallback = completeCallback
  end
  if not self:IsAutoDecisionEnabled() then
    if bInitial then
      self._autoShopCompleteCallback = nil
    end
    return false
  end
  local mapShopCase = self.mapCases[self.EnumCase.Hawker]
  local mapMachineCase = self.mapCases[self.EnumCase.StrengthenMachine]
  local bShop = mapShopCase ~= nil and mapShopCase.bFinish ~= true and self._bAutoShopFinished ~= true
  local bMachine = mapMachineCase ~= nil and mapMachineCase.bFinish ~= true and self._bAutoMachineFinished ~= true
  if not bShop and not bMachine then
    self:CompleteAutoShopEntry()
    return true
  end
  local nCoin = self._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  local mapDecision = StarTowerAutoDecision:DecideShopEntry(self:BuildAutoDecisionContext(), {
    bShop = bShop,
    bShopExhausted = self._bAutoShopExhausted == true,
    bUpgradeBeforeSpendAll = self._bAutoUpgradeBeforeShopSpendAll == true,
    bMachine = bMachine,
    nMachineCost = self:GetStrengthMachineCost(),
    nCoin = nCoin
  })
  if mapDecision.bSuccess ~= true then
    if mapDecision.nFailReason == StarTowerAutoDecision.FailReason.NoMatchedTarget or mapDecision.nFailReason == StarTowerAutoDecision.FailReason.CoinNotEnough then
      self._bAutoMachineFinished = true
      self:CompleteAutoShopEntry()
      return true
    end
    if bInitial then
      self._autoShopCompleteCallback = nil
      self:StopAutoDecision(mapDecision.nFailReason, false)
      return false
    end
    if mapDecision.nFailReason == StarTowerAutoDecision.FailReason.TokenNotEnough then
      self._autoShopCompleteCallback = nil
      self:StopAutoDecision(mapDecision.nFailReason, false)
      EventManager.Hit("StarTowerAutoDecisionRequestManual")
    else
      self:CompleteAutoShopEntry()
    end
    return true
  end
  if mapDecision.nActionType == StarTowerAutoDecision.ActionType.OpenShop then
    self._bAutoUpgradeBeforeShopSpendAll = false
    local bShopPanelOpen, bShopPanelActive = PanelManager.CheckPanelOpen(PanelId.StarTowerShop)
    if bShopPanelOpen and bShopPanelActive then
      self:InteractiveShop(mapShopCase.Id, mapShopCase.nNpc, true)
      return true
    end
    EventManager.Hit("StarTowerAutoPreviewShopOption", 1)
    self:ScheduleAutoDecision(mapDecision, {
      nCaseId = mapShopCase.Id,
      bLocalAction = true,
      isValidCallback = function()
        local bOptionOpen, bOptionActive = PanelManager.CheckPanelOpen(PanelId.StarTowerFastBattleOption)
        return bOptionOpen and bOptionActive and self.mapCases[self.EnumCase.Hawker] == mapShopCase and mapShopCase.bFinish ~= true and self._bAutoShopFinished ~= true
      end
    }, function()
      EventManager.Hit("StarTowerAutoExecuteShopOption", 1)
    end)
    return true
  end
  if mapDecision.nActionType == StarTowerAutoDecision.ActionType.StrengthMachine then
    if PanelManager.CheckPanelOpen(PanelId.StarTowerShop) then
      self:CloseAutoShop(function()
        self:TryAutoShopEntry()
      end)
      return true
    end
    EventManager.Hit("StarTowerAutoPreviewShopOption", 2)
    self:ScheduleAutoDecision(mapDecision, {
      nCaseId = mapMachineCase.Id,
      isValidCallback = function()
        local bOptionOpen, bOptionActive = PanelManager.CheckPanelOpen(PanelId.StarTowerFastBattleOption)
        return bOptionOpen and bOptionActive and not PanelManager.CheckPanelOpen(PanelId.StarTowerShop) and self.mapCases[self.EnumCase.StrengthenMachine] == mapMachineCase and mapMachineCase.bFinish ~= true and self._bAutoMachineFinished ~= true
      end,
      invalidCallback = function()
        self:HandleCases()
      end
    }, function()
      EventManager.Hit("StarTowerAutoExecuteShopOption", 2)
    end)
    return true
  end
  if bInitial then
    self._autoShopCompleteCallback = nil
  end
  return false
end

function StarTowerSweepData:OpenShop(bAuto)
  local mapShopCase = self.mapCases[self.EnumCase.Hawker]
  if mapShopCase == nil then
    return false
  end
  local nCaseId = mapShopCase.Id
  self:InteractiveShop(nCaseId, mapShopCase.nNpc, bAuto == true)
  return true
end

function StarTowerSweepData:OpenStrengthMachine(bAuto)
  local mapStrengthMachine = self.mapCases[self.EnumCase.StrengthenMachine]
  if mapStrengthMachine == nil then
    return false
  end
  self:InteractiveStrengthMachine(mapStrengthMachine.Id, 0, bAuto == true)
  return true
end

function StarTowerSweepData:DiscSkillActive(tbParam)
  if self.tbPopup[self.EnumPopup.Disc] == nil then
    self.tbPopup[self.EnumPopup.Disc] = {}
  end
  table.insert(self.tbPopup[self.EnumPopup.Disc], {bFinish = false, param = tbParam})
end

function StarTowerSweepData:OnEvent_RewardPopup(tbParam)
  if self.tbPopup[self.EnumPopup.Reward] == nil then
    self.tbPopup[self.EnumPopup.Reward] = {}
  end
  table.insert(self.tbPopup[self.EnumPopup.Reward], {bFinish = false, param = tbParam})
end

function StarTowerSweepData:OnEvent_PotentialPopup(tbParam)
  if self.tbPopup[self.EnumPopup.Potential] == nil then
    self.tbPopup[self.EnumPopup.Potential] = {}
  end
  table.insert(self.tbPopup[self.EnumPopup.Potential], {bFinish = false, param = tbParam})
end

function StarTowerSweepData:OnEvent_ShopStrengthFx(tbParam)
  if self.tbPopup[self.EnumPopup.StrengthFx] == nil then
    self.tbPopup[self.EnumPopup.StrengthFx] = {}
  end
  table.insert(self.tbPopup[self.EnumPopup.StrengthFx], {bFinish = false, param = tbParam})
end

function StarTowerSweepData:CheckLastShopRoom()
  local bLastRoom = self.nCurLevel == #self.tbStarTowerAllLevel
  return bLastRoom
end

function StarTowerSweepData:GetShopMinPrice()
  local nMinPrice = -1
  local mapCase = self.mapCases[self.EnumCase.Hawker]
  if mapCase ~= nil then
    for index, mapGood in ipairs(mapCase.List) do
      local bSoldOut = table.indexof(mapCase.Purchase, mapGood.Sid) > 0
      local nPrice = 0 < mapGood.Discount and mapGood.Discount or mapGood.Price
      if (nMinPrice > nPrice or nMinPrice == -1) and not bSoldOut then
        nMinPrice = nPrice
      end
    end
    if mapCase.CanReRoll and 0 < mapCase.ReRollTimes then
      nMinPrice = 0 < nMinPrice and math.min(nMinPrice, mapCase.ReRollPrice) or mapCase.ReRollPrice
    end
  end
  return nMinPrice
end

function StarTowerSweepData:GetRecommondPotential(tbPotentialData)
  local tbPotential = {}
  for _, mapData in ipairs(tbPotentialData) do
    table.insert(tbPotential, mapData.Id)
  end
  if self.mapPreselectionData ~= nil then
    local tbRecommend = {}
    for k, v in ipairs(self.mapPreselectionData.tbCharPotential) do
      if k == 1 then
        if self.tbTeam[k] == v.nCharId then
          for _, potential in ipairs(v.tbPotential) do
            if table.indexof(tbPotential, potential.nId) > 0 then
              table.insert(tbRecommend, {
                nId = potential.nId,
                nLevel = potential.nLevel
              })
            end
          end
        end
      elseif 1 < table.indexof(self.tbTeam, v.nCharId) then
        for _, potential in ipairs(v.tbPotential) do
          if table.indexof(tbPotential, potential.nId) > 0 then
            table.insert(tbRecommend, {
              nId = potential.nId,
              nLevel = potential.nLevel
            })
          end
        end
      end
    end
    return tbRecommend
  end
  local ret = {}
  local curRarity = 999
  for _, nPotentialId in ipairs(tbPotential) do
    local itemCfg = ConfigTable.GetData("Item", nPotentialId)
    if itemCfg ~= nil then
      local nRarity = itemCfg.Rarity
      if itemCfg.Stype == GameEnum.itemStype.SpecificPotential then
        nRarity = 0
      end
      if curRarity > nRarity then
        ret = {}
        curRarity = nRarity
        table.insert(ret, {nId = nPotentialId})
      elseif nRarity == curRarity then
        table.insert(ret, {nId = nPotentialId})
      end
    end
  end
  if #ret < 2 then
    return ret
  end
  local ret1 = {}
  local nCurCharId = 0
  local nCurCount = -1
  
  local function GetCharacterPotentialCount(nCharId)
    local ret = 0
    if self._mapPotential[nCharId] ~= nil then
      for _, nCount in pairs(self._mapPotential[nCharId]) do
        ret = ret + nCount
      end
    end
    return ret
  end
  
  for _, v in ipairs(ret) do
    local nPotentialId = v.nId
    local potentialCfg = ConfigTable.GetData("Potential", nPotentialId)
    if potentialCfg ~= nil then
      local nCharId = potentialCfg.CharId
      local nCount = GetCharacterPotentialCount(nCharId)
      if nCurCount < 0 then
        nCurCharId = nCharId
        nCurCount = nCount
        table.insert(ret1, {nId = nPotentialId})
      elseif nCharId ~= nCurCharId and nCount < nCurCount then
        ret1 = {}
        nCurCharId = nCharId
        nCurCount = nCount
        table.insert(ret1, {nId = nPotentialId})
      else
        table.insert(ret1, {nId = nPotentialId})
      end
    end
  end
  if #ret1 < 1 then
    return ret
  end
  if #ret1 < 2 then
    return ret1
  end
  local ret2 = {}
  local nCurBuildCount = -1
  local bHasBuild = false
  
  local function GetPotentialBuildCount(nPotnetialId)
    local ret = 0
    local retBuild = 0
    local potentialCfg = ConfigTable.GetData("Potential", nPotnetialId)
    if potentialCfg ~= nil then
      retBuild = potentialCfg.Build
      local nCharId = potentialCfg.CharId
      for nId, nCount in pairs(self._mapPotential[nCharId]) do
        local mapCfg = ConfigTable.GetData("Potential", nId)
        local potentialItemCfg = ConfigTable.GetData_Item(nId)
        if mapCfg ~= nil and potentialItemCfg ~= nil then
          local param = 1
          if potentialItemCfg.Stype == GameEnum.itemStype.SpecificPotential then
            param = 99
          end
          if mapCfg.Build == potentialCfg.Build then
            ret = ret + param
          end
        end
      end
    end
    return ret, retBuild
  end
  
  for _, v in ipairs(ret1) do
    local nPotentialId = v.nId
    local nCount, nBuild = GetPotentialBuildCount(nPotentialId)
    if nCurBuildCount < 0 and nBuild ~= 0 then
      table.insert(ret2, {nId = nPotentialId})
      nCurBuildCount = nCount
      bHasBuild = nBuild ~= GameEnum.potentialBuild.PotentialBuildCommon
    elseif bHasBuild then
      if nBuild ~= GameEnum.potentialBuild.PotentialBuildCommon then
        if nCount == nCurBuildCount then
          table.insert(ret2, {nId = nPotentialId})
        elseif nCount > nCurBuildCount then
          ret2 = {}
          table.insert(ret2, {nId = nPotentialId})
          nCurBuildCount = nCount
          bHasBuild = nBuild ~= GameEnum.potentialBuild.PotentialBuildCommon
        end
      end
    elseif nBuild == GameEnum.potentialBuild.PotentialBuildCommon then
      if nCount == nCurBuildCount then
        table.insert(ret2, {nId = nPotentialId})
      elseif nCount > nCurBuildCount then
        ret2 = {}
        table.insert(ret2, {nId = nPotentialId})
        nCurBuildCount = nCount
      end
    else
      ret2 = {}
      table.insert(ret2, {nId = nPotentialId})
      nCurBuildCount = nCount
      bHasBuild = true
    end
  end
  if #ret2 < 1 then
    return ret1
  end
  if #ret2 < 2 then
    return ret2
  end
  local ret3 = {}
  local curLessPotential = -1
  for _, v in ipairs(ret2) do
    local nPotentialId = v.nId
    local potentialCfg = ConfigTable.GetData("Potential", nPotentialId)
    if potentialCfg ~= nil then
      local nCharId = potentialCfg.CharId
      local nCurCount = 0
      if self._mapPotential[nCharId] ~= nil and self._mapPotential[nCharId][nPotentialId] ~= nil then
        nCurCount = self._mapPotential[nCharId][nPotentialId]
      end
      if curLessPotential < 0 then
        table.insert(ret3, {nId = nPotentialId})
        curLessPotential = nCurCount
      elseif nCurCount == curLessPotential then
        table.insert(ret3, {nId = nPotentialId})
      elseif nCurCount < curLessPotential then
        ret3 = {}
        table.insert(ret3, {nId = nPotentialId})
        curLessPotential = nCurCount
      end
    end
  end
  if #ret3 < 1 then
    return ret2
  end
  return ret3
end

function StarTowerSweepData:GetShopGoods()
  local nType = self.nRoomType
  local mapStarTower = ConfigTable.GetData("StarTower", self.nTowerId)
  if not mapStarTower then
    return
  end
  local nNpcId = mapStarTower.ShopNpc
  if nType ~= GameEnum.starTowerRoomType.ShopRoom then
    nNpcId = mapStarTower.StandShopNpc
  end
  if self.mapCases[self.EnumCase.Hawker] and self.mapNpc[nNpcId] then
    return self.mapCases[self.EnumCase.Hawker].List
  end
end

return StarTowerSweepData
