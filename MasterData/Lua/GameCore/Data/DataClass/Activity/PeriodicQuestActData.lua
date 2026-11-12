local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local PeriodicQuestActData = class("PeriodicQuestActData", ActivityDataBase)
local ClientManager = CS.ClientManager.Instance

function PeriodicQuestActData:Init()
  self.tbAllQuestList = {}
  self.bFinalStatus = false
  self.perQuestActCfg = ConfigTable.GetData("PeriodicQuestControl", self.nActId)
  self.nMaxQuestDay = self:GetMaxOpenDay()
end

function PeriodicQuestActData:CreateQuest(mapQuestData)
  local tbQuestData = {}
  tbQuestData.Id = mapQuestData.Id
  if nil ~= mapQuestData.Progress[1] then
    tbQuestData.nCurProcess = mapQuestData.Progress[1].Cur
    tbQuestData.nTotalProcess = mapQuestData.Progress[1].Max
  else
    tbQuestData.nCurProcess = 0
    tbQuestData.nTotalProcess = 0
  end
  if mapQuestData.Status == 0 then
    tbQuestData.nStatus = AllEnum.ActQuestStatus.UnComplete
  elseif mapQuestData.Status == 1 then
    tbQuestData.nStatus = AllEnum.ActQuestStatus.Complete
  elseif mapQuestData.Status == 2 then
    tbQuestData.nStatus = AllEnum.ActQuestStatus.Received
  end
  local questCfg = ConfigTable.GetData("PeriodicQuest", mapQuestData.Id)
  local nGroupId = questCfg.Groupid
  tbQuestData.nGroupId = nGroupId
  local nDay = CacheTable.GetData("_PeriodicQuestDay", self.nActId)[nGroupId]
  tbQuestData.nDay = nDay
  return tbQuestData
end

function PeriodicQuestActData:RefreshQuestList(mapQuestList)
  for _, v in ipairs(mapQuestList) do
    local tbQuestData = self:CreateQuest(v)
    self.tbAllQuestList[v.Id] = tbQuestData
  end
  self:RefreshRedDot()
end

function PeriodicQuestActData:RefreshQuestData(questData)
  self.tbAllQuestList[questData.Id] = self:CreateQuest(questData)
  self:RefreshRedDot()
  local bAllQuestComplete = self:CheckAllQuestComplete()
  if bAllQuestComplete then
    PlayerData.Base:UserEventUpload_PC("pc_start_mission_minerva")
  end
end

function PeriodicQuestActData:RefreshQuestStatus(nQuestId)
  local tbQuestList = {}
  if 0 == nQuestId then
    for questId, v in pairs(self.tbAllQuestList) do
      if v.nStatus == AllEnum.ActQuestStatus.Complete then
        table.insert(tbQuestList, questId)
        v.nStatus = AllEnum.ActQuestStatus.Received
      end
    end
  elseif nil ~= self.tbAllQuestList[nQuestId] then
    table.insert(tbQuestList, nQuestId)
    self.tbAllQuestList[nQuestId].nStatus = AllEnum.ActQuestStatus.Received
  end
  self:RefreshRedDot()
  return tbQuestList
end

function PeriodicQuestActData:RefreshFinalStatus(bFinalStatus)
  self.bFinalStatus = bFinalStatus
  self:RefreshRedDot()
end

function PeriodicQuestActData:GetQuestListByGroup()
  local tbQuestList = {}
  for _, v in pairs(self.tbAllQuestList) do
    if nil == tbQuestList[v.nGroupId] then
      tbQuestList[v.nGroupId] = {}
    end
    table.insert(tbQuestList[v.nGroupId], v)
  end
  return tbQuestList
end

function PeriodicQuestActData:GetQuestListByDay()
  local tbQuestList = {}
  for _, v in pairs(self.tbAllQuestList) do
    if nil == tbQuestList[v.nDay] then
      tbQuestList[v.nDay] = {}
    end
    table.insert(tbQuestList[v.nDay], v)
  end
  return tbQuestList
end

function PeriodicQuestActData:GetCurOpenDay()
  local nMaxDay = CacheTable.GetData("_PeriodicQuestMaxDay", self.nActId)
  if nil == nMaxDay then
    printError("读取PeriodicQuestGroup配置失败！！！actId = " .. tostring(self.nActId))
    return 1
  end
  local nCurTime = ClientManager.serverTimeStamp
  local nOpenTime = self.nOpenTime
  local nCurDay = 0
  local nNextRefreshTime = ClientManager:GetNextRefreshTime(nOpenTime)
  while nOpenTime < nNextRefreshTime and nCurTime > nOpenTime and nMaxDay >= nCurDay do
    nOpenTime = nNextRefreshTime
    nCurDay = nCurDay + 1
    nNextRefreshTime = ClientManager:GetNextRefreshTime(nOpenTime)
  end
  nCurDay = math.min(nCurDay, nMaxDay)
  return nCurDay
end

function PeriodicQuestActData:GetMaxOpenDay()
  local nMaxDay = 0
  local groupCfg = CacheTable.GetData("_PeriodicQuestDay", self.nActId)
  if nil ~= groupCfg then
    for _, v in pairs(groupCfg) do
      if v > nMaxDay then
        nMaxDay = v
      end
    end
  end
  return nMaxDay
end

function PeriodicQuestActData:GetCanReceiveRewardGroup()
  local nGroupId = 0
  local nCurDay = self:GetCurOpenDay()
  for _, v in pairs(self.tbAllQuestList) do
    if nCurDay >= v.nDay and v.nStatus == AllEnum.ActQuestStatus.Complete and (0 == nGroupId or nGroupId > v.nGroupId) then
      nGroupId = v.nGroupId
    end
  end
  return nGroupId
end

function PeriodicQuestActData:GetCanRecRewardDay()
  for _, v in pairs(self.tbAllQuestList) do
    if v.nStatus == AllEnum.ActQuestStatus.Complete then
      return v.nDay
    end
  end
  return 0
end

function PeriodicQuestActData:GetDayQuestStatus(nDay)
  local nAllQuest, nReceivedQuest = 0, 0
  for _, v in pairs(self.tbAllQuestList) do
    if v.nDay == nDay then
      nAllQuest = nAllQuest + 1
      if v.nStatus == AllEnum.ActQuestStatus.Received then
        nReceivedQuest = nReceivedQuest + 1
      end
    end
  end
  return nAllQuest, nReceivedQuest
end

function PeriodicQuestActData:GetNextDayOpenTime()
  local nextRefreshTime = ClientManager:GetNextRefreshTime(ClientManager.serverTimeStamp)
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local nRemainTime = nextRefreshTime - nCurTime
  return math.floor(nRemainTime / 3600)
end

function PeriodicQuestActData:GetPerQuestCfg()
  return self.perQuestActCfg
end

function PeriodicQuestActData:GetQuestProgress()
  local curProgress = 0
  local allProgress = #CacheTable.GetData("_PeriodicQuest", self.nActId)
  local canReceive = 0
  local nCurDay = self:GetCurOpenDay()
  for _, v in pairs(self.tbAllQuestList) do
    if nCurDay >= v.nDay then
      if v.nStatus == AllEnum.ActQuestStatus.Received then
        curProgress = curProgress + 1
      elseif v.nStatus == AllEnum.ActQuestStatus.Complete then
        canReceive = canReceive + 1
      end
    end
  end
  return curProgress, allProgress, canReceive
end

function PeriodicQuestActData:CheckFinalReward()
  return self.bFinalStatus
end

function PeriodicQuestActData:CheckAllQuestComplete()
  local bAllComplete = true
  for nId, v in pairs(self.tbAllQuestList) do
    if v.nStatus == AllEnum.ActQuestStatus.UnComplete then
      bAllComplete = false
      break
    end
  end
  return bAllComplete
end

function PeriodicQuestActData:RefreshRedDot()
  local bOpen = self:CheckActShow()
  local bQuestReward = false
  local tbGroupStatus = {}
  local nCurDay = self:GetCurOpenDay()
  if nil ~= next(self.tbAllQuestList) then
    for _, v in pairs(self.tbAllQuestList) do
      if nCurDay >= v.nDay then
        if nil == tbGroupStatus[v.nGroupId] then
          tbGroupStatus[v.nGroupId] = 0
        end
        if v.nStatus == AllEnum.ActQuestStatus.Complete then
          tbGroupStatus[v.nGroupId] = tbGroupStatus[v.nGroupId] + 1
          bQuestReward = true
        end
      end
    end
    for group, v in pairs(tbGroupStatus) do
      RedDotManager.SetValid(RedDotDefine.Activity_Periodic_Quest_Group, {
        self.nActId,
        group
      }, 0 < v and bOpen)
    end
    local nCur, nAll = self:GetQuestProgress()
    local bFinalReward = nAll <= nCur and not self.bFinalStatus
    RedDotManager.SetValid(RedDotDefine.Activity_Periodic_Final_Reward, self.nActId, bFinalReward and bOpen)
    RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nActId, (bQuestReward or bFinalReward) and bOpen)
  end
end

return PeriodicQuestActData
