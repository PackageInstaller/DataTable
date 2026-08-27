local base = require("Game.ActivitySpring.UI.Task.UINSpring23LimitTaskNode")
local UINWinter23DailyTask = class("UINWinter23DailyTask", base)
local UINSpring23LimitTaskItem = require("Game.ActivitySpring.UI.Task.UINSpring23LimitTaskItem")
local UINChristmas22LimitTaskEmptyItem = require("Game.ActivityChristmas.UI.Task.UINChristmas22LimitTaskEmptyItem")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon

function UINWinter23DailyTask:__OnInitChristmasUI()
  self._taskItemPool = UIItemPool.New(UINSpring23LimitTaskItem, self.ui.taskItem)
  self.ui.taskItem:SetActive(false)
  self._emptyPool = UIItemPool.New(UINChristmas22LimitTaskEmptyItem, self.ui.emptyItem)
  self.ui.emptyItem:SetActive(false)
  self.__HideTaskRefreshWhenActEndCallback = BindCallback(self, self.__HideTaskRefreshWhenActEnd)
  MsgCenter:AddListener(eMsgEventId.SectorActivityRunEnd, self.__HideTaskRefreshWhenActEndCallback)
end

function UINWinter23DailyTask:BindWinter23DailyTaskOperFunc(func)
  self._operFunc = func
end

function UINWinter23DailyTask:RefreshTopBarTex()
  if self:__GetActInRuning() then
    self.ui.obj_refreshTip:SetActive(true)
    base.RefreshTopBarTex(self)
    return
  end
  self.ui.obj_refreshTip:SetActive(false)
  self.ui.tex_RefreshTimes:SetIndex(1)
end

function UINWinter23DailyTask:InitWinter23LimitTaskNode(actDailyTaskData, frameData)
  self._actDailyTaskData = actDailyTaskData
  local cfg = self._actDailyTaskData:GetActDailyTaskCfg()
  self._limitCount = cfg.task_limit
  self._dailyReleast = cfg.task_daily_release
  self._totalRefCount = cfg.daily_task_refresh_max
  self.ui.tex_Tip.text = ConfigData:GetTipContent(8720)
  self._frameData = frameData
end

function UINWinter23DailyTask:__GetRefTimes()
  return self._actDailyTaskData:GetActDailyRefTimes()
end

function UINWinter23DailyTask:__GetTaskIds()
  return self._actDailyTaskData:GetActDailyTaskIds()
end

function UINWinter23DailyTask:__GetExpireTimes()
  return self._actDailyTaskData:GetActDailyExpireTime()
end

function UINWinter23DailyTask:__ReqRefresh(taskId, callback)
  local remain = self._totalRefCount - self._actDailyTaskData:GetActDailyRefTimes()
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(7129, remain, self._totalRefCount), function()
    self._actDailyTaskData:ReqActDailyTaskRef(taskId, function()
      if callback ~= nil then
        callback()
      end
      if self._operFunc ~= nil then
        self._operFunc()
      end
    end)
  end, nil)
end

function UINWinter23DailyTask:__GetActInRuning()
  if self._frameData ~= nil then
    return self._frameData:IsInRuningState()
  end
  return false
end

function UINWinter23DailyTask:__ReqCommotTask(taskId, callback)
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
    if self._operFunc ~= nil then
      self._operFunc()
    end
  end)
end

function UINWinter23DailyTask:__OnRemoveChristmasUI()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.SectorActivityRunEnd, self.__HideTaskRefreshWhenActEndCallback)
end

return UINWinter23DailyTask
