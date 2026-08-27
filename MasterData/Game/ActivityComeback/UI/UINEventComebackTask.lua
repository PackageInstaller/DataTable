local UINEventComebackTask = class("UINEventComebackTask", UIBaseNode)
local base = UIBaseNode
local UINEventComebackTaskTitle = require("Game.ActivityComeback.UI.UINEventComebackTaskTitle")
local UINEventComebackTaskItem = require("Game.ActivityComeback.UI.UINEventComebackTaskItem")
local TaskEnum = require("Game.Task.TaskEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function UINEventComebackTask:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._titlePool = UIItemPool.New(UINEventComebackTaskTitle, self.ui.title)
  self.ui.title:SetActive(false)
  self._itemPool = UIItemPool.New(UINEventComebackTaskItem, self.ui.taskItem)
  self.ui.taskItem:SetActive(false)
  self.__OnReceiveTaskCallback = BindCallback(self, self.__OnReceiveTask)
  self.__TaskUpdateCallback = BindCallback(self, self.__TaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  self.__RefreshCallback = BindCallback(self, self.__Refresh)
  MsgCenter:AddListener(eMsgEventId.ActivityTaskUpdate, self.__RefreshCallback)
end

function UINEventComebackTask:InitCombackTask(rookieId)
  local activityTaskCtrl = ControllerManager:GetController(ControllerTypeId.ActivityTask)
  if activityTaskCtrl == nil then
    error("回归任务活动是空")
    return
  end
  self.activityTaskData = activityTaskCtrl:GetAcitvityTaskData(rookieId)
  if self.activityTaskData == nil then
    error("回归任务活动是空")
    return
  end
  self:__RefreshAllTaskUI()
end

function UINEventComebackTask:__RefreshAllTaskUI()
  self._oneTimeTasks = nil
  self._refreshTasks = nil
  self._oneTimeTitle = nil
  self._refreshTitle = nil
  self._taskIdItemDic = {}
  if self._sortOnceTaskList == nil then
    self._sortOnceTaskList = {}
  else
    table.removeall(self._sortOnceTaskList)
  end
  self._titlePool:HideAll()
  self._itemPool:HideAll()
  
  local function Local_ShowItemListFunc(taskIdList)
    for _, taskId in ipairs(taskIdList) do
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
      table.insert(self._sortOnceTaskList, taskData)
    end
    self:__SortTaskData(self._sortOnceTaskList)
    for i, taskData in ipairs(self._sortOnceTaskList) do
      local item = self._itemPool:GetOne()
      item:InitCombackTaskItem(taskData, self.__OnReceiveTaskCallback)
      self._taskIdItemDic[taskData.id] = item
    end
    table.removeall(self._sortOnceTaskList)
  end
  
  self._refreshTitle = self._titlePool:GetOne()
  self._refreshTitle:InitCombackTaskTitle(0)
  Local_ShowItemListFunc(self.activityTaskData.refreshQuests.ids)
  self._oneTimeTitle = self._titlePool:GetOne()
  self._oneTimeTitle:InitCombackTaskTitle(1)
  Local_ShowItemListFunc(self.activityTaskData.onceQuests)
  self:__RefreshDailyCount()
end

function UINEventComebackTask:__SortTaskData(taskDataList)
  table.sort(taskDataList, function(a, b)
    if a.state == TaskEnum.eTaskState.Picked then
      return false
    elseif b.state == TaskEnum.eTaskState.Picked then
      return true
    end
    local aComplete = a:CheckComplete()
    local bComplete = b:CheckComplete()
    if aComplete ~= bComplete then
      return aComplete
    end
    return a.id < b.id
  end)
end

function UINEventComebackTask:__OnReceiveTask(taskData)
  local activityTaskCtrl = ControllerManager:GetController(ControllerTypeId.ActivityTask)
  activityTaskCtrl:SendCommitActivityTask(self.activityTaskData.actId, taskData, function()
    local rewards, nums = taskData:GetTaskCfgRewards()
    for i = #rewards, 1, -1 do
      local itemCfg = ConfigData.item[rewards[i]]
      if itemCfg.type == eItemType.BattlePassPoint then
        table.remove(rewards, i)
        table.remove(nums, i)
      end
    end
    local CommonRewardData = require("Game.CommonUI.CommonRewardData")
    local CRData = CommonRewardData.CreateCRDataUseList(rewards, nums)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      window:AddAndTryShowReward(CRData)
    end)
    self:__RefreshAllTaskUI()
  end)
end

function UINEventComebackTask:__Refresh()
  self:__RefreshAllTaskUI()
end

function UINEventComebackTask:__TaskUpdate(taskData)
  if self._taskIdItemDic == nil then
    return
  end
  local item = self._taskIdItemDic[taskData.id]
  if item == nil then
    return
  end
  if taskData:CheckComplete() then
    self:__RefreshAllTaskUI()
    return
  end
  item:RefreshCombackTaskItem()
  self:__RefreshDailyCount()
end

function UINEventComebackTask:__RefreshDailyCount()
  local activityTaskCfg = ConfigData.task_activity[self.activityTaskData.actId]
  local markTaskId = 0
  local totalCount = 0
  for id, refreshCount in pairs(activityTaskCfg.refresh_limit) do
    markTaskId = id
    totalCount = refreshCount
  end
  local count = self.activityTaskData.refreshQuests.compeleteCnt[markTaskId] or 0
  self._refreshTitle:RefreshCombackTaskProgress(count, totalCount)
end

function UINEventComebackTask:OnDelete()
  base.OnDelete(self)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.ActivityTaskUpdate, self.__RefreshCallback)
end

return UINEventComebackTask
