local UINChristmas22LimitTaskNode = class("UINChristmas22LimitTaskNode", UIBaseNode)
local base = UIBaseNode
local UINChristmas22LimitTaskItem = require("Game.ActivityChristmas.UI.Task.UINChristmas22LimitTaskItem")
local UINChristmas22LimitTaskEmptyItem = require("Game.ActivityChristmas.UI.Task.UINChristmas22LimitTaskEmptyItem")

function UINChristmas22LimitTaskNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__OnTaskRefreshCallback = BindCallback(self, self.__OnTaskRefresh)
  self.__OnTaskCompleteCallback = BindCallback(self, self.__OnTaskComplete)
  self:__OnInitChristmasUI()
end

function UINChristmas22LimitTaskNode:__OnInitChristmasUI()
  self._taskItemPool = UIItemPool.New(UINChristmas22LimitTaskItem, self.ui.taskItem)
  self.ui.taskItem:SetActive(false)
  self._emptyPool = UIItemPool.New(UINChristmas22LimitTaskEmptyItem, self.ui.emptyItem)
  self.ui.emptyItem:SetActive(false)
  self.__RefillChristmas22LimitTaskNode = BindCallback(self, self.RefillChristmas22LimitTaskNode)
  MsgCenter:AddListener(eMsgEventId.ActivityHallowmasExpired, self.__RefillChristmas22LimitTaskNode)
end

function UINChristmas22LimitTaskNode:InitChristmas22LimitTaskNode(hallowmasData)
  self._hallowmasData = hallowmasData
  self._limitCount = self._hallowmasData:GetHallowmasMainCfg().task_limit
  self._totalRefCount = self._hallowmasData:GetHallowmasMainCfg().daily_task_refresh_max
  self._dailyReleast = self._hallowmasData:GetHallowmasMainCfg().task_daily_releast
  self.ui.tex_Tip.text = ConfigData:GetTipContent(8720)
end

function UINChristmas22LimitTaskNode:RefreshTopBarTex()
  local refTimes = self:__GetRefTimes()
  self.ui.tex_RefreshTimes:SetIndex(0, tostring(self._totalRefCount - refTimes), tostring(self._totalRefCount))
end

function UINChristmas22LimitTaskNode:RefillChristmas22LimitTaskNode()
  self._taskItemDic = {}
  local refTimes = self:__GetRefTimes()
  self:RefreshTopBarTex()
  local refActive = self:__GetActInRuning() and refTimes < self._totalRefCount
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
    item:InitChristmas22LimitTaskItem(taskData, self.__OnTaskCompleteCallback, self.__OnTaskRefreshCallback)
    item:SetChristmas22LimitTaskRef(refActive)
    self._taskItemDic[taskData.id] = item
  end
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  local curCount = #taskIds
  self.ui.tex_TaskNum.text = tostring(curCount) .. "/" .. tostring(self._limitCount)
  self.ui.tex_Limited.gameObject:SetActive(curCount >= self._limitCount)
  self._emptyPool:HideAll()
  if self:__GetActInRuning() then
    local nextShowCount = self._limitCount - curCount
    nextShowCount = math.min(nextShowCount, self._dailyReleast)
    for i = 1, nextShowCount do
      local item = self._emptyPool:GetOne()
      item:PlayChristmas22LimitTaskEmptyItemAnim()
      item.transform:SetAsLastSibling()
    end
  end
  self._timerId = TimerManager:StartTimer(1, self.__OnTimer, self)
  self:__OnTimer()
end

function UINChristmas22LimitTaskNode:__SortTaskData(taskDatas)
end

function UINChristmas22LimitTaskNode:RefreshChristmas22LimitTaskChange(taskData)
  local item = self._taskItemDic[taskData.id]
  if item ~= nil then
    item:RefreshChristmas22LimitTaskItem()
  end
end

function UINChristmas22LimitTaskNode:__OnTaskRefresh(taskItem, taskData)
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
    self:RefillChristmas22LimitTaskNode()
  end)
end

function UINChristmas22LimitTaskNode:__OnTaskComplete(taskData)
  self:__ReqCommotTask(taskData.id, function()
    if not IsNull(self.transform) then
      self:RefillChristmas22LimitTaskNode()
    end
  end)
end

function UINChristmas22LimitTaskNode:__OnTimer()
  local diffTime = self:__GetExpireTimes() - PlayerDataCenter.timestamp
  diffTime = math.max(diffTime, 0)
  local str = TimeUtil:TimestampToTime(diffTime)
  for i, v in ipairs(self._emptyPool.listItem) do
    v:SetTaskNextShowTex(str)
  end
end

function UINChristmas22LimitTaskNode:OnHide()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  base.OnHide(self)
end

function UINChristmas22LimitTaskNode:OnDelete()
  self:__OnRemoveChristmasUI()
  self._emptyPool:DeleteAll()
  self._taskItemPool:DeleteAll()
  base.OnDelete(self)
end

function UINChristmas22LimitTaskNode:__OnRemoveChristmasUI()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.ActivityHallowmasExpired, self.__RefillChristmas22LimitTaskNode)
end

function UINChristmas22LimitTaskNode:__GetRefTimes()
  return self._hallowmasData:GetHallowmasTaskRefreshTimes()
end

function UINChristmas22LimitTaskNode:__GetActInRuning()
  return self._hallowmasData:IsActivityRunning()
end

function UINChristmas22LimitTaskNode:__GetTaskIds()
  return self._hallowmasData:GetHallowmasDailyTaskIds()
end

function UINChristmas22LimitTaskNode:__GetExpireTimes()
  return self._hallowmasData:GetHallowmasExpiredTm()
end

function UINChristmas22LimitTaskNode:__ReqRefresh(taskId, callback)
  self._hallowmasData:ReqHallowmasRefreshTask(taskId, callback)
end

function UINChristmas22LimitTaskNode:__ReqCommotTask(taskId, callback)
  self._hallowmasData:ReqHallowmasCommitTask(taskId, callback)
end

return UINChristmas22LimitTaskNode
