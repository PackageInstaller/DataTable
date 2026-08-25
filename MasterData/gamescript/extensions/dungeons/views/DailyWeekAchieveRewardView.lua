local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local TaskState = CommonDefine.TaskState
local DailyWeekAchieveRewardView, Super = NewClass("DailyWeekAchieveRewardView", BaseView)
DailyWeekAchieveRewardView.uiResCls = UI_Dungeons_Popup_Award_OptimizedResource

function DailyWeekAchieveRewardView:ctor()
  Super.ctor(self)
end

function DailyWeekAchieveRewardView:OnEnterView()
  Super.OnEnterView(self)
  self.TabUIs = {}
  self:UpdateUIElements()
  self:UpdateTaskLists()
  self:UpdateTabsScroll()
  self:UpdateAwardsScroll()
  self:BindTimer(0.05, 0, nil, function()
    self:_OnChangeTab(self.selectedGroupId)
    self:RefreshRed()
  end)
end

function DailyWeekAchieveRewardView:UpdateTaskLists()
  if not self.parentTaskList then
    self.parentTaskList, self.taskListMap = DailyChallengeDataUtils.GetDailyAchievementTaskLists()
    self.selectedGroupId = 1
  end
  for _, childList in pairs(self.taskListMap) do
    table.sort(childList, function(aId, bId)
      local aCfg = DT.Task[aId]
      local bCfg = DT.Task[bId]
      local aState = TaskDataUtils.GetTaskData(aId).state
      local bState = TaskDataUtils.GetTaskData(bId).state
      if aState ~= bState then
        if aState == TaskState.Receive then
          aState = -1
        end
        if bState == TaskState.Receive then
          bState = -1
        end
        return aState < bState
      end
      return aCfg.BaseSortID < bCfg.BaseSortID
    end)
  end
end

function DailyWeekAchieveRewardView:UpdateUIElements()
  self:SetText(self.ui.Text_Title, LT.Text("ScoreAchieveTitle"))
end

function DailyWeekAchieveRewardView:UpdateTabsScroll()
  if not self.tabTableView then
    local cellRT = self.ui.UI_Event_Reward_Tab and self.ui.UI_Event_Reward_Tab:GetComponent(TYPEOF_RectTransform) or nil
    if not cellRT then
      return
    end
    local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
    self.tabTableView = self:CreateTableview(self.ui.ScrollView_TabCon, function()
      return #self.parentTaskList or 0
    end, function(view, index)
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(self.ui.UI_Event_Reward_Tab)
      self:SetTabCell(UI_Event_Reward_TabResource(cell.gameObject), index)
      return cell
    end, function()
      return width, height
    end)
  end
  self.tabTableView:ReloadData()
end

function DailyWeekAchieveRewardView:SetTabCell(cellUI, index)
  local parentTaskId = self.parentTaskList[index]
  local taskCfg = DT.Task[parentTaskId]
  self:SetText(cellUI.Text_Title, LT.Text(taskCfg.Desc))
  local completeCount, totalCount = self:GetParentTaskProgress(parentTaskId)
  local progStr = string.format("%s/%s", completeCount, totalCount)
  self:SetText(cellUI.Text_Progress, progStr)
  self.TabUIs[index] = cellUI
  self.binder:BindZ1Button(cellUI.uiNode, function()
    self:_OnChangeTab(index)
  end)
end

function DailyWeekAchieveRewardView:GetParentTaskProgress(parentTaskId)
  local completeCount, totalCount = 0, 0
  local taskList = self.taskListMap[parentTaskId] or {}
  totalCount = #taskList
  for _, taskId in ipairs(taskList) do
    local state = TaskDataUtils.GetTaskData(taskId).state
    if state == TaskState.Done then
      completeCount = completeCount + 1
    end
  end
  return completeCount, totalCount
end

function DailyWeekAchieveRewardView:_OnChangeTab(selectedGroupId)
  self.selectedGroupId = selectedGroupId
  for groupId, tabUI in pairs(self.TabUIs) do
    self:_SetTabState(tabUI, self.selectedGroupId == groupId)
  end
  self.awardTableView:ReloadData()
  self.ui.TaskContent.transform.anchoredPosition = CS.UnityEngine.Vector2(0, 0)
end

function DailyWeekAchieveRewardView:_SetTabState(tabUI, isOn)
  self:SetActive(tabUI.Group_High, isOn)
  if isOn then
    self:SetTextColorType(tabUI.Text_Title, CommonDefine.ColorType.Light)
    self:SetTextColorType(tabUI.Text_Progress, CommonDefine.ColorType.Light)
  else
    self:SetTextColorType(tabUI.Text_Title, CommonDefine.ColorType.Dark)
    self:SetTextColorType(tabUI.Text_Progress, CommonDefine.ColorType.Dark)
  end
end

function DailyWeekAchieveRewardView:UpdateAwardsScroll()
  if self.awardTableView then
    self.awardTableView:ReloadData()
  else
    local cellRT = self.ui.UI_Event_Reward_Item and self.ui.UI_Event_Reward_Item:GetComponent(TYPEOF_RectTransform) or nil
    if not cellRT then
      return
    end
    local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
    self.awardTableView = self:CreateTableview(self.ui.ScrollView_TaskCon, function()
      return self.taskListMap and #self.taskListMap[self.parentTaskList[self.selectedGroupId]] or 0
    end, function(view, index)
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(self.ui.UI_Event_Reward_Item)
      self:SetTaskCell(UI_Event_Reward_ItemResource(cell.gameObject), index)
      return cell
    end, function()
      return width, height
    end)
    self.awardTableView:ReloadData()
  end
  self:SetButtonState(self.ui.Btn_OneKey, self:IsHaveReward() and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
end

function DailyWeekAchieveRewardView:SetTaskCell(cellUI, index)
  local taskId = self.taskListMap[self.parentTaskList[self.selectedGroupId]][index]
  local taskCfg = DT.Task[taskId]
  local taskData = TaskDataUtils.GetTaskData(taskId)
  if not taskData then
    self:SetActive(cellUI.Btn_Receive, false)
    self:SetActive(cellUI.Group_Got, false)
    self:SetActive(cellUI.Group_NotReceive, false)
    self:SetText(cellUI.Text_Desc, "")
    local emptyList = {}
    self:CreateTableview(cellUI.ScrollView_Award, function()
      return #emptyList
    end, function(view, idx)
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(cellUI.UI_Common_Item_WuPin_Type2)
      local itemData = emptyList[idx]
      self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, itemData)
      return cell
    end, function()
      return 110, 110
    end):ReloadData()
    return
  end
  self:SetActive(cellUI.Btn_Receive, taskData.state == TaskState.Receive)
  self:AddButtonClickListener(cellUI.Btn_Receive, function()
    self:ReqTaskReward(taskData)
  end)
  self:SetActive(cellUI.Group_Got, taskData.state == TaskState.Done)
  self:SetActive(cellUI.Group_NotReceive, taskData.state < TaskState.Receive)
  self:SetText(cellUI.Text_Desc, TaskDataUtils.GetTaskProgressDesc(taskId, "%s<color=#A3A6AB>(%s/%s)</color>"))
  local rewardList = {}
  for i = 1, #taskCfg.CompleteAward, 2 do
    table.insert(rewardList, {
      itemTid = taskCfg.CompleteAward[i],
      itemCount = taskCfg.CompleteAward[i + 1]
    })
  end
  self:CreateTableview(cellUI.ScrollView_Award, function()
    return rewardList and #rewardList or 0
  end, function(view, ind)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(cellUI.UI_Common_Item_WuPin_Type2)
    local itemData = rewardList[ind]
    self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, itemData)
    return cell
  end, function()
    return 110, 110
  end):ReloadData()
end

function DailyWeekAchieveRewardView:ReqTaskReward(taskData)
  TaskDataUtils.TaskComplete(taskData.tid, function()
    taskData.state = TaskState.Done
    self:Notify(NotifyId.OnDailyChallengeAchieveAwardGet)
    self:Notify(NotifyId.OnDailyChallengeLevelAwardGet)
  end)
end

function DailyWeekAchieveRewardView:RequestGainAllLifePrize()
  if self:IsHaveReward() then
    DailyChallengeController.Instance:RequestGainAllAchievementPrize(function()
      self:Notify(NotifyId.OnDailyChallengeAchieveAwardGet)
      self:Notify(NotifyId.OnDailyChallengeLevelAwardGet)
      self:Close()
    end)
  end
end

function DailyWeekAchieveRewardView:RefreshRed()
  for groupId, tabUI in pairs(self.TabUIs) do
    local showRed = RedPointDataUtils.IsShowDailyChallengeAchieveRewardNew(self.parentTaskList[groupId])
    self:SetActive(tabUI.Group_RedDot, showRed)
  end
end

function DailyWeekAchieveRewardView:IsHaveReward(groupId)
  do return DailyChallengeDataUtils.IsHaveAchievementReward end
  return DailyChallengeDataUtils.IsHaveAchievementReward, groupId
end

function DailyWeekAchieveRewardView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_OneKey, System.fn(self, self.RequestGainAllLifePrize))
end

function DailyWeekAchieveRewardView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnDailyChallengeAchieveAwardGet, self.UpdateTaskLists, self)
  self:RegisterNotify(NotifyId.OnDailyChallengeAchieveAwardGet, self.UpdateTabsScroll, self)
  self:RegisterNotify(NotifyId.OnDailyChallengeAchieveAwardGet, self.RefreshRed, self)
  self:RegisterNotify(NotifyId.OnDailyChallengeAchieveAwardGet, self.UpdateAwardsScroll, self)
end

function DailyWeekAchieveRewardView:OnExitView()
  Super.OnExitView(self)
end

return DailyWeekAchieveRewardView
