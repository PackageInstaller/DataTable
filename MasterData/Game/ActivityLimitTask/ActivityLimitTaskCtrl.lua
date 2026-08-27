local base = ControllerBase
local ActivityLimitTaskCtrl = class("ActivityLimitTaskCtrl", base)
local ActivityLimitTaskData = require("Game.ActivityLimitTask.Data.ActivityLimitTaskData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function ActivityLimitTaskCtrl:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_task_limit)
  self._OnTaskUpdateFunc = BindCallback(self, self._OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self._OnTaskUpdateFunc)
  self._OnTaskRemoveFunc = BindCallback(self, self._OnTaskRemove)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self._OnTaskRemoveFunc)
end

function ActivityLimitTaskCtrl:InitActLimitTaskCtrl(activityFrameData)
  if self._actLimitTaskData ~= nil then
    error("Cant support more limit task activity")
    return
  end
  self._actLimitTaskData = ActivityLimitTaskData.New()
  self._actLimitTaskData:InitActLimitTaskData(activityFrameData)
  self._taskDic = self._actLimitTaskData:GetActLimitNotPickedTaskDataDic()
  self:UpdActLimitTaskRedDot()
end

function ActivityLimitTaskCtrl:GetCurActLimitTaskData()
  return self._actLimitTaskData
end

function ActivityLimitTaskCtrl:CloseActLimitTaskCtrl(activityFrameData)
  if self._actLimitTaskData:GetActLimitTaskFrameData() ~= activityFrameData then
    error("Cant support more limit task activity")
    return
  end
  if UIManager:GetWindow(UIWindowTypeID.ActivityLimitTask) ~= nil then
    UIUtil.ReturnHome()
  end
  self:Delete()
end

function ActivityLimitTaskCtrl:UpdActLimitTaskRedDot()
  if self._UpdTimer ~= nil then
    return
  end
  self._UpdTimer = TimerManager:StartTimer(1, self._RealUpdActLimitTaskRedDot, self, true, true)
end

function ActivityLimitTaskCtrl:_RealUpdActLimitTaskRedDot()
  local actFrameData = self._actLimitTaskData:GetActLimitTaskFrameData()
  local reddotNode = actFrameData:GetActivityReddotNode()
  local showReddot = false
  for taskId, taskData in pairs(self._taskDic) do
    if taskData:CheckComplete() then
      showReddot = true
      break
    end
    if self._actLimitTaskData:IsActLimitTaskShowNew(taskData) then
      showReddot = true
      break
    end
  end
  reddotNode:SetRedDotCount(showReddot and 1 or 0)
  self._UpdTimer = nil
end

function ActivityLimitTaskCtrl:_OnTaskUpdate(taskData, isNewTask)
  if not self._actLimitTaskData:IsActLimitTask(taskData.stcData.type) then
    return
  end
  if isNewTask then
    self._taskDic[taskData.id] = taskData
  end
  if taskData:IsPickedTaskReward() then
    self._taskDic[taskData.id] = nil
  end
  self:UpdActLimitTaskRedDot()
  local win = UIManager:GetWindow(UIWindowTypeID.ActivityLimitTask)
  if win ~= nil then
    win:OnUIActLimitTaskUpdate(taskData, isNewTask)
  end
end

function ActivityLimitTaskCtrl:_OnTaskRemove(taskId)
  if self._taskDic[taskId] == nil then
    return
  end
  self._taskDic[taskId] = nil
  self:UpdActLimitTaskRedDot()
  local win = UIManager:GetWindow(UIWindowTypeID.ActivityLimitTask)
  if win ~= nil then
    win:OnUIActLimitTaskRemove(taskId)
  end
end

function ActivityLimitTaskCtrl:OnDelete()
  TimerManager:StopTimer(self._UpdTimer)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self._OnTaskUpdateFunc)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self._OnTaskRemoveFunc)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_task_limit)
end

return ActivityLimitTaskCtrl
