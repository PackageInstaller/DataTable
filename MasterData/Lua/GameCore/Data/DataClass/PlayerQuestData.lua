local LocalData = require("GameCore.Data.LocalData")
local statusOrder = {
  [0] = 1,
  [1] = 2,
  [2] = 0
}
local PlayerQuestData = class("PlayerQuestData")
local QuestType = {
  Unknown = 0,
  TourGuide = 1,
  Daily = 2,
  TravelerDuel = 3,
  TravelerDuelChallenge = 4,
  Affinity = 5,
  BattlePassDaily = 6,
  BattlePassWeekly = 7,
  VampireSurvivorNormal = 8,
  VampireSurvivorSeason = 9,
  Tower = 10,
  Demon = 11,
  TowerEvent = 12,
  Weekly = 13,
  Assist = 14,
  Dorm = 15,
  GuideMission = 16
}
local QuestRedDotType = {
  TourGuide = RedDotDefine.Task_Guide,
  Daily = RedDotDefine.Task_Daily,
  TravelerDuel = RedDotDefine.Task_Duel,
  TravelerDuelChallenge = RedDotDefine.Task_Season,
  Affinity = RedDotDefine.Role_AffinityTask,
  Tower = RedDotDefine.StarTowerQuest,
  Weekly = RedDotDefine.Task_Weekly,
  Assist = RedDotDefine.TaskNewbie_TeamFormation
}

function PlayerQuestData:Init()
  self._mapQuest = {}
  self.tbDailyActives = {}
  self.tbWeeklyActives = {}
  self.nCurTourGroupOrderIndex = 0
  self.nMaxTourGroupOrderIndex = 0
  self.nMaxTeamFormationGroupIdx = 0
  self.nMaxTeamFormationGroupIdxInAttr = {}
  self.tbTourGuideGroup = {}
  self.tbTourGuide = {}
  self.tbTeamFormation = {}
  self.tbTeamFormationGroup = {}
  self.tbTeamFormationAttr = {}
  self.tbGuideMissionQuestGroup = {}
  self.tbGuideMissionQuest = {}
  self:InitConfig()
  self:UpdateQuestRedDot("GuideMission")
  EventManager.Add(EventId.IsNewDay, self, self.HandleExpire)
  EventManager.Add(EventId.UpdateWorldClass, self, self.UpdateDailyQuestRedDot)
  EventManager.Add(EventId.UpdateWorldClass, self, self.UpdateWeeklyQuestRedDot)
end

function PlayerQuestData:UnInit()
  EventManager.Remove(EventId.IsNewDay, self, self.HandleExpire)
  EventManager.Remove(EventId.UpdateWorldClass, self, self.UpdateDailyQuestRedDot)
  EventManager.Remove(EventId.UpdateWorldClass, self, self.UpdateWeeklyQuestRedDot)
end

function PlayerQuestData:InitConfig()
  local function foreachDailyActive(mapData)
    self.tbDailyActives[mapData.Id] = {
      bReward = false,
      
      nActive = mapData.Active
    }
  end
  
  ForEachTableLine(DataTable.DailyQuestActive, foreachDailyActive)
  
  local function foreachTourGroup(mapData)
    table.insert(self.tbTourGuideGroup, mapData)
  end
  
  ForEachTableLine(DataTable.TourGuideQuestGroup, foreachTourGroup)
  table.sort(self.tbTourGuideGroup, function(a, b)
    return a.Order < b.Order
  end)
  self.nMaxTourGroupOrderIndex = #self.tbTourGuideGroup
  
  local function foreachTourQuest(mapData)
    if nil == self.tbTourGuide[mapData.Order] then
      self.tbTourGuide[mapData.Order] = {}
    end
    table.insert(self.tbTourGuide[mapData.Order], mapData)
  end
  
  ForEachTableLine(DataTable.TourGuideQuest, foreachTourQuest)
  
  local function foreachGuideMissionQuestGroup(mapData)
    if self.tbGuideMissionQuestGroup[mapData.ChapterId] == nil then
      self.tbGuideMissionQuestGroup[mapData.ChapterId] = {}
    end
    table.insert(self.tbGuideMissionQuestGroup[mapData.ChapterId], mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("GuideMissionQuestGroup"), foreachGuideMissionQuestGroup)
  
  local function foreachGuideMissionQuest(mapData)
    if self.tbGuideMissionQuest[mapData.GroupId] == nil then
      self.tbGuideMissionQuest[mapData.GroupId] = {}
    end
    table.insert(self.tbGuideMissionQuest[mapData.GroupId], mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("GuideMissionQuest"), foreachGuideMissionQuest)
  
  local function foreachDemonQuest(line)
    if nil == CacheTable.GetData("_DemonQuest", line.AdvanceGroup) then
      CacheTable.SetData("_DemonQuest", line.AdvanceGroup, {})
    end
    CacheTable.InsertData("_DemonQuest", line.AdvanceGroup, line)
  end
  
  ForEachTableLine(ConfigTable.Get("DemonQuest"), foreachDemonQuest)
  
  local function foreachWeeklyActive(mapData)
    self.tbWeeklyActives[mapData.Id] = {
      bReward = false,
      nActive = mapData.Active
    }
  end
  
  ForEachTableLine(DataTable.WeeklyQuestActive, foreachWeeklyActive)
  
  local function foreachTeamFormationGroup(mapData)
    if self.nMaxTeamFormationGroupIdxInAttr[mapData.AttributeId] == nil then
      self.nMaxTeamFormationGroupIdxInAttr[mapData.AttributeId] = 0
    end
    self.nMaxTeamFormationGroupIdxInAttr[mapData.AttributeId] = self.nMaxTeamFormationGroupIdxInAttr[mapData.AttributeId] + 1
    table.insert(self.tbTeamFormationGroup, mapData)
  end
  
  ForEachTableLine(DataTable.AssistQuestGroup, foreachTeamFormationGroup)
  table.sort(self.tbTeamFormationGroup, function(a, b)
    return a.Id < b.Id
  end)
  self.nMaxTeamFormationGroupIdx = #self.tbTeamFormationGroup
  
  local function foreachTeamFormation(mapData)
    table.insert(self.tbTeamFormation, mapData)
  end
  
  ForEachTableLine(DataTable.AssistQuest, foreachTeamFormation)
  
  local function foreachTeamFormationAttr(mapData)
    table.insert(self.tbTeamFormationAttr, mapData)
  end
  
  ForEachTableLine(DataTable.AssistAttribute, foreachTeamFormationAttr)
end

function PlayerQuestData:GetAllQuestData()
  local retDaily = {}
  
  local function sortDaily(a, b)
    if a.nStatus ~= b.nStatus then
      return statusOrder[a.nStatus] > statusOrder[b.nStatus]
    end
    local mapQuestA = ConfigTable.GetData("DailyQuest", a.nTid)
    local mapQuestB = ConfigTable.GetData("DailyQuest", b.nTid)
    return mapQuestA.Order < mapQuestB.Order
  end
  
  if self._mapQuest[2] ~= nil then
    for _, mapQuest in pairs(self._mapQuest[2]) do
      table.insert(retDaily, mapQuest)
    end
    if 0 < #retDaily then
      table.sort(retDaily, sortDaily)
    end
  end
  if self._mapQuest[QuestType.TourGuide] == nil and self.nCurTourGroupOrderIndex >= self.nMaxTourGroupOrderIndex then
    self._mapQuest[QuestType.TourGuide] = {}
    local nGroupId = self.tbTourGuideGroup[self.nMaxTourGroupOrderIndex].Id
    local tbQuest = self.tbTourGuide[nGroupId]
    if nil ~= tbQuest then
      for _, v in ipairs(tbQuest) do
        self._mapQuest[QuestType.TourGuide][v.Id] = {
          nTid = v.Id,
          nGoal = 1,
          nCurProgress = 1,
          nStatus = 2,
          nExpire = 0
        }
      end
    end
  end
  local retWeekly = {}
  
  local function sortWeekly(a, b)
    if a.nStatus ~= b.nStatus then
      return statusOrder[a.nStatus] > statusOrder[b.nStatus]
    end
    local mapQuestA = ConfigTable.GetData("WeeklyQuest", a.nTid)
    local mapQuestB = ConfigTable.GetData("WeeklyQuest", b.nTid)
    return mapQuestA.Order < mapQuestB.Order
  end
  
  if self._mapQuest[QuestType.Weekly] ~= nil then
    for _, mapQuest in pairs(self._mapQuest[QuestType.Weekly]) do
      table.insert(retWeekly, mapQuest)
    end
    if 0 < #retWeekly then
      table.sort(retWeekly, sortWeekly)
    end
  end
  if self._mapQuest[QuestType.Assist] == nil then
    self._mapQuest[QuestType.Assist] = {}
    local nGroupId = self.tbTeamFormationGroup[self.nMaxTeamFormationGroupIdx].Id
    local tbQuest = self.tbTeamFormation[nGroupId]
    if nil ~= tbQuest then
      for _, v in ipairs(tbQuest) do
        self._mapQuest[QuestType.Assist][v.Id] = {
          nTid = v.Id,
          nGoal = 1,
          nCurProgress = 1,
          nStatus = 2,
          nExpire = 0
        }
      end
    end
  end
  return retDaily, self._mapQuest[QuestType.TourGuide], retWeekly, self._mapQuest[QuestType.Assist]
end

function PlayerQuestData:CheckTourGroupReward(nIndex)
  return nIndex <= self.nCurTourGroupOrderIndex
end

function PlayerQuestData:CheckTeamFormationGroupReward(nAttributeId, nIndex)
  if self.tbCurTeamFormationGroupIndex == nil then
    return false
  end
  if self.tbCurTeamFormationGroupIndex[nAttributeId] == nil then
    return false
  end
  return nIndex <= self.tbCurTeamFormationGroupIndex[nAttributeId]
end

function PlayerQuestData:CheckTeamFormationAllCompleted()
  local nCompletedGroupCount = 0
  for nAttributeId, nGroupCount in pairs(self.tbCurTeamFormationGroupIndex) do
    nCompletedGroupCount = nCompletedGroupCount + nGroupCount
  end
  return nCompletedGroupCount >= #self.tbTeamFormationGroup
end

function PlayerQuestData:GetTourGuideQuestRewardId()
  local tbQuest = self._mapQuest[QuestType.TourGuide]
  if tbQuest ~= nil then
    for nId, v in pairs(tbQuest) do
      if v.nStatus == 1 then
        return nId
      end
    end
  end
  return 0
end

function PlayerQuestData:GetMaxTourGroupOrderIndex()
  return self.nMaxTourGroupOrderIndex
end

function PlayerQuestData:CheckDailyActiveReceive(nActiveId)
  if self.tbDailyActives[nActiveId] ~= nil then
    return self.tbDailyActives[nActiveId].bReward
  end
  return false
end

function PlayerQuestData:CheckWeeklyActiveReceive(nActiveId)
  if self.tbWeeklyActives[nActiveId] ~= nil then
    return self.tbWeeklyActives[nActiveId].bReward
  end
  return false
end

function PlayerQuestData:GetTravelerDuelQuestData()
  if self._mapQuest[3] == nil then
    self._mapQuest[3] = {}
  end
  return self._mapQuest[3], self._mapQuest[4]
end

function PlayerQuestData:GetBattlePassQuestData()
  if self._mapQuest[6] == nil then
    self._mapQuest[6] = {}
  end
  if self._mapQuest[7] == nil then
    self._mapQuest[7] = {}
  end
  return self._mapQuest[6], self._mapQuest[7]
end

function PlayerQuestData:GetStarTowerBookQuestData()
  if self._mapQuest[12] == nil then
    self._mapQuest[12] = {}
  end
  return self._mapQuest[12]
end

function PlayerQuestData:GetOngoingAttributeId()
  local nLastestAttributeId = 0
  for k, v in pairs(self.tbTeamFormationAttr) do
    local bComplete = self:CheckTeamFormationAttributeCompleted(v.Id)
    if not bComplete then
      nLastestAttributeId = v.Id
      break
    end
  end
  return nLastestAttributeId
end

function PlayerQuestData:GetAttributeIdByGroupId(nGroupId)
  for nGroupIdx, mapGroup in pairs(self.tbTeamFormationGroup) do
    if mapGroup.Id == nGroupId then
      return mapGroup.AttributeId
    end
  end
  return 0
end

function PlayerQuestData:GetTeamFormationGroupIndexInAttribute(nGroupId)
  local nAttributeId = self:GetAttributeIdByGroupId(nGroupId)
  if nAttributeId == 0 then
    return 0
  end
  local nIdx = 0
  for nGroupIdx, mapGroup in pairs(self.tbTeamFormationGroup) do
    if mapGroup.AttributeId == nAttributeId then
      nIdx = nIdx + 1
      if mapGroup.Id == nGroupId then
        return nIdx
      end
    end
  end
  return 0
end

function PlayerQuestData:GetCurTeamFormationQuestGroup(nAttributeId)
  if self._mapQuest[QuestType.Assist] == nil or self.tbCurTeamFormationGroupIndex[nAttributeId] == nil then
    local mapFirstGroup
    for nGroupIdx, mapGroup in pairs(self.tbTeamFormationGroup) do
      if mapGroup.AttributeId == nAttributeId then
        mapFirstGroup = mapGroup
        break
      end
    end
    if mapFirstGroup == nil then
      return 0
    end
    return mapFirstGroup.Id
  end
  local nCurIndex = math.min(self.tbCurTeamFormationGroupIndex[nAttributeId] + 1, self.nMaxTeamFormationGroupIdxInAttr[nAttributeId])
  local nCurAttriCount = 0
  for i = 1, #self.tbTeamFormationGroup do
    if self.tbTeamFormationGroup[i].AttributeId == nAttributeId then
      nCurAttriCount = nCurAttriCount + 1
      if nCurAttriCount == nCurIndex then
        return self.tbTeamFormationGroup[i].Id
      end
    end
  end
end

function PlayerQuestData:GetTeamFormationQuestData()
  if self._mapQuest[QuestType.Assist] == nil then
    self._mapQuest[QuestType.Assist] = {}
  end
  return self._mapQuest[QuestType.Assist]
end

function PlayerQuestData:GetTeamFormationGroupById(nGroupId)
  local tbTeamFormation = self:GetTeamFormationQuestData()
  if tbTeamFormation == nil then
    return nil
  end
  local tbGroupData = {}
  for k, v in pairs(self.tbTeamFormation) do
    if nGroupId == v.QuestGroup then
      table.insert(tbGroupData, tbTeamFormation[v.Id])
    end
  end
  return tbGroupData
end

function PlayerQuestData:GetTeamFormationGroupStartIndex(nAttrId)
  local nStartIndex = 0
  for nGroupIndex, mapGroup in pairs(self.tbTeamFormationGroup) do
    if mapGroup.AttributeId == nAttrId then
      nStartIndex = nGroupIndex
      break
    end
  end
  return nStartIndex
end

function PlayerQuestData:GetTeamFormationGroupEndIndex(nAttrId)
  local nEndIndex = 0
  local nLastestGroupId = self:GetCurTeamFormationQuestGroup(nAttrId)
  for nGroupIndex, mapGroup in pairs(self.tbTeamFormationGroup) do
    if mapGroup.AttributeId == nAttrId and mapGroup.Id == nLastestGroupId then
      nEndIndex = nGroupIndex
    end
  end
  return nEndIndex
end

function PlayerQuestData:CheckTeamFormationAttributeCompleted(nAttrId)
  local bCompleted = true
  local tbIndexInAttr = {}
  for nGroupIndex, mapGroup in pairs(self.tbTeamFormationGroup) do
    if mapGroup.AttributeId == nAttrId then
      if tbIndexInAttr[nAttrId] == nil then
        tbIndexInAttr[nAttrId] = 0
      end
      tbIndexInAttr[nAttrId] = tbIndexInAttr[nAttrId] + 1
      local bGroupCompleted = self:CheckTeamFormationGroupReward(nAttrId, tbIndexInAttr[nAttrId])
      bCompleted = bCompleted and bGroupCompleted
      if bCompleted == false then
        return false
      end
    end
  end
  return bCompleted
end

function PlayerQuestData:CheckTeamFormationGroupCompleted(nGroupId)
  local tbGroupData = self:GetTeamFormationGroupById(nGroupId)
  if tbGroupData == nil then
    return false
  end
  for k, questData in pairs(tbGroupData) do
    if questData.nStatus ~= 1 then
      return false
    end
  end
  return true
end

function PlayerQuestData:CheckTeamFormationAttributeUnlocked(nAttrId)
  local mapAttr = ConfigTable.GetData("AssistAttribute", nAttrId)
  if mapAttr == nil then
    return false
  end
  if mapAttr.Pre == nil or mapAttr.Pre == 0 then
    return true
  end
  local bCompleted = true
  local nGroupIdxInAttr = 0
  for nGroupIndex, mapGroup in pairs(self.tbTeamFormationGroup) do
    if mapGroup.AttributeId == mapAttr.Pre then
      nGroupIdxInAttr = nGroupIdxInAttr + 1
      local bGroupCompleted = self:CheckTeamFormationGroupReward(mapAttr.Pre, nGroupIdxInAttr)
      bCompleted = bCompleted and bGroupCompleted
      if bCompleted == false then
        return false
      end
    end
  end
  return bCompleted
end

function PlayerQuestData:GetTeamFormationAttributeProgress(nAttrId)
  local nTotalCount = 0
  local nReceivedCount = 0
  local tbIndexInAttr = {}
  for nGroupIndex, mapGroup in pairs(self.tbTeamFormationGroup) do
    if mapGroup.AttributeId == nAttrId then
      if tbIndexInAttr[nAttrId] == nil then
        tbIndexInAttr[nAttrId] = 0
      end
      tbIndexInAttr[nAttrId] = tbIndexInAttr[nAttrId] + 1
      nTotalCount = nTotalCount + 1
      local bGroupCompleted = self:CheckTeamFormationGroupReward(nAttrId, tbIndexInAttr[nAttrId])
      if bGroupCompleted then
        nReceivedCount = nReceivedCount + 1
      end
    end
  end
  return nReceivedCount, nTotalCount
end

function PlayerQuestData:GetCurTourGroup()
  if self._mapQuest[QuestType.TourGuide] == nil then
    return 0
  end
  local nCurIndex = math.min(self.nCurTourGroupOrderIndex + 1, self.nMaxTourGroupOrderIndex)
  local mapCurGroup = self.tbTourGuideGroup[nCurIndex]
  return mapCurGroup.Id
end

function PlayerQuestData:GetCurTourGroupOrder()
  if self._mapQuest[QuestType.TourGuide] == nil then
    return 0
  end
  local nCurIndex = math.min(self.nCurTourGroupOrderIndex + 1, self.nMaxTourGroupOrderIndex)
  local mapCurGroup = self.tbTourGuideGroup[nCurIndex]
  return mapCurGroup.Order
end

function PlayerQuestData:GetMaxTourGroup()
  return self.tbTourGuideGroup[self.nMaxTourGroupOrderIndex].Id
end

function PlayerQuestData:GetAffinityQuestData(questId)
  if self._mapQuest[QuestType.Affinity] ~= nil and self._mapQuest[QuestType.Affinity][questId] ~= nil then
    return self._mapQuest[QuestType.Affinity][questId]
  end
  return nil
end

function PlayerQuestData:GetStarTowerQuestData()
  local tbCore, tbNormal = {}, {}
  if not self._mapQuest[QuestType.Tower] then
    return tbCore, tbNormal
  end
  for nId, v in pairs(self._mapQuest[QuestType.Tower]) do
    local mapCfg = ConfigTable.GetData("StarTowerQuest", nId)
    if mapCfg and v.nStatus ~= 2 then
      if mapCfg.TowerQuestType == GameEnum.TowerQuestType.Core then
        table.insert(tbCore, v)
      elseif mapCfg.TowerQuestType == GameEnum.TowerQuestType.Normal then
        table.insert(tbNormal, v)
      end
    end
  end
  
  local function sort(a, b)
    if a.nStatus ~= b.nStatus then
      return statusOrder[a.nStatus] > statusOrder[b.nStatus]
    elseif a.nTid ~= b.nTid then
      return a.nTid < b.nTid
    end
  end
  
  if 0 < #tbNormal then
    table.sort(tbNormal, sort)
  end
  return tbCore, tbNormal
end

function PlayerQuestData:ReceiveDemonQuest(nGroupId)
  if self._mapQuest[QuestType.Demon] ~= nil then
    for nId, v in pairs(self._mapQuest[QuestType.Demon]) do
      local mapCfg = ConfigTable.GetData("DemonQuest", nId)
      if mapCfg ~= nil and mapCfg.AdvanceGroup == nGroupId then
        v.nStatus = 2
      end
    end
  end
end

function PlayerQuestData:GetDemonQuestData(nGroupId, nStageId)
  local tbQuest = {}
  if self._mapQuest[QuestType.Demon] == nil then
    self._mapQuest[QuestType.Demon] = {}
  end
  for nId, v in pairs(self._mapQuest[QuestType.Demon]) do
    local mapCfg = ConfigTable.GetData("DemonQuest", nId)
    if mapCfg ~= nil and mapCfg.AdvanceGroup == nGroupId then
      table.insert(tbQuest, v)
    end
  end
  if #tbQuest == 0 then
    local nCurStageId = PlayerData.Base:GetCurWorldClassStageId()
    local tbAllQuest = CacheTable.GetData("_DemonQuest", nGroupId)
    if tbAllQuest ~= nil and 0 < #tbAllQuest then
      for _, v in ipairs(tbAllQuest) do
        table.insert(tbQuest, {
          nTid = v.Id,
          nGoal = 1,
          nCurProgress = 0,
          nStatus = nStageId < nCurStageId and 2 or 0,
          nExpire = 0
        })
      end
    end
  end
  table.sort(tbQuest, function(a, b)
    if a.nStatus == b.nStatus then
      return a.nTid < b.nTid
    end
    return a.nStatus < b.nStatus
  end)
  return tbQuest
end

function PlayerQuestData:OnQuestProgressChanged(mapData)
  local nCur = mapData.Progress[1] == nil and 0 or mapData.Progress[1].Cur
  print(string.format("任务进度变更 ID:%d 当前进度:%d 当前状态:%d", mapData.Id, nCur, mapData.Status))
  if QuestType[mapData.Type] == nil then
    return
  end
  if self._mapQuest[QuestType[mapData.Type]] == nil then
    self._mapQuest[QuestType[mapData.Type]] = {}
  end
  if #mapData.Progress == 0 then
    printError("没有任务进度：" .. mapData.Id)
    return
  end
  self._mapQuest[QuestType[mapData.Type]][mapData.Id] = {
    nTid = mapData.Id,
    nGoal = mapData.Progress[1].Max,
    nCurProgress = mapData.Status ~= 2 and mapData.Progress[1].Cur or mapData.Progress[1].Max,
    nStatus = mapData.Status,
    nExpire = mapData.Expire
  }
  EventManager.Hit(EventId.QuestDataRefresh, mapData.Type)
end

function PlayerQuestData:ReceiveTourReward(nTid, callback)
  local msg = {Value = nTid}
  local tbReceivedId = {}
  if nTid == 0 then
    for nId, mapQuestData in pairs(self._mapQuest[QuestType.TourGuide]) do
      if mapQuestData.nStatus == 1 then
        table.insert(tbReceivedId, nId)
      end
    end
  end
  
  local function Callback(_, mapMsgData)
    if nTid == 0 then
      for _, nQuestId in ipairs(tbReceivedId) do
        self._mapQuest[QuestType.TourGuide][nQuestId].nStatus = 2
        self._mapQuest[QuestType.TourGuide][nQuestId].nCurProgress = 1
        self._mapQuest[QuestType.TourGuide][nQuestId].nGoal = 1
      end
    else
      self._mapQuest[QuestType.TourGuide][nTid].nStatus = 2
      self._mapQuest[QuestType.TourGuide][nTid].nCurProgress = 1
      self._mapQuest[QuestType.TourGuide][nTid].nGoal = 1
    end
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    local bWasInBatch = self._bInBatchReceive
    if callback ~= nil then
      callback(mapMsgData)
    end
    if not bWasInBatch then
      EventManager.Hit(EventId.TourQuestReceived, mapMsgData.Rewards, mapMsgData.Change)
    end
    self:UpdateQuestRedDot("TourGuide")
  end
  
  PlayerData.State:SetMailOverflow(false)
  HttpNetHandler.SendMsg(NetMsgId.Id.quest_tour_guide_reward_receive_req, msg, nil, Callback)
end

function PlayerQuestData:ReceiveTourGroupReward(callback)
  local function Callback(_, mapMsgData)
    self.nCurTourGroupOrderIndex = self.nCurTourGroupOrderIndex + 1
    
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    local bWasInBatch = self._bInBatchReceive
    if callback ~= nil then
      callback(mapMsgData)
    end
    if not bWasInBatch then
      EventManager.Hit(EventId.TourGroupReceived, mapMsgData.Rewards, mapMsgData.Change)
    end
    self:UpdateQuestRedDot("TourGuide")
  end
  
  PlayerData.State:SetMailOverflow(false)
  HttpNetHandler.SendMsg(NetMsgId.Id.quest_tour_guide_group_reward_receive_req, {}, nil, Callback)
end

function PlayerQuestData:ReceiveTeamFormationReward(nTid, nGroupId, callback)
  local msg = {Group = nGroupId, Quest = nTid}
  local tbReceivedId = {}
  if nTid == 0 and nGroupId ~= 0 then
    for _, mapData in pairs(self.tbTeamFormation) do
      if mapData.QuestGroup == nGroupId then
        local mapQuestData = self._mapQuest[QuestType.Assist][mapData.Id]
        if mapQuestData.nStatus == 1 then
          table.insert(tbReceivedId, mapData.Id)
        end
      end
    end
  end
  
  local function Callback(_, mapMsgData)
    if nTid == 0 and nGroupId ~= 0 then
      for _, nQuestId in ipairs(tbReceivedId) do
        self._mapQuest[QuestType.Assist][nQuestId].nStatus = 2
        self._mapQuest[QuestType.Assist][nQuestId].nCurProgress = 1
        self._mapQuest[QuestType.Assist][nQuestId].nGoal = 1
      end
    elseif nTid ~= 0 and nGroupId == 0 then
      self._mapQuest[QuestType.Assist][nTid].nStatus = 2
      self._mapQuest[QuestType.Assist][nTid].nCurProgress = 1
      self._mapQuest[QuestType.Assist][nTid].nGoal = 1
    end
    local tbItem = {}
    if 0 < #tbReceivedId then
      for _, nQuestId in pairs(tbReceivedId) do
        local mapQuestData = ConfigTable.GetData("AssistQuest", nQuestId)
        if mapQuestData ~= nil then
          for i = 1, 4 do
            local nItemId = mapQuestData["Item" .. i]
            local nQty = mapQuestData["Qty" .. i]
            if nItemId ~= 0 and 0 < nQty then
              local bFoundInTable = false
              for k, dataItem in pairs(tbItem) do
                if dataItem.Tid == nItemId then
                  dataItem.Qty = dataItem.Qty + nQty
                  bFoundInTable = true
                  break
                end
              end
              if not bFoundInTable then
                table.insert(tbItem, {Tid = nItemId, Qty = nQty})
              end
            end
          end
        end
      end
    else
      local mapQuestData = ConfigTable.GetData("AssistQuest", nTid)
      if mapQuestData ~= nil then
        for i = 1, 4 do
          local nItemId = mapQuestData["Item" .. i]
          local nQty = mapQuestData["Qty" .. i]
          if nItemId ~= 0 and 0 < nQty then
            local bFoundInTable = false
            for k, dataItem in pairs(tbItem) do
              if dataItem.Tid == nItemId then
                dataItem.Qty = dataItem.Qty + nQty
                bFoundInTable = true
                break
              end
            end
            if not bFoundInTable then
              table.insert(tbItem, {Tid = nItemId, Qty = nQty})
            end
          end
        end
      end
    end
    
    local function cb()
      EventManager.Hit("UpdateTeamFormationGroup")
    end
    
    if not self._bInBatchReceive then
      UTILS.OpenReceiveByDisplayItem(tbItem, mapMsgData, cb)
    end
    self:UpdateQuestRedDot("Assist")
    if callback ~= nil then
      callback(mapMsgData, tbItem, mapMsgData)
    end
  end
  
  PlayerData.State:SetMailOverflow(false)
  HttpNetHandler.SendMsg(NetMsgId.Id.quest_assist_reward_receive_req, msg, nil, Callback)
end

function PlayerQuestData:ReceiveTeamFormationGroupReward(nGroupId, nAttributeIdx, callback)
  local msg = {Value = nGroupId}
  
  local function Callback(_, mapMsgData)
    if mapMsgData.BuildInfo ~= nil then
      if mapMsgData.BuildInfo.Brief ~= nil then
        PlayerData.Build:CacheRogueBuild(mapMsgData.BuildInfo)
      elseif mapMsgData.BuildInfo.BuildCoin ~= nil and mapMsgData.BuildInfo.BuildCoin > 0 then
        local function checkLimitCb()
          local nLimit = PlayerData.StarTower:GetStarTowerRewardLimit()
          
          local nCur = PlayerData.StarTower:GetStarTowerTicket()
          if nLimit < mapMsgData.BuildInfo.BuildCoin + nCur then
            local sTip = ConfigTable.GetUIText("BUILD_12")
            EventManager.Hit(EventId.OpenMessageBox, sTip)
          end
          local encodeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
          if encodeInfo["proto.Res"] ~= nil then
            for _, mapCoin in ipairs(encodeInfo["proto.Res"]) do
              if mapCoin.Tid == AllEnum.CoinItemId.FRRewardCurrency then
                PlayerData.StarTower:AddStarTowerTicket(mapCoin.Qty)
              end
            end
          end
        end
        
        PlayerData.StarTower:SendTowerGrowthDetailReq(checkLimitCb)
      end
    end
    local nNextGroupIdx = self:GetTeamFormationGroupIndexInAttribute(nGroupId)
    self.tbCurTeamFormationGroupIndex[nAttributeIdx] = nNextGroupIdx
    local bAttributeComplete = self:CheckTeamFormationAttributeCompleted(nAttributeIdx)
    local nNextGroupId = 0
    for i = 1, #self.tbTeamFormationGroup do
      if self.tbTeamFormationGroup[i].PreGroup == nGroupId then
        nNextGroupId = self.tbTeamFormationGroup[i].Id
        break
      end
    end
    local tbItem = {}
    local mapQuest = ConfigTable.GetData("AssistQuestGroup", nGroupId)
    if mapQuest ~= nil then
      for i = 1, 5 do
        local nItemId = mapQuest["Item" .. i]
        local nQty = mapQuest["Qty" .. i]
        if nItemId ~= 0 and 0 < nQty then
          local bFoundInTable = false
          for k, dataItem in pairs(tbItem) do
            if dataItem.Tid == nItemId then
              dataItem.Qty = dataItem.Qty + nQty
              bFoundInTable = true
              break
            end
          end
          if not bFoundInTable then
            table.insert(tbItem, {Tid = nItemId, Qty = nQty})
          end
        end
      end
      if mapMsgData.BuildInfo ~= nil and mapMsgData.BuildInfo.Brief ~= nil then
        table.insert(tbItem, {
          Tid = mapQuest.ShowBuildId,
          Qty = 1
        })
      end
    end
    
    local function cb()
      EventManager.Hit("UpdateTeamFormationGroup", bAttributeComplete, nNextGroupId)
    end
    
    if not self._bInBatchReceive then
      UTILS.OpenReceiveByDisplayItem(tbItem, mapMsgData.Change, cb)
    end
    self:UpdateQuestRedDot("Assist")
    if callback ~= nil then
      callback(mapMsgData, tbItem, mapMsgData.Change, bAttributeComplete, nNextGroupId)
    end
  end
  
  PlayerData.State:SetMailOverflow(false)
  HttpNetHandler.SendMsg(NetMsgId.Id.quest_assist_group_reward_receive_req, msg, nil, Callback)
end

function PlayerQuestData:SetBatchReceiveFlag(bOn)
  self._nBatchReceiveCount = self._nBatchReceiveCount or 0
  if bOn then
    self._nBatchReceiveCount = self._nBatchReceiveCount + 1
  else
    self._nBatchReceiveCount = self._nBatchReceiveCount - 1
    if self._nBatchReceiveCount < 0 then
      self._nBatchReceiveCount = 0
    end
  end
  self._bInBatchReceive = self._nBatchReceiveCount > 0
end

function PlayerQuestData:ReceiveDailyReward(nTid, callback)
  local msg = {Value = nTid}
  local tbReceivedId = {}
  for nId, mapQuestData in pairs(self._mapQuest[QuestType.Daily]) do
    local questCfg = ConfigTable.GetData("DailyQuest", nId)
    if nil ~= questCfg and nTid == 0 and mapQuestData.nStatus == 1 then
      table.insert(tbReceivedId, nId)
    end
  end
  
  local function Callback(_, mapMsgData)
    if nTid == 0 then
      for _, nId in ipairs(tbReceivedId) do
        if self._mapQuest[QuestType.Daily][nId].nStatus == 1 then
          self._mapQuest[QuestType.Daily][nId].nStatus = 2
          self._mapQuest[QuestType.Daily][nId].nCurProgress = 1
          self._mapQuest[QuestType.Daily][nId].nGoal = 1
        end
      end
    else
      self._mapQuest[QuestType.Daily][nTid].nStatus = 2
      self._mapQuest[QuestType.Daily][nTid].nCurProgress = 1
      self._mapQuest[QuestType.Daily][nTid].nGoal = 1
      table.insert(tbReceivedId, nTid)
    end
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    local bWasInBatch = self._bInBatchReceive
    if callback ~= nil then
      callback(mapDecodedChangeInfo, mapMsgData)
    end
    if not bWasInBatch then
      EventManager.Hit(EventId.DailyQuestReceived, mapMsgData)
    end
    self:UpdateQuestRedDot("Daily")
  end
  
  PlayerData.State:SetMailOverflow(false)
  HttpNetHandler.SendMsg(NetMsgId.Id.quest_daily_reward_receive_req, msg, nil, Callback)
end

function PlayerQuestData:ReceiveDailyActiveReward(callBack)
  local function callback(_, mapMsgData)
    local tbReward = {}
    
    for _, v in ipairs(mapMsgData.ActiveIds) do
      self.tbDailyActives[v].bReward = true
      local mapCfg = ConfigTable.GetData("DailyQuestActive", v)
      if mapCfg ~= nil then
        for i = 1, 2 do
          if mapCfg["ItemTid" .. i] ~= 0 then
            if tbReward[mapCfg["ItemTid" .. i]] == nil then
              tbReward[mapCfg["ItemTid" .. i]] = 0
            end
            tbReward[mapCfg["ItemTid" .. i]] = tbReward[mapCfg["ItemTid" .. i]] + mapCfg["Number" .. i]
          end
        end
      end
    end
    self:UpdateDailyQuestRedDot()
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    local tbShowReward = {}
    for id, count in pairs(tbReward) do
      table.insert(tbShowReward, {id = id, count = count})
    end
    local bWasInBatch = self._bInBatchReceive
    if callBack ~= nil then
      callBack(tbShowReward, mapDecodedChangeInfo)
    end
    if not bWasInBatch then
      EventManager.Hit(EventId.DailyQuestActiveReceived, tbShowReward)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.quest_daily_active_reward_receive_req, {}, nil, callback)
end

function PlayerQuestData:ReceiveWeeklyReward(nTid, callback)
  local msg = {Value = nTid}
  local tbReceivedId = {}
  for nId, mapQuestData in pairs(self._mapQuest[QuestType.Weekly]) do
    local questCfg = ConfigTable.GetData("WeeklyQuest", nId)
    if nil ~= questCfg and nTid == 0 and mapQuestData.nStatus == 1 then
      table.insert(tbReceivedId, nId)
    end
  end
  
  local function Callback(_, mapMsgData)
    if nTid == 0 then
      for _, nId in ipairs(tbReceivedId) do
        if self._mapQuest[QuestType.Weekly][nId].nStatus == 1 then
          self._mapQuest[QuestType.Weekly][nId].nStatus = 2
          self._mapQuest[QuestType.Weekly][nId].nCurProgress = 1
          self._mapQuest[QuestType.Weekly][nId].nGoal = 1
        end
      end
    else
      self._mapQuest[QuestType.Weekly][nTid].nStatus = 2
      self._mapQuest[QuestType.Weekly][nTid].nCurProgress = 1
      self._mapQuest[QuestType.Weekly][nTid].nGoal = 1
      table.insert(tbReceivedId, nTid)
    end
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    local bWasInBatch = self._bInBatchReceive
    if callback ~= nil then
      callback(mapDecodedChangeInfo, mapMsgData)
    end
    if not bWasInBatch then
      EventManager.Hit(EventId.WeeklyQuestReceived, mapMsgData)
    end
    self:UpdateQuestRedDot("Weekly")
  end
  
  PlayerData.State:SetMailOverflow(false)
  HttpNetHandler.SendMsg(NetMsgId.Id.quest_weekly_reward_receive_req, msg, nil, Callback)
end

function PlayerQuestData:ReceiveWeeklyActiveReward(callBack)
  local function callback(_, mapMsgData)
    local tbReward = {}
    
    for _, v in ipairs(mapMsgData.ActiveIds) do
      self.tbWeeklyActives[v].bReward = true
      local mapCfg = ConfigTable.GetData("WeeklyQuestActive", v)
      if mapCfg ~= nil then
        for i = 1, 2 do
          if mapCfg["ItemTid" .. i] ~= 0 then
            if tbReward[mapCfg["ItemTid" .. i]] == nil then
              tbReward[mapCfg["ItemTid" .. i]] = 0
            end
            tbReward[mapCfg["ItemTid" .. i]] = tbReward[mapCfg["ItemTid" .. i]] + mapCfg["Number" .. i]
          end
        end
      end
    end
    self:UpdateWeeklyQuestRedDot()
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    local tbShowReward = {}
    for id, count in pairs(tbReward) do
      table.insert(tbShowReward, {id = id, count = count})
    end
    local bWasInBatch = self._bInBatchReceive
    if callBack ~= nil then
      callBack(tbShowReward, mapDecodedChangeInfo)
    end
    if not bWasInBatch then
      EventManager.Hit(EventId.WeeklyQuestActiveReceived, tbShowReward)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.quest_weekly_active_reward_receive_req, {}, nil, callback)
end

function PlayerQuestData:ReceiveTravelerDuelReward(nTid, callback)
  local msg = {Id = nTid, Type = 3}
  local tbReceivedId = {}
  if nTid == 0 then
    for nId, mapQuestData in pairs(self._mapQuest[QuestType.TravelerDuel]) do
      if mapQuestData.nStatus == 1 then
        table.insert(tbReceivedId, nId)
      end
    end
  end
  
  local function Callback(_, mapMsgData)
    if nTid == 0 then
      for _, nId in ipairs(tbReceivedId) do
        if self._mapQuest[QuestType.TravelerDuel][nId].nStatus == 1 then
          self._mapQuest[QuestType.TravelerDuel][nId].nStatus = 2
          self._mapQuest[QuestType.TravelerDuel][nId].nCurProgress = 1
          self._mapQuest[QuestType.TravelerDuel][nId].nGoal = 1
        end
      end
    else
      self._mapQuest[QuestType.TravelerDuel][nTid].nStatus = 2
      self._mapQuest[QuestType.TravelerDuel][nTid].nCurProgress = 1
      self._mapQuest[QuestType.TravelerDuel][nTid].nGoal = 1
      table.insert(tbReceivedId, nTid)
    end
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    if callback ~= nil then
      callback()
    end
    EventManager.Hit(EventId.TRNormalQusetReceived, mapMsgData.QuestRewards, tbReceivedId, mapMsgData.Change)
    self:UpdateQuestRedDot("TravelerDuel")
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.traveler_duel_quest_reward_receive_req, msg, nil, Callback)
end

function PlayerQuestData:ReceiveTravelerDuelChallengeReward(nTid, callback)
  local msg = {Id = nTid, Type = 4}
  local tbReceivedId = {}
  if nTid == 0 then
    for nId, mapQuestData in pairs(self._mapQuest[QuestType.TravelerDuelChallenge]) do
      if mapQuestData.nStatus == 1 then
        table.insert(tbReceivedId, nId)
      end
    end
  end
  
  local function Callback(_, mapMsgData)
    if nTid == 0 then
      for _, nId in ipairs(tbReceivedId) do
        if self._mapQuest[QuestType.TravelerDuelChallenge][nId].nStatus == 1 then
          self._mapQuest[QuestType.TravelerDuelChallenge][nId].nStatus = 2
          self._mapQuest[QuestType.TravelerDuelChallenge][nId].nCurProgress = 1
          self._mapQuest[QuestType.TravelerDuelChallenge][nId].nGoal = 1
        end
      end
    else
      self._mapQuest[QuestType.TravelerDuelChallenge][nTid].nStatus = 2
      self._mapQuest[QuestType.TravelerDuelChallenge][nTid].nCurProgress = 1
      self._mapQuest[QuestType.TravelerDuelChallenge][nTid].nGoal = 1
      table.insert(tbReceivedId, nTid)
    end
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    if callback ~= nil then
      callback()
    end
    EventManager.Hit(EventId.TRChallengeQusetReceived, mapMsgData.QuestRewards, tbReceivedId, mapMsgData.Change)
    self:UpdateQuestRedDot("TravelerDuelChallenge")
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.traveler_duel_quest_reward_receive_req, msg, nil, Callback)
end

function PlayerQuestData:ReceiveBattlePassQuestData(nTid, callback)
  local function msgCallback(_, msgData)
    if nTid == 0 then
      for _, mapQuest in pairs(self._mapQuest[6]) do
        if mapQuest.nStatus == 1 then
          mapQuest.nStatus = 2
        end
      end
      for _, mapQuest in pairs(self._mapQuest[7]) do
        if mapQuest.nStatus == 1 then
          mapQuest.nStatus = 2
        end
      end
    else
      local mapQuestCfgData = ConfigTable.GetData("BattlePassQuest", nTid)
      if mapQuestCfgData ~= nil then
        if mapQuestCfgData.Type == GameEnum.battlePassQuestType.DAY then
          if self._mapQuest[6][nTid] ~= nil then
            self._mapQuest[6][nTid].nStatus = 2
          end
        elseif self._mapQuest[7][nTid] ~= nil then
          self._mapQuest[7][nTid].nStatus = 2
        end
      end
    end
    EventManager.Hit("BattlePassQuestReceive", msgData)
    if callback ~= nil and type(callback) == "function" then
      callback()
    end
    self:UpdateBattlePassRedDot()
  end
  
  local msg = {Value = nTid}
  HttpNetHandler.SendMsg(NetMsgId.Id.battle_pass_quest_reward_receive_req, msg, nil, msgCallback)
end

function PlayerQuestData:ReceiveAffinityReward(questIds, curCharId, callback)
  local msg = {CharId = curCharId, QuestId = 0}
  
  local function Callback(_, mapMsgData)
    if self._mapQuest[QuestType.Affinity] == nil then
      self._mapQuest[QuestType.Affinity] = {}
    end
    for k, v in ipairs(questIds) do
      if self._mapQuest[QuestType.Affinity][v] ~= nil then
        self._mapQuest[QuestType.Affinity][v].nStatus = 2
      else
        local data = {
          nTid = v,
          nGoal = 1,
          nCurProgress = 1,
          nStatus = 2
        }
        self._mapQuest[QuestType.Affinity][v] = data
      end
    end
    if callback ~= nil then
      callback()
    end
    self:UpdateCharAffinityRedDot()
    EventManager.Hit(EventId.AffinityQuestReceived)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.char_affinity_quest_reward_receive_req, msg, nil, Callback)
end

function PlayerQuestData:ReceiveStarTowerReward(nTid, callback)
  local msg = {Value = nTid}
  local tbReceivedId = {}
  if nTid == 0 then
    for nId, mapQuestData in pairs(self._mapQuest[QuestType.Tower]) do
      if mapQuestData.nStatus == 1 then
        table.insert(tbReceivedId, nId)
      end
    end
  end
  
  local function Callback(_, mapMsgData)
    if nTid == 0 then
      for _, nId in ipairs(tbReceivedId) do
        if self._mapQuest[QuestType.Tower][nId].nStatus == 1 then
          self._mapQuest[QuestType.Tower][nId].nStatus = 2
          self._mapQuest[QuestType.Tower][nId].nCurProgress = 1
          self._mapQuest[QuestType.Tower][nId].nGoal = 1
        end
      end
    else
      self._mapQuest[QuestType.Tower][nTid].nStatus = 2
      self._mapQuest[QuestType.Tower][nTid].nCurProgress = 1
      self._mapQuest[QuestType.Tower][nTid].nGoal = 1
      table.insert(tbReceivedId, nTid)
    end
    UTILS.OpenReceiveByChangeInfo(mapMsgData, function()
      if callback ~= nil then
        callback()
      end
      EventManager.Hit("StarTowerQuestReceived")
    end)
    self:UpdateQuestRedDot("Tower")
  end
  
  PlayerData.State:SetMailOverflow(false)
  HttpNetHandler.SendMsg(NetMsgId.Id.quest_tower_reward_receive_req, msg, nil, Callback)
end

function PlayerQuestData:ReceiveStarTowerEventReward(nTid, callback)
  local function sucCall(_, mapMsgData)
    for _, v in ipairs(mapMsgData.ReceivedIds) do
      if self._mapQuest[12] ~= nil and self._mapQuest[12][v] ~= nil then
        self._mapQuest[12][v].nStatus = 2
        
        self._mapQuest[12][v].nCurProgress = 0
        self._mapQuest[12][v].nGoal = 0
      end
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_Event_Reward, v, false)
    end
    UTILS.OpenReceiveByChangeInfo(mapMsgData.Change, callback)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_book_event_reward_receive_req, {Value = nTid}, nil, sucCall)
end

function PlayerQuestData:CacheAllQuest(tbQuests)
  local tbQuestType = {}
  for _, mapQuest in pairs(tbQuests) do
    self:OnQuestProgressChanged(mapQuest)
    if nil == tbQuestType[mapQuest.Type] then
      tbQuestType[mapQuest.Type] = 1
    end
  end
  for questType, v in pairs(tbQuestType) do
    self:UpdateQuestRedDot(questType)
  end
end

function PlayerQuestData:CacheDailyActiveIds(tbIds)
  for _, v in ipairs(tbIds) do
    self.tbDailyActives[v].bReward = true
  end
  self:UpdateDailyQuestRedDot()
end

function PlayerQuestData:CacheWeeklyActiveIds(tbIds)
  self.nextWeekRefreshTime = GetNextWeekRefreshTime()
  for _, v in ipairs(tbIds) do
    self.tbWeeklyActives[v].bReward = true
  end
  self:UpdateWeeklyQuestRedDot()
end

function PlayerQuestData:CacheTourGroupOrder(nIndex)
  self.nCurTourGroupOrderIndex = nIndex
end

function PlayerQuestData:CacheTeamFormation(mapData)
  self.tbCurTeamFormationGroupIndex = {}
  for k, v in pairs(mapData) do
    local nIdxInGroup = 0
    for nGroupIdx, mapGroup in pairs(self.tbTeamFormationGroup) do
      if v.Attribute == mapGroup.AttributeId then
        nIdxInGroup = nIdxInGroup + 1
        if mapGroup.Id == v.Group then
          break
        end
      end
    end
    self.tbCurTeamFormationGroupIndex[v.Attribute] = nIdxInGroup
  end
end

function PlayerQuestData:CheckClientType(nEventType)
  local tbQuestId = {}
  for nQuestType, tbQuestList in pairs(self._mapQuest) do
    for _, mapQuest in pairs(tbQuestList) do
      local nClientType
      if nQuestType == QuestType.Daily then
        local mapQuestCfg = ConfigTable.GetData("DailyQuest", mapQuest.nTid)
        if mapQuestCfg ~= nil then
          nClientType = mapQuestCfg.CompleteCondClient
        end
      end
      if nClientType == nEventType and mapQuest.nStatus == 0 then
        table.insert(tbQuestId, mapQuest.nTid)
      end
    end
  end
  return tbQuestId
end

function PlayerQuestData:HandleExpire()
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local tbExpire = {}
  if self._mapQuest[2] ~= nil then
    for nTid, mapQuest in pairs(self._mapQuest[2]) do
      if mapQuest.nExpire > 0 and curTime >= mapQuest.nExpire then
        table.insert(tbExpire, nTid)
      end
    end
    for _, nTid in ipairs(tbExpire) do
      self._mapQuest[2][nTid] = nil
    end
  end
  tbExpire = {}
  if self._mapQuest[6] ~= nil then
    for nTid, mapQuest in pairs(self._mapQuest[6]) do
      if mapQuest.nExpire > 0 and curTime >= mapQuest.nExpire then
        table.insert(tbExpire, nTid)
      end
    end
    for _, nTid in ipairs(tbExpire) do
      self._mapQuest[6][nTid] = nil
    end
  end
  tbExpire = {}
  if self._mapQuest[7] ~= nil then
    for nTid, mapQuest in pairs(self._mapQuest[7]) do
      if mapQuest.nExpire > 0 and curTime >= mapQuest.nExpire then
        table.insert(tbExpire, nTid)
      end
    end
    for _, nTid in ipairs(tbExpire) do
      self._mapQuest[7][nTid] = nil
    end
  end
  for _, v in pairs(self.tbDailyActives) do
    v.bReward = false
  end
  if curTime > self.nextWeekRefreshTime then
    for _, v in pairs(self.tbWeeklyActives) do
      v.bReward = false
    end
    self.nextWeekRefreshTime = GetNextWeekRefreshTime()
  end
  self:UpdateDailyQuestRedDot()
  self:UpdateWeeklyQuestRedDot()
  self:UpdateBattlePassRedDot()
  self:UpdateVampireQuestRedDot()
  self:UpdateTeamFormationRedDot()
  self:UpdateDormQuestRedDot()
end

function PlayerQuestData:IsQuestHasReceived(nType, nQuestId)
  if self._mapQuest[nType] == nil then
    printError("没有记录的任务类型数据：" .. nQuestId)
    return false
  end
  if self._mapQuest[nType][nQuestId] == nil then
    printError("没有记录的任务组数据：" .. nQuestId)
    return false
  end
  return self._mapQuest[nType][nQuestId].nStatus == 2
end

function PlayerQuestData:SendClientEvent(nEventType, nCount)
  if nCount == nil then
    nCount = 1
  end
  local tbQuestId = self:CheckClientType(nEventType)
  if 0 < #tbQuestId then
    local tbSendData = {}
    for _, v in ipairs(tbQuestId) do
      table.insert(tbSendData, {
        Id = GameEnum.eventTypes.eClient,
        Data = {nCount, v}
      })
    end
    local msgData = {List = tbSendData}
    HttpNetHandler.SendMsg(NetMsgId.Id.client_event_report_req, msgData, nil, nil)
  end
end

function PlayerQuestData:UpdateServerQuestRedDot(mapMsgData)
  if nil == mapMsgData then
    return
  end
  local redDotType = QuestRedDotType[mapMsgData.Type]
  if nil ~= redDotType then
    RedDotManager.SetValid(redDotType, nil, mapMsgData.New)
  end
end

function PlayerQuestData:UpdateQuestRedDot(questType)
  if nil == questType then
    return
  end
  if questType == "Daily" then
    self:UpdateDailyQuestRedDot()
  elseif questType == "TourGuide" then
    self:UpdateTourGuideQuestRedDot()
  elseif questType == "Affinity" then
    self:UpdateCharAffinityRedDot()
  elseif questType == "TravelerDuel" or questType == "TravelerDuelChallenge" then
    self:UpdateDuelQuestRedDot(questType)
  elseif questType == "BattlePassDaily" or questType == "BattlePassWeekly" then
    self:UpdateBattlePassRedDot()
  elseif questType == "Tower" then
    self:UpdateStarTowerQuestRedDot()
  elseif questType == "Demon" then
    PlayerData.Base:RefreshWorldClassRedDot()
  elseif questType == "VampireSurvivorSeason" or questType == "VampireSurvivorNormal" then
    self:UpdateVampireQuestRedDot()
  elseif questType == "TowerEvent" then
    self:UpdateStarTowerBookQuestRedDot()
  elseif questType == "Weekly" then
    self:UpdateWeeklyQuestRedDot()
  elseif questType == "Assist" then
    self:UpdateTeamFormationRedDot()
  elseif questType == "GuideMission" then
    self:UpdateGuideMissionQuestRedDot()
  elseif questType == "Dorm" then
    self:UpdateDormQuestRedDot()
  end
end

function PlayerQuestData:UpdateDailyQuestRedDot()
  local bCanReceive = false
  local bActiveReward = false
  local nTotalActiveCount = 0
  local questList = self._mapQuest[QuestType.Daily]
  if nil ~= questList then
    for _, v in pairs(questList) do
      if v.nStatus == 1 then
        bCanReceive = true
      elseif v.nStatus == 2 then
        local questCfg = ConfigTable.GetData("DailyQuest", v.nTid)
        if questCfg ~= nil then
          nTotalActiveCount = nTotalActiveCount + questCfg.Active
        end
      end
    end
  end
  for _, v in pairs(self.tbDailyActives) do
    bActiveReward = bActiveReward or nTotalActiveCount >= v.nActive and v.bReward == false
  end
  local bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.DailyQuest, false)
  RedDotManager.SetValid(RedDotDefine.Task_Daily, nil, (bCanReceive or bActiveReward) and bFuncUnlock)
end

function PlayerQuestData:UpdateWeeklyQuestRedDot()
  local bCanReceive = false
  local bActiveReward = false
  local nTotalActiveCount = 0
  local questList = self._mapQuest[QuestType.Weekly]
  if nil ~= questList then
    for _, v in pairs(questList) do
      if v.nStatus == 1 then
        bCanReceive = true
      elseif v.nStatus == 2 then
        local questCfg = ConfigTable.GetData("WeeklyQuest", v.nTid)
        if questCfg ~= nil then
          nTotalActiveCount = nTotalActiveCount + questCfg.Active
        end
      end
    end
  end
  for _, v in pairs(self.tbWeeklyActives) do
    bActiveReward = bActiveReward or nTotalActiveCount >= v.nActive and v.bReward == false
  end
  local bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.WeeklyQuest, false)
  RedDotManager.SetValid(RedDotDefine.Task_Weekly, nil, (bCanReceive or bActiveReward) and bFuncUnlock)
end

function PlayerQuestData:UpdateTeamFormationRedDot()
  local bCanReceive = false
  local bAllReceive = true
  local nAttr = 1
  local nFinish = 0
  
  local function foreachAttri(mapData)
    nFinish = nFinish + 1
  end
  
  ForEachTableLine(DataTable.AssistAttribute, foreachAttri)
  for i = 1, nFinish do
    local bComp = self:CheckTeamFormationAttributeCompleted(i)
    if not bComp then
      nAttr = i
      break
    end
    if i == nFinish then
      nAttr = i
    end
  end
  local nCurGroupId = self:GetCurTeamFormationQuestGroup(nAttr)
  local questList = self._mapQuest[QuestType.Assist]
  if nil ~= questList then
    for _, v in pairs(questList) do
      local questCfg = ConfigTable.GetData("AssistQuest", v.nTid)
      if nil ~= questCfg and nCurGroupId == questCfg.QuestGroup then
        if v.nStatus == 1 then
          bCanReceive = true
        end
        if v.nStatus ~= 2 then
          bAllReceive = false
        end
      end
    end
  end
  local bGroupReceived = true
  if nCurGroupId ~= 0 then
    local nIdx = self:GetTeamFormationGroupIndexInAttribute(nCurGroupId)
    bGroupReceived = self:CheckTeamFormationGroupReward(nAttr, nIdx)
  end
  local bChapterCanReceive = bAllReceive and not bGroupReceived
  local nSelectedTeam = LocalData.GetPlayerLocalData("TeamFormationQuestSelected")
  local bTeamSelected = nSelectedTeam ~= nil
  RedDotManager.SetValid(RedDotDefine.TaskNewbie_TeamFormation, nil, bCanReceive or bChapterCanReceive or not bTeamSelected)
end

function PlayerQuestData:UpdateGuideMissionQuestRedDot()
  local tbGroupCanReceive = {}
  local questList = self._mapQuest[QuestType.GuideMission]
  if nil ~= questList then
    for _, v in pairs(questList) do
      local questCfg = ConfigTable.GetData("GuideMissionQuest", v.nTid)
      local groupCfg = questCfg ~= nil and ConfigTable.GetData("GuideMissionQuestGroup", questCfg.GroupId) or nil
      if nil ~= groupCfg then
        local nChapterId = groupCfg.ChapterId
        local nGroupId = groupCfg.Id
        if tbGroupCanReceive[nChapterId] == nil then
          tbGroupCanReceive[nChapterId] = {}
        end
        tbGroupCanReceive[nChapterId][nGroupId] = tbGroupCanReceive[nChapterId][nGroupId] or v.nStatus == 1
      end
    end
  end
  local tbChapterList = PlayerData.GuideMission ~= nil and PlayerData.GuideMission:GetChapterList() or nil
  if nil == tbChapterList then
    return
  end
  for _, mapChapter in ipairs(tbChapterList) do
    local tbChapterGroupList = PlayerData.Quest:GetGuideMissionQuestGroupByChapter(mapChapter.Id)
    if nil ~= tbChapterGroupList then
      for _, mapGroup in ipairs(tbChapterGroupList) do
        local bCanReceive = tbGroupCanReceive[mapChapter.Id] ~= nil and tbGroupCanReceive[mapChapter.Id][mapGroup.Id] or false
        local bUnlock = PlayerData.GuideMission:IsGroupUnlock(mapChapter.Id, mapGroup.Id)
        RedDotManager.SetValid(RedDotDefine.GuideMission_Group, {
          mapChapter.Id,
          mapGroup.Id
        }, bCanReceive and bUnlock)
      end
    end
  end
end

function PlayerQuestData:UpdateTourGuideQuestRedDot()
  local bCanReceive = false
  local bAllReceive = true
  local nCurGroupId = self:GetCurTourGroup()
  local questList = self._mapQuest[QuestType.TourGuide]
  if nil ~= questList then
    for _, v in pairs(questList) do
      if v.nStatus == 1 then
        local questCfg = ConfigTable.GetData("TourGuideQuest", v.nTid)
        if nil ~= questCfg and nCurGroupId == questCfg.Order then
          bCanReceive = true
          break
        end
      end
      if v.nStatus ~= 2 then
        bAllReceive = false
      end
    end
  end
  local bGroupReceived = self:CheckTourGroupReward(self:GetCurTourGroupOrder())
  local bChapterCanReceive = bAllReceive and not bGroupReceived
  RedDotManager.SetValid(RedDotDefine.Task_Guide, nil, bCanReceive or bChapterCanReceive)
end

function PlayerQuestData:UpdateDuelQuestRedDot(questType)
  local bCanReceive = false
  local questList = self._mapQuest[QuestType[questType]]
  if nil ~= questList then
    for _, v in pairs(questList) do
      if v.nStatus == 1 then
        bCanReceive = true
        break
      end
    end
  end
  RedDotManager.SetValid(QuestRedDotType[questType], nil, bCanReceive)
end

function PlayerQuestData:UpdateCharAffinityRedDot()
  if self.tbCharQuest == nil then
    self.tbCharQuest = {}
  end
  local questList = self._mapQuest[QuestType.Affinity]
  if nil ~= questList then
    for k, v in pairs(questList) do
      local data = ConfigTable.GetData("AffinityQuest", v.nTid)
      if data ~= nil then
        if self.tbCharQuest[data.CharId] == nil then
          self.tbCharQuest[data.CharId] = {}
        end
        table.insert(self.tbCharQuest[data.CharId], v)
      end
    end
    local tbCharList = {}
    for k, list in pairs(self.tbCharQuest) do
      for i = 1, #list do
        local state = list[i].nStatus
        if state == 1 then
          tbCharList[k] = true
          break
        else
          tbCharList[k] = false
        end
      end
    end
    for k, v in pairs(tbCharList) do
      RedDotManager.SetValid(RedDotDefine.Role_AffinityTask, k, v)
    end
  end
end

function PlayerQuestData:UpdateBattlePassRedDot()
  local bCanDailyReceive = false
  local bCanWeekReceive = false
  local questList = self._mapQuest[6]
  if nil ~= questList then
    for _, v in pairs(questList) do
      if v.nStatus == 1 then
        bCanDailyReceive = true
        break
      end
    end
  end
  questList = self._mapQuest[7]
  if nil ~= questList then
    for _, v in pairs(questList) do
      if v.nStatus == 1 then
        bCanWeekReceive = true
        break
      end
    end
  end
  PlayerData.BattlePass:UpdateQuestRedDot(bCanDailyReceive, bCanWeekReceive)
end

function PlayerQuestData:UpdateStarTowerQuestRedDot()
  local bCanReceive = false
  local questList = self._mapQuest[QuestType.Tower]
  if nil ~= questList then
    for _, v in pairs(questList) do
      if v.nStatus == 1 then
        bCanReceive = true
        break
      end
    end
  end
  RedDotManager.SetValid(QuestRedDotType.Tower, nil, bCanReceive)
end

function PlayerQuestData:UpdateStarTowerBookQuestRedDot()
  local questList = self._mapQuest[QuestType.TowerEvent]
  if nil ~= questList then
    for _, v in pairs(questList) do
      if v.nStatus == 1 then
        RedDotManager.SetValid(RedDotDefine.StarTowerBook_Event_Reward, v.nTid, true)
      else
        RedDotManager.SetValid(RedDotDefine.StarTowerBook_Event_Reward, v.nTid, false)
      end
    end
  end
end

function PlayerQuestData:GetVampireQuestData()
  local tbScore, tbPass = {}, {}
  if self._mapQuest[QuestType.VampireSurvivorSeason] ~= nil then
    for nId, v in pairs(self._mapQuest[QuestType.VampireSurvivorSeason]) do
      table.insert(tbScore, v)
    end
  end
  if self._mapQuest[QuestType.VampireSurvivorNormal] ~= nil then
    for nId, v in pairs(self._mapQuest[QuestType.VampireSurvivorNormal]) do
      table.insert(tbPass, v)
    end
  end
  return tbScore, tbPass
end

function PlayerQuestData:GetVampireQuestStatusById(nId)
  if nId == nil then
    return 0
  end
  if self._mapQuest[QuestType.VampireSurvivorSeason] ~= nil and self._mapQuest[QuestType.VampireSurvivorSeason][nId] ~= nil then
    return self._mapQuest[QuestType.VampireSurvivorSeason][nId].nStatus
  end
  if self._mapQuest[QuestType.VampireSurvivorNormal] ~= nil and self._mapQuest[QuestType.VampireSurvivorNormal][nId] ~= nil then
    return self._mapQuest[QuestType.VampireSurvivorNormal][nId].nStatus
  end
  return 0
end

function PlayerQuestData:ReceiveVampireQuest(nType, tbList, callback)
  local msg = {
    QuestType = nType - 7,
    QuestIds = tbList
  }
  
  local function Callback(_, mapMsgData)
    for _, nTid in ipairs(tbList) do
      if self._mapQuest[8][nTid] ~= nil then
        self._mapQuest[8][nTid].nStatus = 2
      end
      if self._mapQuest[9] ~= nil and self._mapQuest[9][nTid] ~= nil then
        self._mapQuest[9][nTid].nStatus = 2
      end
    end
    self:UpdateVampireQuestRedDot()
    EventManager.Hit("VampireQuestRefresh")
    if callback ~= nil then
      callback(mapMsgData)
    end
    EventManager.Hit(EventId.EventReminder_Update, GameEnum.EventReminderType.Vampire)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_quest_reward_receive_req, msg, nil, Callback)
end

function PlayerQuestData:UpdateVampireQuestRedDot()
  local bCanNormalReceive = false
  local bCanHardReceive = false
  local bCanSeasonReceive = false
  local questList = self._mapQuest[8]
  if nil ~= questList then
    for _, v in pairs(questList) do
      if v.nStatus == 1 then
        local mapQusetData = ConfigTable.GetData("VampireSurvivorQuest", v.nTid)
        if mapQusetData ~= nil then
          if mapQusetData.Type == GameEnum.vampireSurvivorType.Normal then
            bCanNormalReceive = true
          elseif mapQusetData.Type == GameEnum.vampireSurvivorType.Hard then
            bCanHardReceive = true
          elseif mapQusetData.Type == GameEnum.vampireSurvivorType.Turn then
            bCanSeasonReceive = true
          end
        end
      end
    end
  end
  questList = self._mapQuest[9]
  if nil ~= questList then
    for _, v in pairs(questList) do
      if v.nStatus == 1 then
        local mapQusetData = ConfigTable.GetData("VampireSurvivorQuest", v.nTid)
        if mapQusetData ~= nil then
          if mapQusetData.Type == GameEnum.vampireSurvivorType.Normal then
            bCanNormalReceive = true
          elseif mapQusetData.Type == GameEnum.vampireSurvivorType.Hard then
            bCanHardReceive = true
          elseif mapQusetData.Type == GameEnum.vampireSurvivorType.Turn then
            bCanSeasonReceive = true
          end
        end
      end
    end
  end
  RedDotManager.SetValid(RedDotDefine.VampireQuest_Normal, nil, bCanNormalReceive)
  RedDotManager.SetValid(RedDotDefine.VampireQuest_Hard, nil, bCanHardReceive)
  RedDotManager.SetValid(RedDotDefine.VampireQuest_Season, nil, bCanSeasonReceive)
end

function PlayerQuestData:ClearVampireSeasonQuest(nCurSeason)
  local mapSeasonData = ConfigTable.GetData("VampireRankSeason", nCurSeason)
  local tbRemove = {}
  if mapSeasonData ~= nil then
    local nSeasonGroupId = mapSeasonData.QuestGroup
    if self._mapQuest[9] == nil then
      self._mapQuest[9] = {}
    end
    for nTid, mapQuest in pairs(self._mapQuest[9]) do
      local mapQuestCfgData = ConfigTable.GetData("VampireRankSeason", nTid)
      if mapQuestCfgData ~= nil and mapQuestCfgData.GroupId ~= nSeasonGroupId then
        table.insert(tbRemove, nTid)
      end
    end
    for _, nQuestId in ipairs(tbRemove) do
      if self._mapQuest[9][nQuestId] ~= nil then
        self._mapQuest[9][nQuestId] = nil
      end
    end
  end
end

function PlayerQuestData:GetDormQuestData()
  return self._mapQuest[QuestType.Dorm] ~= nil and self._mapQuest[QuestType.Dorm] or {}
end

function PlayerQuestData:ReceiveDormQuest(nType, nId, callback)
  local tbQuestId = {}
  if nId == 0 then
    if self._mapQuest[QuestType.Dorm] ~= nil then
      for _, v in pairs(self._mapQuest[QuestType.Dorm]) do
        if v.nStatus == 1 then
          table.insert(tbQuestId, v.nTid)
        end
      end
    end
  elseif nType == 0 then
    table.insert(tbQuestId, nId)
  end
  
  local function NetCallback(_, msgData)
    for _, v in pairs(self._mapQuest[QuestType.Dorm]) do
      if table.indexof(tbQuestId, v.nTid) > 0 then
        v.nStatus = 2
      end
    end
    UTILS.OpenReceiveByChangeInfo(msgData.change_info, callback)
    EventManager.Hit(EventId.QuestDataRefresh, "Dorm")
    PlayerData.PlayerDormData:RefreshRedDotQuest()
  end
  
  local msg = {Value = 0, Version = 0}
  if nId ~= 0 then
    msg.Value = nId
    msg.Version = nType
  end
  HttpNetHandler.SendMsg(NetMsgId.Id.quest_dorm_reward_receive_req, msg, nil, NetCallback)
end

function PlayerQuestData:GetDormQuestDataById(nId)
  if self._mapQuest[QuestType.Dorm] == nil then
    return nil
  end
  return self._mapQuest[QuestType.Dorm][nId]
end

function PlayerQuestData:UpdateDormQuestRedDot()
  local bHasQuest = false
  for _, v in pairs(self._mapQuest[QuestType.Dorm]) do
    if v.nStatus == 1 then
      bHasQuest = true
      break
    end
  end
  RedDotManager.SetValid(RedDotDefine.DormQuest, nil, bHasQuest)
end

function PlayerQuestData:GetGuideMissionQuestGroupByChapter(nChapterId)
  return self.tbGuideMissionQuestGroup[nChapterId]
end

function PlayerQuestData:GetGuideMissionQuestListByGroup(nGroupId)
  return self.tbGuideMissionQuest[nGroupId]
end

function PlayerQuestData:GetGuideMissionQuestData()
  return self._mapQuest[QuestType.GuideMission] ~= nil and self._mapQuest[QuestType.GuideMission] or {}
end

function PlayerQuestData:GetGuideMissionQuestDataById(nId)
  if self._mapQuest[QuestType.GuideMission] == nil then
    return nil
  end
  return self._mapQuest[QuestType.GuideMission][nId]
end

function PlayerQuestData:FillGuideMissionQuestDefault(nGroupId, bDone)
  local tbQuestCfgList = self.tbGuideMissionQuest[nGroupId]
  if tbQuestCfgList == nil then
    return
  end
  if self._mapQuest[QuestType.GuideMission] == nil then
    self._mapQuest[QuestType.GuideMission] = {}
  end
  local tbQuest = self._mapQuest[QuestType.GuideMission]
  for _, mapQuestCfg in ipairs(tbQuestCfgList) do
    if bDone then
      tbQuest[mapQuestCfg.Id] = {
        nTid = mapQuestCfg.Id,
        nGoal = mapQuestCfg.ClientCompleteCount or 0,
        nCurProgress = mapQuestCfg.ClientCompleteCount or 0,
        nStatus = 2,
        nExpire = 0
      }
    elseif tbQuest[mapQuestCfg.Id] == nil then
      tbQuest[mapQuestCfg.Id] = {
        nTid = mapQuestCfg.Id,
        nGoal = mapQuestCfg.ClientCompleteCount or 0,
        nCurProgress = 0,
        nStatus = 0,
        nExpire = 0
      }
    end
  end
end

function PlayerQuestData:RequestGuideMissionInfo(callback)
  local function processCb(_, mapDataCb)
    local tbDoneChapter = {}
    
    if mapDataCb.Chapters ~= nil then
      for _, mapChapterData in pairs(mapDataCb.Chapters) do
        PlayerData.GuideMission:CacheServerUnlockTime(mapChapterData.Id, mapChapterData.UnlockTime)
        if mapChapterData.Quests ~= nil and mapChapterData.Quests.List ~= nil then
          for _, mapQuestData in pairs(mapChapterData.Quests.List) do
            self:OnQuestProgressChanged(mapQuestData)
          end
        end
        if mapChapterData.Done then
          tbDoneChapter[mapChapterData.Id] = true
        end
      end
    end
    for nGroupId, _ in pairs(self.tbGuideMissionQuest) do
      self:FillGuideMissionQuestDefault(nGroupId, false)
    end
    for nChapterId, _ in pairs(tbDoneChapter) do
      local tbChapterGroupList = self.tbGuideMissionQuestGroup[nChapterId]
      if tbChapterGroupList ~= nil then
        for _, mapGroupCfg in ipairs(tbChapterGroupList) do
          self:FillGuideMissionQuestDefault(mapGroupCfg.Id, true)
        end
      end
    end
    self:UpdateQuestRedDot("GuideMission")
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.guide_mission_info_req, {}, nil, processCb)
end

function PlayerQuestData:ReceiveGuideMissionQuestReward(nTid, bGroup, callback)
  local msg = {
    QuestId = nTid,
    Group = bGroup or false
  }
  
  local function Callback(_, mapMsgData)
    local tbQuest = self._mapQuest[QuestType.GuideMission]
    if tbQuest ~= nil then
      if bGroup then
        local questCfg = ConfigTable.GetData("GuideMissionQuest", nTid)
        local tbGroupQuestList = questCfg ~= nil and self.tbGuideMissionQuest[questCfg.GroupId] or nil
        if tbGroupQuestList ~= nil then
          for _, mapQuestCfg in ipairs(tbGroupQuestList) do
            if tbQuest[mapQuestCfg.Id] ~= nil and tbQuest[mapQuestCfg.Id].nStatus == 1 then
              tbQuest[mapQuestCfg.Id].nStatus = 2
            end
          end
        end
      elseif tbQuest[nTid] ~= nil then
        tbQuest[nTid].nStatus = 2
      end
    end
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    UTILS.OpenReceiveByChangeInfo(mapMsgData)
    self:UpdateQuestRedDot("GuideMission")
    if callback ~= nil and type(callback) == "function" then
      callback(mapMsgData)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.guide_mission_quest_reward_receive_req, msg, nil, Callback)
end

return PlayerQuestData
