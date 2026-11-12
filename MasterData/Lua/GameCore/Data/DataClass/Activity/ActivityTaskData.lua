local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local ActivityTaskData = class("ActivityTaskData", ActivityDataBase)
local MAPSTATUS = {
  [0] = AllEnum.ActQuestStatus.UnComplete,
  [1] = AllEnum.ActQuestStatus.Complete,
  [2] = AllEnum.ActQuestStatus.Received
}

function ActivityTaskData:Init()
  self.tbActivityTaskGroupIds = {}
  self.tbActivityTaskIds = {}
  self.mapActivityTaskDatas = {}
  self.mapActivityTaskGroupData = {}
  self:InitConfig()
end

function ActivityTaskData:InitConfig()
  local function func_Parse_ActivityTaskGroup(mapData)
    if mapData.ActivityId == self.nActId then
      self.mapActivityTaskGroupData[mapData.Id] = {}
    end
  end
  
  ForEachTableLine(DataTable.ActivityTaskGroup, func_Parse_ActivityTaskGroup)
  
  local function func_Parse_ActivityTask(mapData)
    local nGroupId = mapData.ActivityTaskGroupId
    local nTaskId = mapData.Id
    if self.mapActivityTaskGroupData[nGroupId] ~= nil then
      table.insert(self.mapActivityTaskGroupData[nGroupId], nTaskId)
    end
  end
  
  ForEachTableLine(DataTable.ActivityTask, func_Parse_ActivityTask)
end

function ActivityTaskData:CacheData(mapData)
  for _, nActivityTaskGroupId in ipairs(mapData.GroupIds) do
    table.insert(self.tbActivityTaskGroupIds, nActivityTaskGroupId)
  end
  for _, Quest in ipairs(mapData.ActivityTasks.List) do
    local nActivityTaskId = Quest.Id
    if table.indexof(self.tbActivityTaskIds, nActivityTaskId) <= 0 then
      table.insert(self.tbActivityTaskIds, nActivityTaskId)
    end
    local _nCur, _nMax = 0, 0
    for __, QuestProgress in ipairs(Quest.Progress) do
      _nCur = _nCur + QuestProgress.Cur
      _nMax = _nMax + QuestProgress.Max
    end
    self.mapActivityTaskDatas[nActivityTaskId] = {
      nStatus = MAPSTATUS[Quest.Status],
      nExpire = Quest.Expire,
      nCur = Quest.Status == 2 and _nMax or _nCur,
      nMax = _nMax
    }
  end
  self:RefreshTaskRedDot()
end

function ActivityTaskData:RefreshSingleQuest(questData)
  if type(self.tbActivityTaskIds) ~= "table" or type(self.mapActivityTaskDatas) ~= "table" then
    return
  end
  local nActivityTaskId = questData.Id
  if table.indexof(self.tbActivityTaskIds, nActivityTaskId) <= 0 then
    table.insert(self.tbActivityTaskIds, nActivityTaskId)
  end
  local data = self.mapActivityTaskDatas[nActivityTaskId]
  if data == nil then
    local _nCur, _nMax = 0, 0
    for __, QuestProgress in ipairs(questData.Progress) do
      _nCur = _nCur + QuestProgress.Cur
      _nMax = _nMax + QuestProgress.Max
    end
    self.mapActivityTaskDatas[nActivityTaskId] = {
      nStatus = MAPSTATUS[questData.Status],
      nExpire = questData.Expire,
      nCur = questData.Status == 2 and _nMax or _nCur,
      nMax = _nMax
    }
    data = self.mapActivityTaskDatas[nActivityTaskId]
  end
  data.nStatus = MAPSTATUS[questData.Status]
  local _nCur, _nMax = 0, 0
  for __, QuestProgress in ipairs(questData.Progress) do
    _nCur = _nCur + QuestProgress.Cur
    _nMax = _nMax + QuestProgress.Max
  end
  data.nCur = questData.Status == 2 and _nMax or _nCur
  data.nMax = _nMax
  self:RefreshTaskRedDot()
end

function ActivityTaskData:RefreshTaskRedDot()
  local bActOpen = self:CheckActivityOpen()
  for nGroupId, tbList in pairs(self.mapActivityTaskGroupData) do
    local nAllCount = #tbList
    local nReceivedCount = 0
    local nCompleteCount = 0
    for _, nTaskId in ipairs(tbList) do
      local mapData = self.mapActivityTaskDatas[nTaskId]
      if mapData ~= nil then
        if mapData.nStatus == AllEnum.ActQuestStatus.Complete then
          nCompleteCount = nCompleteCount + 1
        elseif mapData.nStatus == AllEnum.ActQuestStatus.Received then
          nReceivedCount = nReceivedCount + 1
        end
      end
    end
    local bTotalReceived = 0 < table.indexof(self.tbActivityTaskGroupIds, nGroupId)
    local bHasReward = false
    local mapGroupCfg = ConfigTable.GetData("ActivityTaskGroup", nGroupId)
    if mapGroupCfg ~= nil then
      for i = 1, 6 do
        local nTid = mapGroupCfg["Reward" .. i]
        local nCount = mapGroupCfg["RewardQty" .. i]
        if nTid ~= 0 and 0 < nCount then
          bHasReward = true
          break
        end
      end
    end
    if bHasReward == false then
      bTotalReceived = true
    end
    local bCanReceive = 0 < nCompleteCount or nReceivedCount == nAllCount and not bTotalReceived
    local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
    local bActGroupUnlock = true
    if bInActGroup then
      local actGroupData = PlayerData.Activity:GetActivityGroupDataById(nActGroupId)
      bActGroupUnlock = actGroupData:IsUnlock()
    end
    RedDotManager.SetValid(RedDotDefine.Activity_Group_Task_Group, {
      nActGroupId,
      self.nActId,
      nGroupId
    }, bCanReceive and bActOpen and bActGroupUnlock)
  end
end

function ActivityTaskData:SendMsg_ActivityTaskRewardReceiveReq(nActivityTaskGroupId, nActivityTaskId, nTabType, ui_ctrl_callback)
  local mapSend = {}
  mapSend.GroupId = nActivityTaskGroupId
  mapSend.TabType = nTabType
  mapSend.QuestId = nActivityTaskId
  
  local function succ_cb(_, mapData)
    local function receiveCallback()
      if type(ui_ctrl_callback) == "function" then
        ui_ctrl_callback()
      end
    end
    
    UTILS.OpenReceiveByChangeInfo(mapData, receiveCallback)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_task_reward_receive_req, mapSend, nil, succ_cb)
end

function ActivityTaskData:SendMsg_ActivityTaskGroupRewardReceiveReq(nActivityTaskGroupId, ui_ctrl_callback)
  local mapSend = {}
  mapSend.Value = nActivityTaskGroupId
  
  local function succ_cb(_, mapData)
    if table.indexof(self.tbActivityTaskGroupIds, nActivityTaskGroupId) <= 0 then
      table.insert(self.tbActivityTaskGroupIds, nActivityTaskGroupId)
    end
    if type(ui_ctrl_callback) == "function" then
      ui_ctrl_callback()
    end
    UTILS.OpenReceiveByChangeInfo(mapData)
    self:RefreshTaskRedDot()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_task_group_reward_receive_req, mapSend, nil, succ_cb)
end

function ActivityTaskData:CalcTotalProgress()
  local nDone = 0
  local nTotal = 0
  for k, v in pairs(self.mapActivityTaskDatas) do
    nTotal = nTotal + 1
    if v.nStatus == AllEnum.ActQuestStatus.Received then
      nDone = nDone + 1
    end
  end
  return nDone, nTotal
end

function ActivityTaskData:GetAllTaskList()
  return self.mapActivityTaskGroupData, self.mapActivityTaskDatas
end

return ActivityTaskData
