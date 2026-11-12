local DailyInstanceLevel = class("DailyInstanceLevel")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local AdventureModuleHelper = CS.AdventureModuleHelper
local TimerManager = require("GameCore.Timer.TimerManager")
local mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  [EventId.AbandonBattle] = "OnEvent_AbandonBattle",
  DailyInstanceGameEnd = "OnEvent_LevelResult",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  BattlePause = "OnEvnet_Pause"
}

function DailyInstanceLevel:Init(parent, nLevelId, nBuildId)
  self.parent = parent
  self.nLevelId = nLevelId
  
  local function GetBuildCallback(mapBuildData)
    self.mapBuildData = mapBuildData
    self.tbCharId = {}
    self.tbCharTrialId = {}
    for _, mapChar in ipairs(self.mapBuildData.tbChar) do
      table.insert(self.tbCharId, mapChar.nTid)
      self.tbCharTrialId[mapChar.nTid] = mapChar.nTrialId
    end
    self.tbDiscId = {}
    for _, nDiscId in ipairs(self.mapBuildData.tbDisc) do
      if 0 < nDiscId then
        table.insert(self.tbDiscId, nDiscId)
      end
    end
    self.mapActorInfo = {}
    for idx, nTid in ipairs(self.tbCharId) do
      local stActorInfo = self:CalCharFixedEffect(nTid, idx == 1, self.tbDiscId)
      self.mapActorInfo[nTid] = stActorInfo
    end
    PlayerData.nCurGameType = AllEnum.WorldMapNodeType.DailyInstance
    CS.AdventureModuleHelper.EnterDailyInstanceMap(nLevelId, self.tbCharId)
    NovaAPI.EnterModule("AdventureModuleScene", true, 17)
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
end

function DailyInstanceLevel:RefreshCharDamageData()
  self.tbCharDamage = UTILS.GetCharDamageResult(self.tbCharId)
end

function DailyInstanceLevel:OnEvent_LoadLevelRefresh()
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetBuildAllEft(self.mapBuildData.nBuildId)
  safe_call_cs_func(CS.AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
  EventManager.Hit("OpenDailyInstanceRoomInfo", ConfigTable.GetData("DailyInstance", self.nLevelId).FloorId, self.nLevelId)
end

function DailyInstanceLevel:OnEvent_LevelResult(tbStar, bAbandon)
  EventManager.Hit("DailyInstanceBattleEnd")
  if self.parent:GetSettlementState() then
    printError("日常副本结算流程重复进入，本次退出")
    return
  end
  self:RefreshCharDamageData()
  self.parent:SetSettlementState(true)
  local mapDILevelCfgData = ConfigTable.GetData("DailyInstance", self.nLevelId)
  local nStar = 0
  local nStarCount = 0
  nStar = tbStar[0] and nStar | 1 or nStar
  nStar = tbStar[1] and nStar | 2 or nStar
  nStar = tbStar[2] and nStar | 4 or nStar
  for i = 0, 2 do
    if tbStar[i] then
      nStarCount = nStarCount + 1
    end
  end
  
  local function callback(tbSelectReward, tbFirstReward, tbDoubleItems, nExp, mapChangeInfo)
    local function waitCallback()
      NovaAPI.InputEnable()
      
      if 0 < nStar then
        self:PlaySuccessPerform(tbFirstReward, tbSelectReward, tbDoubleItems, nExp, tbStar, mapChangeInfo)
      else
        EventManager.Hit(EventId.ClosePanel, PanelId.BtnTips)
        local sLarge, sSmall = "", ""
        EventManager.Hit(EventId.OpenPanel, PanelId.DailyInstanceResultPanel, false, tbStar, {}, {}, {}, 0, false, sLarge, sSmall, self.nLevelId, self.tbCharId, mapChangeInfo or {}, self.tbCharDamage, {})
        self.parent:LevelEnd()
      end
    end
    
    EventManager.Hit("DailyInstanceLevelEnd", mapDILevelCfgData.FloorId)
    if bAbandon then
      waitCallback()
    else
      TimerManager.Add(1, 2, self, waitCallback, true, true, true, nil)
    end
  end
  
  NovaAPI.InputDisable()
  self.parent:MsgSettleDailyInstance(self.nLevelId, self.mapBuildData.nBuildId, nStar, callback)
end

function DailyInstanceLevel:OnEvent_AbandonBattle()
  self:OnEvent_LevelResult({
    false,
    false,
    false
  }, true)
end

function DailyInstanceLevel:OnEvent_AdventureModuleEnter()
  PlayerData.Achievement:SetSpecialBattleAchievement(GameEnum.levelType.DailyInstance)
  EventManager.Hit(EventId.OpenPanel, PanelId.DailyInstanceBattlePanel, self.tbCharId)
  self:SetPersonalPerk()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(nCharId, idx == 1, self.tbDiscId)
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function DailyInstanceLevel:BindEvent()
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

function DailyInstanceLevel:UnBindEvent()
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

function DailyInstanceLevel:PlaySuccessPerform(FirstRewardItems, tbSelectReward, tbDoubleItems, nExp, tbStar, mapChangeInfo)
  local function func_SettlementFinish(bSuccess)
  end
  
  local tbChar = self.tbCharId
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    local nType = ConfigTable.GetData("DailyInstanceFloor", ConfigTable.GetData("DailyInstance", self.nLevelId).FloorId).Theme
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
    local sLarge, sSmall = "", ""
    EventManager.Hit(EventId.OpenPanel, PanelId.DailyInstanceResultPanel, true, tbStar, tbSelectReward or {}, FirstRewardItems or {}, {}, nExp or 0, false, sLarge, sSmall, self.nLevelId, self.tbCharId, mapChangeInfo, self.tbCharDamage, tbDoubleItems or {})
    self.bSettle = false
    self.parent:LevelEnd()
    self:UnBindEvent()
  end
  
  EventManager.Add("SettlementPerformLoadFinish", self, openBattleResultPanel)
  CS.AdventureModuleHelper.LevelStateChanged(true)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleResultMask)
end

function DailyInstanceLevel:SetCharFixedAttribute()
  for nCharId, stActorInfo in pairs(self.mapActorInfo) do
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function DailyInstanceLevel:CalCharFixedEffect(nCharId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Build:CalBuildCharacterAttrBattle(self.mapBuildData.nBuildId, nCharId, self.tbCharTrialId and self.tbCharTrialId[nCharId], stActorInfo, bMainChar, tbDiscId)
  return stActorInfo
end

function DailyInstanceLevel:SetPersonalPerk()
  if self.mapBuildData ~= nil then
    for nCharId, tbPerk in pairs(self.mapBuildData.tbPotentials) do
      local mapAddLevel = PlayerData.Build:GetBuildEnhancedPotential(self.mapBuildData.nBuildId, nCharId, self.tbCharTrialId and self.tbCharTrialId[nCharId])
      local tbPerkInfo = {}
      for _, mapPerkInfo in ipairs(tbPerk) do
        local nAddLv = mapAddLevel[mapPerkInfo.nPotentialId] or 0
        local stPerkInfo = CS.Lua2CSharpInfo_TPPerkInfo()
        stPerkInfo.perkId = mapPerkInfo.nPotentialId
        stPerkInfo.nCount = mapPerkInfo.nLevel + nAddLv
        table.insert(tbPerkInfo, stPerkInfo)
      end
      safe_call_cs_func(CS.AdventureModuleHelper.ChangePersonalPerkIds, tbPerkInfo, nCharId)
    end
  end
end

function DailyInstanceLevel:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Build:GetBuildDiscInfoInBuild(self.mapBuildData.nBuildId, nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function DailyInstanceLevel:OnEvnet_Pause()
  EventManager.Hit("OpenDailyInstancePause", self.nLevelId, self.tbCharId)
end

return DailyInstanceLevel
