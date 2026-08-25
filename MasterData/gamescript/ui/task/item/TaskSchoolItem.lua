local TaskState = CommonDefine.TaskState
local MAX_REWARD_NUM = 3
local TaskSchoolItem, Super = System.NewComponent("TaskSchoolItem")

function TaskSchoolItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Task_Popup_Career_ItemResource(uiNode)
  self.taskTid = data.taskTid
  self.taskUid = data.taskUid
  self.taskState = data.taskState
  self.taskCfg = DT.Task[self.taskTid]
  self.banClick = false
end

function TaskSchoolItem:OnBind(binder)
  self.binder = binder
  self:BindLeftDescPart(binder)
  self:BindMiddleRewardPart(binder)
  self:BindRightStatePart(binder)
end

function TaskSchoolItem:BindLeftDescPart(binder)
  binder:BindToImage(self.ui.Image_IconGold, function()
    if self.taskCfg.CompleteCond ~= CommonDefine.TaskCond.AwakerAppointSchoolBreakLevelNum then
      return nil
    end
    local schoolId = self.taskCfg.CompleteCondPara[2]
    return DT.SchoolConfig[schoolId].Icon
  end)
  binder:BindToText(self.ui.Text_Desc1, function()
    do return LT.Text end
    return LT.Text, self.taskCfg.Name
  end)
  binder:BindToText(self.ui.Text_Desc2, function()
    do return LT.Text end
    return LT.Text, self.taskCfg.Desc
  end)
  binder:BindToText(self.ui.Text_Count, function()
    if not self.taskUid then
      return ""
    end
    local taskData = TaskDataUtils.GetTaskData(self.taskUid)
    local totalProgress = TaskDataUtils.GetTaskProgressLimit(taskData.tid)
    do return LT.Text, string.format("%s/%s", math.min(taskData.count, totalProgress), totalProgress) end
    return LT.Text, string.format("%s/%s", math.min(taskData.count, totalProgress), totalProgress)
  end)
end

function TaskSchoolItem:BindMiddleRewardPart(binder)
  local rewardGroup = TaskDataUtils.GetTaskCompleteAward(self.taskTid)
  for i = 1, MAX_REWARD_NUM do
    local obj = self.ui["Article_" .. i]
    obj:SetActive(i <= #rewardGroup)
    if i <= #rewardGroup then
      local data = rewardGroup[i]
      local itemData = {
        itemTid = data.tid,
        itemCount = data.num
      }
      binder:BindComponent(CommonIconItemType2(obj, itemData))
    end
  end
end

function TaskSchoolItem:BindRightStatePart(binder)
  binder:BindToVisible(self.ui.Group_Nor, function()
    return self.taskState ~= TaskState.Done
  end)
  binder:BindToVisible(self.ui.Group_Lock, function()
    return self.taskState == TaskState.Doing
  end)
  binder:BindToVisible(self.ui.Group_Over, function()
    return self.taskState == TaskState.Done
  end)
  binder:BindToVisible(self.ui.Btn_Get, function()
    return self.taskState == TaskState.Receive
  end)
  binder:BindZ1Button(self.ui.Btn_Get, System.fn(self, self.OnTaskReceive), nil, function()
    do return LT.Text end
    return LT.Text, "TaskModule_btn_reward"
  end, function()
    return RedPointDataUtils.RedAttrType.Red
  end)
end

function TaskSchoolItem:OnTaskReceive()
  if not self.banClick then
    TaskDataUtils.TaskComplete(self.taskUid)
    self.banClick = true
    self.binder:BindTimer(0.5, 0, nil, function()
      self.banClick = false
    end)
  end
end

return TaskSchoolItem
