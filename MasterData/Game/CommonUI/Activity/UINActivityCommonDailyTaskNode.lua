local UINActivityCommonDailyTaskNode = class("UINActivityCommonDailyTaskNode", UIBaseNode)
local base = UIBaseNode

function UINActivityCommonDailyTaskNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__OnTaskRefreshCallback = BindCallback(self, self.__OnTaskRefresh)
  self.__OnTaskCompleteCallback = BindCallback(self, self.__OnTaskComplete)
  self:__OnInitCommonTaskNodeUI()
end

function UINActivityCommonDailyTaskNode:RefillDailyTaskNode()
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

function UINActivityCommonDailyTaskNode:RefreshDailyTaskChange(taskData)
  local item = self._taskItemDic[taskData.id]
  if item ~= nil then
    item:RefreshDailyTaskItem()
  end
end

function UINActivityCommonDailyTaskNode:__OnTaskRefresh(taskItem, taskData)
  local refTimes = self:__GetRefTimes()
  if refTimes >= self._totalRefCount then
    return
  end
  if taskData:CheckComplete() then
    return
  end
  self:__ReqRefresh(taskData.id, function(newTaskId)
    if IsNull(self.transform) then
      return
    end
    self:RefillDailyTaskNode()
  end)
end

function UINActivityCommonDailyTaskNode:__OnTaskComplete(taskData)
  self:__ReqCommitTask(taskData.id, function()
    if not IsNull(self.transform) then
      self:RefillDailyTaskNode()
    end
  end)
end

function UINActivityCommonDailyTaskNode:__OnTimer()
  local time = self:__GetExpireTimes()
  local diffTime = self:__GetExpireTimes() - PlayerDataCenter.timestamp
  diffTime = math.max(diffTime, 0)
  local str = TimeUtil:TimestampToTime(diffTime)
  for i, v in ipairs(self._emptyPool.listItem) do
    v:SetTaskNextShowTex(str)
  end
end

function UINActivityCommonDailyTaskNode:RefillDailyTaskListNode()
end

function UINActivityCommonDailyTaskNode:RefillEmptyTaskListNode()
end

function UINActivityCommonDailyTaskNode:__OnInitCommonTaskNodeUI()
end

function UINActivityCommonDailyTaskNode:InitDailyTaskNode()
end

function UINActivityCommonDailyTaskNode:RefreshTaskNodeUI()
end

function UINActivityCommonDailyTaskNode:RefreshTopBarTex()
end

function UINActivityCommonDailyTaskNode:__SortTaskData()
end

function UINActivityCommonDailyTaskNode:__GetRefTimes()
end

function UINActivityCommonDailyTaskNode:__GetActIsRunning()
end

function UINActivityCommonDailyTaskNode:__GetTaskIds()
end

function UINActivityCommonDailyTaskNode:__GetExpireTimes()
end

function UINActivityCommonDailyTaskNode:__ReqRefresh()
end

function UINActivityCommonDailyTaskNode:__ReqCommitTask()
end

function UINActivityCommonDailyTaskNode:__OnRemoveCommonTaskNodeUI()
end

function UINActivityCommonDailyTaskNode:OnHide()
  if self._timer ~= nil then
    TimerManager:StopTimer(self._timer)
    self._timer = nil
  end
  base.OnHide(self)
end

function UINActivityCommonDailyTaskNode:OnDelete()
  self._taskItemPool:DeleteAll()
  self._emptyPool:DeleteAll()
  base.OnDelete(self)
end

return UINActivityCommonDailyTaskNode
