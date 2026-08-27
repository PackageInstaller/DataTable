local base = require("Game.CommonUI.Activity.UINActivityCommonDailyTaskNode")
local UINActivityAnniversary23DailyTask = class("UINActivityAnniversary23DailyTask", base)
local UINActivityAnniversary23DailyTaskEmptyItem = require("Game.ActivityAnniversary23.UI.Task.UINActivityAnniversary23DailyTaskEmptyItem")
local UINActivityAnniversary23DailyTaskItem = require("Game.ActivityAnniversary23.UI.Task.UINActivityAnniversary23DailyTaskItem")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon

function UINActivityAnniversary23DailyTask:__OnInitCommonTaskNodeUI()
  self._taskItemPool = UIItemPool.New(UINActivityAnniversary23DailyTaskItem, self.ui.taskItem)
  self.ui.taskItem:SetActive(false)
  self._emptyPool = UIItemPool.New(UINActivityAnniversary23DailyTaskEmptyItem, self.ui.emptyItem)
  self.ui.emptyItem:SetActive(false)
end

function UINActivityAnniversary23DailyTask:BindAnniversary23DailyTaskOpenFunc(func)
  self._openFunc = func
end

function UINActivityAnniversary23DailyTask:InitDailyTaskNode(actDailyTaskData, frameData)
  self._actDailyTaskData = actDailyTaskData
  self._frameData = frameData
  local cfg = self._actDailyTaskData:GetActDailyTaskCfg()
  self._limitCount = cfg.task_limit
  self._totalRefCount = cfg.daily_task_refresh_max
  self._dailyRelease = cfg.task_daily_release
  self.ui.tex_Tip.text = ConfigData:GetTipContent(8720)
end

function UINActivityAnniversary23DailyTask:RefreshTaskNodeUI()
  self.ui.tex_TaskNum.text = tostring(self._curCount) .. "/" .. tostring(self._limitCount)
  self.ui.tex_Limited.gameObject:SetActive(self._curCount >= self._limitCount)
end

function UINActivityAnniversary23DailyTask:RefillDailyTaskNode()
  self:RefreshTopBarTex()
  self:RefillDailyTaskListNode()
  self:RefillEmptyTaskListNode()
  self:RefreshTaskNodeUI()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._timerId = TimerManager:StartTimer(1, self.__OnTimer, self)
  self:__OnTimer()
end

function UINActivityAnniversary23DailyTask:RefillDailyTaskListNode()
  self._taskItemDic = {}
  local refTimes = self:__GetRefTimes()
  local refActive = self:__GetActIsRunning() and refTimes < self._totalRefCount
  self._taskItemPool:HideAll()
  local taskIds = self:__GetTaskIds()
  local taskDatas = {}
  for i, v in ipairs(taskIds) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(v)
    if taskData ~= nil then
      table.insert(taskDatas, taskData)
    end
  end
  self:__SortTaskData(taskDatas)
  for i, taskData in ipairs(taskDatas) do
    local item = self._taskItemPool:GetOne()
    item:InitDailyTaskItem(taskData, self.__OnTaskCompleteCallback, self.__OnTaskRefreshCallback)
    item:SetDailyTaskItemRef(refActive)
    self._taskItemDic[taskData.id] = item
  end
end

function UINActivityAnniversary23DailyTask:RefillEmptyTaskListNode()
  local taskIds = self:__GetTaskIds()
  local curCount = #taskIds
  self._emptyPool:HideAll()
  if self:__GetActIsRunning() then
    local nextShowCount = self._limitCount - curCount
    nextShowCount = math.min(nextShowCount, self._dailyRelease)
    for i = 1, nextShowCount do
      local item = self._emptyPool:GetOne()
      item:PlayDailyTaskEmptyItemAnim()
      item.transform:SetAsLastSibling()
    end
  end
end

function UINActivityAnniversary23DailyTask:RefreshTopBarTex()
  if self:__GetActIsRunning() then
    self.ui.obj_refreshTip:SetActive(true)
    local refTimes = self:__GetRefTimes()
    self.ui.tex_RefreshTimes:SetIndex(0, tostring(self._totalRefCount - refTimes), tostring(self._totalRefCount))
    return
  end
  self.ui.obj_refreshTip:SetActive(false)
  self.ui.tex_RefreshTimes:SetIndex(1)
end

function UINActivityAnniversary23DailyTask:__GetActIsRunning()
  if self._frameData ~= nil then
    return self._frameData:IsInRuningState()
  end
  return false
end

function UINActivityAnniversary23DailyTask:__SortTaskData(taskDatas)
  self._curCount = #taskDatas
  table.sort(taskDatas, function(a, b)
    if a.isPicked ~= b.isPicked then
      return not a.isPicked
    end
    local aComplete = a:CheckComplete()
    if aComplete ~= b:CheckComplete() then
      return aComplete
    end
    return a.id < b.id
  end)
end

function UINActivityAnniversary23DailyTask:__GetRefTimes()
  return self._actDailyTaskData:GetActDailyRefTimes()
end

function UINActivityAnniversary23DailyTask:__GetTaskIds()
  return self._actDailyTaskData:GetActDailyTaskIds()
end

function UINActivityAnniversary23DailyTask:__GetExpireTimes()
  return self._actDailyTaskData:GetActDailyExpireTime()
end

function UINActivityAnniversary23DailyTask:__ReqRefresh(taskId, callback)
  local remain = self._totalRefCount - self._actDailyTaskData:GetActDailyRefTimes()
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(7129, remain, self._totalRefCount), function()
    self._actDailyTaskData:ReqActDailyTaskRef(taskId, function()
      if callback ~= nil then
        callback()
      end
      if self._openFunc ~= nil then
        self._openFunc()
      end
    end)
  end, nil)
end

function UINActivityAnniversary23DailyTask:__ReqCommitTask(taskId, callback)
  local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
  if taskData == nil then
    return
  end
  if not taskData:CheckComplete() then
    local flag, jumpId, jumpArgs = taskData:GetTaskJumpArg()
    if flag then
      JumpManager:Jump(jumpId, nil, nil, jumpArgs)
    end
    return
  end
  self._actDailyTaskData:ReqActDailyTaskCommit(taskId, function()
    if callback ~= nil then
      callback()
    end
    if self._openFunc ~= nil then
      self._openFunc()
    end
  end)
end

function UINActivityAnniversary23DailyTask:__OnRemoveCommonTaskNodeUI()
end

return UINActivityAnniversary23DailyTask
