local ActivityLevelsInstanceLevel = class("ActivityLevelsInstanceLevel")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local AdventureModuleHelper = CS.AdventureModuleHelper
local TimerManager = require("GameCore.Timer.TimerManager")
local mapEventConfig = {
  LevelStateChanged = "OnEvent_SendMsgFinishBattle",
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  [EventId.AbandonBattle] = "OnEvent_AbandonBattle",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  BattlePause = "OnEvent_Pause",
  ActivityInstance_Result = "LevelResultChange",
  ActivityLevelSettle_Failed = "OnEvent_ActivityLevelSettleFailed",
  ActivityLevels_Instance_Gameplay_Time = "OnEvent_ActivityLevels_Time"
}

function ActivityLevelsInstanceLevel:Init(parent, nActivityId, nLevelId, nBuildId)
  self.parent = parent
  self.nLevelId = nLevelId
  self.nActivityId = nActivityId
  self.isSettlement = false
  self.nBuildId = nBuildId
  self.curFloorIdx = 1
  self.levelTotalTime = 0
  
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
    PlayerData.nCurGameType = AllEnum.WorldMapNodeType.ActivityLevels
    local mapParams = {
      tostring(self.curFloorIdx),
      tostring(self.levelTotalTime)
    }
    CS.AdventureModuleHelper.EnterActivityLevelsInstance(nLevelId, self.tbCharId, mapParams)
    NovaAPI.EnterModule("AdventureModuleScene", true, 17)
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
end

function ActivityLevelsInstanceLevel:OnEvent_LoadLevelRefresh()
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetBuildAllEft(self.mapBuildData.nBuildId)
  safe_call_cs_func(CS.AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
  EventManager.Hit("OpenActivityLevelsInstanceRoomInfo", self.nLevelId, self.levelTotalTime)
end

function ActivityLevelsInstanceLevel:OnEvent_LevelResult(tbStar, bAbandon)
end

function ActivityLevelsInstanceLevel:OnEvent_AbandonBattle()
  self:LevelResultChange(false, 0)
end

function ActivityLevelsInstanceLevel:OnEvent_AdventureModuleEnter()
  PlayerData.Achievement:SetSpecialBattleAchievement(GameEnum.levelType.ActivityLevels)
  EventManager.Hit(EventId.OpenPanel, PanelId.ActivityLevelsBattlePanel, self.tbCharId)
  self:SetPersonalPerk()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(nCharId, idx == 1, self.tbDiscId)
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function ActivityLevelsInstanceLevel:OnEvent_SendMsgFinishBattle()
  if self.isSettlement then
    return
  end
  local mapCfg = ConfigTable.GetData("ActivityLevelsLevel", self.nLevelId)
  if self.curFloorIdx < #mapCfg.FloorId then
    local function GetBuildCallback(mapBuildData)
      self.curFloorIdx = self.curFloorIdx + 1
      
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
      PlayerData.nCurGameType = AllEnum.WorldMapNodeType.ActivityLevels
      
      local function levelEndCallback()
        EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        self:OnEvent_AdventureModuleEnter()
      end
      
      EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
      local mapParams = {
        tostring(self.curFloorIdx),
        tostring(self.levelTotalTime)
      }
      CS.AdventureModuleHelper.EnterActivityLevelsInstance(self.nLevelId, self.tbCharId, mapParams)
      CS.AdventureModuleHelper.LevelStateChanged(false)
    end
    
    PlayerData.Build:GetBuildDetailData(GetBuildCallback, self.nBuildId)
    return
  end
end

function ActivityLevelsInstanceLevel:LevelResultChange(isWin, totalTime)
  EventManager.Hit("ActivityLevelsInstanceBattleEnd")
  self:SettleLevelsInstance(isWin, totalTime)
end

function ActivityLevelsInstanceLevel:RefreshCharDamageData()
  self.tbCharDamage = UTILS.GetCharDamageResult(self.tbCharId)
end

function ActivityLevelsInstanceLevel:SettleLevelsInstance(isWin, totalTime)
  if self.isSettlement then
    return
  end
  self.isSettlement = true
  local starCount = 0
  self:RefreshCharDamageData()
  if isWin then
    local mapCfg = ConfigTable.GetData("ActivityLevelsLevel", self.nLevelId)
    if totalTime <= mapCfg.ThreeStarCondition[1] then
      starCount = 3
    elseif totalTime <= mapCfg.TwoStarCondition[1] then
      starCount = 2
    else
      starCount = 1
    end
  end
  
  local function callback(taFixed, tbFirstReward, nExp, mapChangeInfo)
    NovaAPI.InputEnable()
    EventManager.Hit("ActivityLevelsInstanceLevelEnd")
    self.passStar = starCount
    if isWin then
      self:PlaySuccessPerform(taFixed, tbFirstReward, nExp, starCount, mapChangeInfo)
    else
      EventManager.Hit(EventId.ClosePanel, PanelId.BtnTips)
      local sLarge, sSmall = "", ""
      EventManager.Hit(EventId.OpenPanel, PanelId.ActivityLevelsInstanceResultPanel, false, 0, {}, {}, {}, 0, false, sLarge, sSmall, self.nLevelId, self.tbCharId, mapChangeInfo, self.tbCharDamage)
    end
    self:UnBindEvent()
    self.parent:LevelEnd()
  end
  
  NovaAPI.InputDisable()
  self.parent:SendActivityLevelSettleReq(self.nActivityId, starCount, callback)
end

function ActivityLevelsInstanceLevel:OnEvent_ActivityLevelSettleFailed()
  NovaAPI.InputEnable()
  EventManager.Hit("ActivityLevelsInstanceLevelEnd")
  self.passStar = 0
  EventManager.Hit(EventId.ClosePanel, PanelId.BtnTips)
  local sLarge, sSmall = "", ""
  EventManager.Hit(EventId.OpenPanel, PanelId.ActivityLevelsInstanceResultPanel, false, 0, {}, {}, {}, 0, false, sLarge, sSmall, self.nLevelId, self.tbCharId, nil, self.tbCharDamage)
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local nEndTime = self.parent.nEndTime
  if nCurTime > nEndTime then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_End_Notice"))
  end
  self:UnBindEvent()
  self.parent:LevelEnd()
end

function ActivityLevelsInstanceLevel:PlaySuccessPerform(FixedRewardItems, FirstRewardItems, nExp, starCount, mapChangeInfo)
  local function func_SettlementFinish(bSuccess)
  end
  
  local tbChar = self.tbCharId
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    local tabFloor = ConfigTable.GetData("ActivityLevelsLevel", self.nLevelId).FloorId
    local tabFloorCount = #tabFloor
    local nType = ConfigTable.GetData("ActivityLevelsFloor", tabFloor[tabFloorCount]).Theme
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
    EventManager.Hit(EventId.OpenPanel, PanelId.ActivityLevelsInstanceResultPanel, true, starCount, FixedRewardItems or {}, FirstRewardItems or {}, {}, nExp or 0, false, sLarge, sSmall, self.nLevelId, self.tbCharId, mapChangeInfo, self.tbCharDamage)
    self.bSettle = false
    self.parent:LevelEnd()
    self:UnBindEvent()
  end
  
  EventManager.Add("SettlementPerformLoadFinish", self, openBattleResultPanel)
  CS.AdventureModuleHelper.LevelStateChanged(true)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleResultMask)
end

function ActivityLevelsInstanceLevel:BindEvent()
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

function ActivityLevelsInstanceLevel:UnBindEvent()
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

function ActivityLevelsInstanceLevel:SetCharFixedAttribute()
  for nCharId, stActorInfo in pairs(self.mapActorInfo) do
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function ActivityLevelsInstanceLevel:CalCharFixedEffect(nCharId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Build:CalBuildCharacterAttrBattle(self.mapBuildData.nBuildId, nCharId, self.tbCharTrialId and self.tbCharTrialId[nCharId], stActorInfo, bMainChar, tbDiscId)
  return stActorInfo
end

function ActivityLevelsInstanceLevel:SetPersonalPerk()
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

function ActivityLevelsInstanceLevel:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Build:GetBuildDiscInfoInBuild(self.mapBuildData.nBuildId, nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function ActivityLevelsInstanceLevel:OnEvent_Pause()
  EventManager.Hit("OpenActivityLevelsInstancePause", self.nActivityId, self.nLevelId, self.tbCharId)
end

function ActivityLevelsInstanceLevel:OnEvent_ActivityLevels_Time(nTime)
  self.levelTotalTime = nTime
end

return ActivityLevelsInstanceLevel
