local base = require("Game.ActivityChristmas.UI.Task.UINChristmas22LimitTaskNode")
local UINSpring23LimitTaskNode = class("UINSpring23LimitTaskNode", base)
local UINSpring23LimitTaskItem = require("Game.ActivitySpring.UI.Task.UINSpring23LimitTaskItem")
local UINChristmas22LimitTaskEmptyItem = require("Game.ActivityChristmas.UI.Task.UINChristmas22LimitTaskEmptyItem")
local JumpManager = require("Game.Jump.JumpManager")

function UINSpring23LimitTaskNode:__OnInitChristmasUI()
  self._taskItemPool = UIItemPool.New(UINSpring23LimitTaskItem, self.ui.taskItem)
  self.ui.taskItem:SetActive(false)
  self._emptyPool = UIItemPool.New(UINChristmas22LimitTaskEmptyItem, self.ui.emptyItem)
  self.ui.emptyItem:SetActive(false)
  self.__RefillChristmas22LimitTaskNode = BindCallback(self, self.RefillChristmas22LimitTaskNode)
  MsgCenter:AddListener(eMsgEventId.ActivitySpringTaskExpired, self.__RefillChristmas22LimitTaskNode)
  self.__HideTaskRefreshWhenActEndCallback = BindCallback(self, self.__HideTaskRefreshWhenActEnd)
  MsgCenter:AddListener(eMsgEventId.SectorActivityRunEnd, self.__HideTaskRefreshWhenActEndCallback)
end

function UINSpring23LimitTaskNode:InitChristmas22LimitTaskNode(actSpringData)
  self._springData = actSpringData
  local cfg = self._springData:GetSpringMainCfg()
  self._limitCount = cfg.task_limit
  self._dailyReleast = cfg.task_daily_release
  self._totalRefCount = cfg.daily_task_refresh_max
  self.ui.tex_Tip.text = ConfigData:GetTipContent(8720)
end

function UINSpring23LimitTaskNode:RefreshChristmas22LimitTaskChange(taskData)
  if taskData:CheckComplete() then
    self:RefillChristmas22LimitTaskNode()
  else
    base.RefreshChristmas22LimitTaskChange(self, taskData)
  end
end

function UINSpring23LimitTaskNode:__SortTaskData(taskDatas)
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

function UINSpring23LimitTaskNode:__GetRefTimes()
  return self._springData:GetSpringRefTimes()
end

function UINSpring23LimitTaskNode:__GetTaskIds()
  return self._springData:GetSpringRefreshTaskIds()
end

function UINSpring23LimitTaskNode:__GetExpireTimes()
  return self._springData:GetSpringDailyTaskExpireTime()
end

function UINSpring23LimitTaskNode:__ReqRefresh(taskId, callback)
  self._springData:ReqSpringDailyRef(taskId, callback)
end

function UINSpring23LimitTaskNode:__GetActInRuning()
  return self._springData:IsActivityRunning()
end

function UINSpring23LimitTaskNode:__ReqCommotTask(taskId, callback)
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
  self._springData:ReqSpringDailyTask(taskId, callback)
end

function UINSpring23LimitTaskNode:__OnRemoveChristmasUI()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.ActivitySpringTaskExpired, self.__RefillChristmas22LimitTaskNode)
  MsgCenter:RemoveListener(eMsgEventId.SectorActivityRunEnd, self.__HideTaskRefreshWhenActEndCallback)
end

function UINSpring23LimitTaskNode:__HideTaskRefreshWhenActEnd()
  if not self:__GetActInRuning() then
    for i, v in ipairs(self._taskItemPool.listItem) do
      v:SetChristmas22LimitTaskRef(false)
    end
    self._emptyPool:HideAll()
  end
end

return UINSpring23LimitTaskNode
