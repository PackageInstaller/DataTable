local JointDrillLevelData_2 = class("JointDrillLevelData_2")
local AdventureModuleHelper = CS.AdventureModuleHelper
local LocalData = require("GameCore.Data.LocalData")
local ModuleManager = require("GameCore.Module.ModuleManager")
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  BattlePause = "OnEvent_Pause",
  JointDrill_StartTiming = "OnEvent_BattleStart",
  JointDrill_MonsterSpawn_Type2 = "OnEvent_MonsterSpawn",
  JointDrill_BossDeath_Type2 = "OnEvent_BossDeath",
  JointDrill_BattleLvsToggle_Type2 = "OnEvent_BattleLvsToggle",
  ADVENTURE_LEVEL_UNLOAD_COMPLETE = "OnEvent_UnloadComplete",
  JointDrill_Gameplay_Time = "OnEvent_JointDrill_Gameplay_Time",
  JointDrill_DamageValue = "OnEvent_DamageValue",
  JointDrill_CharDamageValue = "OnEvent_CharDamageValue",
  GiveUpJointDrill = "OnEvent_GiveUpBattle",
  RestartJointDrill = "OnEvent_RestartJointDrill",
  RetreatJointDrill = "OnEvent_RetreatJointDrill",
  JointDrill_Result = "OnEvent_JointDrill_Result",
  InputEnable = "OnEvent_InputEnable",
  JointDrill_StopTime = "OnEvent_JointDrill_StopTime",
  JointDrillChallengeFinishError = "OnEvent_JointDrillChallengeFinishError",
  Upload_Dodge_Event = "OnEvent_UploadDodgeEvent",
  JointDrill_CacheTempData_Suc = "OnEvent_CacheTempData"
}

function JointDrillLevelData_2:Init(parent, nLevelId, nBuildId, nCurLevel, nLevelType)
  self.parent = parent
  self.nLevelId = nLevelId
  self.nCurLevel = nCurLevel
  self.nBuildId = nBuildId
  self.nLevelType = nLevelType
  self.recordCallback = nil
  self.mapLevel = nil
  self.tbFloor = {}
  self.mapFloor = nil
  self.nGameTime = self.parent:GetGameTime()
  self.bInResult = false
  self.bAllBossDead = false
  self.bChangeLevel = self.nLevelType == AllEnum.JointDrillLevelStartType.ChangeLevel
  self.bRestart = self.nLevelType == AllEnum.JointDrillLevelStartType.Restart
  if not self.bChangeLevel then
    self.nDamageValue = 0
    self.tbCharDamage = {}
    self.mapInitBossInfo = clone(self.parent:GetBossInfo())
    self.nInitLevel = self.nCurLevel
    if self.parent.record ~= nil and self.parent.record ~= "" then
      self.initRecord = self.parent.record
    end
  end
  local mapJointDrillLevelCfg = ConfigTable.GetData("JointDrill_2_Level", nLevelId)
  if mapJointDrillLevelCfg == nil then
    return
  end
  self.mapLevel = mapJointDrillLevelCfg
  local nFloorGroup = mapJointDrillLevelCfg.FloorId
  self.tbFloor = CacheTable.GetData("_JointDrill_2_Floor", nFloorGroup)
  self.mapFloor = self.tbFloor[nCurLevel]
  
  local function GetBuildCallback(mapBuildData)
    self.mapBuildData = mapBuildData
    self.parent:AddJointDrillTeam(self.mapBuildData, self.nGameTime, self.nDamageValue)
    self.tbCharId = {}
    for _, mapChar in ipairs(self.mapBuildData.tbChar) do
      table.insert(self.tbCharId, mapChar.nTid)
    end
    self.tbDiscId = {}
    for _, nDiscId in pairs(self.mapBuildData.tbDisc) do
      if 0 < nDiscId then
        table.insert(self.tbDiscId, nDiscId)
      end
    end
    if #self.tbCharDamage == 0 then
      for _, v in ipairs(self.tbCharId) do
        table.insert(self.tbCharDamage, {nCharId = v, nDamage = 0})
      end
    end
    PlayerData.nCurGameType = AllEnum.WorldMapNodeType.JointDrill
    local sRecord = self.parent.record or ""
    local mapParams = {
      tostring(self.nCurLevel),
      tostring(self.bChangeLevel),
      tostring(self.nGameTime),
      sRecord
    }
    if not self.bChangeLevel and not self.bRestart then
      AdventureModuleHelper.EnterDynamic(self.nLevelId, self.tbCharId, GameEnum.dynamicLevelType.JointDrill_2, mapParams)
      NovaAPI.EnterModule("AdventureModuleScene", true, 17)
    else
      self:StartJointDrill()
      AdventureModuleHelper.EnterDynamic(self.nLevelId, self.tbCharId, GameEnum.dynamicLevelType.JointDrill_2, mapParams)
    end
    local sKey = LocalData.GetPlayerLocalData("JointDrillRecordKey") or ""
    safe_call_cs_func(CS.AdventureModuleHelper.SetDamageRecordId, sKey)
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
end

function JointDrillLevelData_2:BindEvent()
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

function JointDrillLevelData_2:UnBindEvent()
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

function JointDrillLevelData_2:CalCharFixedEffect(nCharId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Char:CalCharacterAttrBattle(nCharId, stActorInfo, bMainChar, tbDiscId, self.mapBuildData.nBuildId)
  return stActorInfo
end

function JointDrillLevelData_2:SetPersonalPerk()
  if self.mapBuildData ~= nil then
    for nCharId, tbPerk in pairs(self.mapBuildData.tbPotentials) do
      local mapAddLevel = PlayerData.Char:GetCharEnhancedPotential(nCharId)
      local tbPerkInfo = {}
      for _, mapPerkInfo in ipairs(tbPerk) do
        local nAddLv = mapAddLevel[mapPerkInfo.nPotentialId] or 0
        local stPerkInfo = CS.Lua2CSharpInfo_TPPerkInfo()
        stPerkInfo.perkId = mapPerkInfo.nPotentialId
        stPerkInfo.nCount = mapPerkInfo.nLevel + nAddLv
        table.insert(tbPerkInfo, stPerkInfo)
      end
      safe_call_cs_func(AdventureModuleHelper.ChangePersonalPerkIds, tbPerkInfo, nCharId)
    end
  end
end

function JointDrillLevelData_2:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Disc:CalcDiscInfoInBuild(nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function JointDrillLevelData_2:GetSyncGameTime(nTime)
  return math.floor(tonumber(string.format("%.3f", nTime)) * 1000)
end

function JointDrillLevelData_2:JointDrillSuccess(netMsg)
  local tbSkin = {}
  for _, nCharId in ipairs(self.tbCharId) do
    local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
    table.insert(tbSkin, nSkinId)
  end
  local nScoreOld = 0
  local mapSelfRank = self.parent:GetSelfRankData()
  if mapSelfRank ~= nil then
    nScoreOld = mapSelfRank.Score
  end
  
  local function func_SettlementFinish()
  end
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    local nType = self.mapFloor.Theme
    local sName = ConfigTable.GetData("EndSceneType", nType).EndSceneName
    print("sceneName:" .. sName)
    AdventureModuleHelper.PlaySettlementPerform(sName, "", tbSkin, func_SettlementFinish)
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
  
  local function openBattleResultPanel()
    EventManager.Remove("SettlementPerformLoadFinish", self, openBattleResultPanel)
    local nResultType = AllEnum.JointDrillResultType.Success
    local nScore = netMsg.FightScore + netMsg.HpScore + netMsg.DifficultyScore
    local mapScore = {
      FightScore = netMsg.FightScore,
      HpScore = netMsg.HpScore,
      DifficultyScore = netMsg.DifficultyScore,
      nTotalScore = self.parent.nTotalScore,
      nScore = nScore,
      nScoreOld = nScoreOld
    }
    local bSimulate = self.parent:GetBattleSimulate()
    local nBattleCount = self.parent:GetJointDrillBattleCount()
    local tbLastCharIds = self.parent:GetJointDrillLastTeam()
    EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.parent.nActId, "Result"), nResultType, self.nCurLevel, 0, self.nLevelId, {}, mapScore, netMsg.Items or {}, netMsg.Change or {}, netMsg.Old, netMsg.New, bSimulate, nBattleCount, self.tbCharDamage, tbLastCharIds)
    self.parent:ChallengeEnd()
  end
  
  EventManager.Add("SettlementPerformLoadFinish", self, openBattleResultPanel)
  AdventureModuleHelper.LevelStateChanged(true)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleResultMask)
end

function JointDrillLevelData_2:CheckJointDrillGameOver()
  local nChallengeCount = self.parent:GetJointDrillBattleCount()
  local nAllChallengeCount = self.parent:GetMaxChallengeCount(self.nLevelId)
  
  function self.recordCallback(sRecord)
    if nChallengeCount >= nAllChallengeCount then
      local function syncCallback()
        local function callback(netMsg)
          self:JointDrillFail(AllEnum.JointDrillResultType.ChallengeEnd, netMsg, self.nCurLevel)
        end
        
        self.parent:JointDrillGameOver(callback)
      end
      
      self.parent:JointDrillSync(self.nCurLevel, self.nGameTime, self.nDamageValue, "", syncCallback)
    else
      local function syncCallback()
        local function callback(netMsg)
          self:JointDrillFail(AllEnum.JointDrillResultType.BattleEnd, netMsg, self.nCurLevel)
        end
        
        self.parent:JointDrillGiveUp(self.nCurLevel, self.nGameTime, self.nDamageValue, sRecord, callback)
      end
      
      self.parent:JointDrillSync(self.nCurLevel, self.nGameTime, self.nDamageValue, "", syncCallback)
    end
  end
  
  NovaAPI.DispatchEventWithData("JointDrill_CacheTempData_Start", nil, {
    false,
    true,
    true,
    false,
    0,
    0
  })
end

function JointDrillLevelData_2:JointDrillFail(nResultType, netMsg, nLevel)
  local bossInfo = {}
  local mapAllBossInfo = self.parent:GetBossInfo()
  local mapCurBossInfo = mapAllBossInfo[nLevel]
  if mapCurBossInfo ~= nil then
    for nIndex, v in ipairs(mapCurBossInfo) do
      if v.nBossCfgId ~= 0 then
        table.insert(bossInfo, {
          nBossId = v.nBossCfgId,
          nHp = v.nHp,
          nHpMax = v.nHpMax
        })
      end
    end
  end
  local bSimulate = self.parent:GetBattleSimulate()
  local mapScore = {}
  local mapReward = {}
  local mapChange = {}
  local nOld, nNew = 0, 0
  local nScoreOld = 0
  local mapSelfRank = self.parent:GetSelfRankData()
  if mapSelfRank ~= nil then
    nScoreOld = mapSelfRank.Score
  end
  if netMsg ~= nil then
    local nScore = netMsg.FightScore + netMsg.HpScore + netMsg.DifficultyScore
    mapScore = {
      FightScore = netMsg.FightScore,
      HpScore = netMsg.HpScore,
      DifficultyScore = netMsg.DifficultyScore,
      nTotalScore = self.parent.nTotalScore,
      nScore = nScore,
      nScoreOld = nScoreOld
    }
    nOld = netMsg.Old
    nNew = netMsg.New
    mapReward = netMsg.Items or {}
    mapChange = netMsg.Change or {}
  end
  local nBattleCount = self.parent:GetJointDrillBattleCount()
  local tbLastCharIds = self.parent:GetJointDrillLastTeam()
  EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.parent.nActId, "Result"), nResultType, self.nCurLevel, self.nGameTime, self.nLevelId, bossInfo, mapScore, mapReward, mapChange, nOld, nNew, bSimulate, nBattleCount, self.tbCharDamage, tbLastCharIds)
  self.parent:LevelEnd(nResultType)
end

function JointDrillLevelData_2:JointDrillTimeOut()
  if self.bInResult then
    return
  end
  self.bInResult = true
  NovaAPI.DispatchEventWithData("JointDrill_Level_TimeOut")
  NovaAPI.DispatchEventWithData("JointDrill_CacheTempData_Start", nil, {
    false,
    true,
    true,
    true,
    0,
    0
  })
  
  local function syncCallback()
    local function callback(netMsg)
      self:JointDrillFail(AllEnum.JointDrillResultType.ChallengeEnd, netMsg, self.nCurLevel)
    end
    
    self.parent:AddJointDrillTeam(self.mapBuildData, self.nGameTime, self.nDamageValue)
    self.parent:JointDrillGameOver(callback)
  end
  
  self.parent:JointDrillSync(self.nCurLevel, self.nGameTime, self.nDamageValue, "", syncCallback)
end

function JointDrillLevelData_2:SyncGameTime(nTime)
  nTime = nTime or 0
  self.nGameTime = math.min(self:GetSyncGameTime(nTime), self.mapLevel.BattleTime * 1000)
  self.parent:SetGameTime(self.nGameTime)
  EventManager.Hit("RefreshJointDrillGameTime", self.nGameTime)
end

function JointDrillLevelData_2:StartJointDrill()
  EventManager.Hit(EventId.OpenPanel, PanelId.JointDrillBattlePanel, self.tbCharId, self.mapLevel.Id, self.mapLevel.BattleTime, GameEnum.JointDrillMode.JointDrill_Mode_2)
  self:SetPersonalPerk()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(nCharId, idx == 1, self.tbDiscId)
    safe_call_cs_func(AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function JointDrillLevelData_2:OnEvent_LoadLevelRefresh()
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetBuildAllEft(self.mapBuildData.nBuildId)
  safe_call_cs_func(AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
  self.parent:AddRecordFloorList()
  PlayerData.Build:SetBuildReportInfo(self.mapBuildData.nBuildId)
  NovaAPI.DispatchEventWithData("JointDrill_ResetCharacter")
end

function JointDrillLevelData_2:OnEvent_AdventureModuleEnter()
  self:StartJointDrill()
end

function JointDrillLevelData_2:OnEvent_BattleStart(nTime)
  self:SyncGameTime(nTime)
end

function JointDrillLevelData_2:OnEvent_MonsterSpawn(nBossId, nCfgId, nIndex, nHp, nHpMax)
  if self.nLevelType ~= AllEnum.JointDrillLevelStartType.Start then
    return
  end
  
  function self.recordCallback(sRecord)
    self.parent:JointDrillSync(self.nCurLevel, self.nGameTime, self.nDamageValue, sRecord)
    self.initRecord = sRecord
  end
  
  NovaAPI.DispatchEventWithData("JointDrill_CacheTempData_Start", nil, {
    false,
    true,
    true,
    false,
    0,
    0
  })
end

function JointDrillLevelData_2:OnEvent_BossDeath(nBattleLv, nTotalTime, nDamageValue, nParam)
  if nBattleLv < self.nCurLevel then
    return
  end
  if nBattleLv == nParam then
    self.bAllBossDead = true
    return
  end
  local nLastLevel = self.nCurLevel
  nTotalTime = math.min(self.mapLevel.BattleTime * 1000, self:GetSyncGameTime(nTotalTime))
  self.nCurLevel = nParam
  self.nDamageValue = self.nDamageValue + nDamageValue
  self.mapFloor = self.tbFloor[self.nCurLevel]
  self.parent:AddJointDrillTeam(self.mapBuildData, nTotalTime, self.nDamageValue)
  PanelManager.InputDisable()
  self.parent:StopRecord()
  
  function self.recordCallback(sRecord)
    local function syncCallback()
      PanelManager.InputEnable()
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        EventManager.Hit(EventId.BattleDashboardVisible, false)
      end
      
      cs_coroutine.start(wait)
    end
    
    self.parent:JointDrillSync(self.nCurLevel, nTotalTime, self.nDamageValue, sRecord, syncCallback)
  end
  
  NovaAPI.DispatchEventWithData("JointDrill_CacheTempData_Start", nil, {
    true,
    true,
    false,
    true,
    nLastLevel,
    nParam
  })
end

function JointDrillLevelData_2:OnEvent_BattleLvsToggle()
  if self.bInResult or self.bAllBossDead or self.bChangeLevel then
    return
  end
  self.bChangeLevel = true
  self.bRestart = false
  AdventureModuleHelper.LevelStateChanged(false)
  EventManager.Hit("ResetBossHUD")
end

function JointDrillLevelData_2:OnEvent_UnloadComplete()
  if self.bInErrorResult then
    NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
    self.bInErrorResult = false
    return
  end
  if self.bInResult == true then
    return
  end
  if self.bRestart then
    self.parent:RestartBattle()
  else
    self.parent:ChangeLevel(self.nCurLevel)
  end
end

function JointDrillLevelData_2:OnEvent_JointDrill_Gameplay_Time(nTime)
  self:SyncGameTime(nTime)
end

function JointDrillLevelData_2:OnEvent_Pause()
  EventManager.Hit("OpenJointDrillPause", self.nLevelId, self.tbCharId, self.nGameTime)
end

function JointDrillLevelData_2:OnEvent_DamageValue(nDamageValue)
  self.nDamageValue = self.nDamageValue + nDamageValue
end

function JointDrillLevelData_2:OnEvent_GiveUpBattle()
  self.parent:AddJointDrillTeam(self.mapBuildData, self.nGameTime, self.nDamageValue)
  self:CheckJointDrillGameOver()
end

function JointDrillLevelData_2:OnEvent_RestartJointDrill()
  self.bRestart = true
  self.bChangeLevel = false
  self.parent:SetGameTime(0)
  self.parent:ResetRecord(self.initRecord)
  self.parent:ResetBossInfo(self.mapInitBossInfo)
  self.parent:SetRecorderExcludeIds(true)
  AdventureModuleHelper.LevelStateChanged(false)
  EventManager.Hit("ResetBossHUD")
end

function JointDrillLevelData_2:OnEvent_RetreatJointDrill()
  local function callback()
    self.parent:ResetRecord(self.initRecord)
    
    self.parent:ResetBossInfo(self.mapInitBossInfo)
    self:JointDrillFail(AllEnum.JointDrillResultType.Retreat, nil, self.nInitLevel)
  end
  
  self.parent:JointDrillRetreat(self.mapBuildData, callback)
end

function JointDrillLevelData_2:OnEvent_JointDrill_Result(nLevelState, nTotalTime, nDamageValue)
  if self.bInResult then
    return
  end
  nTotalTime = math.min(self.mapLevel.BattleTime * 1000, self:GetSyncGameTime(nTotalTime))
  self.bInResult = true
  self.nDamageValue = self.nDamageValue + nDamageValue
  if nLevelState == GameEnum.levelState.Failed then
    self.parent:AddJointDrillTeam(self.mapBuildData, self.nGameTime, self.nDamageValue)
    self:CheckJointDrillGameOver()
  elseif nLevelState == GameEnum.levelState.Success then
    local function callback(netMsg)
      self:JointDrillSuccess(netMsg)
    end
    
    self.parent:JointDrillSettle(self.mapBuildData, self.nGameTime, self.nDamageValue, callback)
  end
end

function JointDrillLevelData_2:OnEvent_CharDamageValue(charDamageValue)
  for nCharId, nValue in pairs(charDamageValue) do
    for _, v in ipairs(self.tbCharDamage) do
      if v.nCharId == nCharId then
        v.nDamage = v.nDamage + nValue
        break
      end
    end
  end
end

function JointDrillLevelData_2:OnEvent_InputEnable(bEnable)
end

function JointDrillLevelData_2:OnEvent_JointDrill_StopTime()
end

function JointDrillLevelData_2:OnEvent_JointDrillChallengeFinishError()
  local function callback()
    if self.parent:CheckJointDrillInBattle() then
      self.parent:JointDrillGameOver(nil, true)
    else
      local bInAdventure = ModuleManager.GetIsAdventure()
      if bInAdventure then
        self.bInErrorResult = true
        AdventureModuleHelper.LevelStateChanged(true, 0, true)
      end
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self.parent:SetResetLevelSelect(true)
        EventManager.Hit(EventId.ClosePanel, JointDrillContext.GetPanelId(self.parent.nActId, "BuildList"))
      end
      
      cs_coroutine.start(wait)
      self.parent:ChallengeEnd()
    end
  end
  
  PlayerData.Activity:SendActivityDetailMsg(callback, true)
end

function JointDrillLevelData_2:OnEvent_UploadDodgeEvent(padMode)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tab, {"pad_mode", padMode})
  table.insert(tab, {"level_type", "JointDrill"})
  table.insert(tab, {
    "build_id",
    tostring(self.nBuildId)
  })
  table.insert(tab, {
    "level_id",
    tostring(self.nLevelId)
  })
  table.insert(tab, {
    "up_time",
    tostring(CS.ClientManager.Instance.serverTimeStamp)
  })
  NovaAPI.UserEventUpload("use_dodge_key", tab)
end

function JointDrillLevelData_2:OnEvent_CacheTempData(sJson, nLength, mapBossInfo)
  self.parent:ResetRecord(sJson)
  self.parent:UpdateBossInfo(mapBossInfo)
  if self.recordCallback ~= nil then
    self.recordCallback(sJson)
    self.recordCallback = nil
  end
end

return JointDrillLevelData_2
