local TrialLevel = class("TrialLevel")
local TimerManager = require("GameCore.Timer.TimerManager")
local mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  [EventId.AbandonBattle] = "OnEvent_AbandonBattle",
  TrialGameEnd = "OnEvent_LevelResult",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  BattlePause = "OnEvent_Pause",
  TrialDepot = "OnEvent_Depot",
  TaskLevel_InitTask = "OnEvent_InitQuest",
  Trial_QuestComplete = "OnEvent_QuestComplete",
  Trial_Time = "OnEvent_Time"
}

function TrialLevel:Init(parent, nLevelId)
  self.parent = parent
  self.nLevelId = nLevelId
  self.mapChangeInfo = {}
  self.bTrialBattleStartUploaded = false
  self.mapLevelCfg = ConfigTable.GetData("TrialFloor", nLevelId)
  if not self.mapLevelCfg then
    return
  end
  self.mapBuildData = PlayerData.Build:GetTrialBuild(self.mapLevelCfg.TrialBuild)
  self.tbCharId, self.tbCharTrialId, self.mapCharData, self.mapTalentAddLevel = {}, {}, {}, {}
  for _, mapChar in ipairs(self.mapBuildData.tbChar) do
    table.insert(self.tbCharId, mapChar.nTid)
    self.tbCharTrialId[mapChar.nTid] = mapChar.nTrialId
    self.mapCharData[mapChar.nTid] = PlayerData.Char:GetTrialCharById(mapChar.nTrialId)
    self.mapTalentAddLevel[mapChar.nTid] = PlayerData.Talent:GetTrialEnhancedPotential(mapChar.nTrialId)
  end
  self.tbDiscId, self.mapDiscData = {}, {}
  for _, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if 0 < nDiscId then
      table.insert(self.tbDiscId, nDiscId)
      local mapCfg = ConfigTable.GetData("TrialDisc", nDiscId)
      if mapCfg then
        self.mapDiscData[mapCfg.DiscId] = PlayerData.Disc:GetTrialDiscById(nDiscId)
      end
    end
  end
  self:ParseDepotData()
  self.mapActorInfo = {}
  for idx, nTid in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(self.tbCharTrialId[nTid], idx == 1, self.tbDiscId)
    self.mapActorInfo[nTid] = stActorInfo
  end
  PlayerData.nCurGameType = AllEnum.WorldMapNodeType.Trial
  local params = NovaAPI.GetDynamicLevelParamsBootConfig()
  CS.AdventureModuleHelper.EnterDynamic(nLevelId, self.tbCharId, GameEnum.dynamicLevelType.Trial, params)
  NovaAPI.EnterModule("AdventureModuleScene", true, 17)
end

function TrialLevel:ParseDepotData()
  self.tbDepotPotential = {}
  for nCharId, tbPerk in pairs(self.mapBuildData.tbPotentials) do
    if self.tbCharTrialId[nCharId] then
      if not self.tbDepotPotential[nCharId] then
        self.tbDepotPotential[nCharId] = {}
      end
      for _, v in ipairs(tbPerk) do
        self.tbDepotPotential[nCharId][v.nPotentialId] = v.nLevel
      end
    else
      printError("体验build内，有多余角色的潜能" .. nCharId)
    end
  end
end

function TrialLevel:OnEvent_LoadLevelRefresh()
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetTrialBuildAllEft()
  safe_call_cs_func(CS.AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
  EventManager.Hit("OpenTrialInfo", self.nQuestId)
  if not self.bTrialBattleStartUploaded then
    self.bTrialBattleStartUploaded = true
    PlayerData.Trial:UserEventUpload_TrialBattle(1)
  end
end

function TrialLevel:RefreshCharDamageData()
  self.tbCharDamage = UTILS.GetCharDamageResult(self.tbCharId)
  for i, v in ipairs(self.tbCharDamage) do
    self.tbCharDamage[i].nSkinId = PlayerData.Char:GetCharSkinId(v.nCharId)
  end
end

function TrialLevel:OnEvent_LevelResult(nLevelTime)
  self:RefreshCharDamageData()
  local bReceived = PlayerData.Trial:CheckGroupReceived()
  local bAbandon = not bReceived
  local bHasReward = PlayerData.Trial:IsActivityTrialMode()
  EventManager.Hit("TrialBattleEnd")
  if self.parent:GetSettlementState() then
    printError("试玩关结算流程重复进入，本次退出")
    return
  end
  self.parent:SetSettlementState(true)
  if bAbandon then
    EventManager.Hit("TrialLevelEnd", self.nLevelId)
    EventManager.Hit(EventId.ClosePanel, PanelId.BtnTips)
    EventManager.Hit(EventId.OpenPanel, PanelId.TrialResult, false, nLevelTime or 0, self.tbCharId, self.parent.nActId or 0, {}, self.tbCharDamage, bHasReward)
    self.parent:LevelEnd()
    return
  end
  EventManager.Hit("TrialLevelEnd", self.nLevelId)
  self:PlaySuccessPerform(nLevelTime)
end

function TrialLevel:OnEvent_AbandonBattle()
  self:OnEvent_LevelResult(self.nLevelTime)
end

function TrialLevel:OnEvent_AdventureModuleEnter()
  self:SetPersonalPerk()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(self.tbCharTrialId[nCharId], idx == 1, self.tbDiscId)
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
  local tbDisc = {}
  for _, v in ipairs(self.tbDiscId) do
    local mapCfg = ConfigTable.GetData("TrialDisc", v)
    if mapCfg then
      table.insert(tbDisc, mapCfg.DiscId)
    end
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.TrialBattlePanel, self.tbCharId, tbDisc, self.mapCharData, self.mapDiscData, self.mapTalentAddLevel)
end

function TrialLevel:BindEvent()
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

function TrialLevel:UnBindEvent()
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

function TrialLevel:PlaySuccessPerform(nLevelTime)
  local function func_SettlementFinish(bSuccess)
  end
  
  local tbChar = self.tbCharId
  local bHasReward = PlayerData.Trial:IsActivityTrialMode()
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    local nType = self.mapLevelCfg.Theme
    local sName = ConfigTable.GetData("EndSceneType", nType).EndSceneName
    local tbSkin = {}
    for _, nCharId in ipairs(tbChar) do
      local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
      table.insert(tbSkin, nSkinId)
    end
    CS.AdventureModuleHelper.PlaySettlementPerform(sName, "", tbSkin, func_SettlementFinish)
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
  
  local function openBattleResultPanel()
    EventManager.Remove("SettlementPerformLoadFinish", self, openBattleResultPanel)
    EventManager.Hit(EventId.OpenPanel, PanelId.TrialResult, true, nLevelTime or 0, self.tbCharId, self.parent.nActId or 0, self.mapChangeInfo, self.tbCharDamage, bHasReward)
    self.bSettle = false
    self.parent:LevelEnd()
    self:UnBindEvent()
  end
  
  EventManager.Add("SettlementPerformLoadFinish", self, openBattleResultPanel)
  CS.AdventureModuleHelper.LevelStateChanged(true)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleResultMask)
end

function TrialLevel:SetCharFixedAttribute()
  for nCharId, stActorInfo in pairs(self.mapActorInfo) do
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function TrialLevel:CalCharFixedEffect(nTrialId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Char:CalCharacterTrialAttrBattle(nTrialId, stActorInfo, bMainChar, tbDiscId, self.mapLevelCfg.TrialBuild)
  return stActorInfo
end

function TrialLevel:SetPersonalPerk()
  if self.mapBuildData ~= nil then
    for nCharId, tbPerk in pairs(self.mapBuildData.tbPotentials) do
      local mapTalentAddLevel = {}
      if self.tbCharTrialId[nCharId] then
        mapTalentAddLevel = PlayerData.Talent:GetTrialEnhancedPotential(self.tbCharTrialId[nCharId])
      else
        printError("体验build内，有多余角色的潜能" .. nCharId)
      end
      local tbPerkInfo = {}
      for _, mapPerkInfo in ipairs(tbPerk) do
        local nAddLv = mapTalentAddLevel[mapPerkInfo.nPotentialId] or 0
        local stPerkInfo = CS.Lua2CSharpInfo_TPPerkInfo()
        stPerkInfo.perkId = mapPerkInfo.nPotentialId
        stPerkInfo.nCount = mapPerkInfo.nLevel + nAddLv
        table.insert(tbPerkInfo, stPerkInfo)
      end
      safe_call_cs_func(CS.AdventureModuleHelper.ChangePersonalPerkIds, tbPerkInfo, nCharId)
    end
  end
end

function TrialLevel:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Disc:CalcTrialInfoInBuild(nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function TrialLevel:OnEvent_InitQuest(nQuestId)
  self.nQuestId = nQuestId
end

function TrialLevel:OnEvent_QuestComplete()
  if not PlayerData.Trial:IsActivityTrialMode() then
    self:ShowTeleportIndicator()
    return
  end
  local bOpen = false
  local actData = PlayerData.Activity:GetActivityDataById(self.parent.nActId)
  if actData then
    bOpen = actData:CheckActivityOpen()
  end
  if not bOpen then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_3")
    })
  end
  local bReceived = PlayerData.Trial:CheckGroupReceived()
  if not bReceived and bOpen then
    PanelManager.InputDisable()
    
    local function callback(mapChangeInfo)
      PanelManager.InputEnable()
      self.mapChangeInfo = mapChangeInfo or {}
    end
    
    self.parent:SendReceiveTrialRewardReq(callback)
  end
  self:ShowTeleportIndicator()
end

function TrialLevel:ShowTeleportIndicator()
  local tbTeleports = CS.AdventureModuleHelper.GetLevelTeleporters()
  if tbTeleports ~= nil then
    for i = 0, tbTeleports.Count - 1 do
      EventManager.Hit("SetIndicator", 2, tbTeleports[i], Vector3.zero, nil)
    end
  end
end

function TrialLevel:OnEvent_Time(nTime)
  self.nLevelTime = nTime
end

function TrialLevel:OnEvent_Pause()
  EventManager.Hit("OpenTrialPause", self.tbCharId, self.mapCharData, self.mapLevelCfg.TrialChar)
end

function TrialLevel:OnEvent_Depot()
  local tbDisc = {}
  for _, v in ipairs(self.tbDiscId) do
    local mapCfg = ConfigTable.GetData("TrialDisc", v)
    if mapCfg then
      table.insert(tbDisc, mapCfg.DiscId)
    end
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.TrialDepot, self.tbCharId, tbDisc, self.mapCharData, self.mapDiscData, self.mapTalentAddLevel, self.tbDepotPotential, self.mapBuildData.tbNotes, true)
end

return TrialLevel
