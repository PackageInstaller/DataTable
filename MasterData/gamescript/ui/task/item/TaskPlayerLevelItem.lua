local TaskState = CommonDefine.TaskState
local MAX_REWARD_NUM = 5
local MAX_SHOW_ITEM_NUM = 10
local TaskPlayerLevelItem, Super = System.NewComponent("TaskPlayerLevelItem")

function TaskPlayerLevelItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Task_Popup_Challenge_Item1Resource(uiNode)
  self.taskTid = data.taskTid
  self.taskUid = data.taskUid
  self.taskState = data.taskState
  self.taskCfg = DT.Task[self.taskTid]
end

function TaskPlayerLevelItem:OnBind(binder)
  self:BindLeftDescPart(binder)
  self:BindMiddleRewardPart(binder)
  self:BindRightStatePart(binder)
end

function TaskPlayerLevelItem:BindLeftDescPart(binder)
  binder:BindToText(self.ui.Text_LvevlNum, function()
    if self.taskCfg.CompleteCond ~= CommonDefine.TaskCond.PlayerLevel then
      return ""
    end
    local showLevel = self.taskCfg.CompleteCondPara[1]
    do return LT.Text end
    return LT.Text, showLevel
  end)
end

function TaskPlayerLevelItem:BindMiddleRewardPart(binder)
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

function TaskPlayerLevelItem:BindRightStatePart(binder)
  binder:BindToVisible(self.ui.Group_Content, function()
    return not self:LockByPlayerLevel()
  end)
  binder:BindToVisible(self.ui.Group_Nor, function()
    return self.taskState ~= TaskState.Done
  end)
  binder:BindToVisible(self.ui.Group_Get, function()
    return self.taskState == TaskState.Receive
  end)
  binder:BindToVisible(self.ui.Group_Over, function()
    return self.taskState == TaskState.Done
  end)
  binder:BindToVisible(self.ui.Group_Undone, function()
    return self.taskState == TaskState.Doing and not self:LockByPlayerLevel()
  end)
  binder:BindToVisible(self.ui.Group_Lock, function()
    do return self.LockByPlayerLevel end
    return self.LockByPlayerLevel, self
  end)
  binder:BindZ1Button(self.ui.Btn_Get, System.fn(self, self.OnTaskReceive), nil, function()
    do return LT.Text end
    return LT.Text, "TaskModule_btn_reward"
  end, function()
    return RedPointDataUtils.RedAttrType.Red
  end)
end

function TaskPlayerLevelItem:OnTaskReceive()
  TaskDataUtils.TaskComplete(self.taskUid)
end

function TaskPlayerLevelItem:LockByPlayerLevel()
  local playerLevel = PlayerDataUtils.GetLevel()
  local showLevel = self.taskCfg.CompleteCondPara[1]
  return showLevel > playerLevel + MAX_SHOW_ITEM_NUM
end

return TaskPlayerLevelItem
