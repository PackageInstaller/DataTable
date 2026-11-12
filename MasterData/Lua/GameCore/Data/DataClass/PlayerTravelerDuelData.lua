local PlayerTravelerDuelData = class("PlayerTravelerDuelData")

function PlayerTravelerDuelData:Init()
  self.rankingRefreshTime = 610
  self.bClassChange = false
  self.oldLevel = 0
  self.oldExp = 0
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  self.bHasData = false
  self.curLevel = nil
  self.nDuelLevel = 0
  self.selBuildId = 0
  self.nDuelExp = 0
  self.mapBossLevel = {}
  self.RankingData = {}
  self.SelfRankingData = {}
  self.LastRankingRefreshTime = 0
  self.UploadRemainTimes = 0
  self.mapCurChallenge = {
    bLock = false,
    nIdx = 0,
    nOpenTime = 0,
    nCloseTime = 0
  }
end

function PlayerTravelerDuelData:UnInit()
  EventManager.Remove(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function PlayerTravelerDuelData:CacheTravelerDuelData(mapDuelData)
  self.nDuelLevel = mapDuelData.DuelLevel
  self.nDuelExp = mapDuelData.DuelExp
  self.WeeklyAwardTimes = mapDuelData.WeeklyAwardTimes
  self:CacheTravelerDuelLevelData(mapDuelData)
  self.mapCurChallenge.bUnlock = mapDuelData.Challenge.Unlock
  if mapDuelData.Challenge.Id == 0 then
    printError("season idx == 0")
  else
    self.mapCurChallenge.nIdx = mapDuelData.Challenge.Id
  end
  self.mapCurChallenge.nOpenTime = mapDuelData.Challenge.OpenTime
  self.mapCurChallenge.nCloseTime = mapDuelData.Challenge.CloseTime
  PlayerData.Quest:CacheAllQuest(mapDuelData.Quests.List)
end

function PlayerTravelerDuelData:CacheTravelerDuelLevelData(mapDuelData)
  for _, mapBossLevel in ipairs(mapDuelData.Levels) do
    self.mapBossLevel[mapBossLevel.Id] = {
      nStar = mapBossLevel.Star,
      nLastBuildId = mapBossLevel.BuildId,
      nMaxDifficulty = mapBossLevel.Difficulty
    }
  end
end

function PlayerTravelerDuelData:CacheTravelerDuelRankingData(mapDuelData)
  self.SelfRankingData = mapDuelData.Self
  self.RankingData = mapDuelData.Rank
  self.LastRankingRefreshTime = mapDuelData.LastRefreshTime
  self.UploadRemainTimes = mapDuelData.UploadRemainTimes
  if self.SelfRankingData ~= nil then
    self.SelfRankingData.nRewardIdx = self:GetRewardIdx(self.SelfRankingData.Rank)
  end
  local nSelfuid = PlayerData.Base:GetPlayerId()
  for _, mapRankingData in ipairs(self.RankingData) do
    mapRankingData.nRewardIdx = self:GetRewardIdx(mapRankingData.Rank)
    mapRankingData.bSelf = nSelfuid == mapRankingData.Id
    mapRankingData.nBuildRank = self:GetBuildRank(mapRankingData.BuildScore)
    if mapRankingData.TitlePrefix == 0 then
      mapRankingData.TitlePrefix = 1
    end
    if mapRankingData.TitleSuffix == 0 then
      mapRankingData.TitleSuffix = 2
    end
  end
end

function PlayerTravelerDuelData:GetTDRankingData()
  return self.SelfRankingData, self.RankingData, self.LastRankingRefreshTime, self.UploadRemainTimes
end

function PlayerTravelerDuelData:GetTravelerDuelLevel()
  return self.nDuelLevel, self.nDuelExp
end

function PlayerTravelerDuelData:GetTravelerDuelChallenge()
  return self.mapCurChallenge
end

function PlayerTravelerDuelData:GetCachedBuildId(nLevelId)
  if self.selBuildId ~= 0 and self.selBuildId ~= nil then
    local ret = self.selBuildId
    return ret
  end
  if self.mapBossLevel[nLevelId] ~= nil then
    return self.mapBossLevel[nLevelId].nLastBuildId
  end
  return 0
end

function PlayerTravelerDuelData:SetCacheAffixids(tbAffixes, nBossId)
  if tbAffixes ~= nil then
    self.CachedAffixes = tbAffixes
    self.curCachedAffixesBoss = nBossId
  end
  self.CachedBossId = nBossId
end

function PlayerTravelerDuelData:GetCacheAffixids()
  return self.CachedAffixes, self.CachedBossId
end

function PlayerTravelerDuelData:SetSelBuildId(nBuildId)
  self.selBuildId = nBuildId
end

function PlayerTravelerDuelData:EnterTravelerDuel(nLevel, nBuildId, tbAffixes)
  if self.curLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Adventure.TravelerDuelLevel.TravelerDuelLevelData")
  if luaClass == nil then
    return
  end
  self.entryLevelId = nLevel
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, nLevel, tbAffixes, nBuildId)
  end
end

function PlayerTravelerDuelData:EnterTravelerDuelEditor(nLevel, tbChar, tbAffixes, tbDisc, tbNote)
  if self.curLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Adventure.TravelerDuelLevel.TravelerDuelLevelEditorData")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, nLevel, tbAffixes, tbChar, tbDisc, tbNote)
  end
end

function PlayerTravelerDuelData:LevelEnd()
  if type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.curLevel = nil
end

function PlayerTravelerDuelData:SendMsg_EnterTravelerDuel(nLevelId, nBuildId, tbAffixes)
  local msgData = {
    Id = nLevelId,
    BuildId = nBuildId,
    AffixIds = tbAffixes
  }
  
  local function Callback()
    if self.mapBossLevel[nLevelId] == nil then
      self.mapBossLevel[nLevelId] = {
        nStar = 0,
        nLastBuildId = 0,
        nMaxDifficulty = 0
      }
    end
    self.mapBossLevel[nLevelId].nLastBuildId = nBuildId
    self:EnterTravelerDuel(nLevelId, nBuildId, tbAffixes)
  end
  
  self.LevelId = nLevelId
  HttpNetHandler.SendMsg(NetMsgId.Id.traveler_duel_level_apply_req, msgData, nil, Callback)
end

function PlayerTravelerDuelData:SendMsg_UplodeTravelerDuelRanking(tbChar, Score, callback)
  local oldScore = 0
  local oldRank = 0
  if self.SelfRankingData ~= nil then
    oldScore = self.SelfRankingData.Score
  end
  local LocalData = require("GameCore.Data.LocalData")
  local sKey = LocalData.GetPlayerLocalData("TravelerDuelRecordKey")
  local bSuccess, nCheckSum = NovaAPI.GetRecorderKey(sKey)
  
  local function msgCallback(_, mapValue)
    if self.SelfRankingData == nil then
      self.SelfRankingData = {}
    end
    self.SelfRankingData.Chars = tbChar
    self.SelfRankingData.Score = Score
    self.SelfRankingData.Rank = mapValue.New
    oldRank = mapValue.Old
    self.UploadRemainTimes = self.UploadRemainTimes - 1
    local curIdx = -1
    local minLower = -1
    
    local function forEachReward(mapData)
      if self.SelfRankingData.Rank <= mapData.RankUpper and (minLower > mapData.RankUpper or minLower < 0) then
        curIdx = mapData.Id
        minLower = mapData.RankUpper
      end
    end
    
    ForEachTableLine(DataTable.TravelerDuelChallengeRankReward, forEachReward)
    if curIdx < 0 then
      curIdx = 4
    end
    self.SelfRankingData.nRewardIdx = curIdx
    EventManager.Hit(EventId.OpenPanel, PanelId.TravelerDuelRankUploadSuccess, oldScore, Score, oldRank, self.SelfRankingData.Rank, curIdx)
    if callback ~= nil and type(callback) == "function" then
      callback()
    end
    if bSuccess and mapValue.Token ~= nil and mapValue.Token ~= "" and sKey ~= nil and sKey ~= "" then
      NovaAPI.UploadStartowerFile(mapValue.Token, sKey)
      LocalData.SetPlayerLocalData("TravelerDuelRecordKey", "")
    else
      NovaAPI.DeleteRecFile(sKey)
    end
  end
  
  local tbSamples = UTILS.GetBattleSamples(sKey)
  HttpNetHandler.SendMsg(NetMsgId.Id.traveler_duel_rank_upload_req, {Sample = tbSamples, Checksum = nCheckSum}, nil, msgCallback)
end

function PlayerTravelerDuelData:SendMsg_TravelerDuelSettle(nStar, nLevelId, nTime, callback)
  local Events = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.TravelerDuel, 0 < nStar)
  local msgData = {
    Star = nStar,
    Time = nTime,
    Events = {List = Events}
  }
  
  local function Callback(_, netMsgData)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(netMsgData.Change)
    local nBossId = ConfigTable.GetData("TravelerDuelBossLevel", nLevelId).BossId
    if 0 < nStar then
      if self.nDuelLevel ~= netMsgData.DuelLevel then
        self.bClassChange = true
        self.oldLevel = self.nDuelLevel
        self.oldExp = self.nDuelExp
      end
      self.nDuelLevel = netMsgData.DuelLevel
      self.nDuelExp = netMsgData.DuelExp
      if self.mapBossLevel[nLevelId] == nil then
        self.mapBossLevel[nLevelId] = {
          nStar = nStar,
          nLastBuildId = 0,
          nMaxDifficulty = 0
        }
      else
        if 0 < self.mapBossLevel[nLevelId].nStar then
          self.WeeklyAwardTimes = self.WeeklyAwardTimes + 1
        end
        if nStar > self.mapBossLevel[nLevelId].nStar then
          self.mapBossLevel[nLevelId].nStar = nStar
        end
      end
    end
    if netMsgData.Affinities ~= nil then
      for k, v in pairs(netMsgData.Affinities) do
        PlayerData.Char:ChangeCharAffinityValue(v)
      end
    end
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    if callback ~= nil then
      callback(netMsgData)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.traveler_duel_level_settle_req, msgData, nil, Callback)
end

function PlayerTravelerDuelData:SendMsg_GetTravelerDuelRanking(callback)
  local function msgCallback()
    if callback ~= nil and type(callback) == "function" then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.traveler_duel_rank_req, {}, nil, msgCallback)
end

function PlayerTravelerDuelData:OnEvent_NewDay()
  self.bHasData = false
end

function PlayerTravelerDuelData:GetTravelerDuelData(callback)
  if self.bHasData and callback ~= nil then
    callback()
    return
  end
  
  local function Callback(_, netMsgData)
    self:CacheTravelerDuelData(netMsgData)
    local nCurChallengeBossId = 0
    local mapSeasonCfg = ConfigTable.GetData("TravelerDuelChallengeSeason", self.mapCurChallenge.nIdx)
    if mapSeasonCfg ~= nil then
      nCurChallengeBossId = mapSeasonCfg.BossId
    end
    if nCurChallengeBossId ~= self.curCachedAffixesBoss then
      self.CachedBossId = nil
      self.CachedAffixes = nil
      self.curCachedAffixesBoss = nil
    end
    self.bHasData = true
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.traveler_duel_info_req, {}, nil, Callback)
end

function PlayerTravelerDuelData:GetTravelerDuelLevelUnlock(nLevelId)
  if nLevelId == 0 then
    return false, 0
  end
  local mapBossLevel = ConfigTable.GetData("TravelerDuelBossLevel", nLevelId)
  if mapBossLevel == nil then
    return false, ConfigTable.GetUIText("RegusBoss_Unlock_Rank")
  end
  if mapBossLevel.PreLevelId ~= 0 then
    local bPreLevelId = self.mapBossLevel[mapBossLevel.PreLevelId] ~= nil and 0 < self.mapBossLevel[mapBossLevel.PreLevelId].nStar
    if not bPreLevelId then
      return false, ConfigTable.GetUIText("RegusBoss_Unlock_Rank")
    end
  end
  if mapBossLevel.UnlockWorldClass ~= 0 then
    local nCurWorldClass = PlayerData.Base:GetWorldClass()
    local bUnlockWorldClass = nCurWorldClass >= mapBossLevel.UnlockWorldClass
    if not bUnlockWorldClass then
      return false, orderedFormat(ConfigTable.GetUIText("TravelerDuel_Unlock_WorldClass"), mapBossLevel.UnlockWorldClass)
    end
  end
  if mapBossLevel.UnlockDuelLevel ~= 0 then
    local nDuelLevel = self.nDuelLevel
    local bDuelLevel = nDuelLevel >= mapBossLevel.UnlockDuelLevel
    if not bDuelLevel then
      return false, orderedFormat(ConfigTable.GetUIText("TravelerDuel_Unlock_DuelRank"), mapBossLevel.UnlockDuelLevel)
    end
  end
  return true, 0
end

function PlayerTravelerDuelData:GetTravelerDuelLevelRewardCount(nBossId)
  if self.WeeklyAwardTimes == nil then
    return 0
  end
  return self.WeeklyAwardTimes
end

function PlayerTravelerDuelData:GetTravelerDuelLevelStar(nLevelId)
  if self.mapBossLevel[nLevelId] == nil then
    return 0
  else
    return self.mapBossLevel[nLevelId].nStar
  end
end

function PlayerTravelerDuelData:GetTravelerDuelAffixUnlock(nAffixId)
  local mapAffixCfgData = ConfigTable.GetData("TravelerDuelChallengeAffix", nAffixId)
  if mapAffixCfgData.UnlockWorldClass > 0 or 0 < mapAffixCfgData.UnlockDuelLevel or 0 < mapAffixCfgData.UnlockDifficulty then
    local nWorldClass = PlayerData.Base:GetWorldClass()
    if nWorldClass < mapAffixCfgData.UnlockWorldClass then
      return false, 1, mapAffixCfgData.UnlockWorldClass
    elseif mapAffixCfgData.UnlockDuelLevel > self.nDuelLevel then
      return false, 2, mapAffixCfgData.UnlockDuelLevel
    else
      return false, 3, mapAffixCfgData.UnlockDifficulty
    end
  else
    return true, 0, 0
  end
end

function PlayerTravelerDuelData:GetTravelerChallengeUnlock()
  local nNeedWorldLevel = 0
  local nNeedDuelLevel = 0
  local mapOpenFunc = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.TravelerDuelChallenge)
  if mapOpenFunc ~= nil then
    nNeedWorldLevel = mapOpenFunc.NeedWorldClass
    nNeedDuelLevel = 0
  end
  local nDuelLevel = self.nDuelLevel
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local sDesc = ""
  if nNeedWorldLevel > nWorldClass then
    sDesc = orderedFormat(ConfigTable.GetUIText("TD_Lock_WorldClass"), nNeedWorldLevel)
  elseif nNeedDuelLevel > nDuelLevel then
    sDesc = orderedFormat(ConfigTable.GetUIText("TD_Lock_DuelLevel"), nNeedDuelLevel)
  end
  return nNeedWorldLevel <= nWorldClass and nNeedDuelLevel <= nDuelLevel, sDesc
end

function PlayerTravelerDuelData:GetCurLevel()
  if self.curLevel == nil then
    return 0
  end
  return self.curLevel.nlevelId
end

function PlayerTravelerDuelData:TryOpenTDUpgradePanel(callback)
  if self.bClassChange then
    EventManager.Hit(EventId.OpenPanel, PanelId.TDLevelUpgrade, callback)
    self.bClassChange = false
  end
end

function PlayerTravelerDuelData:GetOldTDLevelData()
  return self.oldLevel, self.oldExp
end

function PlayerTravelerDuelData:GetBuildRank(nScore)
  local curIdx = -1
  local minLower = -1
  if curIdx < 0 then
    curIdx = 1
  end
  return curIdx
end

function PlayerTravelerDuelData:GetRewardIdx(nScore)
  local curIdx = -1
  local minLower = -1
  
  local function forEachReward(mapData)
    if nScore < mapData.RankUpper and (minLower > mapData.RankUpper or minLower < 0) then
      curIdx = mapData.Id - 1
      minLower = mapData.RankUpper
    end
  end
  
  ForEachTableLine(DataTable.TravelerDuelChallengeRankReward, forEachReward)
  if curIdx < 0 then
    curIdx = 4
  end
  return curIdx
end

return PlayerTravelerDuelData
