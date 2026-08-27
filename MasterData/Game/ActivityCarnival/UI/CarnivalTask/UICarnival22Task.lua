local UICarnival22Task = class("UICarnival22Task", UIBaseWindow)
local base = UIBaseWindow
local UINCarnival22TaskItem = require("Game.ActivityCarnival.UI.CarnivalTask.UINCarnival22TaskItem")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon

function UICarnival22Task:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Intro, self, self.OnClickTaskIntro)
  self._taskItemPool = UIItemPool.New(UINCarnival22TaskItem, self.ui.taskItem)
  self.ui.taskItem:SetActive(false)
  self.__OnTaskUpteEventCallback = BindCallback(self, self.__OnTaskUpteEvent)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnTaskUpteEventCallback)
  self.__UpdateTaskAllCallback = BindCallback(self, self.__UpdateTaskAll)
  MsgCenter:AddListener(eMsgEventId.ActivityCarnivalTimePass, self.__UpdateTaskAllCallback)
  self.__OnChangeTaskCallback = BindCallback(self, self.__OnChangeTask)
  self.__OnCompleteTaskCallback = BindCallback(self, self.__OnCompleteTask)
  self.__OnJumpTaskCallback = BindCallback(self, self.__OnJumpTask)
end

function UICarnival22Task:InitCarnivalTask(carnivalData, callback)
  self._carnivalData = carnivalData
  self:__UpdateTaskAll()
  self._callback = callback
end

function UICarnival22Task:__UpdateTaskAll()
  self._taskChangeCD = self._carnivalData:GetCarnivalMainCfg().change_frequency
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._timerId = TimerManager:StartTimer(1, self.__UpdateTimer, self)
  self:__UpdateTimer()
  self:__TaskAllRefresh()
end

function UICarnival22Task:__TaskAllRefresh()
  local taskDic = self._carnivalData:GetCarnivalTask()
  local taskDataList = {}
  for taskId, _ in pairs(taskDic) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    table.insert(taskDataList, taskData)
  end
  table.sort(taskDataList, function(a, b)
    local isPickedA = a.state == TaskEnum.eTaskState.Picked
    local isPickedB = b.state == TaskEnum.eTaskState.Picked
    if isPickedA ~= isPickedB then
      return not isPickedA
    end
    return taskDic[a.id] < taskDic[b.id]
  end)
  self._taskItemPool:HideAll()
  self._taskItemDic = {}
  for _, taskData in ipairs(taskDataList) do
    local item = self._taskItemPool:GetOne()
    item:BindCarnivalTaskCallback(self.__OnChangeTaskCallback, self.__OnCompleteTaskCallback, self.__OnJumpTaskCallback)
    item:InitCarnivalTaskItem(self._carnivalData, taskData)
    self._taskItemDic[taskData.id] = item
  end
end

function UICarnival22Task:__UpdateTimer()
  local nextRefreshTm = self._carnivalData:GetCarnivalTaskNextTm()
  local diff = nextRefreshTm - PlayerDataCenter.timestamp
  if diff <= 0 then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
    self.ui.tex_ClockTime.text = "00:00:00"
    return
  end
  local _, h, m, s = TimeUtil:TimestampToTimeInter(diff)
  self.ui.tex_ClockTime.text = string.format("%02d:%02d:%02d", h, m, s)
end

function UICarnival22Task:__OnTaskUpteEvent(taskData)
  if self._taskItemDic[taskData.id] == nil then
    return
  end
  if taskData:CheckComplete() then
    self:__TaskAllRefresh()
  else
    self:__RefreshTaskSingle(taskData.id)
  end
end

function UICarnival22Task:__RefreshTaskSingle(taskId)
  if self._taskItemDic == nil then
    return
  end
  local taskItem = self._taskItemDic[taskId]
  if taskItem ~= nil then
    taskItem:UpdateCarnivalTaskProcess()
  end
end

function UICarnival22Task:__OnChangeTask(taskId, item)
  if PlayerDataCenter.timestamp - (self._lastChangeTm or 0) < self._taskChangeCD then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7123))
    return
  end
  if PlayerDataCenter.timestamp > self._carnivalData:GetCarnivalTaskNextTm() then
    return
  end
  self._lastChangeTm = PlayerDataCenter.timestamp
  self._carnivalData:ReqCarnivalSingleTaskRefresh(taskId, function(newTaskId, oriTaskId)
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(newTaskId, true)
    item:ChangeCarnivalTaskItem(taskData)
    self._taskItemDic[taskId] = nil
    self._taskItemDic[newTaskId] = item
  end)
end

function UICarnival22Task:__OnCompleteTask(taskId)
  if PlayerDataCenter.timestamp > self._carnivalData:GetCarnivalTaskNextTm() then
    return
  end
  local taskItem = self._taskItemDic[taskId]
  if taskItem == nil then
    return
  end
  local taskData = taskItem:GetCarnivalTaskData()
  if taskData.state == TaskEnum.eTaskState.Picked then
    return
  end
  if not taskData:CheckComplete() then
    return
  end
  local activityFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNet:CS_Activity_Quest_Commit(self._carnivalData:GetActFrameId(), taskId, function()
    self:__TaskAllRefresh()
    local rewards, nums = taskData:GetTaskCfgRewards()
    local CommonRewardData = require("Game.CommonUI.CommonRewardData")
    local CRData = CommonRewardData.CreateCRDataUseList(rewards, nums)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      window:AddAndTryShowReward(CRData)
    end)
  end)
end

function UICarnival22Task:__OnJumpTask(taskId)
  local taskItem = self._taskItemDic[taskId]
  if taskItem == nil then
    return
  end
  local taskData = taskItem:GetCarnivalTaskData()
  if taskData.state == TaskEnum.eTaskState.Picked then
    return
  end
  if taskData:CheckComplete() then
    return
  end
  local jumpId = taskData.stcData.jump_id
  if jumpId == 0 then
    return
  end
  JumpManager:Jump(jumpId, nil, nil, taskData.stcData.jumpArgs)
end

function UICarnival22Task:OnClickTaskIntro()
  local carnivalCfg = self._carnivalData:GetCarnivalMainCfg()
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22InfoWindow, function(win)
    if win == nil then
      return
    end
    win:InitCarnivalTaskIntroRule(carnivalCfg.task_rule_id)
  end)
end

function UICarnival22Task:OnClickClose()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UICarnival22Task:OnDelete()
  base.OnDelete(self)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__OnTaskUpteEventCallback)
  MsgCenter:RemoveListener(eMsgEventId.ActivityCarnivalTimePass, self.__UpdateTaskAllCallback)
end

return UICarnival22Task
