local ScoreBossLevel = class("ScoreBossLevel")
local LocalData = require("GameCore.Data.LocalData")
local mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  BattlePause = "OnEvent_Pause",
  [EventId.AbandonBattle] = "OnEvent_AbandonBattle",
  ScoreBossLevelGameEnd = "OnEvent_LevelResult",
  BossRush_Spawn_Id = "OnEvent_BossRushSpawnId",
  ScoreBoss_Result_Time = "ScoreBossResultTime",
  LevelStateChanged = "ScoreBossResult",
  ScoreBoss_BehaviorScore = "OnEvent_ControlScore",
  ScoreBossSettleSuccess = "OnEvent_ScoreBossSettleSuccess",
  ScoreBossSettleGiveUp = "OnEvent_ScoreBossSettleGiveUp",
  Upload_Dodge_Event = "OnEvent_UploadDodgeEvent",
  ADVENTURE_LEVEL_UNLOAD_COMPLETE = "OnEvent_UnloadComplete"
}

function ScoreBossLevel:Init(parent, nLevelId, nBuildId, isAgain)
  self.isSettlement = false
  self.parent = parent
  self.LevelId = nLevelId
  self.tmpBuildId = nBuildId
  self.BossId = 0
  self.BossMaxHp = 0
  self.BossCurLvMinHp = -1
  self.BossCurLvTotalChangeHp = 0
  self.BattleLv = 1
  self.nTime = 0
  self.isCanPause = true
  local leveData = ConfigTable.GetData("ScoreBossLevel", nLevelId)
  if leveData == nil then
    printError("ScoreBossLevel 表不存在 id ==== " .. nLevelId)
    return
  end
  local getControlData = ConfigTable.GetData("ScoreBossGetControl", leveData.NonDamageScoreGet)
  if getControlData == nil then
    printError("ScoreBossGetControl 表不存在 id ==== " .. leveData.NonDamageScoreGet)
    return
  end
  self.totalControlScore = 0
  self.OnceControlScore = getControlData.OnceScore
  self.MaxControlScore = getControlData.MaxLimit
  self.ScoreBossBehavior = getControlData.ScoreBossBehavior
  self.ScoreGetSwitchGroupId = leveData.ScoreGetSwitchGroup
  self._dmgSeq = 0
  self.totalDamageVal = 0
  self.SwitchRate = 300
  local getSwitchData = ConfigTable.GetData("ScoreGetSwitch", self.ScoreGetSwitchGroupId * 1000 + 1)
  if getSwitchData ~= nil then
    self.SwitchRate = getSwitchData.SwitchRate
  end
  
  local function GetBuildCallback(mapBuildData)
    self.mapBuildData = mapBuildData
    self.tbCharId = {}
    for _, mapChar in ipairs(self.mapBuildData.tbChar) do
      table.insert(self.tbCharId, mapChar.nTid)
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
    self.parent:CacheBuildCharTid(self.tbCharId)
    PlayerData.nCurGameType = AllEnum.WorldMapNodeType.ScoreBoss
    CS.AdventureModuleHelper.EnterScoreBossFloor(self.LevelId, self.tbCharId)
    local sKey = LocalData.GetPlayerLocalData("ScoreBossRecordKey")
    safe_call_cs_func(CS.AdventureModuleHelper.SetDamageRecordId, sKey)
    if not isAgain then
      NovaAPI.EnterModule("AdventureModuleScene", true, 17)
    else
      self:OnEvent_AdventureModuleEnter()
    end
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
end

function ScoreBossLevel:CalCharFixedEffect(nCharId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Char:CalCharacterAttrBattle(nCharId, stActorInfo, bMainChar, tbDiscId, self.mapBuildData.nBuildId)
  return stActorInfo
end

function ScoreBossLevel:OnEvent_LoadLevelRefresh()
  self.isCanPause = true
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetBuildAllEft(self.mapBuildData.nBuildId)
  safe_call_cs_func(CS.AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
  PlayerData.Build:SetBuildReportInfo(self.mapBuildData.nBuildId)
end

function ScoreBossLevel:OnEvent_AdventureModuleEnter()
  PlayerData.Achievement:SetSpecialBattleAchievement(GameEnum.levelType.ScoreBoss)
  EventManager.Hit(EventId.OpenPanel, PanelId.ScoreBossBattlePanel, self.tbCharId)
  self:SetPersonalPerk()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(nCharId, idx == 1, self.tbDiscId)
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function ScoreBossLevel:SetPersonalPerk()
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
      safe_call_cs_func(CS.AdventureModuleHelper.ChangePersonalPerkIds, tbPerkInfo, nCharId)
    end
  end
end

function ScoreBossLevel:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Disc:CalcDiscInfoInBuild(nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function ScoreBossLevel:OnEvent_Pause()
  if self.isCanPause then
    EventManager.Hit("OpenScoreBossPause", self.LevelId, self.tbCharId)
  end
end

function ScoreBossLevel:OnEvent_AbandonBattle()
  self.parent:QuiteLevel()
end

function ScoreBossLevel:OnEvent_LevelResult(tbStar, bAbandon)
  self.parent:LevelEnd()
end

function ScoreBossLevel:OnEvent_BossRushSpawnId(bossId)
  self.BossId = bossId
  local healthInfo = CS.AdventureModuleHelper.GetEntityHealthInfo(bossId)
  self.BossMaxHp = healthInfo ~= nil and healthInfo.hpMax or 0
  EventManager.AddEntityEvent("BossRushMonsterLevelChanged", self.BossId, self, self.OnEvent_BossRushMonsterLevelChanged)
  EventManager.AddEntityEvent("BossRushMonsterDamageValue", self.BossId, self, self.OnEvent_BossRushMonsterDamageValue)
end

function ScoreBossLevel:OnEvent_BossRushMonsterLevelChanged(oldLevel, battleLevel)
  self.BattleLv = battleLevel
end

function ScoreBossLevel:OnEvent_BossRushMonsterDamageValue(val)
  self.totalDamageVal = self.totalDamageVal + val
  self.parent:DamageToScore(self.totalDamageVal, self.SwitchRate, self.BattleLv)
end

function ScoreBossLevel:ScoreBossResultTime(nTime)
  self.nTime = nTime
end

function ScoreBossLevel:ScoreBossResult(levelState, totalTime)
  if self.isSettlement then
    return
  end
  self.isSettlement = true
  self.parent:SendScoreBossSettleReq(self.nTime)
end

function ScoreBossLevel:PlaySuccessPerform(entryLevelId, totalScore, totalStar)
  local tbChar = {}
  self:RefreshCharDamageData()
  for _, nCharId in ipairs(self.tbCharId) do
    table.insert(tbChar, nCharId)
  end
  
  local function func_SettlementFinish(bSuccess)
  end
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    local nLevelData = ConfigTable.GetData("ScoreBossLevel", self.LevelId)
    local nType = ConfigTable.GetData("ScoreBossFloor", nLevelData.FloorId).Theme
    local sName = ConfigTable.GetData("EndSceneType", nType).EndSceneName
    print("sceneName:" .. sName)
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
    EventManager.Hit(EventId.OpenPanel, PanelId.ScoreBossResult, entryLevelId, totalScore, totalStar, self.tbCharDamage, self.tbCharId)
  end
  
  EventManager.Add("SettlementPerformLoadFinish", self, openBattleResultPanel)
  CS.AdventureModuleHelper.LevelStateChanged(true)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleResultMask)
end

function ScoreBossLevel:RefreshCharDamageData()
  self.tbCharDamage = UTILS.GetCharDamageResult(self.tbCharId)
end

function ScoreBossLevel:OnEvent_ControlScore(Id, nBehavior)
  if self.isSettlement then
    return
  end
  if self.BossId == Id and nBehavior == self.ScoreBossBehavior and self.totalControlScore < self.MaxControlScore then
    self.totalControlScore = self.totalControlScore + self.OnceControlScore
    self.parent:BehaviorToScore(self.totalControlScore)
  end
end

function ScoreBossLevel:OnEvent_ScoreBossSettleSuccess(entryLevelId, totalScore, totalStar)
  self:PlaySuccessPerform(entryLevelId, totalScore, totalStar)
end

function ScoreBossLevel:OnEvent_ScoreBossSettleGiveUp(totalScore, totalStar)
  self.parent:LevelEnd()
end

function ScoreBossLevel:BindEvent()
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

function ScoreBossLevel:UnBindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
  if self.BossId then
    EventManager.RemoveEntityEvent("BossRushMonsterLevelChanged", self.BossId, self, self.OnEvent_BossRushMonsterLevelChanged)
    EventManager.RemoveEntityEvent("BossRushMonsterDamageValue", self.BossId, self, self.OnEvent_BossRushMonsterDamageValue)
    self.BossId = nil
  end
end

function ScoreBossLevel:OnEvent_UploadDodgeEvent(padMode)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tab, {"pad_mode", padMode})
  table.insert(tab, {"level_type", "ScoreBoss"})
  table.insert(tab, {
    "build_id",
    tostring(self.tmpBuildId)
  })
  table.insert(tab, {
    "level_id",
    tostring(self.LevelId)
  })
  table.insert(tab, {
    "up_time",
    tostring(CS.ClientManager.Instance.serverTimeStamp)
  })
  NovaAPI.UserEventUpload("use_dodge_key", tab)
end

function ScoreBossLevel:OnEvent_UnloadComplete()
  self.parent:EntryLvAgain()
end

return ScoreBossLevel
