local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local TrekkerVersusData = class("TrekkerVersusData", ActivityDataBase)

function TrekkerVersusData:Init()
  self.nActId = 0
  self.nRecord = 0
  self.nLastBuildId = 0
  self.tbRecordAffix = {}
  self.tbRecordChar = {}
  self.nRecordBuildLevel = 0
  self.nCachedBuildId = 0
  self.mapQuests = {}
  self.CachedAffixes = {}
  self.bFirstIn = true
  self.nSuccessBattle = 0
  self.nLastBattleHard = 0
  self.nTimerIdleRefresh = 0
  self.bFirstBattlePlayed = false
  EventManager.Add("TrekkerVersusReceiveHeatQuest", self, self.RequestReceiveScheduleReward)
  EventManager.Add("TrekkerVersusFanGiftDataRefresh", self, self.OnEvent_TrekkerVersusFanGiftDataRefresh)
end

function TrekkerVersusData:GetActivityData()
  return {
    nActId = self.nActId,
    tbRecordAffix = clone(self.tbRecordAffix),
    tbRecordChar = clone(self.tbRecordChar),
    nRecordBuildLevel = self.nRecordBuildLevel,
    nLastBuildId = self.nLastBuildId,
    nRecord = self.nRecord
  }
end

function TrekkerVersusData:RefreshTrekkerVersusData(nActId, msgData)
  self:Init()
  self.nActId = nActId
  self.nDayNum = msgData.DayNum
  self.nFanLevel = msgData.Level
  self.nFanExp = msgData.Exp
  self.nIdleRewardStartTime = msgData.Show.IdleTime
  self.tbIdleReward = msgData.Show.IdleValues or {}
  self.nSelfHotValue = msgData.Show.SelfHotValue
  self.nRivalHotValue = msgData.Show.RivalHotValue
  self.tbHotValueRewardIds = msgData.HotValueRewardIds or {}
  self.tbDuelRewardIds = msgData.DuelRewardIds
  self.tbDuelHistory = msgData.Results
  self.bFirstBattlePlayed = self.nIdleRewardStartTime ~= nil and self.nIdleRewardStartTime > 0
  self.nLastBuildId = msgData.Build.BuildId
  self.nCachedBuildId = msgData.Build.BuildId
  self.nRecord = msgData.Show.Difficult or 0
  self.nRivalCount = 0
  
  local function foreachRival(mapData)
    if mapData.GroupId == self.nActId then
      self.nRivalCount = self.nRivalCount + 1
    end
  end
  
  ForEachTableLine(DataTable.TravelerDuelTarget, foreachRival)
  for _, mapQuest in ipairs(msgData.Quests) do
    self.mapQuests[mapQuest.Id] = mapQuest
  end
  self:RefreshQusetRedDot()
  PlayerData.State:RefreshTrekkerVersusIdleRewardRedDot()
end

function TrekkerVersusData:EnterTrekkerVersus(nActId, nLevelId, nBuildId, tbAffix)
  if nActId == nil or nActId == 0 then
    nActId = self.nActId
  end
  if nActId == 0 then
    printWarn("TrekkerVersusData:EnterTrekkerVersus nActId is 0, skip")
    return
  end
  
  local function callback()
    self:SetCachedBuildId(nBuildId)
    self:EnterGame(nLevelId, nBuildId, tbAffix)
  end
  
  local mapBuildData = PlayerData.Build:GetBuildData(nBuildId)
  local bTrial = mapBuildData.nBuildSource == AllEnum.BuildSource.Trial or mapBuildData.nBuildSource == AllEnum.BuildSource.LimitedTrial
  local nBuildType = bTrial and 2 or 1
  local msg = {
    ActivityId = nActId,
    LevelId = nLevelId,
    Build = {Type = nBuildType, BuildId = nBuildId},
    AffixIds = tbAffix
  }
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_trekker_versus_apply_req, msg, nil, callback)
end

function TrekkerVersusData:GetTravelerDuelAffixUnlock(nAffixId)
  local mapAffixCfgData = ConfigTable.GetData("TravelerDuelChallengeAffix", nAffixId)
  local curTimeStamp = CS.ClientManager.Instance.serverTimeStamp
  local _fixedTimeStamp = self.nOpenTime + mapAffixCfgData.UnlockDurationTime * 60
  if mapAffixCfgData.UnlockDurationTime > 0 and curTimeStamp < _fixedTimeStamp then
    local sCond = ""
    local sumTime = _fixedTimeStamp - curTimeStamp
    sCond = orderedFormat(ConfigTable.GetUIText("TDQuest_Day"), math.ceil(sumTime / 86400))
    return false, 4, sCond
  end
  if 0 < mapAffixCfgData.UnlockDifficulty and self.nRecord < mapAffixCfgData.UnlockDifficulty then
    return false, 3, mapAffixCfgData.UnlockDifficulty
  end
  return true, 0, 0
end

function TrekkerVersusData:GetCachedBuildId()
  return self.nCachedBuildId
end

function TrekkerVersusData:GetAllQuestData()
  local ret = {}
  for _, mapQuest in pairs(self.mapQuests) do
    table.insert(ret, mapQuest)
  end
  local statusOrder = {
    [0] = 1,
    [1] = 2,
    [2] = 0
  }
  
  local function sort(a, b)
    if a.Status == b.Status then
      return a.Id < b.Id
    end
    return statusOrder[a.Status] > statusOrder[b.Status]
  end
  
  table.sort(ret, sort)
  return ret
end

function TrekkerVersusData:CheckBattlePlayed()
  return self.bFirstBattlePlayed
end

function TrekkerVersusData:GetCurStreamerDuelData()
  local mapStreamerDuelCfgData = self:GetTrekkerVersusCfgData()
  local mapDuelData
  local nMaxDay = 1
  local mapLastData
  
  local function foreachDuel(mapData)
    if mapData.DayNum >= nMaxDay then
      nMaxDay = mapData.DayNum
      mapLastData = mapData
    end
    if mapData.GroupId == mapStreamerDuelCfgData.TargetGroupId and mapData.DayNum == self.nDayNum then
      mapDuelData = mapData
    end
  end
  
  ForEachTableLine(DataTable.TravelerDuelTarget, foreachDuel)
  if mapDuelData == nil then
    mapDuelData = mapLastData
  end
  return mapDuelData
end

function TrekkerVersusData:GetCurHeatValue()
  local nLastDuelResultHeatValue = 0
  if self.tbDuelHistory ~= nil and 0 < #self.tbDuelHistory then
    nLastDuelResultHeatValue = self.tbDuelHistory[#self.tbDuelHistory].SelfHotValue or 0
  end
  if nLastDuelResultHeatValue > self.nSelfHotValue then
    self.nSelfHotValue = nLastDuelResultHeatValue
    self.nRivalHotValue = self.tbDuelHistory[#self.tbDuelHistory].RivalHotValue or 0
  end
  local mapHeatData = {
    nSelfHotValue = self.nSelfHotValue or 0,
    nRivalHotValue = self.nRivalHotValue or 0
  }
  return mapHeatData
end

function TrekkerVersusData:GetCurDayNum()
  return self.nDayNum
end

function TrekkerVersusData:GetCurFanData()
  local mapFanData = {
    nFanLevel = self.nFanLevel or 0,
    nFanExp = self.nFanExp or 0
  }
  return mapFanData
end

function TrekkerVersusData:GetDuelHistory()
  table.sort(self.tbDuelHistory, function(a, b)
    return a.RivalHotValue > b.RivalHotValue
  end)
  return self.tbDuelHistory
end

function TrekkerVersusData:GetIdleReward()
  local tbIdleReward = {}
  local bAllZero = true
  
  local function foreachIdleReward(mapData)
    for k, v in pairs(self.tbIdleReward) do
      if v.TypeId == mapData.HotValueItemType then
        local nCount = math.floor(v.Value / mapData.CumulativeValue)
        if 1 <= nCount then
          bAllZero = false
        end
        table.insert(tbIdleReward, {
          Tid = mapData.Id,
          Qty = nCount
        })
        break
      end
    end
  end
  
  ForEachTableLine(DataTable.TravelerDuelHotValueItem, foreachIdleReward)
  if bAllZero then
    tbIdleReward = {}
  end
  return tbIdleReward
end

function TrekkerVersusData:GetIdleValue()
  return self.tbIdleReward or 0
end

function TrekkerVersusData:GetRecordLevel()
  return self.nRecord or 0
end

function TrekkerVersusData:GetIdleRewardStartTime()
  return self.nIdleRewardStartTime
end

function TrekkerVersusData:GetRivalCount()
  return self.nRivalCount or 0
end

function TrekkerVersusData:GetHotValueRewardTable()
  return self.tbHotValueRewardIds
end

function TrekkerVersusData:GetDuelRewardTable()
  return self.tbDuelRewardIds
end

function TrekkerVersusData:SetCachedBuildId(nBuildId)
  self.nCachedBuildId = nBuildId
end

function TrekkerVersusData:SetCacheAffixids(tbAffixes)
  if tbAffixes ~= nil then
    self.CachedAffixes = tbAffixes
  end
end

function TrekkerVersusData:GetCacheAffixids()
  return self.CachedAffixes
end

function TrekkerVersusData:EnterGame(nLevel, nBuildId, tbAffixes)
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

function TrekkerVersusData:SettleBattle(bSuccess, nLevelId, nTime, tbAffix, nBuildId, msgCallback)
  local function callback(_, msgData)
    local bNewRecord = false
    
    if bSuccess then
      local nRecordLevel = 0
      for _, nAffixId in ipairs(tbAffix) do
        local mapAffixCfgData = ConfigTable.GetData("TravelerDuelChallengeAffix", nAffixId)
        if mapAffixCfgData ~= nil then
          nRecordLevel = nRecordLevel + mapAffixCfgData.Difficulty
        end
      end
      if nRecordLevel >= self.nRecord then
        self.nRecord = nRecordLevel
        self.tbRecordAffix = clone(tbAffix)
        bNewRecord = true
        
        local function buildDataCallback(mapBuild)
          self.nRecordBuildLevel = mapBuild.nScore
          self.tbRecordChar = {}
          for _, mapBuildChar in ipairs(mapBuild.tbChar) do
            table.insert(self.tbRecordChar, mapBuildChar.nTid)
          end
        end
        
        PlayerData.Build:GetBuildDetailData(buildDataCallback, nBuildId)
      end
      self.nSuccessBattle = 1
      self.nLastBattleHard = nRecordLevel
      self.bFirstBattlePlayed = true
    else
      self.nSuccessBattle = -1
      local nRecordLevel = 0
      for _, nAffixId in ipairs(tbAffix) do
        local mapAffixCfgData = ConfigTable.GetData("TravelerDuelChallengeAffix", nAffixId)
        if mapAffixCfgData ~= nil then
          nRecordLevel = nRecordLevel + mapAffixCfgData.Difficulty
        end
      end
      self.nLastBattleHard = nRecordLevel
    end
    if msgData ~= nil and msgData.Show ~= nil then
      self.nIdleRewardStartTime = msgData.Show.IdleTime
      self.tbIdleReward = msgData.Show.IdleValues
    end
    if msgCallback ~= nil then
      msgCallback(bNewRecord)
    end
  end
  
  local msg = {
    ActivityId = self.nActId,
    Time = nTime,
    Passed = bSuccess,
    Events = {
      List = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.TravelerDuel, true)
    }
  }
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_trekker_versus_settle_req, msg, nil, callback)
end

function TrekkerVersusData:RequestIdleRefresh(nActId, callback)
  if nActId == nil or nActId == 0 then
    nActId = self.nActId
  end
  if nActId == 0 then
    printWarn("TrekkerVersusData:RequestIdleRefresh nActId is 0, skip")
    return
  end
  local nElapsedTime = CS.ClientManager.Instance.serverTimeStamp - self.nTimerIdleRefresh
  if nElapsedTime < 60 then
    if callback ~= nil then
      callback()
    end
    return
  end
  self.nTimerIdleRefresh = CS.ClientManager.Instance.serverTimeStamp
  
  local function cb(_, msgData)
    if msgData ~= nil then
      self.nDifficult = msgData.Difficulty
      self.tbIdleReward = msgData.IdleValues
      self.nSelfHotValue = msgData.SelfHotValue
      self.nRivalHotValue = msgData.RivalHotValue
      local bRedDotOn = false
      if self.tbIdleReward ~= nil and #self.tbIdleReward > 0 then
        local nPassedTime = CS.ClientManager.Instance.serverTimeStamp - self.nIdleRewardStartTime
        if nPassedTime >= 3600 * ConfigTable.GetConfigNumber("TrekkerVersusIdleRewardRedDotTime") then
          bRedDotOn = true
        end
      end
      local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
      if bInActGroup then
        RedDotManager.SetValid(RedDotDefine.TrekkerVersusIdleReward, {
          nActGroupId,
          self.nActId
        }, bRedDotOn)
      end
      PlayerData.State:RefreshTrekkerVersusIdleRewardRedDot(self.nIdleRewardStartTime)
      self:RefreshQusetRedDot()
      local mapHeatData = self:GetCurHeatValue()
      EventManager.Hit("UpdateTrekkerVersusHotValue", mapHeatData.nSelfHotValue, mapHeatData.nRivalHotValue)
      if callback ~= nil then
        callback(msgData)
      end
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_trekker_versus_idle_refresh_req, {Value = nActId}, nil, cb)
end

function TrekkerVersusData:RequestIdleRewardReceive(nActId, callback)
  if nActId == nil or nActId == 0 then
    nActId = self.nActId
  end
  if nActId == 0 then
    printWarn("TrekkerVersusData:RequestIdleRewardReceive nActId is 0, skip")
    return
  end
  local msg = {Value = nActId}
  
  local function cb(_, msgData)
    if msgData ~= nil then
      if msgData.Change ~= nil then
        local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(msgData.Change)
        HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
        UTILS.OpenReceiveByDisplayItem(msgData.AwardItems, msgData.ChangeInfo)
      end
      self.nIdleRewardStartTime = msgData.IdleTime
      for k, v in pairs(self.tbIdleReward) do
        v.Value = 0
      end
      PlayerData.State:RefreshTrekkerVersusIdleRewardRedDot(self.nIdleRewardStartTime)
      self:RefreshQusetRedDot()
      if callback ~= nil then
        callback(msgData)
      end
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_trekker_versus_idle_reward_receive_req, msg, nil, cb)
end

function TrekkerVersusData:RequestSendStreamerGift(nActId, tbGift, nAddHotValue, callback)
  if nActId == nil or nActId == 0 then
    nActId = self.nActId
  end
  if nActId == 0 then
    printWarn("TrekkerVersusData:RequestSendStreamerGift nActId is 0, skip")
    return
  end
  local msg = {ActivityId = nActId, Items = tbGift}
  
  local function cb(_, msgData)
    if msgData ~= nil then
      local nPrevFanLevel = self.nFanLevel
      local nPrevFanExp = self.nFanExp
      self.nFanLevel = msgData.Level
      self.nFanExp = msgData.Exp
      local nNowTime = CS.ClientManager.Instance.serverTimeStamp
      if msgData.SelfHotValue > self.nSelfHotValue then
        self.nSelfHotValue = msgData.SelfHotValue
      elseif nNowTime < self:GetChallengeEndTime() then
        self.nSelfHotValue = self.nSelfHotValue + nAddHotValue
      end
      self.nRivalHotValue = msgData.RivalHotValue
      local mapHeatData = self:GetCurHeatValue()
      EventManager.Hit("UpdateTrekkerVersusHotValue", mapHeatData.nSelfHotValue, mapHeatData.nRivalHotValue)
      if msgData.Change ~= nil then
        local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(msgData.Change)
        HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
      end
      self:RefreshQusetRedDot()
      if callback ~= nil then
        callback(msgData, nPrevFanLevel, nPrevFanExp)
      end
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_trekker_versus_rank_boost_req, msg, nil, cb)
end

function TrekkerVersusData:RequestReceiveScheduleReward(nActId, nScheduleType)
  if nActId == nil or nActId == 0 then
    nActId = self.nActId
  end
  if nActId == 0 then
    printWarn("TrekkerVersusData:RequestReceiveScheduleReward nActId is 0, skip")
    return
  end
  local msg = {ActivityId = nActId, ScheduleType = nScheduleType}
  
  local function callback(_, msgData)
    if msgData ~= nil then
      if msgData.Change ~= nil then
        local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(msgData.Change)
        HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
        UTILS.OpenReceiveByDisplayItem(msgData.AwardItems, msgData.ChangeInfo)
      end
      if nScheduleType == 1 then
        local function foreachHeatQuest(mapQuestData)
          if mapQuestData.GroupId == self.nActId and mapQuestData.TargetValue <= self.nSelfHotValue and table.indexof(self.tbHotValueRewardIds, mapQuestData.Id) <= 0 then
            table.insert(self.tbHotValueRewardIds, mapQuestData.Id)
          end
        end
        
        ForEachTableLine(DataTable.TravelerDuelHotValueRewards, foreachHeatQuest)
        self:RefreshQusetRedDot()
        EventManager.Hit("TrekkerVersusHeatQuestRefresh")
      elseif nScheduleType == 2 then
        for _, v in pairs(self.tbDuelHistory) do
          if table.indexof(self.tbDuelRewardIds, v.TargetId) <= 0 then
            table.insert(self.tbDuelRewardIds, v.TargetId)
          end
        end
        self:RefreshQusetRedDot()
        EventManager.Hit("TrekkerVersusDuelQuestRefresh")
      end
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_trekker_versus_schedule_reward_receive_req, msg, nil, callback)
end

function TrekkerVersusData:CheckBattleSuccess()
  local retResult = self.nSuccessBattle
  local retHard = self.nLastBattleHard
  self.nSuccessBattle = 0
  self.nLastBattleHard = 0
  return retResult, retHard
end

function TrekkerVersusData:LevelEnd()
  if type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.curLevel = nil
end

function TrekkerVersusData:RefreshQuestData(questData)
  self.mapQuests[questData.Id] = questData
  self:RefreshQusetRedDot()
end

function TrekkerVersusData:ReceiveQuestReward(nActId, callback)
  if nActId == nil or nActId == 0 then
    nActId = self.nActId
  end
  if nActId == 0 then
    printWarn("TrekkerVersusData:ReceiveQuestReward nActId is 0, skip")
    return
  end
  local bReceive = false
  for _, mapQuest in pairs(self.mapQuests) do
    if mapQuest.Status == 1 then
      bReceive = true
      break
    end
  end
  
  local function msgCallback(_, msgData)
    if msgData.Change ~= nil then
      local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(msgData.Change)
      HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
      UTILS.OpenReceiveByDisplayItem(msgData.AwardItems, msgData.ChangeInfo)
    end
    for _, mapQuest in pairs(self.mapQuests) do
      if mapQuest.Status == 1 then
        mapQuest.Status = 2
      end
    end
    self:RefreshQusetRedDot()
    EventManager.Hit("TrekkerVersusQuestRefresh")
    if callback ~= nil then
      callback(msgData)
    end
  end
  
  if bReceive then
    local msg = {Value = nActId}
    HttpNetHandler.SendMsg(NetMsgId.Id.activity_trekker_versus_reward_receive_req, msg, nil, msgCallback)
  else
    local sTip = ConfigTable.GetUIText("Quest_ReceiveNone")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
end

function TrekkerVersusData:GetTrekkerVersusCfgData()
  local mapCfgData = ConfigTable.GetData("TravelerDuelChallengeControl", self.nActId)
  return mapCfgData
end

function TrekkerVersusData:GetChallengeStartTime()
  local mapActivityData = ConfigTable.GetData("TravelerDuelChallengeControl", self.nActId)
  if mapActivityData ~= nil then
    return String2Time(mapActivityData.OpenTime)
  end
  return self.nOpenTime
end

function TrekkerVersusData:GetChallengeEndTime()
  local mapActivityData = ConfigTable.GetData("TravelerDuelChallengeControl", self.nActId)
  if mapActivityData ~= nil then
    return String2Time(mapActivityData.EndTime)
  end
  return self.nEndTime
end

function TrekkerVersusData:IsOpenStreamerDuel(nStartTime)
  local nowTime = CS.ClientManager.Instance.serverTimeStamp
  local nEndTime = CS.ClientManager.Instance:GetNextRefreshTime(nStartTime) + 86400 * (self.nRivalCount - 1)
  return nStartTime < nowTime and nowTime < nEndTime
end

function TrekkerVersusData:RefreshQusetRedDot()
  local bGiftQuestVisible = false
  local bBattleQuestVisible = false
  for _, mapQuest in pairs(self.mapQuests) do
    if mapQuest.Status == 1 then
      local mapQuestData = ConfigTable.GetData("TravelerDuelChallengeQuest", mapQuest.Id)
      if mapQuestData.CompleteCond == GameEnum.questCompleteCond.TrekkerVersusFansWithSpecificLevel then
        bGiftQuestVisible = true
      else
        bBattleQuestVisible = true
      end
    end
  end
  local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
  if bInActGroup then
    RedDotManager.SetValid(RedDotDefine.TrekkerVersusGiftQuest, {
      nActGroupId,
      self.nActId
    }, bGiftQuestVisible)
    RedDotManager.SetValid(RedDotDefine.TrekkerVersusBattleQuest, {
      nActGroupId,
      self.nActId
    }, bBattleQuestVisible)
  end
  local bStreamerDuelOpen = self:IsOpenStreamerDuel(self:GetChallengeStartTime())
  local nPassedDuelCount = bStreamerDuelOpen and self.nDayNum - 1 or self.nRivalCount
  if self.nDayNum == 0 then
    nPassedDuelCount = self.nRivalCount
  end
  local nReceivedDuelReward = #self.tbDuelRewardIds
  if bInActGroup then
    RedDotManager.SetValid(RedDotDefine.TrekkerVersusDuelQuest, {
      nActGroupId,
      self.nActId
    }, nPassedDuelCount > nReceivedDuelReward)
  end
  local bHeatQuestVisible = false
  
  local function foreachHeatReward(mapData)
    if mapData.GroupId == self.nActId and mapData.TargetValue <= self.nSelfHotValue and table.indexof(self.tbHotValueRewardIds, mapData.Id) <= 0 then
      bHeatQuestVisible = true
    end
  end
  
  ForEachTableLine(DataTable.TravelerDuelHotValueRewards, foreachHeatReward)
  if bInActGroup then
    RedDotManager.SetValid(RedDotDefine.TrekkerVersusHeatQuest, {
      nActGroupId,
      self.nActId
    }, bHeatQuestVisible)
  end
end

function TrekkerVersusData:GetCanReceiveAllQuestReward()
  for _, mapQuest in pairs(self.mapQuests) do
    if mapQuest.Status == 1 then
      return true
    end
  end
  return false
end

function TrekkerVersusData:GetFirstIn()
  local bFirst = self.bFirstIn
  if self.bFirstIn == true then
    self.bFirstIn = false
  end
  return bFirst
end

function TrekkerVersusData:OnEvent_TrekkerVersusFanGiftDataRefresh(nActId, nFanLevel, nExp)
  if nActId ~= self.nActId then
    return
  end
  self.nFanLevel = nFanLevel
  self.nFanExp = nExp
  EventManager.Hit("TrekkerVersusFanGiftShowRefresh")
end

return TrekkerVersusData
