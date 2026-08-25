local ActivitySkinTaskItem, Super = System.NewComponent("ActivitySkinTaskItem", SummonGiftTask)

function ActivitySkinTaskItem:ctor(uiNode, skinTaskInfo)
  Super.ctor(self, uiNode, skinTaskInfo and skinTaskInfo.skinTaskTid, System.fn(self, self._ReqTaskReward), {isHideTime = true})
  self.skinTaskInfo = skinTaskInfo
end

function ActivitySkinTaskItem:OnBind(binder)
  if not self.skinTaskInfo then
    binder:SetActive(self.ui.uiNode, false)
    return
  end
  local skinActivityTid = self.skinTaskInfo.skinActivityTid
  local skinActivityData = ActivityDataUtils.GetActivityData(skinActivityTid)
  if not skinActivityData or not ActivityDataUtils.IsActivityOpen(skinActivityTid) then
    binder:SetActive(self.ui.uiNode, false)
    return
  end
  binder:SetActive(self.ui.uiNode, true)
  Super.OnBind(self, binder)
end

function ActivitySkinTaskItem:GetTaskEndTs()
  local skinActivityData = ActivityDataUtils.GetActivityData(self.skinTaskInfo.skinActivityTid)
  return skinActivityData and skinActivityData.base.endTime or math.maxinteger
end

function ActivitySkinTaskItem:_OnBindRedPoint(binder)
  local taskData = TaskDataUtils.GetTaskData(self.taskTid) or {}
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, function()
    return taskData.state == cd.TaskState.Receive
  end))
end

function ActivitySkinTaskItem:_ReqTaskReward()
  ActivityDataUtils.ReqGainAward(self.skinTaskInfo.skinActivityTid, self.skinTaskInfo.skinTaskTid)
end

return ActivitySkinTaskItem
