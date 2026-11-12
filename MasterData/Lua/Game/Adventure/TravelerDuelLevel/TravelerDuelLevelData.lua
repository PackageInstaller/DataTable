local TravelerDuelLevelData = class("TravelerDuelLevelData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local AdventureModuleHelper = CS.AdventureModuleHelper
local TimerManager = require("GameCore.Timer.TimerManager")
local mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  [EventId.AbandonBattle] = "OnEvent_AbandonBattle",
  TravelerDuel_Result = "OnEvent_LevelResult",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  BattlePause = "OnEvnet_Pause",
  Upload_Dodge_Event = "OnEvent_UploadDodgeEvent"
}

function TravelerDuelLevelData:Init(parent, nLevel, tbAffixes, nBuildId)
  self._EntryTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  self.bEnd = false
  self.parent = parent
  self.nlevelId = nLevel
  self.tmpBuildId = nBuildId
  self.tbAffixes = tbAffixes
  local mapCfg = ConfigTable.GetData("TravelerDuelBossLevel", nLevel)
  if mapCfg then
    self.nTime = mapCfg.Timelimit
  end
  
  local function GetDataCallback(mapBuildData)
    local mapLevel = ConfigTable.GetData("TravelerDuelBossLevel", nLevel)
    if mapLevel == nil then
      printError("TravelerDuelBossLevel missing:" .. nLevel)
      return
    end
    self.mapBuildData = mapBuildData
    self.tbCharId = {}
    self.tbCharTrialId = {}
    for i, v in pairs(mapBuildData.tbChar) do
      table.insert(self.tbCharId, v.nTid)
      self.tbCharTrialId[v.nTid] = v.nTrialId
    end
    self.tbDiscId = {}
    for _, nDiscId in ipairs(self.mapBuildData.tbDisc) do
      if 0 < nDiscId then
        table.insert(self.tbDiscId, nDiscId)
      end
    end
    PlayerData.nCurGameType = AllEnum.WorldMapNodeType.TravelerDuel
    CS.AdventureModuleHelper.EnterTravelerDuel(nLevel, mapLevel.FloorId, self.tbCharId, tbAffixes)
    NovaAPI.EnterModule("AdventureModuleScene", true, 17)
  end
  
  PlayerData.Build:GetBuildDetailData(GetDataCallback, nBuildId)
end

function TravelerDuelLevelData:RefreshCharDamageData()
  self.tbCharDamage = UTILS.GetCharDamageResult(self.tbCharId)
end

function TravelerDuelLevelData:OnEvent_LoadLevelRefresh()
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetBuildAllEft(self.mapBuildData.nBuildId)
  safe_call_cs_func(CS.AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
end

function TravelerDuelLevelData:OnEvent_LevelResult(bSuccess, nTime)
  if self.bEnd then
    return
  end
  self.bEnd = true
  self:RefreshCharDamageData()
  
  local function msgCallback(bNewRecord)
    self._EndTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local tabUpLevel = {}
    local nResult = bSuccess and "1" or "2"
    table.insert(tabUpLevel, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tabUpLevel, {
      "game_cost_time",
      tostring(nTime)
    })
    table.insert(tabUpLevel, {
      "real_cost_time",
      tostring(self._EndTime - self._EntryTime)
    })
    table.insert(tabUpLevel, {
      "build_id",
      tostring(self.mapBuildData.nBuildId)
    })
    table.insert(tabUpLevel, {
      "battle_id",
      tostring(self.nlevelId)
    })
    table.insert(tabUpLevel, {
      "battle_result",
      tostring(nResult)
    })
    local tmp = table.concat(self.tbAffixes, ",")
    table.insert(tabUpLevel, {
      "battle_affix",
      tmp
    })
    table.insert(tabUpLevel, {
      "characterid1",
      self.tbCharDamage[1] ~= nil and tostring(self.tbCharDamage[1].nCharId) or "0"
    })
    table.insert(tabUpLevel, {
      "damage1",
      self.tbCharDamage[1] ~= nil and tostring(self.tbCharDamage[1].nDamage) or "0"
    })
    table.insert(tabUpLevel, {
      "characterid2",
      self.tbCharDamage[2] ~= nil and tostring(self.tbCharDamage[2].nCharId) or "0"
    })
    table.insert(tabUpLevel, {
      "damage2",
      self.tbCharDamage[2] ~= nil and tostring(self.tbCharDamage[2].nDamage) or "0"
    })
    table.insert(tabUpLevel, {
      "characterid3",
      self.tbCharDamage[3] ~= nil and tostring(self.tbCharDamage[3].nCharId) or "0"
    })
    table.insert(tabUpLevel, {
      "damage3",
      self.tbCharDamage[3] ~= nil and tostring(self.tbCharDamage[3].nDamage) or "0"
    })
    NovaAPI.UserEventUpload("traveler_duel_battle", tabUpLevel)
    if bSuccess then
      self:PlaySuccessPerform(bNewRecord, 3, nTime)
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.TDBattleResultPanel, false, {
        false,
        false,
        false
      }, {}, {}, {}, 0, false, nTime, self.nlevelId, self.tbCharId, self.tbAffixes, 0, 0, 0, bNewRecord, {}, {}, {}, self.tbCharDamage)
      self.parent:LevelEnd()
    end
  end
  
  local function wait()
    self.parent:SettleBattle(bSuccess, self.nlevelId, nTime, self.tbAffixes, self.mapBuildData.nBuildId, msgCallback)
  end
  
  if bSuccess then
    TimerManager.Add(1, 2, self, wait, true, true, nil, nil)
  else
    wait()
  end
end

function TravelerDuelLevelData:OnEvent_AbandonBattle()
  self:OnEvent_LevelResult(false, 0)
end

function TravelerDuelLevelData:OnEvent_AdventureModuleEnter()
  PlayerData.Achievement:SetSpecialBattleAchievement(GameEnum.levelType.TravelerDuel)
  EventManager.Hit(EventId.OpenPanel, PanelId.TDBattlePanel, self.tbCharId, self.nlevelId)
  self:SetPersonalPerk()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(nCharId, idx == 1, self.tbDiscId)
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function TravelerDuelLevelData:BindEvent()
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

function TravelerDuelLevelData:UnBindEvent()
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

function TravelerDuelLevelData:SetPersonalPerk()
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

function TravelerDuelLevelData:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Build:GetBuildDiscInfoInBuild(self.mapBuildData.nBuildId, nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function TravelerDuelLevelData:PlaySuccessPerform(bNewRecord, nStar, nTime)
  local function func_OpenResult(bSuccess)
  end
  
  local tbChar = self.tbCharId
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    local nFloorId = ConfigTable.GetData("TravelerDuelBossLevel", self.nlevelId).FloorId
    local nType = ConfigTable.GetData("TravelerDuelFloor", nFloorId).Theme
    local sName = ConfigTable.GetData("EndSceneType", nType).EndSceneName
    local tbSkin = {}
    for _, nCharId in ipairs(tbChar) do
      local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
      table.insert(tbSkin, nSkinId)
    end
    CS.AdventureModuleHelper.PlaySettlementPerform(sName, "", tbSkin, func_OpenResult)
  end
  
  local function openBattleResultPanel()
    EventManager.Remove("SettlementPerformLoadFinish", self, openBattleResultPanel)
    EventManager.Hit(EventId.OpenPanel, PanelId.TDBattleResultPanel, true, {
      true,
      true,
      true
    }, {}, {}, {}, 0, false, nTime, self.nlevelId, self.tbCharId, self.tbAffixes, {}, {}, {}, bNewRecord, {}, {}, {}, self.tbCharDamage)
    self.bSettle = false
    self.parent:LevelEnd()
    self:UnBindEvent()
  end
  
  EventManager.Add("SettlementPerformLoadFinish", self, openBattleResultPanel)
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
  CS.AdventureModuleHelper.LevelStateChanged(true)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleResultMask)
end

function TravelerDuelLevelData:CalCharFixedEffect(nCharId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Build:CalBuildCharacterAttrBattle(self.mapBuildData.nBuildId, nCharId, self.tbCharTrialId and self.tbCharTrialId[nCharId], stActorInfo, bMainChar, tbDiscId)
  return stActorInfo
end

function TravelerDuelLevelData:OnEvnet_Pause()
  local nHard = 0
  for _, nAffixId in ipairs(self.tbAffixes) do
    local mapAffixCfgData = ConfigTable.GetData("TravelerDuelChallengeAffix", nAffixId)
    if mapAffixCfgData ~= nil then
      nHard = nHard + mapAffixCfgData.Difficulty
    end
  end
  EventManager.Hit("OpenTDPause", self.nlevelId, self.tbCharId, nHard)
end

function TravelerDuelLevelData:OnEvent_UploadDodgeEvent(padMode)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tab, {"pad_mode", padMode})
  table.insert(tab, {
    "level_type",
    "TravelerDuel"
  })
  table.insert(tab, {
    "build_id",
    tostring(self.tmpBuildId)
  })
  table.insert(tab, {
    "level_id",
    tostring(self.nlevelId)
  })
  table.insert(tab, {
    "up_time",
    tostring(CS.ClientManager.Instance.serverTimeStamp)
  })
  NovaAPI.UserEventUpload("use_dodge_key", tab)
end

return TravelerDuelLevelData
