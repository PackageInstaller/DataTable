local DailyTaskItem, Super = NewClass("DailyTaskItem", ViewComponent)

function DailyTaskItem:ctor(uiNode, view, taskTid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Main_Item_ActiveTasksResource(uiNode)
  self.taskTid = taskTid
end

function DailyTaskItem:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:_CreateRewardTableView()
  self:AddButtonClickListener(self.ui.Btn_Receive, System.fn(self, self._OnClickReceive))
  self:AddButtonClickListener(self.ui.Btn_Proxy, System.fn(self, self._OnClickProxy))
  self:BindEvent(EventMgr.Instance.TaskViewUpdate, System.fn(self, self._OnTaskViewUpdate))
end

function DailyTaskItem:_OnClickProxy()
  if not self:_IsSkipItemEnough() then
    local tip = LT.Textf("Shop_Buy_Lack_Money", LT.Text(ItemCfgUtils.GetCfgField("Name", DT.GetConstant("DailyChallengeSkipConsume"))))
    Alert.ShowStr(tip)
    return
  end
  Alert.Show(20200, nil, function()
    DailyChallengeController.Instance:ReqOnCutClass()
  end)
end

function DailyTaskItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:Refresh()
end

function DailyTaskItem:Refresh()
  local taskTid = self.taskTid
  local taskCfg = TaskDataUtils.GetTaskConfigByTid(taskTid)
  self:SetText(self.ui.Text_Desc, TaskDataUtils.GetTaskProgressDesc(taskTid, "%s<color=#A3A6AB>(%s/%s)</color>"))
  self:SetActive(self.ui.Group_Got, TaskDataUtils.TaskFinshAndGetedAward(taskTid))
  self:SetActive(self.ui.Btn_Receive, TaskDataUtils.IsTaskCanReward(taskTid))
  self:SetActive(self.ui.Group_NotReceive, TaskDataUtils.IsTaskNotComplete(taskTid))
  self:SetActive(self.ui.Btn_Proxy, TaskDataUtils.IsTaskNotComplete(taskTid))
  local btnState = self:_IsSkipItemEnough() and CommonDefine.Z1ButtonState.High or CommonDefine.Z1ButtonState.Unclickable
  self:SetButtonState(self.ui.Btn_Proxy, btnState)
  self:_RefreshRewards(taskTid)
end

function DailyTaskItem:_IsSkipItemEnough()
  local challengeSkipConsumeItemTid = DT.GetConstant("DailyChallengeSkipConsume")
  local itemNum = ItemDataUtils.GetItemNum(challengeSkipConsumeItemTid)
  return itemNum > 0
end

function DailyTaskItem:_OnClickReceive()
  local taskTid = self.taskTid
  TaskDataUtils.TaskComplete(taskTid)
end

function DailyTaskItem:_OnTaskViewUpdate()
  self:Refresh()
end

function DailyTaskItem:_RefreshRewards(taskTid)
  local taskCfg = TaskDataUtils.GetTaskConfigByTid(taskTid)
  self._rewards = {}
  for itemTid, itemCount in table.iteraDouble(taskCfg.CompleteAward) do
    table.insert(self._rewards, {itemTid = itemTid, itemCount = itemCount})
  end
  self._rewardTableView:ReloadData()
end

function DailyTaskItem:_CreateRewardTableView()
  local cellGameObj = self.ui.UI_Common_Item_WuPin_Type2
  local sizeDelta = cellGameObj.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._rewardTableView = self:CreateTableview(self.ui.ScrollView_Award, function()
    return #self._rewards
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(cellGameObj)
    local viewData = self._rewards[index]
    self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, viewData)
    return cell
  end, function()
    return w, h
  end)
end

return DailyTaskItem
