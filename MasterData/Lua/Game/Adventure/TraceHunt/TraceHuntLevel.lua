local TraceHuntLevel = class("TraceHuntLevel")
local TimerManager = require("GameCore.Timer.TimerManager")
local mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  BattlePause = "OnEvent_Pause",
  [EventId.AbandonBattle] = "OnEvent_AbandonBattle",
  TraceHunt_Spawn_Id = "OnEvent_TraceHuntSpawnId",
  TraceHunt_Result_Time = "TraceHuntResultTime",
  LevelStateChanged = "TraceHuntResult",
  TraceHuntSettleSuccess = "OnEvent_TraceHuntSettleSuccess",
  ADVENTURE_LEVEL_UNLOAD_COMPLETE = "OnEvent_UnloadComplete"
}

function TraceHuntLevel:Init(parent, nLevelId, nBuildId, nFloorId, isAgain)
  self.isSettlement = false
  self.parent = parent
  self.LevelId = nLevelId
  self.BossId = 0
  self.BossMaxHp = 0
  self.BossCurLvMinHp = -1
  self.BossCurLvTotalChangeHp = 0
  self.BattleLv = 1
  self.nTime = 0
  self.isCanPause = true
  local leveData = ConfigTable.GetData("TraceHuntFloorGroup", nFloorId)
  if leveData == nil then
    printError("TraceHuntFloorGroup 表不存在 id ==== " .. nFloorId)
    return
  end
  self.ScoreGetSwitchGroupId = leveData.ScoreGetSwitchGroup
  self.SwitchRate = 300
  local getSwitchData = ConfigTable.GetData("TraceHuntScoreSwitch", self.ScoreGetSwitchGroupId * 1000 + 1)
  if getSwitchData ~= nil then
    self.SwitchRate = getSwitchData.SwitchRate
  end
  
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
    PlayerData.nCurGameType = AllEnum.WorldMapNodeType.TraceHunt
    local params = NovaAPI.GetDynamicLevelParamsBootConfig()
    CS.AdventureModuleHelper.EnterDynamic(nFloorId, self.tbCharId, GameEnum.dynamicLevelType.TraceHunt, params)
    if not isAgain then
      NovaAPI.EnterModule("AdventureModuleScene", true, 17)
    else
      self:OnEvent_AdventureModuleEnter()
    end
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
end

function TraceHuntLevel:CalCharFixedEffect(nCharId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Build:CalBuildCharacterAttrBattle(self.mapBuildData.nBuildId, nCharId, self.tbCharTrialId and self.tbCharTrialId[nCharId], stActorInfo, bMainChar, tbDiscId)
  return stActorInfo
end

function TraceHuntLevel:OnEvent_LoadLevelRefresh()
  self.isCanPause = true
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetBuildAllEft(self.mapBuildData.nBuildId)
  safe_call_cs_func(CS.AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
end

function TraceHuntLevel:OnEvent_AdventureModuleEnter()
  PlayerData.Achievement:SetSpecialBattleAchievement(GameEnum.levelType.TraceHunt)
  EventManager.Hit(EventId.OpenPanel, PanelId.TraceHuntBattle, self.tbCharId)
  self:SetPersonalPerk()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(nCharId, idx == 1, self.tbDiscId)
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function TraceHuntLevel:SetPersonalPerk()
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

function TraceHuntLevel:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Build:GetBuildDiscInfoInBuild(self.mapBuildData.nBuildId, nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function TraceHuntLevel:OnEvent_Pause()
  if self.isCanPause then
    EventManager.Hit("OpenTraceHuntPause", self.LevelId, self.tbCharId, self.parent.bSelfBoss)
  end
end

function TraceHuntLevel:OnEvent_AbandonBattle()
  self.parent:QuiteLevel()
end

function TraceHuntLevel:OnEvent_TraceHuntSpawnId(bossId)
  self.BossId = bossId
  local healthInfo = CS.AdventureModuleHelper.GetEntityHealthInfo(bossId)
  self.BossMaxHp = healthInfo ~= nil and healthInfo.hpMax or 0
  EventManager.AddEntityEvent("HpChanged", self.BossId, self, self.OnEvent_HpChanged)
  EventManager.AddEntityEvent("BossRushMonsterLevelChanged", self.BossId, self, self.OnEvent_TraceHuntMonsterLevelChanged)
  EventManager.AddEntityEvent("BossRushMonsterBattleAttrChanged", self.BossId, self, self.OnEvent_TraceHuntMonsterBattleAttrChanged)
end

function TraceHuntLevel:OnEvent_HpChanged(hp, hpMax)
  if self.isSettlement then
    return
  end
  if self.isDontChangeHp then
    return
  end
  if self.BossCurLvMinHp == -1 then
    self.BossCurLvMinHp = hp
    self.parent:DamageToScore(hpMax - hp, self.SwitchRate, self.BattleLv)
    return
  end
  if hp > self.BossCurLvMinHp then
    self.BossCurLvMinHp = hp
    return
  end
  if hp <= self.BossCurLvMinHp then
    self.BossCurLvMinHp = hp
    self.parent:DamageToScore(hpMax - hp, self.SwitchRate, self.BattleLv)
  end
end

function TraceHuntLevel:OnEvent_TraceHuntMonsterLevelChanged(oldLevel, battleLevel)
  if self.isSettlement then
    return
  end
  self.isDontChangeHp = true
  self.BossCurLvTotalChangeHp = self.BossCurLvTotalChangeHp + self.BossCurLvMinHp
  self.BossCurLvMinHp = -1
  self.BattleLv = battleLevel
  self.parent:DamageToScore(self.BossMaxHp, self.SwitchRate, self.BattleLv)
  self.BossCurLvTotalChangeHp = 0
  if battleLevel <= 100 then
    local getSwitchData = ConfigTable.GetData("TraceHuntScoreSwitch", self.ScoreGetSwitchGroupId * 1000 + battleLevel)
    if getSwitchData ~= nil then
      self.SwitchRate = getSwitchData.SwitchRate
    end
  end
  self.parent:HPLevelChanged()
end

function TraceHuntLevel:OnEvent_TraceHuntMonsterBattleAttrChanged()
  local healthInfo = CS.AdventureModuleHelper.GetEntityHealthInfo(self.BossId)
  self.BossMaxHp = healthInfo ~= nil and healthInfo.hpMax or 0
  self.isDontChangeHp = false
end

function TraceHuntLevel:TraceHuntResultTime(nTime)
  self.nTime = nTime
end

function TraceHuntLevel:TraceHuntResult(levelState, totalTime)
  if self.isSettlement then
    return
  end
  self.isSettlement = true
  local nLeft = self.parent:GetControlLeftTime()
  if nLeft <= 0 then
    local bEmpty = self.parent:GetSelfHuntCount() == 0
    local sTip = ""
    if self.parent.bSelfBoss then
      sTip = bEmpty and ConfigTable.GetUIText("TraceHunt_ControlTimeOverInFirstBattle") or ConfigTable.GetUIText("TraceHunt_ControlTimeOverInBattle")
    else
      sTip = ConfigTable.GetUIText("TraceHunt_ControlTimeOverInFirstBattle")
    end
    local msg = {
      nType = AllEnum.MessageBox.Alert,
      sContent = sTip,
      callbackConfirm = function()
        self.parent:QuiteLevel()
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
    return
  end
  self.parent:SendTraceHuntSettleReq(self.LevelId)
end

function TraceHuntLevel:RefreshCharDamageData()
  self.tbCharDamage = UTILS.GetCharDamageResult(self.tbCharId)
end

function TraceHuntLevel:OnEvent_TraceHuntSettleSuccess(entryLevelId, totalStar, nExp, bSelfBoss, mapChangeInfo, bUpgrade, nBeforeMaxStar)
  self:RefreshCharDamageData()
  EventManager.Hit(EventId.OpenPanel, PanelId.TraceHuntResult, entryLevelId, totalStar, nExp, bSelfBoss, mapChangeInfo, bUpgrade, nBeforeMaxStar, self.tbCharDamage)
end

function TraceHuntLevel:BindEvent()
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

function TraceHuntLevel:UnBindEvent()
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
    EventManager.RemoveEntityEvent("HpChanged", self.BossId, self, self.OnEvent_HpChanged)
    EventManager.RemoveEntityEvent("BossRushMonsterLevelChanged", self.BossId, self, self.OnEvent_TraceHuntMonsterLevelChanged)
    EventManager.RemoveEntityEvent("BossRushMonsterBattleAttrChanged", self.BossId, self, self.OnEvent_TraceHuntMonsterBattleAttrChanged)
    self.BossId = nil
  end
end

function TraceHuntLevel:OnEvent_UnloadComplete()
  self.parent:EntryLvAgain()
end

return TraceHuntLevel
