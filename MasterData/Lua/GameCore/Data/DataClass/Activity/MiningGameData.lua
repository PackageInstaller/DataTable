local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local LocalData = require("GameCore.Data.LocalData")
local MiningGameData = class("MiningGameData", ActivityDataBase)

function MiningGameData:Init()
  self.tbQuestDataList = {}
  self.bIsFirst = true
  self.nScore = 0
  self.tbGridDataList = {}
  self.nCurLevel = 0
  self.tbCurReward = {}
  self.bCanGoNext = false
  self.tbSupList = {}
  self.nAddAxeCount_Daliy = 0
  self.nAddAxeCount_LongTime = 0
  self.tbConfig = {}
  self.nConfigId = 0
  self.tbCurDicGroupId = {}
  self.tbCurStoryGroupData = {}
  self.tbCurStoryListData = {}
  self.nAxeId = 0
  self:AddListeners()
end

function MiningGameData:AddListeners()
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  EventManager.Add("Mining_Daily_Reward", self, self.On_DailyReward_Update)
  EventManager.Add("Mining_Supplement_Reward", self, self.On_SupplementReward_Update)
  EventManager.Add("Mining_UpdateLevelData", self, self.OnEvent_Mining_UpdateLevelData)
  EventManager.Add("Mining_UpdateRigResult", self, self.OnEvent_Mining_UpdateDigResult)
end

function MiningGameData:OnEvent_NewDay()
  self.nAddAxeCount = 0
end

function MiningGameData:CacheAllQuestData(questListData)
  self.tbQuestDataList = {}
  for _, v in pairs(questListData) do
    local config = ConfigTable.GetData("MiningQuest", v.Id)
    if config ~= nil then
      local nGroupId = config.GroupId
      local questData = {
        nId = v.Id,
        nStatus = self:QuestServer2Client(v.Status),
        progress = v.Progress
      }
      if self.tbQuestDataList[nGroupId] == nil then
        self.tbQuestDataList[nGroupId] = {}
      end
      table.insert(self.tbQuestDataList[nGroupId], questData)
    end
  end
  self:RefreshQuestReddot()
end

function MiningGameData:GetAllQuestData()
  return self.tbQuestDataList
end

function MiningGameData:GetQuestData(nQuestId)
  local questData
  for _, v in pairs(self.tbQuestDataList) do
    for _, v2 in ipairs(v) do
      if v2.nId == nQuestId then
        questData = v2
        break
      end
    end
  end
  return questData
end

function MiningGameData:GetAllReceivedCount()
  local nCount = 0
  for _, v in pairs(self.tbQuestDataList) do
    for _, v2 in ipairs(v) do
      if v2.nStatus == AllEnum.ActQuestStatus.Received then
        nCount = nCount + 1
      end
    end
  end
  return nCount
end

function MiningGameData:GetAllQuestCount()
  local nCount = 0
  for _, v in pairs(self.tbQuestDataList) do
    nCount = nCount + #v
  end
  return nCount
end

function MiningGameData:GetAllGroupId()
  local tbGroupId = {}
  for k, _ in pairs(self.tbQuestDataList) do
    table.insert(tbGroupId, k)
  end
  return tbGroupId
end

function MiningGameData:GetQuestbyGroupId(nGroupId)
  return self.tbQuestDataList[nGroupId]
end

function MiningGameData:GetGroupQuestReceiveCount(nGroupId)
  local nCount = 0
  for _, v in pairs(self.tbQuestDataList[nGroupId]) do
    if v.nStatus == AllEnum.ActQuestStatus.Received then
      nCount = nCount + 1
    end
  end
  return nCount
end

function MiningGameData:RefreshQuestData(questData)
  for _, v in pairs(self.tbQuestDataList) do
    for _, v2 in ipairs(v) do
      if v2.nId == questData.Id then
        v2.nStatus = self:QuestServer2Client(questData.Status)
        v2.progress = questData.Progress
        break
      end
    end
  end
  self:RefreshQuestReddot()
  EventManager.Hit("MiningQuestUpdate")
end

function MiningGameData:RefreshQuestReddot()
  local bTabReddot = false
  for _, v in pairs(self.tbQuestDataList) do
    for _, v2 in ipairs(v) do
      local bReddot = v2.nStatus == AllEnum.ActQuestStatus.Complete
      local nGroupId = ConfigTable.GetData("MiningQuest", v2.nId).GroupId
      RedDotManager.SetValid(RedDotDefine.Activity_Mining_Quest, {
        nGroupId,
        v2.nId
      }, bReddot)
      bTabReddot = bTabReddot or bReddot
    end
  end
  RedDotManager.SetValid(RedDotDefine.Activity_Mining_AllQuest, self.nActId, bTabReddot)
end

function MiningGameData:QuestServer2Client(nStatus)
  if nStatus == 0 then
    return AllEnum.ActQuestStatus.UnComplete
  elseif nStatus == 1 then
    return AllEnum.ActQuestStatus.Complete
  else
    return AllEnum.ActQuestStatus.Received
  end
end

function MiningGameData:InitCurDicData()
  local function GetRewardsByGroupId(lineData)
    if lineData.ActivityId == self.nActId then
      table.insert(self.tbCurDicGroupId, lineData.Id)
    end
  end
  
  ForEachTableLine(DataTable.MiningTreasure, GetRewardsByGroupId)
end

function MiningGameData:GetDicGroupId()
  return self.tbCurDicGroupId
end

function MiningGameData:InitStoryData(readStoryList)
  local function GetRewardsByGroupId(lineData)
    if lineData.ActivityId == self.nActId then
      table.insert(self.tbCurStoryListData, {
        nId = lineData.Id,
        
        config = lineData
      })
      
      local function isRead(id)
        for _, v in ipairs(readStoryList) do
          if v == id then
            return true
          end
        end
        return false
      end
      
      self.tbCurStoryGroupData[lineData.Id] = {
        nId = lineData.Id,
        bIsRead = isRead(lineData.Id),
        self.nCurLevel < lineData.UnlockLayer
      }
    end
  end
  
  ForEachTableLine(DataTable.MiningStory, GetRewardsByGroupId)
  table.sort(self.tbCurStoryListData, function(a, b)
    return a.config.UnlockLayer < b.config.UnlockLayer
  end)
end

function MiningGameData:GetGroupStoryData()
  return self.tbCurStoryGroupData
end

function MiningGameData:GetStoryConfigIdList()
  return self.tbCurStoryListData
end

function MiningGameData:UpdateStoryLockState(...)
  for k, v in pairs(self.tbCurStoryGroupData) do
    if v.bIsLock then
      local config = DataTable.GetData("MiningStory", v.id)
      if self.nCurLevel >= config.UnlockLayer then
        v.bIsLock = false
      end
    end
  end
end

function MiningGameData:ChangeStoryState(storyId)
  if self.tbCurStoryGroupData[storyId] ~= nil then
    self.tbCurStoryGroupData[storyId].bIsRead = true
  end
end

function MiningGameData:GetSupDataList()
  return self.tbSupList
end

function MiningGameData:GetCellData()
  return self.tbGridDataList
end

function MiningGameData:RefreshMiningGameActData(actId, msgData)
  self:Init()
  self.nActId = actId
  self.nCurLevel = msgData.Layer
  self.tbConfig = ConfigTable.GetData("MiningControl", self.nActId)
  self.nAxeId = self.tbConfig.DigConsumeItemId
  local sKey = tostring(self.nActId) .. "IsFirst"
  self.bIsFirst = LocalData.GetPlayerLocalData(sKey)
  if self.bIsFirst == nil then
    self.bIsFirst = true
  end
  self:InitCurDicData()
  self.nScore = msgData.Score
  self:CacheAllQuestData(msgData.Quests)
end

function MiningGameData:GetIsFirstIn()
  return self.bIsFirst
end

function MiningGameData:SetIsFirstIn()
  self.bIsFirst = false
  local sKey = tostring(self.nActId) .. "IsFirst"
  LocalData.SetPlayerLocalData(sKey, self.bIsFirst)
end

function MiningGameData:GetLevel(...)
  return self.nCurLevel
end

function MiningGameData:GetCurLevelRewardData()
  return self.tbCurReward
end

function MiningGameData:GetCanGoNext(...)
  return self.bCanGoNext
end

function MiningGameData:GetMiningCfg(...)
  if not self.tbConfig then
    self.tbConfig = ConfigTable.GetData("MiningControl", self.nActId)
  end
  return self.tbConfig
end

function MiningGameData:GetScore()
  return self.nScore
end

function MiningGameData:AddScore(addValue)
  self.nScore = self.nScore + addValue
  EventManager.Hit("MiningGameUpdateScore", self.nScore)
end

function MiningGameData:ResponseLevelData(msgData, callback)
  local layer = msgData.Layer
  self.nCurLevel = layer.Layer
  self.nMapId = layer.Map.Id
  self.tbGridDataList = {}
  for _, v in pairs(layer.Map.Grids) do
    local cellData = {
      nId = v.Id,
      nIndex = v.PosIndex + 1,
      nStatus = GameEnum.miningGridType[v.GridType],
      bMark = v.Marked
    }
    table.insert(self.tbGridDataList, v.PosIndex + 1, cellData)
  end
  self.tbCurlevelEnterChange = msgData.MiningChangeInfo
  self.tbCurReward = {}
  for _, v in pairs(layer.Map.Treasures) do
    local tbPosIndex = {}
    for _, n in pairs(v.PosIndex) do
      table.insert(tbPosIndex, n + 1)
    end
    local rewardData = {
      nId = v.Id,
      bIsGet = v.Received,
      tbPosIndex = tbPosIndex
    }
    table.insert(self.tbCurReward, rewardData)
  end
  self.tbSupList = {}
  for _, v in pairs(layer.Supports) do
    table.insert(self.tbSupList, {
      nId = v.Id
    })
  end
  EventManager.Hit("MiningUpdateLevel")
  if callback ~= nil then
    callback()
  end
end

function MiningGameData:DoEnterResult()
  self:DoResult(self.tbCurlevelEnterChange)
  self.tbCurlevelEnterChange = nil
end

function MiningGameData:DoResult(changeInfo)
  if changeInfo == nil then
    return
  end
  local tbSkillData = {}
  for k, v in pairs(changeInfo.Processes) do
    local tbUpdateGrid = {}
    for _, m in pairs(v.EffectedGrids) do
      self.tbGridDataList[m.PosIndex + 1].nStatus = GameEnum.miningGridType[m.GridType]
      self.tbGridDataList[m.PosIndex + 1].bMark = m.Marked
      table.insert(tbUpdateGrid, {
        nIndex = m.PosIndex + 1,
        nStatus = GameEnum.miningGridType[m.GridType],
        bMark = m.Marked
      })
    end
    local skillData = {
      nEffectType = v.EffectType,
      tbUpdateGrid = tbUpdateGrid
    }
    table.insert(tbSkillData, skillData)
  end
  for k, v in pairs(changeInfo.ReceivedTreasures) do
    self:UpdateReward(v)
  end
  self:UpdateAxe()
  self:AddScore(changeInfo.Score)
  EventManager.Hit("MiningKnockResult", tbSkillData)
end

function MiningGameData:UpdateReward(nId)
  for key, value in pairs(self.tbCurReward) do
    if nId == value.nId then
      value.bIsGet = true
    end
  end
  EventManager.Hit("MiningUpdateReward", nId)
end

function MiningGameData:GetAxeId()
  return self.nAxeId
end

function MiningGameData:GetAxeCount(...)
  return PlayerData.Item:GetItemCountByID(self.nAxeId)
end

function MiningGameData:UpdateAxe(...)
  EventManager.Hit("MiningAxeUpdate", PlayerData.Item:GetItemCountByID(self.nAxeId))
end

function MiningGameData:GetPassAllLevelResult()
  local nMaxLevel = self.tbConfig.ConfigMaxLayer
  if nMaxLevel > self.nCurLevel then
    return false
  end
  for _, data in pairs(self.tbCurReward) do
    if not data.bIsGet then
      return false
    end
  end
  return true
end

function MiningGameData:On_DailyReward_Update(msgData)
  local tbItemList = PlayerData.Item:ProcessRewardChangeInfo(msgData)
  for _, v in pairs(tbItemList) do
    if v.nId == self.nAxeId then
      self.nAddAxeCount_Daliy = v.nCount
      break
    end
  end
end

function MiningGameData:On_SupplementReward_Update(msgData)
  local tbItemList = PlayerData.Item:ProcessRewardChangeInfo(msgData)
  for _, v in pairs(tbItemList) do
    if v.nId == self.nAxeId then
      self.nAddAxeCount_LongTime = v.nCount
      break
    end
  end
end

function MiningGameData:GetAddAxeCount()
  return self.nAddAxeCount_Daliy + self.nAddAxeCount_LongTime
end

function MiningGameData:ResetAddAxeCount()
  self.nAddAxeCount_Daliy = 0
  self.nAddAxeCount_LongTime = 0
end

function MiningGameData:OnEvent_Mining_UpdateLevelData(mapMsgData)
  self:ResponseLevelData(mapMsgData)
end

function MiningGameData:OnEvent_Mining_UpdateDigResult(mapMsgData)
  self:DoResult(mapMsgData.MiningChangeInfo)
end

function MiningGameData:RequestLevelData(nStatus, callback)
  if nStatus == 0 then
    local function callbackFunc(_, msgData)
      self:ResponseLevelData(msgData, callback)
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.activity_mining_apply_req, {
      ActivityId = self.nActId
    }, nil, callbackFunc)
  elseif nStatus == 1 then
    local function callbackFunc(_, msgData)
      self:ResponseLevelData(msgData)
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.activity_mining_move_to_next_layer_req, {
      ActivityId = self.nActId
    }, nil, callbackFunc)
  end
end

function MiningGameData:RequestKnockCell(nId)
  local nAxeCount = PlayerData.Item:GetItemCountByID(self.nAxeId)
  if nAxeCount <= 0 then
    return
  end
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_mining_dig_req, {
    ActivityId = self.nActId,
    GridId = nId
  }, nil, nil)
end

function MiningGameData:RequestFinishAvg(storyId, callback)
  local function msgCallback(_, mapMsgData)
    self:ChangeStoryState(storyId)
    
    EventManager.Hit(EventId.ClosePanel, PanelId.PureAvgStory)
    if callback ~= nil then
      callback(mapMsgData)
    end
    EventManager.Hit("MiningStoryFinish")
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_mining_story_reward_receive_req, {
    ActivityId = self.nActId,
    StoryId = storyId
  }, nil, msgCallback)
end

function MiningGameData:SendQuestReceive(nQuestId, nGroupId)
  local function callback(_, msgData)
    UTILS.OpenReceiveByChangeInfo(msgData, nil)
    
    if nQuestId == 0 then
      if nGroupId ~= 0 then
        for _, v in pairs(self.tbQuestDataList[nGroupId]) do
          if v.nStatus == AllEnum.ActQuestStatus.Complete then
            v.nStatus = AllEnum.ActQuestStatus.Received
          end
        end
      end
    else
      local questData = self:GetQuestData(nQuestId)
      if questData then
        questData.nStatus = AllEnum.ActQuestStatus.Received
      end
    end
    EventManager.Hit("MiningQuestUpdate")
    self:UpdateAxe()
    self:RefreshQuestReddot()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_mining_quest_reward_receive_req, {
    ActivityId = self.nActId,
    QuestId = nQuestId,
    GroupId = nGroupId
  }, nil, callback)
end

return MiningGameData
