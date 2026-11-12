local RegionBossBattleLevel = class("RegionBossBattleLevel")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local AdventureModuleHelper = CS.AdventureModuleHelper
local TimerManager = require("GameCore.Timer.TimerManager")
local mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  [EventId.AbandonBattle] = "OnEvent_AbandonBattle",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  Region_Boss_Result = "LevelResultChange",
  BattlePause = "OnEvnet_Pause"
}

function RegionBossBattleLevel:Init(parent, nLevelId, nBuildId, isWeekBoss)
  self.parent = parent
  self.nLevelId = nLevelId
  self.nBuildId = nBuildId
  self.isSettlement = false
  
  local function GetBuildCallback(mapBuildData)
    self.mapBuildData = mapBuildData
    self.tbCharId = {}
    self.tbCharTrialId = {}
    if mapBuildData == nil then
      local sTip = ConfigTable.GetUIText("RegionBoss_Team_Delete")
      EventManager.Hit(EventId.OpenMessageBox, sTip)
      return
    end
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
    local nFloorId = 0
    if isWeekBoss == 1 then
      PlayerData.RogueBoss:SetIsWeeklyCopies(false)
      nFloorId = ConfigTable.GetData("RegionBossLevel", nLevelId).FloorId
    elseif isWeekBoss == 2 then
      PlayerData.RogueBoss:SetIsWeeklyCopies(true)
      nFloorId = ConfigTable.GetData("WeekBossLevel", nLevelId).FloorId
    end
    PlayerData.nCurGameType = AllEnum.WorldMapNodeType.Rogueboss
    CS.AdventureModuleHelper.EnterRogueBossMap(nFloorId, self.tbCharId, nLevelId, 0, isWeekBoss)
    NovaAPI.EnterModule("AdventureModuleScene", true, 17)
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
  self.nResultTime = 0
end

function RegionBossBattleLevel:RefreshCharDamageData()
  self.tbCharDamage = UTILS.GetCharDamageResult(self.tbCharId)
end

function RegionBossBattleLevel:SettleRegionBoss(isWin)
  if self.isSettlement then
    return
  end
  self.isSettlement = true
  self:RefreshCharDamageData()
  local isWeeklyCopies = PlayerData.RogueBoss:GetIsWeeklyCopies()
  print("is week " .. tostring(isWeeklyCopies))
  if isWeeklyCopies then
    local function callback(mapMsgData, nPassStar)
      local nExp = 0
      
      local CacheRewardTab = {}
      for i, v in ipairs(mapMsgData.FirstItems) do
        v.rewardType = AllEnum.RewardType.First
        table.insert(CacheRewardTab, v)
      end
      for i, v in ipairs(mapMsgData.AwardItems) do
        table.insert(CacheRewardTab, v)
      end
      if isWin then
        self:PlaySuccessPerform(ConfigTable.GetData("WeekBossLevel", self.nLevelId).FloorId, self.nBuildId, nExp, CacheRewardTab, mapMsgData.Change, true)
      else
        EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossResult, 2, self.nResultTime, self.nBuildId, nExp, CacheRewardTab, mapMsgData.Change, self.tbCharDamage)
      end
      self:UnBindEvent()
      self.parent:LevelEnd()
    end
    
    self.parent:WeeklyCopiesLevelSettleReq(isWin, self.nResultTime, callback)
  else
    local function callback(mapMsgData, nPassStar)
      self.passStar = nPassStar
      
      local nExp = mapMsgData.Exp
      local CacheRewardTab = {}
      for i, v in ipairs(mapMsgData.FirstItems) do
        v.rewardType = AllEnum.RewardType.First
        table.insert(CacheRewardTab, v)
      end
      for i, v in ipairs(mapMsgData.ThreeStarItems) do
        v.rewardType = AllEnum.RewardType.Three
        table.insert(CacheRewardTab, v)
      end
      for i, v in ipairs(mapMsgData.SurpriseItems) do
        v.rewardType = AllEnum.RewardType.Extra
        table.insert(CacheRewardTab, v)
      end
      for i, v in ipairs(mapMsgData.AwardItems) do
        table.insert(CacheRewardTab, v)
      end
      for i, v in ipairs(mapMsgData.DoubleItems) do
        v.rewardType = AllEnum.RewardType.Double
        table.insert(CacheRewardTab, v)
      end
      if isWin then
        self:PlaySuccessPerform(ConfigTable.GetData("RegionBossLevel", self.nLevelId).FloorId, self.nBuildId, nExp, CacheRewardTab, mapMsgData.Change, false)
      else
        EventManager.Hit(EventId.OpenPanel, PanelId.BossInstanceResultPanel, false, 0, CacheRewardTab, nExp, self.nLevelId, self.tbCharId, mapMsgData.Change, self.tbCharDamage)
      end
      self:UnBindEvent()
      self.parent:LevelEnd()
    end
    
    self.parent:RegionBossLevelSettleReq(isWin, self.nResultTime, callback)
  end
end

function RegionBossBattleLevel:OnEvent_LoadLevelRefresh()
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetBuildAllEft(self.mapBuildData.nBuildId)
  safe_call_cs_func(CS.AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
end

function RegionBossBattleLevel:OnEvent_AbandonBattle()
  self:SettleRegionBoss(false)
end

function RegionBossBattleLevel:OnEvent_AdventureModuleEnter()
  local isWeeklyCopies = PlayerData.RogueBoss:GetIsWeeklyCopies()
  if isWeeklyCopies then
    PlayerData.Achievement:SetSpecialBattleAchievement(GameEnum.levelType.WeeklyCopies)
  else
    PlayerData.Achievement:SetSpecialBattleAchievement(GameEnum.levelType.RegionBoss)
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossBattlePanel, self.tbCharId)
  self:SetPersonalPerk()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(nCharId, idx == 1, self.tbDiscId)
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function RegionBossBattleLevel:OnEvent_OpenChest()
  local function wait()
    self:SettleRegionBoss(true)
  end
  
  TimerManager.Add(1, 1, self, wait, true, true, true, nil)
end

function RegionBossBattleLevel:LevelResultChange(isWin, totaltime)
  self.nResultTime = totaltime
  self:SettleRegionBoss(isWin)
end

function RegionBossBattleLevel:BindEvent()
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

function RegionBossBattleLevel:UnBindEvent()
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

function RegionBossBattleLevel:PlaySuccessPerform(nMapId, buildId, nExp, tbReward, mapChangeInfo, isWeekBoss)
  local function func_SettlementFinish(bSuccess)
  end
  
  local tbChar = self.tbCharId
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    if isWeekBoss then
      local nType = ConfigTable.GetData("WeekBossFloor", nMapId).Theme
      local sName = ConfigTable.GetData("EndSceneType", nType).EndSceneName
      print("sceneName:" .. sName)
      local tbSkin = {}
      for _, nCharId in ipairs(tbChar) do
        local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
        table.insert(tbSkin, nSkinId)
      end
      CS.AdventureModuleHelper.PlaySettlementPerform(sName, "", tbSkin, func_SettlementFinish)
    else
      local nType = ConfigTable.GetData("RegionBossFloor", nMapId).Theme
      local sName = ConfigTable.GetData("EndSceneType", nType).EndSceneName
      print("sceneName:" .. sName)
      local tbSkin = {}
      for _, nCharId in ipairs(tbChar) do
        local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
        table.insert(tbSkin, nSkinId)
      end
      CS.AdventureModuleHelper.PlaySettlementPerform(sName, "", tbSkin, func_SettlementFinish)
    end
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
  
  local function openBattleResultPanel()
    EventManager.Remove("SettlementPerformLoadFinish", self, openBattleResultPanel)
    if self.passStar == nil then
      self.passStar = 1
    end
    if isWeekBoss then
      EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossResult, 1, self.nResultTime, buildId, nExp, tbReward, mapChangeInfo, self.tbCharDamage)
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.BossInstanceResultPanel, true, self.passStar, tbReward, nExp, self.nLevelId, self.tbCharId, mapChangeInfo, self.tbCharDamage)
    end
  end
  
  EventManager.Add("SettlementPerformLoadFinish", self, openBattleResultPanel)
  CS.AdventureModuleHelper.LevelStateChanged(true)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleResultMask)
end

function RegionBossBattleLevel:SetTempActorAttribute(nCharId)
  local mapChar = {nLevel = 1, nAdvance = 0}
  local nLevel = mapChar.nLevel
  local nAdvance = mapChar.nAdvance
  local nAttrId = UTILS.GetCharacterAttributeId(nCharId, nAdvance, nLevel)
  local mapCharAttr = ConfigTable.GetData_Attribute(tostring(nAttrId))
  if mapCharAttr == nil then
    printError("属性配置不存在:" .. nAttrId)
    return {}
  end
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  stActorInfo.Atk = mapCharAttr.Atk
  stActorInfo.Def = mapCharAttr.Def
  stActorInfo.MDef = mapCharAttr.Mdef
  stActorInfo.ShieldBonus = mapCharAttr.ShieldBonus
  stActorInfo.IncomingShieldBonus = mapCharAttr.IncomingShieldBonus
  stActorInfo.Evd = mapCharAttr.Evd
  stActorInfo.CritRate = mapCharAttr.CritRate
  stActorInfo.CritResistance = mapCharAttr.CritResistance
  stActorInfo.CritPower = mapCharAttr.CritPower
  stActorInfo.HitRate = mapCharAttr.HitRate
  stActorInfo.DefPierce = mapCharAttr.DefPierce
  stActorInfo.WEE = mapCharAttr.WEE
  stActorInfo.FEE = mapCharAttr.FEE
  stActorInfo.SEE = mapCharAttr.SEE
  stActorInfo.AEE = mapCharAttr.AEE
  stActorInfo.LEE = mapCharAttr.LEE
  stActorInfo.DEE = mapCharAttr.DEE
  stActorInfo.WEP = mapCharAttr.WEP
  stActorInfo.FEP = mapCharAttr.FEP
  stActorInfo.AEP = mapCharAttr.AEP
  stActorInfo.SEP = mapCharAttr.SEP
  stActorInfo.LEP = mapCharAttr.LEP
  stActorInfo.DEP = mapCharAttr.DEP
  stActorInfo.WER = mapCharAttr.WER
  stActorInfo.FER = mapCharAttr.FER
  stActorInfo.AER = mapCharAttr.AER
  stActorInfo.SER = mapCharAttr.SER
  stActorInfo.LER = mapCharAttr.LER
  stActorInfo.DER = mapCharAttr.DER
  stActorInfo.Hp = mapCharAttr.Hp
  stActorInfo.Suppress = mapCharAttr.Suppress
  stActorInfo.SkillLevel = {
    1,
    1,
    1
  }
  stActorInfo.skinId = PlayerData.Char:GetCharSkinId(nCharId)
  stActorInfo.attrId = mapCharAttr.sAttrId
  safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
end

function RegionBossBattleLevel:SetCharFixedAttribute()
  for nCharId, stActorInfo in pairs(self.mapActorInfo) do
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function RegionBossBattleLevel:CalCharFixedEffect(nCharId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Build:CalBuildCharacterAttrBattle(self.mapBuildData.nBuildId, nCharId, self.tbCharTrialId and self.tbCharTrialId[nCharId], stActorInfo, bMainChar, tbDiscId)
  return stActorInfo
end

function RegionBossBattleLevel:SetPersonalPerk()
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

function RegionBossBattleLevel:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Build:GetBuildDiscInfoInBuild(self.mapBuildData.nBuildId, nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function RegionBossBattleLevel:OnEvnet_Pause()
  EventManager.Hit("OpenRegionBossPause", self.nLevelId, self.tbCharId)
end

return RegionBossBattleLevel
