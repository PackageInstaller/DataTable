local RailWayTaskView, Super = NewClass("RailWayTaskView", PvpTaskView)

function RailWayTaskView:_RefreshTitle()
  self:SetText(self.ui.Text_Title, LT.Text("RailWayTaskViewTitle"))
end

function RailWayTaskView:_GetTargetTaskType()
  return CommonDefine.TaskType.TaskType_RailWay
end

function RailWayTaskView:_GetTargetTaskSvrIdx()
  return CommonDefine.TaskServerIndex.RailWayChildTask
end

function RailWayTaskView:_GetParentTaskTidList()
  do return DT.GetOriginalConstant end
  return DT.GetOriginalConstant, "RailWayTaskGroup"
end

function RailWayTaskView:_GetParentTaskTitle(taskTid)
  do return LT.Text, TaskCfgUtils.GetCfgField("Name", taskTid) end
  return LT.Text, TaskCfgUtils.GetCfgField("Name", taskTid)
end

return RailWayTaskView
