local BreakthroughConditionItem, Super = System.NewComponent("BreakthroughConditionItem")

function BreakthroughConditionItem:ctor(uiNode, taskId)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_ConditionResource(uiNode)
  self.taskId = taskId
end

function BreakthroughConditionItem:OnBind(binder)
  binder:BindToTextColor(self.ui.Text_Special1, function()
    local result = TaskDataUtils.IsTaskDoneByTaskId(self.taskId)
    return result and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal
  end)
  binder:BindToText(self.ui.Text_Special1, function()
    do return TaskDataUtils.GetTaskDesc end
    return TaskDataUtils.GetTaskDesc, self.taskId
  end)
  binder:BindToRaw(function(_, finish)
    self.ui.Image_Icon_Hook_1:SetActive(finish)
    self.ui.Image_Icon_Cond_1:SetActive(not finish)
    local showLocation = TaskDataUtils.GetConfig(self.taskId).JumpTo ~= nil
    self.ui.Image_Location:SetActive(showLocation and not finish)
  end, function()
    do return TaskDataUtils.IsTaskDoneByTaskId end
    return TaskDataUtils.IsTaskDoneByTaskId, self.taskId
  end)
  binder:BindButtonClick(self.ui.Image_Location, System.fn(self, self.JumpFunction))
end

function BreakthroughConditionItem:JumpFunction()
  FuncJumpManager.Instance:JumpFunc(TaskDataUtils.GetTaskJumpTo(self.taskId))
end

return BreakthroughConditionItem
