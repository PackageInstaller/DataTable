local VampireSurvivorLevelData = class("VampireSurvivorLevelData")
local mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  Vampire_Monster_DeclareDeath = "OnEvent_MonsterDied",
  Vampire_Drop = "OnEvent_LevelDrop",
  takeEffect = "OnEvent_TakeEffect",
  LevelStateChanged = "OnEvent_LevelResult",
  VampireSurvivor_Time = "OnEvent_Time",
  Vampire_Boss_Spawn = "OnEvent_BossSpawn",
  BattlePause = "OnEvent_BattlePause",
  BattleDepot = "OnEvent_OpenDepot",
  AbandonVampireSurvivor = "OnEvent_Abandon",
  VampireBattleSuccess = "OnEvent_BattleEnd",
  Kill_SpecialType = "OnEvent_EventTips",
  VampireAddFateCard = "OnEvent_AddFateCard"
}

function VampireSurvivorLevelData:Init(parent, nLevelId, nBuildId1, nBuildId2, tbEvent, tbReward, tbExReward)
  self.parent = parent
  self.nLevelId = nLevelId
  self.floorId = 0
  self.nBuildId1 = nBuildId1
  self.nBuildId2 = nBuildId2
  self.isFirstHalf = true
  self.mapActorInfo = {}
  self.mapLevel = {}
  self.nCurLevel = 1
  self.nCurExp = 0
  self.nCurTotalTime = 0
  self.nCurTotalTimeFateCard = 0
  self.nBossTime = 0
  self.bBoss = false
  self.bHandleFateCard = false
  self.nPendingLevelUp = 0
  self.bHandleChest = false
  self.tbChest = {}
  self.mapFateCard = {}
  self.mapFateCardEft = {}
  self.mapFateCardEftCount = {}
  self.mapFateCardTimeLimit = {}
  self.mapFateCardTheme = {}
  self.tbCharDamageSecond = {}
  self.tbCharDamageFirst = {}
  self.nFirstBossTime = 60
  self.bFirstHalfEnd = false
  self.bHalfBattle = false
  self.bBattleEnd = false
  self.cachedFirstFateCard = {
    mapFateCard = {},
    mapFateCardEft = {},
    mapFateCardEftCount = {},
    mapFateCardTimeLimit = {},
    mapFateCardTheme = {}
  }
  self.cachedFirstFateCard = {
    nCurLevel = self.nCurLevel,
    nCurExp = self.nCurExp,
    mapNextReward = self.mapNextReward,
    mapFateCard = clone(self.mapFateCard),
    mapFateCardEftCount = clone(self.mapFateCardEftCount),
    mapFateCardTimeLimit = clone(self.mapFateCardTimeLimit),
    mapFateCardTheme = clone(self.mapFateCardTheme),
    nCurTotalTimeFateCard = self.nCurTotalTimeFateCard,
    nScoreShow = self.nScoreShow
  }
  self.tbActivedTalentEft = parent:GetActivedTalentEft()
  local mapVampireLevelData = ConfigTable.GetData("VampireSurvivor", nLevelId)
  if mapVampireLevelData == nil then
    return
  end
  self.bHalfBattle = mapVampireLevelData.Mode == GameEnum.vampireSurvivorMode.Single
  local nFloorId = mapVampireLevelData.FloorId
  local mapVampireFloorData = ConfigTable.GetData("VampireFloor", nFloorId)
  if mapVampireFloorData ~= nil then
    local nPoolId = mapVampireFloorData.FirstHalfPoolId
    
    local function forEachPool(mapData)
      if mapData.PoolId == nPoolId and mapData.PoolType == GameEnum.poolType.Boss then
        self.nFirstBossTime = mapData.WaveKeepTime
      end
    end
    
    ForEachTableLine(DataTable.VampireFloor, forEachPool)
  end
  self.floorId = mapVampireLevelData.FloorId
  local nLevelGroup = mapVampireLevelData.LevelGroupId
  
  local function forEachExp(mapData)
    if mapData.GroupID == nLevelGroup then
      self.mapLevel[mapData.Level] = mapData.Exp
    end
  end
  
  ForEachTableLine(DataTable.VampireSurvivorLevel, forEachExp)
  local mapVampireFloorData = ConfigTable.GetData("VampireFloor", self.floorId)
  if mapVampireFloorData == nil then
    return
  end
  local tbWaveCount = mapVampireFloorData.WaveCount
  self.nBonusTime = 0
  self.tbBonusRank = {}
  self.tbBonusPower = {}
  local sBonusConfig = ConfigTable.GetConfigValue("VampireBonusConfig")
  if sBonusConfig ~= nil then
    local tbBonusConfig = decodeJson(sBonusConfig)
    if tbBonusConfig ~= nil then
      for _, tbData in ipairs(tbBonusConfig) do
        table.insert(self.tbBonusRank, tbData[1])
        table.insert(self.tbBonusPower, tbData[2])
      end
    end
  end
  local sBonusTime = ConfigTable.GetConfigValue("VampireBonusTime")
  if sBonusTime ~= nil then
    local nTime = tonumber(sBonusTime)
    if nTime ~= nil then
      self.nBonusTime = nTime
    end
  end
  self.nScoreShow = 0
  self.tbFirstHalfEventType1 = {}
  self.tbFirstHalfEventType2 = {}
  self.tbSecondHalfEventType1 = {}
  self.tbSecondHalfEventType2 = {}
  self.tbFirstHalfCount = {}
  self.tbSecondHalfCount = {}
  self.tbBonusKillFirstHalf = {}
  self.tbBonusKillEliteFirstHalf = {}
  self.tbBonusKill = {
    0,
    0,
    0
  }
  self.tbBonusKillElite = {
    0,
    0,
    0
  }
  self.nCurBonusCount = 0
  self.nBonusExpireTime = 0
  self.nMonsterCount = 0
  self.nEliteMonsterCount = 0
  self.nLordCount = 0
  self.nBossCount = 0
  self.mapNextReward = tbReward
  self.mapExReward = tbExReward
  for _, mapEvent in ipairs(tbEvent) do
    if mapEvent.EventType == 1 then
      for _, nWave in ipairs(mapEvent.Numbers) do
        if 0 <= tbWaveCount[1] - nWave then
          table.insert(self.tbFirstHalfEventType1, nWave)
        else
          table.insert(self.tbSecondHalfEventType1, nWave - tbWaveCount[1])
        end
      end
    else
      for _, nWave in ipairs(mapEvent.Numbers) do
        if 0 <= tbWaveCount[1] - nWave then
          table.insert(self.tbFirstHalfEventType2, nWave)
        else
          table.insert(self.tbSecondHalfEventType2, nWave - tbWaveCount[1])
        end
      end
    end
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
    self.tbPotentials = self.mapBuildData.tbPotentials
    self.mapActorInfo = {}
    for idx, nTid in ipairs(self.tbCharId) do
      local stActorInfo = self:CalCharFixedEffect(nTid, idx == 1, self.tbDiscId)
      self.mapActorInfo[nTid] = stActorInfo
    end
    local tbActivedDropData = PlayerData.VampireSurvivor:GetActivedDropItem()
    CS.AdventureModuleHelper.EnterVampireFloor(self.floorId, self.tbCharId, true, self.tbFirstHalfEventType1, self.tbFirstHalfEventType2, self.bHalfBattle, tbActivedDropData)
    NovaAPI.EnterModule("AdventureModuleScene", true, 17)
    EventManager.Hit(EventId.OpenPanel, PanelId.VampireSurvivorBattlePanel, self.tbCharId, self.nLevelId, self.mapBuildData)
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId1)
end

function VampireSurvivorLevelData:InitReEnter(parent, nLevelId, nBuildId1, nBuildId2, tbEvent, tbReward, tbFateCard, mapClientData, mapFirst)
  self.parent = parent
  self.nLevelId = nLevelId
  self.floorId = 0
  self.nBuildId1 = nBuildId1
  self.nBuildId2 = nBuildId2
  self.isFirstHalf = false
  self.mapActorInfo = {}
  self.mapLevel = {}
  self.nCurLevel = mapClientData.Level
  self.nCurExp = mapClientData.Exp
  self.nCurTotalTime = 0
  self.nCurTotalTimeFateCard = mapClientData.FateCardTimer
  self.nBossTime = 0
  self.bBoss = false
  self.bHandleFateCard = false
  self.nPendingLevelUp = 0
  self.bHandleChest = false
  self.tbChest = {}
  self.mapFateCard = {}
  self.tbCharDamageSecond = {}
  self.tbCharDamageFirst = {}
  local mapFateCardTimeLimit = {}
  for _, mapLimit in pairs(mapClientData.Limits) do
    mapFateCardTimeLimit[mapLimit.Id] = mapLimit.TimeLimit
  end
  for _, nFateCardId in ipairs(tbFateCard) do
    local nTime = -1
    if mapFateCardTimeLimit[nFateCardId] ~= nil then
      nTime = mapFateCardTimeLimit[nFateCardId]
    end
    self.mapFateCard[nFateCardId] = nTime
  end
  self.mapFateCardEft = {}
  self.mapFateCardEftCount = {}
  for _, mapEft in pairs(mapClientData.Efts) do
    if self.mapFateCardEftCount[mapEft.EftId] == nil then
      self.mapFateCardEftCount[mapEft.EftId] = {}
    end
    self.mapFateCardEftCount[mapEft.EftId][mapEft.Id] = mapEft.Count
  end
  self.mapFateCardTimeLimit = {}
  for _, mapLimit in pairs(mapClientData.Limits) do
    if self.mapFateCardTimeLimit[mapLimit.TimeLimit] == nil then
      self.mapFateCardTimeLimit[mapLimit.TimeLimit] = {}
    end
    table.insert(self.mapFateCardTimeLimit[mapLimit.TimeLimit], mapLimit.Id)
  end
  self.mapFateCardTheme = {}
  
  local function AddFateCardTheme(nFateCardId)
    local mapFateCardCfgData = ConfigTable.GetData("FateCard", nFateCardId)
    if mapFateCardCfgData == nil then
      return
    end
    local operateType = 1
    if mapFateCardCfgData.ThemeType ~= GameEnum.fateCardTheme.NoType then
      local tbTriggerType = mapFateCardCfgData.ThemeTriggerType
      local nCurLevel
      if self.mapFateCardTheme[mapFateCardCfgData.ThemeType] ~= nil then
        nCurLevel = self.mapFateCardTheme[mapFateCardCfgData.ThemeType].nCurLevel
      end
      if nCurLevel == nil then
        operateType = 1
        if self.mapFateCardTheme[mapFateCardCfgData.ThemeType] == nil then
          self.mapFateCardTheme[mapFateCardCfgData.ThemeType] = {
            nCurLevel = 0,
            tbTriggerType = {}
          }
        end
        self.mapFateCardTheme[mapFateCardCfgData.ThemeType].nCurLevel = mapFateCardCfgData.ThemeValue
        self.mapFateCardTheme[mapFateCardCfgData.ThemeType].tbTriggerType = clone(tbTriggerType)
      elseif nCurLevel == GameEnum.fateCardThemeRank.Base and nCurLevel < mapFateCardCfgData.ThemeValue then
        operateType = 2
        self.mapFateCardTheme[mapFateCardCfgData.ThemeType].nCurLevel = mapFateCardCfgData.ThemeValue
        for _, triggerType in ipairs(tbTriggerType) do
          if 1 > table.indexof(self.mapFateCardTheme[mapFateCardCfgData.ThemeType].tbTriggerType, triggerType) then
            table.insert(self.mapFateCardTheme[mapFateCardCfgData.ThemeType].tbTriggerType, triggerType)
          end
        end
      elseif nCurLevel == GameEnum.fateCardThemeRank.ProA and mapFateCardCfgData.ThemeValue == GameEnum.fateCardThemeRank.ProB or nCurLevel == GameEnum.fateCardThemeRank.ProB and mapFateCardCfgData.ThemeValue == GameEnum.fateCardThemeRank.ProA then
        operateType = 2
        self.mapFateCardTheme[mapFateCardCfgData.ThemeType].nCurLevel = GameEnum.fateCardThemeRank.Super
        for _, triggerType in ipairs(tbTriggerType) do
          if 1 > table.indexof(self.mapFateCardTheme[mapFateCardCfgData.ThemeType].tbTriggerType, triggerType) then
            table.insert(self.mapFateCardTheme[mapFateCardCfgData.ThemeType].tbTriggerType, triggerType)
          end
        end
      else
        return
      end
    end
  end
  
  for _, nFateCardId in ipairs(tbFateCard) do
    AddFateCardTheme(nFateCardId)
  end
  self.nFirstBossTime = 60
  self.bFirstHalfEnd = true
  self.bHalfBattle = false
  self.bBattleEnd = false
  self.mapNextReward = tbReward
  self.cachedFirstFateCard = {
    nCurLevel = self.nCurLevel,
    nCurExp = self.nCurExp,
    mapNextReward = self.mapNextReward,
    mapFateCard = clone(self.mapFateCard),
    mapFateCardEftCount = clone(self.mapFateCardEftCount),
    mapFateCardTimeLimit = clone(self.mapFateCardTimeLimit),
    mapFateCardTheme = clone(self.mapFateCardTheme),
    nCurTotalTimeFateCard = self.nCurTotalTimeFateCard,
    nScoreShow = self.nScoreShow
  }
  self.tbActivedTalentEft = parent:GetActivedTalentEft()
  local mapVampireLevelData = ConfigTable.GetData("VampireSurvivor", nLevelId)
  if mapVampireLevelData == nil then
    return
  end
  self.bHalfBattle = mapVampireLevelData.Mode == GameEnum.vampireSurvivorMode.Single
  local nFloorId = mapVampireLevelData.FloorId
  local mapVampireFloorData = ConfigTable.GetData("VampireFloor", nFloorId)
  if mapVampireFloorData ~= nil then
    local nPoolId = mapVampireFloorData.FirstHalfPoolId
    
    local function forEachPool(mapData)
      if mapData.PoolId == nPoolId and mapData.PoolType == GameEnum.poolType.Boss then
        self.nFirstBossTime = mapData.WaveKeepTime
      end
    end
    
    ForEachTableLine(DataTable.VampireFloor, forEachPool)
  end
  self.floorId = mapVampireLevelData.FloorId
  local nLevelGroup = mapVampireLevelData.LevelGroupId
  
  local function forEachExp(mapData)
    if mapData.GroupID == nLevelGroup then
      self.mapLevel[mapData.Level] = mapData.Exp
    end
  end
  
  ForEachTableLine(DataTable.VampireSurvivorLevel, forEachExp)
  local mapVampireFloorData = ConfigTable.GetData("VampireFloor", self.floorId)
  if mapVampireFloorData == nil then
    return
  end
  local tbWaveCount = mapVampireFloorData.WaveCount
  self.nBonusTime = 0
  self.tbBonusRank = {}
  self.tbBonusPower = {}
  local sBonusConfig = ConfigTable.GetConfigValue("VampireBonusConfig")
  if sBonusConfig ~= nil then
    local tbBonusConfig = decodeJson(sBonusConfig)
    if tbBonusConfig ~= nil then
      for _, tbData in ipairs(tbBonusConfig) do
        table.insert(self.tbBonusRank, tbData[1])
        table.insert(self.tbBonusPower, tbData[2])
      end
    end
  end
  local sBonusTime = ConfigTable.GetConfigValue("VampireBonusTime")
  if sBonusTime ~= nil then
    local nTime = tonumber(sBonusTime)
    if nTime ~= nil then
      self.nBonusTime = nTime
    end
  end
  self.tbFirstHalfEventType1 = {}
  self.tbFirstHalfEventType2 = {}
  self.tbSecondHalfEventType1 = {}
  self.tbSecondHalfEventType2 = {}
  self.tbBonusKillFirstHalf = clone(self.tbBonusKill)
  self.tbBonusKillEliteFirstHalf = clone(self.tbBonusKillElite)
  self.tbFirstHalfCount = {}
  for i = 1, 3 do
    table.insert(self.tbFirstHalfCount, mapFirst.KillCount[i] or 0)
  end
  self.tbFirstHalfCount[4] = mapFirst.Time
  self.tbSecondHalfCount = {}
  self.tbBonusKillFirstHalf = {}
  for i = 5, 8 do
    table.insert(self.tbBonusKillFirstHalf, mapFirst.KillCount[i] or 0)
  end
  self.tbBonusKillEliteFirstHalf = {}
  for i = 9, 12 do
    table.insert(self.tbBonusKillEliteFirstHalf, mapFirst.KillCount[i] or 0)
  end
  self.tbBonusKill = {
    0,
    0,
    0
  }
  self.tbBonusKillElite = {
    0,
    0,
    0
  }
  self.nCurBonusCount = 0
  self.nBonusExpireTime = 0
  self.nMonsterCount = 0
  self.nEliteMonsterCount = 0
  self.nLordCount = 0
  self.nBossCount = 0
  self.mapExReward = {}
  self.nScoreShow = self:CalCurScore()
  for _, mapEvent in ipairs(tbEvent) do
    if mapEvent.EventType == 1 then
      for _, nWave in ipairs(mapEvent.Numbers) do
        if 0 <= tbWaveCount[1] - nWave then
          table.insert(self.tbFirstHalfEventType1, nWave)
        else
          table.insert(self.tbSecondHalfEventType1, nWave - tbWaveCount[1])
        end
      end
    else
      for _, nWave in ipairs(mapEvent.Numbers) do
        if 0 <= tbWaveCount[1] - nWave then
          table.insert(self.tbFirstHalfEventType2, nWave)
        else
          table.insert(self.tbSecondHalfEventType2, nWave - tbWaveCount[1])
        end
      end
    end
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
    self.tbPotentials = self.mapBuildData.tbPotentials
    self.mapActorInfo = {}
    for idx, nTid in ipairs(self.tbCharId) do
      local stActorInfo = self:CalCharFixedEffect(nTid, idx == 1, self.tbDiscId)
      self.mapActorInfo[nTid] = stActorInfo
    end
    local tbActivedDropData = PlayerData.VampireSurvivor:GetActivedDropItem()
    CS.AdventureModuleHelper.EnterVampireFloor(self.floorId, self.tbCharId, false, self.tbSecondHalfEventType1, self.tbSecondHalfEventType2, self.bHalfBattle, tbActivedDropData)
    NovaAPI.EnterModule("AdventureModuleScene", true, 17)
    EventManager.Hit(EventId.OpenPanel, PanelId.VampireSurvivorBattlePanel, self.tbCharId, self.nLevelId, self.mapBuildData)
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId2)
end

function VampireSurvivorLevelData:BindEvent()
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

function VampireSurvivorLevelData:UnBindEvent()
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

function VampireSurvivorLevelData:OnEvent_AdventureModuleEnter()
  PlayerData.Achievement:SetSpecialBattleAchievement(GameEnum.levelType.VampireInstance)
  EventManager.Hit("CacheInstanceHud", 100)
  self:ResetFateCardThemeInfo()
  self:SetPersonalPerk()
  self:SetDiscInfo()
  safe_call_cs_func(CS.AdventureModuleHelper.SetBuildLevel, self.mapBuildData.mapRank.Id)
  for nCharId, stActorInfo in pairs(self.mapActorInfo) do
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
  self:AddExp(0)
  EventManager.Hit("VampireScoreChange", self.nScoreShow)
  EventManager.Hit("VampireBonusExpire")
end

function VampireSurvivorLevelData:CalCharFixedEffect(nCharId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Build:CalBuildCharacterAttrBattle(self.mapBuildData.nBuildId, nCharId, self.tbCharTrialId and self.tbCharTrialId[nCharId], stActorInfo, bMainChar, tbDiscId)
  return stActorInfo
end

function VampireSurvivorLevelData:OpenFateCardSelect()
  local function SelectCallback(nIdx, nId, panelCallback, bReRoll, bReward)
    local function CheckChest()
      if #self.tbChest > 0 then
        local tbParam = table.remove(self.tbChest, 1)
        
        self:GetChest(tbParam[1], tbParam[2])
      end
    end
    
    if nIdx == -1 then
      local function wait()
        self.bHandleFateCard = false
        
        CheckChest()
      end
      
      cs_coroutine.start(wait)
      return
    end
    if nIdx == -2 then
      self.mapNextReward = nil
      self.nPendingLevelUp = self.nPendingLevelUp - 1
      
      local function wait()
        self.bHandleFateCard = false
        CheckChest()
      end
      
      cs_coroutine.start(wait)
      return
    end
    local msg = {}
    msg.Id = nId
    msg.SelectReq = {}
    if bReRoll then
      msg.ReRoll = true
    else
      msg.Index = nIdx - 1
    end
    if bReward then
      if self.nPendingLevelUp > 0 then
        panelCallback(1, self.mapNextReward.Pkg.Cards, {
          CanReRoll = 0 < self.mapNextReward.Pkg.ReRoll,
          ReRollPrice = self.mapNextReward.Pkg.ReRoll
        }, 0, false, self.mapFateCard)
      else
        panelCallback(0, {}, {
          CanReRoll = false,
          ReRollPrice = self.mapNextReward.Pkg.ReRoll
        }, 0, false, self.mapFateCard)
      end
      return
    end
    
    local function InteractiveCallback(_, callbackMsg)
      if callbackMsg.Resp ~= nil and callbackMsg.Resp.Reward ~= nil then
        self.mapNextReward = callbackMsg.Resp.Reward
        self.nPendingLevelUp = self.nPendingLevelUp - 1
        if self:AddFateCard(callbackMsg.Resp.FateCardId) then
          self:AddFateCardEft(callbackMsg.Resp.FateCardId)
          self:AddFateCardTheme(callbackMsg.Resp.FateCardId)
        end
        if callbackMsg.Resp.ExtraCards ~= nil and #callbackMsg.Resp.ExtraCards > 0 then
          panelCallback(1, callbackMsg.Resp.ExtraCards, {CanReRoll = false, ReRollPrice = 0}, 0, true, self.mapFateCard)
          for index, value in ipairs(callbackMsg.Resp.ExtraCards) do
            if self:AddFateCard(value.Id) then
              self:AddFateCardEft(value.Id)
              self:AddFateCardTheme(value.Id)
            end
          end
          return
        end
        if self.nPendingLevelUp > 0 then
          panelCallback(1, self.mapNextReward.Pkg.Cards, {
            CanReRoll = 0 < self.mapNextReward.Pkg.ReRoll,
            ReRollPrice = self.mapNextReward.Pkg.ReRoll
          }, 0, false, self.mapFateCard)
        else
          panelCallback(0, {}, {
            CanReRoll = false,
            ReRollPrice = self.mapNextReward.Pkg.ReRoll
          }, 0, false, self.mapFateCard)
        end
      elseif callbackMsg ~= nil then
        self.mapNextReward = callbackMsg
        panelCallback(1, self.mapNextReward.Pkg.Cards, {
          CanReRoll = 0 < self.mapNextReward.Pkg.ReRoll,
          ReRollPrice = self.mapNextReward.Pkg.ReRoll
        }, 0, false, self.mapFateCard)
      end
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_reward_select_req, msg, nil, InteractiveCallback)
  end
  
  if self.mapNextReward ~= nil then
    local nCoin = 0
    self.bHandleFateCard = true
    EventManager.Hit("VampireSelectFateCard", 1, self.mapNextReward.Pkg.Cards, SelectCallback, {
      CanReRoll = 0 < self.mapNextReward.Pkg.ReRoll,
      ReRollPrice = self.mapNextReward.Pkg.ReRoll
    }, 0, false, self.mapFateCard)
  end
end

function VampireSurvivorLevelData:OpenExFateCardSelect()
  local function SelectCallback(nIdx, nId, panelCallback, bReRoll)
    if nIdx == -1 then
      local function wait()
        self.bHandleFateCard = false
      end
      
      cs_coroutine.start(wait)
      return
    end
    if nIdx == -2 then
      self.mapExReward = nil
      
      local function wait()
        self.bHandleFateCard = false
      end
      
      cs_coroutine.start(wait)
      return
    end
    local msg = {}
    msg.Id = nId
    msg.SelectReq = {}
    if bReRoll then
      msg.ReRoll = true
    else
      msg.Index = nIdx - 1
    end
    
    local function InteractiveCallback(_, callbackMsg)
      self.mapExReward = nil
      panelCallback(0, {}, {}, {CanReRoll = false, ReRollPrice = 0}, 0, false, self.mapFateCard)
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_extra_reward_select_req, msg, nil, InteractiveCallback)
  end
  
  if self.mapExReward ~= nil then
    local nCoin = 0
    self.bHandleFateCard = true
    EventManager.Hit("VampireSelectFateCard", 1, self.mapExReward.Pkg.Cards, SelectCallback, {
      CanReRoll = 0 < self.mapExReward.ReRoll,
      ReRollPrice = self.mapExReward.ReRoll
    }, 0, false, self.mapFateCard)
  end
end

function VampireSurvivorLevelData:AddFateCard(nFateCardId)
  local mapFateCardCfgData = ConfigTable.GetData("FateCard", nFateCardId)
  if mapFateCardCfgData == nil then
    self.mapFateCard[nFateCardId] = 0
    return false
  end
  if mapFateCardCfgData == nil or mapFateCardCfgData.Duration == nil or mapFateCardCfgData.Duration == 0 then
    printError("FateCardCfgData Missing or no Duration Time:" .. nFateCardId)
    self.mapFateCard[nFateCardId] = 0
    return false
  end
  if mapFateCardCfgData.Duration == -1 then
    self.mapFateCard[nFateCardId] = -1
  else
    local limitTime = self.nCurTotalTimeFateCard + mapFateCardCfgData.Duration
    if self.mapFateCardTimeLimit[limitTime] == nil then
      self.mapFateCardTimeLimit[limitTime] = {}
    end
    table.insert(self.mapFateCardTimeLimit[limitTime], nFateCardId)
    self.mapFateCard[nFateCardId] = limitTime
  end
  local stFateCard = CS.Lua2CSharpInfo_FateCardInfo()
  stFateCard.fateCardId = nFateCardId
  stFateCard.Remain = 0
  stFateCard.Room = 0
  safe_call_cs_func(CS.AdventureModuleHelper.UpdateFateCardInfos, {stFateCard})
  return true
end

function VampireSurvivorLevelData:AddFateCardEft(nFateCardId)
  local mapFateCardCfgData = ConfigTable.GetData("FateCard", nFateCardId)
  if mapFateCardCfgData == nil then
    return
  end
  if self.mapFateCardEft[mapFateCardCfgData.ClientEffect] == nil then
    self.mapFateCardEft[mapFateCardCfgData.ClientEffect] = {
      nFateCardId = nFateCardId,
      tbEftUid = {}
    }
  end
  for _, nEftId in ipairs(mapFateCardCfgData.ClientExEffect) do
    if self.mapFateCardEft[nEftId] == nil then
      self.mapFateCardEft[nEftId] = {
        nFateCardId = nFateCardId,
        tbEftUid = {}
      }
    end
  end
  if mapFateCardCfgData.ClientEffect ~= 0 then
    local nRemainCount = mapFateCardCfgData.Count
    if 0 < nRemainCount then
      if self.mapFateCardEftCount[mapFateCardCfgData.ClientEffect] ~= nil then
        if self.mapFateCardEftCount[mapFateCardCfgData.ClientEffect][nFateCardId] == nil then
          self.mapFateCardEftCount[mapFateCardCfgData.ClientEffect][nFateCardId] = nRemainCount
        end
        nRemainCount = self.mapFateCardEftCount[mapFateCardCfgData.ClientEffect][nFateCardId]
        if nRemainCount < 1 then
          print("命运卡效果次数为0" .. nFateCardId)
          return
        end
      else
        self.mapFateCardEftCount[mapFateCardCfgData.ClientEffect] = {}
        self.mapFateCardEftCount[mapFateCardCfgData.ClientEffect][nFateCardId] = nRemainCount
      end
    end
    for _, nCharId in ipairs(self.tbCharId) do
      local nUid = UTILS.AddFateCardEft(nCharId, mapFateCardCfgData.ClientEffect, nRemainCount)
      table.insert(self.mapFateCardEft[mapFateCardCfgData.ClientEffect].tbEftUid, {nUid, nCharId})
      for _, nEftId in ipairs(mapFateCardCfgData.ClientExEffect) do
        local nUid = UTILS.AddFateCardEft(nCharId, nEftId, -1)
        table.insert(self.mapFateCardEft[nEftId].tbEftUid, {nUid, nCharId})
      end
    end
    print("添加命运卡效果：" .. nFateCardId)
  end
end

function VampireSurvivorLevelData:AddFateCardTheme(nFateCardId)
  local mapFateCardCfgData = ConfigTable.GetData("FateCard", nFateCardId)
  if mapFateCardCfgData == nil then
    return
  end
  local operateType = 1
  if mapFateCardCfgData.ThemeType ~= GameEnum.fateCardTheme.NoType then
    local tbTriggerType = mapFateCardCfgData.ThemeTriggerType
    local nCurLevel
    if self.mapFateCardTheme[mapFateCardCfgData.ThemeType] ~= nil then
      nCurLevel = self.mapFateCardTheme[mapFateCardCfgData.ThemeType].nCurLevel
    end
    if nCurLevel == nil then
      operateType = 1
      if self.mapFateCardTheme[mapFateCardCfgData.ThemeType] == nil then
        self.mapFateCardTheme[mapFateCardCfgData.ThemeType] = {
          nCurLevel = 0,
          tbTriggerType = {}
        }
      end
      self.mapFateCardTheme[mapFateCardCfgData.ThemeType].nCurLevel = mapFateCardCfgData.ThemeValue
      self.mapFateCardTheme[mapFateCardCfgData.ThemeType].tbTriggerType = clone(tbTriggerType)
    elseif nCurLevel == GameEnum.fateCardThemeRank.Base and nCurLevel < mapFateCardCfgData.ThemeValue then
      operateType = 2
      self.mapFateCardTheme[mapFateCardCfgData.ThemeType].nCurLevel = mapFateCardCfgData.ThemeValue
      for _, triggerType in ipairs(tbTriggerType) do
        if 1 > table.indexof(self.mapFateCardTheme[mapFateCardCfgData.ThemeType].tbTriggerType, triggerType) then
          table.insert(self.mapFateCardTheme[mapFateCardCfgData.ThemeType].tbTriggerType, triggerType)
        end
      end
    elseif nCurLevel == GameEnum.fateCardThemeRank.ProA and mapFateCardCfgData.ThemeValue == GameEnum.fateCardThemeRank.ProB or nCurLevel == GameEnum.fateCardThemeRank.ProB and mapFateCardCfgData.ThemeValue == GameEnum.fateCardThemeRank.ProA then
      operateType = 2
      self.mapFateCardTheme[mapFateCardCfgData.ThemeType].nCurLevel = GameEnum.fateCardThemeRank.Super
      for _, triggerType in ipairs(tbTriggerType) do
        if 1 > table.indexof(self.mapFateCardTheme[mapFateCardCfgData.ThemeType].tbTriggerType, triggerType) then
          table.insert(self.mapFateCardTheme[mapFateCardCfgData.ThemeType].tbTriggerType, triggerType)
        end
      end
    else
      return
    end
    local fcInfo = CS.Lua2CSharpInfo_FateCardThemeInfo()
    fcInfo.theme = mapFateCardCfgData.ThemeType
    fcInfo.rank = self.mapFateCardTheme[mapFateCardCfgData.ThemeType].nCurLevel
    fcInfo.triggerTypes = self.mapFateCardTheme[mapFateCardCfgData.ThemeType].tbTriggerType
    fcInfo.operateType = operateType
    safe_call_cs_func(CS.AdventureModuleHelper.SetFateCardThemes, {fcInfo})
  end
end

function VampireSurvivorLevelData:ResetFateCardThemeInfo()
  local tbFCInfo = {}
  for nThemeType, mapData in pairs(self.mapFateCardTheme) do
    local fcInfo = CS.Lua2CSharpInfo_FateCardThemeInfo()
    fcInfo.theme = nThemeType
    fcInfo.rank = mapData.nCurLevel
    fcInfo.triggerTypes = mapData.tbTriggerType
    fcInfo.operateType = 1
    table.insert(tbFCInfo, fcInfo)
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetFateCardThemes, tbFCInfo)
end

function VampireSurvivorLevelData:RemoveFateCardEft(nFateCardId)
  local mapFateCardCfgData = ConfigTable.GetData("FateCard", nFateCardId)
  if mapFateCardCfgData == nil then
    printError("FateCardCfgData Missing:" .. nFateCardId)
  else
    print("移除命运卡效果：" .. nFateCardId)
    local nEftId = mapFateCardCfgData.ClientEffect
    if self.mapFateCardEft[nEftId] ~= nil and self.mapFateCardEft[nEftId].tbEftUid ~= nil then
      for _, tbUid in ipairs(self.mapFateCardEft[nEftId].tbEftUid) do
        UTILS.RemoveEffect(tbUid[1], tbUid[2])
      end
      self.mapFateCardEft[nEftId] = nil
    end
    for _, nExEftId in ipairs(mapFateCardCfgData.ClientExEffect) do
      if self.mapFateCardEft[nExEftId] ~= nil and self.mapFateCardEft[nExEftId].tbEftUid ~= nil then
        for _, tbUid in ipairs(self.mapFateCardEft[nExEftId].tbEftUid) do
          UTILS.RemoveEffect(tbUid[1], tbUid[2])
        end
        self.mapFateCardEft[nExEftId] = nil
      end
    end
  end
end

function VampireSurvivorLevelData:AbandonBattle()
  local function netMsgCallback(_, msgData)
    local mapFirst = {}
    
    local mapSecond = {}
    local maplevelData = ConfigTable.GetData("VampireSurvivor", self.nLevelId)
    if maplevelData == nil then
      return
    end
    if self.isFirstHalf then
      local nBossCount = self.bFirstHalfEnd and 1 or 0
      local nBossTime = self.bFirstHalfEnd and self.nBossTime or 0
      local nBossScore = self.bFirstHalfEnd and maplevelData.BossScore1 or 0
      mapFirst.KillCount = {
        self.nMonsterCount,
        self.nEliteMonsterCount,
        self.nLordCount,
        nBossCount
      }
      mapFirst.KillScore = {
        self.nMonsterCount * maplevelData.NormalScore1,
        (self.nEliteMonsterCount + self.nLordCount) * maplevelData.EliteScore1,
        0,
        nBossScore
      }
      for i = 1, #self.tbBonusPower do
        table.insert(mapFirst.KillCount, self.tbBonusKill[i])
        table.insert(mapFirst.KillScore, math.floor((self.tbBonusKill[i] or 0) * ((self.tbBonusPower[i] - 100) / 100) * maplevelData.NormalScore1))
      end
      for i = 1, #self.tbBonusPower do
        table.insert(mapFirst.KillCount, self.tbBonusKillElite[i])
        table.insert(mapFirst.KillScore, math.floor((self.tbBonusKillElite[i] or 0) * ((self.tbBonusPower[i] - 100) / 100) * maplevelData.EliteScore1))
      end
      mapFirst.BossTime = nBossTime
      mapFirst.Score = msgData.Defeat.FinalScore
    else
      mapFirst.KillCount = {
        self.tbFirstHalfCount[1],
        self.tbFirstHalfCount[2],
        self.tbFirstHalfCount[3],
        1
      }
      mapFirst.KillScore = {
        self.tbFirstHalfCount[1] * maplevelData.NormalScore1,
        (self.tbFirstHalfCount[2] + self.tbFirstHalfCount[3]) * maplevelData.EliteScore1,
        0,
        maplevelData.BossScore1
      }
      for i = 1, #self.tbBonusPower do
        table.insert(mapFirst.KillCount, self.tbBonusKillFirstHalf[i] or 0)
        table.insert(mapFirst.KillScore, math.floor((self.tbBonusKillFirstHalf[i] or 0) * ((self.tbBonusPower[i] - 100) / 100) * maplevelData.NormalScore1))
      end
      for i = 1, #self.tbBonusPower do
        table.insert(mapFirst.KillCount, self.tbBonusKillEliteFirstHalf[i])
        table.insert(mapFirst.KillScore, math.floor((self.tbBonusKillEliteFirstHalf[i] or 0) * ((self.tbBonusPower[i] - 100) / 100) * maplevelData.EliteScore1))
      end
      mapFirst.BossTime = self.tbFirstHalfCount[4]
      local nTimeScore = math.floor((self.nFirstBossTime - self.tbFirstHalfCount[4]) / self.nFirstBossTime * maplevelData.TimeScore1)
      local nFinalScore = 0
      for _, nScore in ipairs(mapFirst.KillScore) do
        nFinalScore = nFinalScore + nScore
      end
      mapFirst.Score = nTimeScore + nFinalScore
      mapSecond.KillCount = {
        self.nMonsterCount,
        self.nEliteMonsterCount,
        self.nLordCount,
        0
      }
      mapSecond.KillScore = {
        self.nMonsterCount * maplevelData.NormalScore2,
        (self.nEliteMonsterCount + self.nLordCount) * maplevelData.EliteScore2,
        0,
        0
      }
      for i = 1, #self.tbBonusPower do
        table.insert(mapSecond.KillCount, self.tbBonusKill[i] or 0)
        table.insert(mapSecond.KillScore, math.floor((self.tbBonusKill[i] or 0) * ((self.tbBonusPower[i] - 100) / 100) * maplevelData.NormalScore2))
      end
      for i = 1, #self.tbBonusPower do
        table.insert(mapSecond.KillCount, self.tbBonusKillElite[i] or 0)
        table.insert(mapSecond.KillScore, math.floor((self.tbBonusKillElite[i] or 0) * ((self.tbBonusPower[i] - 100) / 100) * maplevelData.EliteScore2))
      end
      mapSecond.BossTime = 0
      mapSecond.Score = msgData.Defeat.FinalScore - mapFirst.Score
    end
    local mapLevelData = ConfigTable.GetData("VampireSurvivor", self.nLevelId)
    if mapLevelData ~= nil and mapLevelData.Type == GameEnum.vampireSurvivorType.Turn then
      self.parent:AddPointAndLevel(msgData.Defeat.FinalScore, 0, msgData.Defeat.SeasonId)
    end
    local nOldScore = PlayerData.VampireSurvivor:GetScoreByLevel(self.nLevelId)
    PlayerData.VampireSurvivor:CacheScoreByLevel(self.nLevelId, msgData.Defeat.FinalScore)
    self:OpenVampireSettle(false, mapFirst, mapSecond, msgData.Defeat.FinalScore, nOldScore < msgData.Defeat.FinalScore)
  end
  
  local nBossCount = 0
  local nBossTime = 0
  if self.isFirstHalf then
    self.tbCharDamageFirst = self:RefreshCharDamageData()
    nBossCount = self.bFirstHalfEnd and 1 or 0
    nBossTime = self.bFirstHalfEnd and self.nBossTime or 0
  elseif self.isFirstHalf == false and self.bHalfBattle == false then
    self.tbCharDamageSecond = self:RefreshCharDamageData()
  end
  local tbKillCount = {
    self.nMonsterCount,
    self.nEliteMonsterCount,
    self.nLordCount,
    nBossCount
  }
  for i = 1, #self.tbBonusPower do
    table.insert(tbKillCount, self.tbBonusKill[i] or 0)
  end
  for i = 1, #self.tbBonusPower do
    table.insert(tbKillCount, self.tbBonusKillElite[i] or 0)
  end
  local msg = {
    KillCount = tbKillCount,
    Time = nBossTime,
    Defeat = true,
    Events = {
      List = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.VampireInstance, false)
    }
  }
  HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_settle_req, msg, nil, netMsgCallback)
  self.bBattleEnd = true
end

function VampireSurvivorLevelData:BattleSuccess()
  local function netMsgCallback(_, msgData)
    self.parent:SetBattleSuccess()
    
    local mapLevelData = ConfigTable.GetData("VampireSurvivor", self.nLevelId)
    if mapLevelData ~= nil then
      if mapLevelData.Type == GameEnum.vampireSurvivorType.Turn then
        self.parent:AddPointAndLevel(msgData.Victory.FinalScore, self.nLevelId, msgData.Victory.SeasonId)
      else
        self.parent:AddPointAndLevel(0, self.nLevelId, msgData.Victory.SeasonId)
      end
    end
    local nOldScore = PlayerData.VampireSurvivor:GetScoreByLevel(self.nLevelId)
    PlayerData.VampireSurvivor:CacheScoreByLevel(self.nLevelId, msgData.Victory.FinalScore)
    self:OpenVampireSettle(true, msgData.Victory.Infos[1], msgData.Victory.Infos[2], msgData.Victory.FinalScore, nOldScore < msgData.Victory.FinalScore)
  end
  
  local tbKillCount = {
    self.nMonsterCount,
    self.nEliteMonsterCount,
    self.nLordCount,
    1
  }
  for i = 1, #self.tbBonusPower do
    table.insert(tbKillCount, self.tbBonusKill[i] or 0)
  end
  for i = 1, #self.tbBonusPower do
    table.insert(tbKillCount, self.tbBonusKillElite[i] or 0)
  end
  local msg = {
    KillCount = tbKillCount,
    Time = self.nBossTime,
    Defeat = false,
    Events = {
      List = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.VampireInstance, true)
    }
  }
  HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_settle_req, msg, nil, netMsgCallback)
  self.bBattleEnd = true
end

function VampireSurvivorLevelData:ChangeArea()
  local function netMsgCallback(_, msgData)
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
      self.isFirstHalf = false
      local tbActivedDropData = PlayerData.VampireSurvivor:GetActivedDropItem()
      CS.AdventureModuleHelper.EnterVampireFloor(self.floorId, self.tbCharId, self.isFirstHalf, self.tbSecondHalfEventType1, self.tbSecondHalfEventType2, false, tbActivedDropData)
      
      local function levelEndCallback()
        EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        self.bHandleFateCard = false
        self.nPendingLevelUp = 0
        self.nBossTime = 0
        self.nMonsterCount = 0
        self.nEliteMonsterCount = 0
        self.nLordCount = 0
        self.nBossCount = 0
        self.bBoss = false
        self.mapFateCardEft = {}
        self.bBattleEnd = false
        self.tbBonusKill = {}
        self.tbBonusKillElite = {}
        self.nCurBonusCount = 0
        self.nBonusExpireTime = 0
        self.nScoreShow = self:CalCurScore()
        EventManager.Hit("VampireScoreChange", self.nScoreShow)
        self.cachedFirstFateCard = {
          nCurLevel = self.nCurLevel,
          nCurExp = self.nCurExp,
          mapNextReward = self.mapNextReward,
          mapFateCard = clone(self.mapFateCard),
          mapFateCardEftCount = clone(self.mapFateCardEftCount),
          mapFateCardTimeLimit = clone(self.mapFateCardTimeLimit),
          mapFateCardTheme = clone(self.mapFateCardTheme),
          nCurTotalTimeFateCard = self.nCurTotalTimeFateCard,
          nScoreShow = self.nScoreShow
        }
        self:SetPersonalPerk()
        self:SetDiscInfo()
        self:ResetFateCardThemeInfo()
        safe_call_cs_func(CS.AdventureModuleHelper.SetBuildLevel, self.mapBuildData.mapRank.Id)
        for idx, nCharId in ipairs(self.tbCharId) do
          local stActorInfo, nHeartStoneLevel = self:CalCharFixedEffect(nCharId, idx == 1)
          safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
        end
      end
      
      EventManager.Hit("VampireSurvivorChangeArea", self.tbCharId, self.mapBuildData)
      EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
      NovaAPI.DispatchEventWithData("Level_Restart", nil, {})
      
      local function wait()
        PanelManager.InputEnable()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        CS.AdventureModuleHelper.LevelStateChanged(false)
      end
      
      cs_coroutine.start(wait)
    end
    
    PlayerData.Build:GetBuildDetailData(GetBuildCallback, self.nBuildId2)
  end
  
  local tbKillCount = {
    self.nMonsterCount,
    self.nEliteMonsterCount,
    self.nLordCount,
    1
  }
  for i = 1, #self.tbBonusPower do
    table.insert(tbKillCount, self.tbBonusKill[i] or 0)
  end
  for i = 1, #self.tbBonusPower do
    table.insert(tbKillCount, self.tbBonusKillElite[i] or 0)
  end
  local tbFateCardEft = {}
  for nEftId, mapFateCardEft in pairs(self.mapFateCardEftCount) do
    for nFateCardId, nRemainCount in pairs(mapFateCardEft) do
      table.insert(tbFateCardEft, {
        Id = nFateCardId,
        EftId = nEftId,
        Count = nRemainCount
      })
    end
  end
  local tbFateCardTime = {}
  for nTimeLimit, tbFateCard in pairs(self.mapFateCardTimeLimit) do
    for _, nFateCardId in ipairs(tbFateCard) do
      table.insert(tbFateCardTime, {Id = nFateCardId, TimeLimit = nTimeLimit})
    end
  end
  local clientData = {
    Efts = tbFateCardEft,
    Limits = tbFateCardTime,
    FateCardTimer = self.nCurTotalTimeFateCard,
    Level = self.nCurLevel,
    Exp = self.nCurExp
  }
  local msg = {
    KillCount = tbKillCount,
    Time = self.nBossTime,
    Events = {
      List = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.VampireInstance, true)
    },
    ClientData = clientData
  }
  self.tbFirstHalfCount = {
    self.nMonsterCount,
    self.nEliteMonsterCount,
    self.nLordCount,
    self.nBossTime
  }
  self.tbBonusKillFirstHalf = clone(self.tbBonusKill)
  self.tbBonusKillEliteFirstHalf = clone(self.tbBonusKillElite)
  HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_area_change_req, msg, nil, netMsgCallback)
  self.bBattleEnd = true
end

function VampireSurvivorLevelData:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Build:GetBuildDiscInfoInBuild(self.mapBuildData.nBuildId, nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function VampireSurvivorLevelData:SetPersonalPerk()
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

function VampireSurvivorLevelData:BonusKill(nType)
  if self.nBonusTime == 0 then
    return
  end
  self.nBonusExpireTime = self.nCurTotalTime + self.nBonusTime
  self.nCurBonusCount = self.nCurBonusCount + 1
  EventManager.Hit("VampireBonusKill", self.nCurBonusCount)
  local nRank = 0
  if nType == 0 or nType == nil then
    return
  end
  for i = #self.tbBonusRank, 1, -1 do
    if self.nCurBonusCount >= self.tbBonusRank[i] then
      if nType == 1 then
        if self.tbBonusKill[i] == nil then
          self.tbBonusKill[i] = 0
        end
        self.tbBonusKill[i] = self.tbBonusKill[i] + 1
      else
        if self.tbBonusKillElite[i] == nil then
          self.tbBonusKillElite[i] = 0
        end
        self.tbBonusKillElite[i] = self.tbBonusKillElite[i] + 1
      end
      nRank = i
      break
    end
  end
  return nRank
end

function VampireSurvivorLevelData:ReTry()
  PanelManager.InputDisable()
  if self.isFirstHalf then
    local function NetCallback(_, netMsg)
      self.nCurLevel = 1
      
      self.nCurExp = 0
      self.nCurTotalTime = 0
      self.nCurTotalTimeFateCard = 0
      self.nBossTime = 0
      self.bBoss = false
      self.bHandleFateCard = false
      self.nPendingLevelUp = 0
      self.bHandleChest = false
      self.tbChest = {}
      self.mapFateCard = {}
      self.mapFateCardEft = {}
      self.mapFateCardEftCount = {}
      self.mapFateCardTimeLimit = {}
      self.mapFateCardTheme = {}
      self.nFirstBossTime = 60
      self.bFirstHalfEnd = false
      self.bBattleEnd = false
      self.tbFirstHalfEventType1 = {}
      self.tbFirstHalfEventType2 = {}
      self.tbSecondHalfEventType1 = {}
      self.tbSecondHalfEventType2 = {}
      self.tbFirstHalfCount = {}
      self.tbSecondHalfCount = {}
      self.tbBonusKillFirstHalf = {}
      self.tbBonusKill = {}
      self.tbBonusKillElite = {}
      self.nCurBonusCount = 0
      self.nBonusExpireTime = 0
      self.nScoreShow = 0
      self.nMonsterCount = 0
      self.nEliteMonsterCount = 0
      self.nLordCount = 0
      self.nBossCount = 0
      self.mapNextReward = netMsg.Reward
      self.mapExReward = netMsg.Select
      local mapVampireFloorData = ConfigTable.GetData("VampireFloor", self.floorId)
      if mapVampireFloorData == nil then
        return
      end
      local tbWaveCount = mapVampireFloorData.WaveCount
      for _, mapEvent in ipairs(netMsg.Events) do
        if mapEvent.EventType == 1 then
          for _, nWave in ipairs(mapEvent.Numbers) do
            if tbWaveCount[1] - nWave >= 0 then
              table.insert(self.tbFirstHalfEventType1, nWave)
            else
              table.insert(self.tbSecondHalfEventType1, nWave - tbWaveCount[1])
            end
          end
        else
          for _, nWave in ipairs(mapEvent.Numbers) do
            if tbWaveCount[1] - nWave >= 0 then
              table.insert(self.tbFirstHalfEventType2, nWave)
            else
              table.insert(self.tbSecondHalfEventType2, nWave - tbWaveCount[1])
            end
          end
        end
      end
      local tbActivedDropData = PlayerData.VampireSurvivor:GetActivedDropItem()
      CS.AdventureModuleHelper.EnterVampireFloor(self.floorId, self.tbCharId, true, self.tbFirstHalfEventType1, self.tbFirstHalfEventType2, self.bHalfBattle, tbActivedDropData)
      
      local function levelEndCallback()
        self:AddExp(0)
        EventManager.Hit("VampireScoreChange", self.nScoreShow)
        EventManager.Hit("VampireBonusExpire")
        EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        self:SetPersonalPerk()
        self:SetDiscInfo()
        self:ResetFateCardThemeInfo()
        safe_call_cs_func(CS.AdventureModuleHelper.SetBuildLevel, self.mapBuildData.mapRank.Id)
        for idx, nCharId in ipairs(self.tbCharId) do
          local stActorInfo, nHeartStoneLevel = self:CalCharFixedEffect(nCharId, idx == 1)
          safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
        end
      end
      
      EventManager.Hit("BattleRestart")
      EventManager.Hit("VampireSurvivorChangeArea", self.tbCharId, self.mapBuildData)
      EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
      NovaAPI.DispatchEventWithData("Level_Restart", nil, {})
      
      local function wait()
        PanelManager.InputEnable()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        CS.AdventureModuleHelper.LevelStateChanged(false)
      end
      
      cs_coroutine.start(wait)
    end
    
    local tbBuildId = {
      self.nBuildId1
    }
    if self.nBuildId2 > 0 then
      table.insert(tbBuildId, self.nBuildId2)
    end
    local tbBuilds = {}
    for _, nBuildId in ipairs(tbBuildId) do
      table.insert(tbBuilds, {
        Type = PlayerData.Build:IsUseTrialRuntime(nBuildId) and 2 or 1,
        BuildId = nBuildId
      })
    end
    local msg = {
      Id = self.nLevelId,
      Builds = tbBuilds
    }
    HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_apply_req, msg, nil, NetCallback)
  else
    local function NetCallback(_, netMsg)
      local tbActivedDropData = PlayerData.VampireSurvivor:GetActivedDropItem()
      
      CS.AdventureModuleHelper.EnterVampireFloor(self.floorId, self.tbCharId, self.isFirstHalf, self.tbSecondHalfEventType1, self.tbSecondHalfEventType2, false, tbActivedDropData, true)
      
      local function levelEndCallback()
        EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        self.nBossTime = 0
        self.nMonsterCount = 0
        self.nEliteMonsterCount = 0
        self.nLordCount = 0
        self.nBossCount = 0
        self.bBoss = false
        self.mapFateCardEft = {}
        self.bBattleEnd = false
        self.tbBonusKill = {}
        self.tbBonusKillElite = {}
        self.nCurBonusCount = 0
        self.nBonusExpireTime = 0
        self.nCurLevel = self.cachedFirstFateCard.nCurLevel
        self.nCurExp = self.cachedFirstFateCard.nCurExp
        self.mapNextReward = self.cachedFirstFateCard.mapNextReward
        self.mapFateCard = clone(self.cachedFirstFateCard.mapFateCard)
        self.mapFateCardEftCount = clone(self.cachedFirstFateCard.mapFateCardEftCount)
        self.mapFateCardTimeLimit = clone(self.cachedFirstFateCard.mapFateCardTimeLimit)
        self.mapFateCardTheme = clone(self.cachedFirstFateCard.mapFateCardTheme)
        self.nCurTotalTimeFateCard = clone(self.cachedFirstFateCard.nCurTotalTimeFateCard)
        self.nScoreShow = self:CalCurScore()
        self:AddExp(0)
        EventManager.Hit("VampireScoreChange", self.nScoreShow)
        EventManager.Hit("VampireBonusExpire")
        self:SetPersonalPerk()
        self:SetDiscInfo()
        self:ResetFateCardThemeInfo()
        safe_call_cs_func(CS.AdventureModuleHelper.SetBuildLevel, self.mapBuildData.mapRank.Id)
        for idx, nCharId in ipairs(self.tbCharId) do
          local stActorInfo, nHeartStoneLevel = self:CalCharFixedEffect(nCharId, idx == 1)
          safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
        end
      end
      
      EventManager.Hit("VampireSurvivorChangeArea", self.tbCharId, self.mapBuildData)
      EventManager.Hit("BattleRestart")
      EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
      NovaAPI.DispatchEventWithData("Level_Restart", nil, {})
      
      local function wait()
        PanelManager.InputEnable()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        CS.AdventureModuleHelper.LevelStateChanged(false)
      end
      
      cs_coroutine.start(wait)
    end
    
    local msg = {}
    HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_restart_req, msg, nil, NetCallback)
  end
  self.bHandleFateCard = false
  self.nPendingLevelUp = 0
end

function VampireSurvivorLevelData:CalCurScore()
  local nScore = 0
  local maplevelData = ConfigTable.GetData("VampireSurvivor", self.nLevelId)
  if maplevelData ~= nil then
    if self.isFirstHalf then
      local bonusKill = 0
      for nRank, nBonusCount in ipairs(self.tbBonusKill) do
        bonusKill = bonusKill + nBonusCount
        local nPower = self.tbBonusPower[nRank]
        if nPower == nil then
          nPower = 1
        end
        nScore = nScore + math.floor(nBonusCount * (nPower / 100) * maplevelData.NormalScore1)
      end
      nScore = nScore + math.max(self.nMonsterCount - bonusKill, 0) * maplevelData.NormalScore1
      local bonusKillElite = 0
      for nRank, nBonusCount in ipairs(self.tbBonusKillElite) do
        bonusKillElite = bonusKillElite + nBonusCount
        local nPower = self.tbBonusPower[nRank]
        if nPower == nil then
          nPower = 1
        end
        nScore = nScore + math.floor(nBonusCount * (nPower / 100) * maplevelData.EliteScore1)
      end
      nScore = nScore + math.max(self.nEliteMonsterCount - bonusKillElite, 0) * maplevelData.EliteScore1
      nScore = nScore + self.nLordCount * maplevelData.EliteScore1
      if self.bFirstHalfEnd then
        nScore = nScore + maplevelData.BossScore1
        local nTimeScore = math.floor((self.nFirstBossTime - self.nBossTime) / self.nFirstBossTime * maplevelData.TimeScore1)
        nScore = nScore + nTimeScore
      end
    else
      local bonusKill = 0
      for nRank, nBonusCount in ipairs(self.tbBonusKillFirstHalf) do
        bonusKill = bonusKill + nBonusCount
        local nPower = self.tbBonusPower[nRank]
        if nPower == nil then
          nPower = 1
        end
        nScore = nScore + math.floor(nBonusCount * (nPower / 100) * maplevelData.NormalScore1)
      end
      nScore = nScore + math.max(self.tbFirstHalfCount[1] - bonusKill, 0) * maplevelData.NormalScore1
      local bonusKillElite = 0
      for nRank, nBonusCount in ipairs(self.tbBonusKillEliteFirstHalf) do
        bonusKillElite = bonusKillElite + nBonusCount
        local nPower = self.tbBonusPower[nRank]
        if nPower == nil then
          nPower = 1
        end
        nScore = nScore + math.floor(nBonusCount * (nPower / 100) * maplevelData.EliteScore1)
      end
      nScore = nScore + math.max(self.tbFirstHalfCount[2] - bonusKillElite, 0) * maplevelData.EliteScore1
      nScore = nScore + self.tbFirstHalfCount[3] * maplevelData.EliteScore1
      nScore = nScore + maplevelData.BossScore1
      bonusKill = 0
      for nRank, nBonusCount in ipairs(self.tbBonusKill) do
        bonusKill = bonusKill + nBonusCount
        local nPower = self.tbBonusPower[nRank]
        if nPower == nil then
          nPower = 1
        end
        nScore = nScore + math.floor(nBonusCount * (nPower / 100) * maplevelData.NormalScore2)
      end
      nScore = nScore + math.max(self.nMonsterCount - bonusKill, 0) * maplevelData.NormalScore2
      bonusKillElite = 0
      for nRank, nBonusCount in ipairs(self.tbBonusKillElite) do
        bonusKillElite = bonusKillElite + nBonusCount
        local nPower = self.tbBonusPower[nRank]
        if nPower == nil then
          nPower = 1
        end
        nScore = nScore + math.floor(nBonusCount * (nPower / 100) * maplevelData.EliteScore2)
      end
      nScore = nScore + math.max(self.nEliteMonsterCount - bonusKillElite, 0) * maplevelData.EliteScore2
      nScore = nScore + self.nLordCount * maplevelData.EliteScore2
      local nTimeScore = math.floor((self.nFirstBossTime - self.tbFirstHalfCount[4]) / self.nFirstBossTime * maplevelData.TimeScore1)
      nScore = nScore + nTimeScore
    end
    nScore = math.floor(nScore)
  end
  return nScore
end

function VampireSurvivorLevelData:OpenVampireSettle(bSuccess, mapFirstInfo, mapSecondInfo, nTotalScore, bNew)
  local nFateCardCount = 0
  for _, _ in pairs(self.mapFateCard) do
    nFateCardCount = nFateCardCount + 1
  end
  
  local function callback()
    local function levelEndCallback()
      EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
      
      self.parent:LevelEnd()
      NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
    end
    
    EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      PanelManager.InputEnable(nil, true)
      CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
    end
    
    cs_coroutine.start(wait)
  end
  
  if mapSecondInfo == nil then
    mapSecondInfo = {}
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.VampireSurvivorSettle, bSuccess, self.nLevelId, nFateCardCount, mapFirstInfo, mapSecondInfo, nTotalScore, bNew, callback, self.tbCharDamageFirst, self.tbCharDamageSecond)
end

function VampireSurvivorLevelData:OnEvent_LoadLevelRefresh()
  if self.mapExReward ~= nil and self.mapExReward.Ids ~= nil and #self.mapExReward.Ids > 0 then
    self:OpenExFateCardSelect()
  end
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetBuildAllEft(self.mapBuildData.nBuildId)
  safe_call_cs_func(CS.AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
  local tabFloorBuff = PlayerData.VampireSurvivor:GetFloorBuff(self.floorId, self.isFirstHalf)
  safe_call_cs_func(CS.AdventureModuleHelper.VampireFloorEffects, tabFloorBuff)
  for nFateCardId, nTime in pairs(self.mapFateCard) do
    if nTime ~= 0 then
      self:AddFateCardEft(nFateCardId)
    end
  end
  for _, nEftId in pairs(self.tbActivedTalentEft) do
    for _, nCharId in pairs(self.tbCharId) do
      UTILS.AddEffect(nCharId, nEftId, 0, 0)
    end
  end
  local tbFateCardInfo = {}
  for nId, _ in pairs(self.mapFateCard) do
    local stFateCard = CS.Lua2CSharpInfo_FateCardInfo()
    stFateCard.fateCardId = nId
    stFateCard.Remain = 0
    stFateCard.Room = 0
    table.insert(tbFateCardInfo, stFateCard)
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetFateCardInfos, tbFateCardInfo)
end

function VampireSurvivorLevelData:OnEvent_BattleEnd()
  self.bFirstHalfEnd = true
  self.nCurBonusCount = 0
  self.nBonusExpireTime = 0
  self.nScoreShow = math.floor(self:CalCurScore())
  EventManager.Hit("VampireScoreChange", self.nScoreShow)
  EventManager.Hit("VampireBonusExpire")
end

function VampireSurvivorLevelData:OnEvent_MonsterDied(nType)
  local nScore = 0
  local maplevelData = ConfigTable.GetData("VampireSurvivor", self.nLevelId)
  if maplevelData == nil then
    return
  end
  if nType == GameEnum.monsterEpicType.NORMAL then
    self.nMonsterCount = self.nMonsterCount + 1
    local nRank = self:BonusKill(1)
    local nPower = 1
    if nRank ~= 0 then
      nPower = self.tbBonusPower[nRank] / 100
    end
    nScore = (self.isFirstHalf and maplevelData.NormalScore1 or maplevelData.NormalScore2) * nPower
  elseif nType == GameEnum.monsterEpicType.ELITE then
    self.nEliteMonsterCount = self.nEliteMonsterCount + 1
    local nRank = self:BonusKill(2)
    local nPower = 1
    if nRank ~= 0 then
      nPower = self.tbBonusPower[nRank] / 100
    end
    nScore = (self.isFirstHalf and maplevelData.EliteScore1 or maplevelData.EliteScore2) * nPower
  elseif nType == GameEnum.monsterEpicType.LEADER then
    self:BonusKill()
    self.nLordCount = self.nLordCount + 1
    nScore = self.isFirstHalf and maplevelData.EliteScore1 or maplevelData.EliteScore2
  elseif nType == GameEnum.monsterEpicType.LORD then
    self:BonusKill()
    self.nBossCount = self.nBossCount + 1
    nScore = self.isFirstHalf and maplevelData.BossScore1 or maplevelData.BossScore2
  end
  self.nScoreShow = self.nScoreShow + nScore
  EventManager.Hit("VampireScoreChange", self.nScoreShow)
end

function VampireSurvivorLevelData:OnEvent_Time(nTime)
  if self.bBoss then
    self.nBossTime = self.nBossTime + 1
  else
    self.nCurTotalTimeFateCard = self.nCurTotalTimeFateCard + 1
    if self.mapFateCardTimeLimit[self.nCurTotalTimeFateCard] ~= nil then
      local tbRemoveFateCard = {}
      for _, nFateCardId in ipairs(self.mapFateCardTimeLimit[self.nCurTotalTimeFateCard]) do
        self:RemoveFateCardEft(nFateCardId)
        table.insert(tbRemoveFateCard, {nTid = nFateCardId, nCount = 0})
        if self.mapFateCard[nFateCardId] ~= nil then
          self.mapFateCard[nFateCardId] = 0
        end
      end
      EventManager.Hit("VampireFateCardTips", tbRemoveFateCard)
      self.mapFateCardTimeLimit[self.nCurTotalTimeFateCard] = nil
    end
  end
  self.nCurTotalTime = self.nCurTotalTime + 1
  if 0 < self.nBonusExpireTime and self.nBonusExpireTime <= self.nCurTotalTime then
    self.nCurBonusCount = 0
    self.nBonusExpireTime = 0
    EventManager.Hit("VampireBonusExpire")
  end
end

function VampireSurvivorLevelData:OnEvent_BattlePause()
  if self.bBattleEnd then
    return
  end
  local nScore = self:CalCurScore()
  EventManager.Hit("OpenVampirePause", self.nLevelId, self.tbCharId, self.nCurTotalTime, nScore)
end

function VampireSurvivorLevelData:OnEvent_Abandon()
  self:AbandonBattle()
  PanelManager.InputDisable()
end

function VampireSurvivorLevelData:OnEvent_BossSpawn()
  self.bBoss = true
end

function VampireSurvivorLevelData:OnEvent_OpenDepot()
  local mapFateCard = {}
  for nFateCardId, nTime in pairs(self.mapFateCard) do
    if 0 < nTime then
      mapFateCard[nFateCardId] = nTime - self.nCurTotalTimeFateCard
    else
      mapFateCard[nFateCardId] = nTime
    end
  end
  EventManager.Hit("VampireDepotOpen", mapFateCard, 1, 0)
end

function VampireSurvivorLevelData:OnEvent_TakeEffect(nCharId, EffectId)
  if self.mapFateCardEftCount[EffectId] ~= nil then
    local tbRemoveFateCard = {}
    for nFateCardId, nRemainCount in pairs(self.mapFateCardEftCount[EffectId]) do
      nRemainCount = nRemainCount - 1
      if nRemainCount < 1 then
        self:RemoveFateCardEft(nFateCardId)
        table.insert(tbRemoveFateCard, {nTid = nFateCardId, nCount = 0})
        if self.mapFateCard[nFateCardId] ~= nil then
          self.mapFateCard[nFateCardId] = 0
        end
      end
      self.mapFateCardEftCount[EffectId][nFateCardId] = nRemainCount
    end
    EventManager.Hit("VampireFateCardTips", tbRemoveFateCard)
  end
end

function VampireSurvivorLevelData:OnEvent_EventTips(nType, nMonsterId)
  nType = math.abs(nType)
  if nType < 1 or 4 < nType then
    return
  end
  EventManager.Hit("VampireEventTips", nType, nMonsterId)
end

function VampireSurvivorLevelData:OnEvent_LevelDrop(nType, nParam1, nParam2)
  if self.bBattleEnd then
    return
  end
  if nType == 1 then
    self:AddExp(nParam1)
  elseif nType == 2 then
    self:GetChest(nParam1, nParam2)
  end
end

function VampireSurvivorLevelData:AddExp(nExp)
  self.nCurExp = self.nCurExp + nExp
  if self.mapLevel[self.nCurLevel + 1] ~= nil and self.mapLevel[self.nCurLevel + 1] < self.nCurExp then
    while self.mapLevel[self.nCurLevel + 1] ~= nil and self.mapLevel[self.nCurLevel + 1] < self.nCurExp do
      self.nCurExp = self.nCurExp - self.mapLevel[self.nCurLevel + 1]
      self.nCurLevel = self.nCurLevel + 1
      self.nPendingLevelUp = self.nPendingLevelUp + 1
    end
  end
  local bMaxLevel = self.mapLevel[self.nCurLevel + 1] == nil
  local nAllExp = bMaxLevel and 0 or self.mapLevel[self.nCurLevel + 1]
  EventManager.Hit("Vampire_Exp_Change", self.nCurExp, nAllExp, self.nCurLevel, bMaxLevel)
  if self.nPendingLevelUp > 0 and not self.bHandleFateCard and not self.bHandleChest then
    self:OpenFateCardSelect()
  end
end

function VampireSurvivorLevelData:GetChest(nType, nWave)
  if self.bHandleChest or self.bHandleFateCard then
    table.insert(self.tbChest, {nType, nWave})
    return
  end
  if not self.isFirstHalf and -3 < nType then
    local mapVampireFloorData = ConfigTable.GetData("VampireFloor", self.floorId)
    if mapVampireFloorData == nil then
      return
    end
    local tbWaveCount = mapVampireFloorData.WaveCount
    nWave = nWave + tbWaveCount[1]
  end
  local mapRewardCard
  
  local function SelectCallback(nIdx, nId, panelCallback, bReRoll)
    if nIdx == -1 then
      local function wait()
        self.bHandleChest = false
        
        self:AddExp(0)
      end
      
      cs_coroutine.start(wait)
      return
    end
    if mapRewardCard ~= nil and 0 < #mapRewardCard then
      panelCallback(1, mapRewardCard, {CanReRoll = false, ReRollPrice = 0}, 0, true, self.mapFateCard)
      for index, value in ipairs(mapRewardCard) do
        if self:AddFateCard(value.Id) then
          self:AddFateCardEft(value.Id)
          self:AddFateCardTheme(value.Id)
        end
      end
      mapRewardCard = nil
      return
    end
    if 0 < #self.tbChest then
      local tbParam = table.remove(self.tbChest, 1)
      local msg = {
        EventType = 0 - tbParam[1],
        Number = tbParam[2]
      }
      
      local function netMsgCallback(_, msgData)
        if panelCallback ~= nil and type(panelCallback) == "function" then
          panelCallback(1, msgData.ChestCards, {CanReRoll = false, ReRollPrice = 0}, 0, true, self.mapFateCard)
        end
        for index, value in ipairs(msgData.ChestCards) do
          if self:AddFateCard(value.Id) then
            self:AddFateCardEft(value.Id)
            self:AddFateCardTheme(value.Id)
          end
        end
      end
      
      HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_reward_chest_req, msg, nil, netMsgCallback)
      return
    else
      if panelCallback ~= nil and type(panelCallback) == "function" then
        panelCallback(0, {}, {CanReRoll = false, ReRollPrice = 0}, 0, false, self.mapFateCard)
      end
      return
    end
  end
  
  local msg = {
    EventType = 0 - nType,
    Number = nWave
  }
  
  local function msgCallback(_, msgData)
    mapRewardCard = msgData.ExtraCards
    EventManager.Hit("VampireSelectFateCard", 1, msgData.ChestCards, SelectCallback, {CanReRoll = false, ReRollPrice = 0}, 0, true, self.mapFateCard)
    for index, value in ipairs(msgData.ChestCards) do
      if self:AddFateCard(value.Id) then
        self:AddFateCardEft(value.Id)
        self:AddFateCardTheme(value.Id)
      end
    end
  end
  
  self.bHandleChest = true
  HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_reward_chest_req, msg, nil, msgCallback)
  EventManager.Hit("VampireSelectFateCard", 1, {}, SelectCallback, {CanReRoll = false, ReRollPrice = 0}, 0, true, self.mapFateCard)
end

function VampireSurvivorLevelData:RefreshCharDamageData()
  local tbCharDamage = UTILS.GetCharDamageResult(self.tbCharId)
  return tbCharDamage
end

function VampireSurvivorLevelData:OnEvent_LevelResult(nState)
  if nState == 1 then
    local function ConfirmCallback()
      PanelManager.InputEnable()
      
      self:ReTry()
    end
    
    local function CancelCallback()
      self:AbandonBattle()
    end
    
    local data = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("Startower_ReBattleHint"),
      sContentSub = "",
      callbackConfirm = ConfirmCallback,
      callbackCancel = CancelCallback
    }
    EventManager.Hit(EventId.OpenMessageBox, data)
  elseif self.bHalfBattle then
    self.tbCharDamageFirst = self:RefreshCharDamageData()
    self:BattleSuccess()
  elseif self.isFirstHalf then
    self.tbCharDamageFirst = self:RefreshCharDamageData()
    self:ChangeArea()
  else
    self.tbCharDamageSecond = self:RefreshCharDamageData()
    self:BattleSuccess()
  end
  EventManager.Hit("VampireBattleEnd")
  PanelManager.InputDisable()
end

function VampireSurvivorLevelData:OnEvent_AddFateCard(nFateCardId)
  if self:AddFateCard(nFateCardId) then
    self:AddFateCardEft(nFateCardId)
    self:AddFateCardTheme(nFateCardId)
  end
end

return VampireSurvivorLevelData
