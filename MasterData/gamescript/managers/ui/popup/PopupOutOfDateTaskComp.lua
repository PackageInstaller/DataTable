local PopupOutOfDateTaskComp = System.NewClass("PopupOutOfDateTaskComp", PopupBaseComp)

function PopupOutOfDateTaskComp:ctor()
  self._checkTaskList = nil
  self.lastCheckTaskTime = nil
end

function PopupOutOfDateTaskComp:OnBind(binder)
  self.binder = binder
end

function PopupOutOfDateTaskComp:Clear()
end

function PopupOutOfDateTaskComp:CheckPopup()
  local outOfDate = DT.GetConstant("DeepSeaInvasionDefensiveActiviityTaskEnd") or 0
  local now = TimeUtils.GetServerTime()
  if outOfDate > now then
    return
  end
  if self.lastCheckTaskTime and now - self.lastCheckTaskTime < 2 then
    return
  end
  self.lastCheckTaskTime = now
  if not self._checkTaskList then
    local taskDataList = {}
    for _, summonCfg in pairs(DT.Summon) do
      if summonCfg.SummonTask then
        table.mergeArray(taskDataList, summonCfg.SummonTask)
      end
    end
    for _, activityCfg in pairs(DT.Activity) do
      if activityCfg.ActivityType == ActivityDefine.ActivityType.DeepSeaInvasionDefensive then
        table.mergeArray(taskDataList, activityCfg.ActivityPara4 or {})
      elseif activityCfg.ActivityType == ActivityDefine.ActivityType.SevenDayLogin then
        table.mergeArray(taskDataList, activityCfg.ActivityPara3 or {})
      end
    end
    self._checkTaskList = taskDataList
  end
  for i = #self._checkTaskList, 1, -1 do
    local taskTid = self._checkTaskList[i]
    if not TaskDataUtils.GetConfig(taskTid) then
      table.remove(self._checkTaskList, i)
    else
      local taskData = TaskDataUtils.GetTaskData(taskTid)
      if taskData and taskData.state ~= CommonDefine.TaskState.Done then
        taskData.state = CommonDefine.TaskState.Done
      end
    end
  end
end

return PopupOutOfDateTaskComp
