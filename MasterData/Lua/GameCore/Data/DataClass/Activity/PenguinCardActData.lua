local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local PenguinCardActData = class("PenguinCardActData", ActivityDataBase)
local LocalData = require("GameCore.Data.LocalData")
local PenguinLevel_Normal = require("Game.UI.Play_PenguinCard.NormalMode.PenguinLevel_Normal")
local PenguinLevel_Endless = require("Game.UI.Play_PenguinCard.EndlessMode.PenguinLevel_Endless")
local ClientManager = CS.ClientManager.Instance
local RapidJson = require("rapidjson")
local tbGuideGroupId = {
  301,
  302,
  303
}

function PenguinCardActData:Init()
  self.mapLevelData = {}
  self.tbLevelList = {}
  self.mapQuestData = {}
  self.tbQuestList = {}
  self.tbQuestGroup = {}
  self.tbSkipNewLevel = {}
  self.tbNewLevel = {}
  self:ParseConfig()
end

function PenguinCardActData:ParseConfig()
  local function foreach_questGroupTable(data)
    if data.ActivityId == self.nActId then
      self.tbQuestList[data.Id] = {}
      
      table.insert(self.tbQuestGroup, data.Id)
    end
  end
  
  ForEachTableLine(DataTable.ActivityPenguinCardQuestGroup, foreach_questGroupTable)
  table.sort(self.tbQuestGroup, function(a, b)
    return a < b
  end)
  
  local function foreach_questTable(data)
    if self.tbQuestList[data.Group] ~= nil then
      table.insert(self.tbQuestList[data.Group], data.Id)
    end
  end
  
  ForEachTableLine(DataTable.ActivityPenguinCardQuest, foreach_questTable)
  for _, v in pairs(self.tbQuestList) do
    table.sort(v, function(a, b)
      return a < b
    end)
  end
  
  local function foreach_levelTable(data)
    if data.ActivityId == self.nActId then
      table.insert(self.tbLevelList, data.Id)
    end
  end
  
  ForEachTableLine(DataTable.ActivityPenguinCardLevel, foreach_levelTable)
  table.sort(self.tbLevelList, function(a, b)
    return a < b
  end)
  local sJson = LocalData.GetPlayerLocalData("PenguinCardLevel")
  local tb = decodeJson(sJson)
  if type(tb) == "table" then
    self.tbSkipNewLevel = tb
  end
end

function PenguinCardActData:RefreshPenguinCardActData(msgData)
  self:CacheLevelData(msgData.Levels)
  self:CacheQuestData(msgData.Quests)
end

function PenguinCardActData:RefreshQuestData(questData)
  self.mapQuestData[questData.Id] = self:CreateQuest(questData)
  self:RefreshQuestRedDot(questData.Id)
end

function PenguinCardActData:CacheQuestData(tbQuest)
  for _, v in ipairs(tbQuest) do
    self.mapQuestData[v.Id] = self:CreateQuest(v)
    self:RefreshQuestRedDot(v.Id)
  end
end

function PenguinCardActData:CreateQuest(mapQuestData)
  local tbQuestData = {}
  tbQuestData.nId = mapQuestData.Id
  if nil ~= mapQuestData.Progress[1] then
    tbQuestData.nCur = mapQuestData.Progress[1].Cur
    tbQuestData.nMax = mapQuestData.Progress[1].Max
  else
    tbQuestData.nCur = 0
    tbQuestData.nMax = self:GetQuestMaxProgress(mapQuestData.Id)
  end
  if mapQuestData.Status == 0 then
    tbQuestData.nStatus = AllEnum.ActQuestStatus.UnComplete
  elseif mapQuestData.Status == 1 then
    tbQuestData.nStatus = AllEnum.ActQuestStatus.Complete
  elseif mapQuestData.Status == 2 then
    tbQuestData.nStatus = AllEnum.ActQuestStatus.Received
  end
  if tbQuestData.nStatus == AllEnum.ActQuestStatus.Received then
    tbQuestData.nCur = tbQuestData.nMax
  end
  return tbQuestData
end

function PenguinCardActData:GetQuestMaxProgress(nId)
  local nMax = 0
  local mapCfg = ConfigTable.GetData("ActivityPenguinCardQuest", nId)
  if mapCfg then
    if mapCfg.FinishType == GameEnum.activityQuestCompleteCond.ActivityPenguinCardLevelPassedScore or mapCfg.FinishType == GameEnum.activityQuestCompleteCond.ActivityPenguinCardLevelPassedWithStar then
      nMax = 1
    else
      nMax = mapCfg.AimNumShow
    end
  end
  return nMax
end

function PenguinCardActData:GetQuestGroup()
  return self.tbQuestGroup
end

function PenguinCardActData:GetQuestbyGroupId(nGroupId)
  return self.tbQuestList[nGroupId]
end

function PenguinCardActData:GetQuestData(nId)
  if self.mapQuestData[nId] then
    return self.mapQuestData[nId]
  else
    return {
      nId = nId,
      nCur = 0,
      nMax = self:GetQuestMaxProgress(nId),
      nStatus = AllEnum.ActQuestStatus.UnComplete
    }
  end
end

function PenguinCardActData:GetGroupQuestReceiveCount(nGroupId)
  local nResult = 0
  if self.tbQuestList[nGroupId] == nil then
    return nResult
  end
  for _, nId in pairs(self.tbQuestList[nGroupId]) do
    if self.mapQuestData[nId] and self.mapQuestData[nId].nStatus == AllEnum.ActQuestStatus.Received then
      nResult = nResult + 1
    end
  end
  return nResult
end

function PenguinCardActData:GetAllQuestCount()
  local nResult = 0
  for _, v in pairs(self.tbQuestList) do
    nResult = nResult + #v
  end
  return nResult
end

function PenguinCardActData:GetAllReceivedCount()
  local nResult = 0
  for nGroupId, _ in pairs(self.tbQuestList) do
    nResult = nResult + self:GetGroupQuestReceiveCount(nGroupId)
  end
  return nResult
end

function PenguinCardActData:CacheLevelData(tbLevel)
  for _, v in ipairs(tbLevel) do
    self.mapLevelData[v.Id] = {
      nScore = v.Score,
      nStar = v.Star,
      nDifficulty = v.Difficulty,
      sData = v.Data
    }
  end
  self:RefreshLevelRedDot()
end

function PenguinCardActData:GetLevelList()
  return self.tbLevelList
end

function PenguinCardActData:CheckLevelLock(nLevelId)
  local bLock = self:CheckLevelLockByTime(nLevelId)
  if bLock == true then
    return bLock
  end
  bLock = self:CheckLevelLockByPrev(nLevelId)
  return bLock
end

function PenguinCardActData:CheckLevelLockByTime(nLevelId)
  local nRemain = self:GetLevelStartTime(nLevelId) - ClientManager.serverTimeStamp
  local bLock = 0 < nRemain
  return bLock, nRemain
end

function PenguinCardActData:CheckLevelLockByPrev(nLevelId)
  local mapCfg = ConfigTable.GetData("ActivityPenguinCardLevel", nLevelId)
  if not mapCfg then
    return true
  end
  local nPrev = mapCfg.Prev
  if nPrev == 0 then
    return false
  end
  local mapLevel = self.mapLevelData[nPrev]
  if mapLevel and 0 < mapLevel.nStar then
    return false
  end
  return true
end

function PenguinCardActData:CheckLevelSkipAble(nLevelId)
  local mapCfg = ConfigTable.GetData("ActivityPenguinCardLevel", nLevelId)
  if not mapCfg then
    return false
  end
  for _, nGroupId in ipairs(tbGuideGroupId) do
    if not PlayerData.Guide:CheckGuideFinishById(nGroupId) then
      return false
    end
  end
  local mapLevel = self:GetLevelData(nLevelId)
  local bComplete = false
  if mapCfg.Type == GameEnum.ActivityPenguinCardLevelType.Endless then
    bComplete = mapLevel.nScore > 0
  else
    bComplete = 0 < mapLevel.nStar
  end
  return mapCfg.Skip and not bComplete
end

function PenguinCardActData:CheckEndlessLevelUnlock()
  for _, nLevelId in ipairs(self.tbLevelList) do
    local mapCfg = ConfigTable.GetData("ActivityPenguinCardLevel", nLevelId)
    if mapCfg and mapCfg.Type == GameEnum.ActivityPenguinCardLevelType.Endless then
      local bLock = self:CheckLevelLock(nLevelId)
      if not bLock then
        return true
      end
    end
  end
  return false
end

function PenguinCardActData:GetLevelData(nId)
  return self.mapLevelData[nId] or {
    nScore = 0,
    nStar = 0,
    nDifficulty = 0,
    sData = ""
  }
end

function PenguinCardActData:GetLevelStartTime(nLevelId)
  local mapCfg = ConfigTable.GetData("ActivityPenguinCardLevel", nLevelId)
  if not mapCfg then
    return 0
  end
  local openActDayNextTime = ClientManager:GetNextRefreshTime(self.nOpenTime)
  local nTempDay = 0
  if openActDayNextTime > self.nOpenTime then
    nTempDay = 1
  end
  local nDay = (ClientManager.serverTimeStamp - openActDayNextTime) // 86400 + nTempDay
  if nDay >= mapCfg.Duration then
    return 0
  end
  local openDayNextTime = ClientManager:GetNextRefreshTime(ClientManager.serverTimeStamp)
  return openDayNextTime + (mapCfg.Duration - nDay - 1) * 86400
end

function PenguinCardActData:EnterLevel(nLevelId)
  local mapCfg = ConfigTable.GetData("ActivityPenguinCardLevel", nLevelId)
  if not mapCfg then
    return
  end
  local mapLevelData = self:GetLevelData(nLevelId)
  if mapCfg.Type == GameEnum.ActivityPenguinCardLevelType.Endless then
    local LevelData = PenguinLevel_Endless.new()
    LevelData:Init(mapCfg.FloorId, nLevelId, self.nActId, mapCfg.StarScore, mapLevelData.sData)
  elseif mapCfg.Type == GameEnum.ActivityPenguinCardLevelType.Normal then
    local LevelData = PenguinLevel_Normal.new()
    LevelData:Init(mapCfg.FloorId, nLevelId, self.nActId, mapCfg.StarScore)
  end
end

function PenguinCardActData:GetLevelDataBySave(sData)
  if sData == "" then
    return 0, 0, 0
  end
  local sAll = NovaAPIHotfix.DecompressString(sData)
  local mapData = RapidJson.decode(sAll)
  return mapData.nCacheStar, mapData.nCacheScore, mapData.nEndlessLevel
end

function PenguinCardActData:RefreshQuestRedDot(nId)
  local mapCfg = ConfigTable.GetData("ActivityPenguinCardQuest", nId)
  if not mapCfg then
    return
  end
  local mapQuest = self.mapQuestData[nId]
  RedDotManager.SetValid(RedDotDefine.Activity_PenguinCard_Quest, {
    mapCfg.Group,
    nId
  }, mapQuest.nStatus == AllEnum.ActQuestStatus.Complete)
end

function PenguinCardActData:RefreshLevelRedDot()
  self.tbNewLevel = {}
  for _, nId in ipairs(self.tbLevelList) do
    local bSkip = table.indexof(self.tbSkipNewLevel, nId) > 0
    if bSkip then
      RedDotManager.SetValid(RedDotDefine.Activity_PenguinCard_Level, {nId}, false)
      local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
      if bInActGroup then
        RedDotManager.SetValid(RedDotDefine.Activity_Group_PenguinCard_Level, {nActGroupId, nId}, false)
      end
    else
      local bLock = self:CheckLevelLock(nId)
      local bHasScore = self.mapLevelData[nId] and (0 < self.mapLevelData[nId].nScore or 0 < self.mapLevelData[nId].nStar)
      local bNew = not bLock and not bHasScore
      if bNew then
        table.insert(self.tbNewLevel, nId)
      end
      RedDotManager.SetValid(RedDotDefine.Activity_PenguinCard_Level, {nId}, bNew)
    end
  end
  local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
  if bInActGroup then
    RedDotManager.SetValid(RedDotDefine.Activity_Group_PenguinCard_Level, {nActGroupId}, #self.tbNewLevel > 0)
  end
end

function PenguinCardActData:SkipLevelRedDot()
  for _, nId in ipairs(self.tbNewLevel) do
    RedDotManager.SetValid(RedDotDefine.Activity_PenguinCard_Level, {nId}, false)
    local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
    if bInActGroup then
      RedDotManager.SetValid(RedDotDefine.Activity_Group_PenguinCard_Level, {nActGroupId}, false)
    end
    if table.indexof(self.tbSkipNewLevel, nId) == 0 then
      table.insert(self.tbSkipNewLevel, nId)
    end
  end
  LocalData.SetPlayerLocalData("PenguinCardLevel", RapidJson.encode(self.tbSkipNewLevel))
end

function PenguinCardActData:SendSkipLevelReq(nLevelId, callback)
  local bAble = self:CheckLevelSkipAble(nLevelId)
  if not bAble then
    return
  end
  self:SendActivityPenguinCardSettleReq(nLevelId, 3, 0, 0, callback)
end

function PenguinCardActData:SendActivityPenguinCardSettleReq(nLevelId, nStar, nScore, nDifficulty, callback)
  nScore = math.floor(nScore)
  local msgData = {
    LevelId = nLevelId,
    Star = nStar,
    Score = math.floor(nScore),
    Difficulty = nDifficulty
  }
  
  local function successCallback(_, mapMainData)
    local bEmpty = self.mapLevelData[nLevelId] == nil
    local bBetterDifficulty = not bEmpty and nDifficulty > self.mapLevelData[nLevelId].nDifficulty
    local bBetterStar = not bEmpty and nDifficulty == self.mapLevelData[nLevelId].nDifficulty and nStar > self.mapLevelData[nLevelId].nStar
    local bBetterScore = not bEmpty and nDifficulty == self.mapLevelData[nLevelId].nDifficulty and nStar == self.mapLevelData[nLevelId].nStar and nScore > self.mapLevelData[nLevelId].nScore
    if not bEmpty then
      self.mapLevelData[nLevelId].sData = ""
    end
    if bEmpty or bBetterDifficulty or bBetterStar or bBetterScore then
      self.mapLevelData[nLevelId] = {
        nScore = nScore,
        nStar = nStar,
        nDifficulty = nDifficulty,
        sData = ""
      }
    end
    local mapReward = PlayerData.Item:ProcessRewardChangeInfo(mapMainData)
    local tbItem = {}
    for _, v in ipairs(mapReward.tbReward) do
      local item = {
        Tid = v.id,
        Qty = v.count,
        rewardType = AllEnum.RewardType.First
      }
      table.insert(tbItem, item)
    end
    UTILS.OpenReceiveByDisplayItem(tbItem, mapMainData, callback)
    self:RefreshLevelRedDot()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_penguin_card_level_settle_req, msgData, nil, successCallback)
end

function PenguinCardActData:SendActivityPenguinCardQuestReceiveReq(nQuestId, nGroupId, callback)
  local msgData = {
    ActivityId = self.nActId,
    QuestId = nQuestId,
    GroupId = nGroupId
  }
  
  local function max(nId)
    if self.mapQuestData[nId] and self.mapQuestData[nId].nStatus == AllEnum.ActQuestStatus.Complete then
      self.mapQuestData[nId].nCur = self.mapQuestData[nId].nMax
      self.mapQuestData[nId].nStatus = AllEnum.ActQuestStatus.Received
      self:RefreshQuestRedDot(nId)
    end
  end
  
  local function successCallback(_, mapMainData)
    if nQuestId ~= 0 then
      max(nQuestId)
    else
      local tbQuest = self:GetQuestbyGroupId(nGroupId)
      for _, v in ipairs(tbQuest) do
        max(v)
      end
    end
    UTILS.OpenReceiveByChangeInfo(mapMainData, callback)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_penguin_card_quest_reward_receive_req, msgData, nil, successCallback)
end

function PenguinCardActData:SendActivityPenguinCardEndlessLevelSaveReq(nLevelId, nScore, sData, callback)
  local msgData = {
    LevelId = nLevelId,
    Data = sData,
    Score = nScore
  }
  
  local function successCallback(_, mapMainData)
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_penguin_card_endless_level_save_req, msgData, nil, successCallback)
end

return PenguinCardActData
