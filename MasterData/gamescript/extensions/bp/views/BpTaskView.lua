local TaskState = CommonDefine.TaskState
local TaskServerIndex = CommonDefine.TaskServerIndex
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local BpTaskView, Super = NewClass("BpTaskView", BaseView)
BpTaskView.uiResCls = UI_Passport_Task_Item_NewResource
local BpPage = CommonDefine.BpPage

function BpTaskView:ctor()
  Super.ctor(self)
end

function BpTaskView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnBpTaskViewTabChanged, self._OnTaskViewTabChanged, self)
  self:AddButtonClickListener(self.ui.Btn_Receive, System.fn(self, self.OnReceiveClick))
  self:AddButtonClickListener(self.ui.Btn_Exclamation_Mark, System.fn(self, self.OpenBpShowPanel))
  self:_InitTaskTabGroupView()
  self:_InitTaskItemGroupView()
end

function BpTaskView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.TaskViewUpdate, function(viewIndex)
    if BpTaskModel.Instance.curSelectTab == viewIndex then
      BpTaskModel.Instance:SetCurTaskList(viewIndex)
      self:_RefreshView()
    end
  end)
end

function BpTaskView:OnEnterView()
  Super.OnEnterView(self)
  BpTaskModel.Instance:SetCurSelectTab(TaskServerIndex.Period)
  self:_InitCompCountDown()
  self:_RefreshView()
  self:AddViewComponentOnce(self.ui.uiNode, CompBpExpSliderItem, UI_Passport_Task_Item_NewResource)
end

function BpTaskView:OnEnterViewFinished()
end

function BpTaskView:RefreshOnRendered()
  self:PlayTableViewFadeInAnim(self.ui.ScrollView_Task_Item)
end

function BpTaskView:_OnTaskViewTabChanged(taskSvrIdx)
  self:_RefreshView()
  self:PlayTableViewFadeInAnim(self.ui.ScrollView_Task_Item)
end

function BpTaskView:_RefreshView()
  self.taskTabGroupView:ReloadData()
  self.taskItemGroupView:ReloadData()
  self:SetActive(self.ui.Btn_Receive, RedPointDataUtils.IsShowTaskReceiveRedDot(BpTaskModel.Instance.taskTabList))
end

function BpTaskView:OnReceiveClick()
  if BattlePassDataUtils.GetWeeklyExp() >= DT.GetConstant("BPExpWeeklyLimit") and not TaskDataUtils.CheckTasksContainState(TaskServerIndex.Period, TaskState.Receive) then
    Alert.ShowStr(LT.Text("BPExpWeeklyLimitTxt"))
  end
  
  local function ReqAllTaskComplete()
    BattlePassDataUtils.ReqReceiveTaskAll()
    self:BindEventOnce(EventMgr.Instance.UpdateBagEvent, System.fn(self, self._ShowOneKeyRewards))
  end
  
  if self:CheckEnergyOver() then
    GetEnergyCheckUtils.TipsShow(ReqAllTaskComplete)
  else
    ReqAllTaskComplete()
  end
end

function BpTaskView:_ShowOneKeyRewards(items)
  local isTask = false
  for _, item in ipairs(items) do
    if item.reason == CommonDefine.ItemReason.Task then
      isTask = true
      break
    end
  end
  if isTask then
    ItemDataUtils.ShowRewardPanel(LT.Text("ItemGain_String_MainTitle_CHN"), "", items)
  end
end

function BpTaskView:CheckEnergyOver()
  local energyItemId = DT.GetConstant("EnergyItemTid")
  local energyItemNum = 0
  for level = 1, BattlePassDataUtils.GetLevel() do
    for _, taskItem in ipairs(BpTaskModel.Instance.curTaskList) do
      local uid = taskItem.uid
      local taskConfig = DT.Task[uid]
      if taskConfig.CompleteAward and BpTaskModel.Instance:GetTaskState(uid) == TaskState.Receive then
        for _tid, _num in table.iteraDouble(taskConfig.CompleteAward) do
          if _tid == energyItemId then
            energyItemNum = energyItemNum + _num
          end
        end
      end
    end
  end
  if energyItemNum > 0 then
    do return GetEnergyCheckUtils.EnergyIsOverMax end
    return GetEnergyCheckUtils.EnergyIsOverMax, energyItemNum, 1, nil, ipairs(BpTaskModel.Instance.curTaskList)
  else
    return false
  end
end

function BpTaskView:_InitCompCountDown()
  self:SetText(self.ui.Text_Time, LT.Textf("BPTimeFormat", BpModel.Instance:GetBpCountDown()))
  self.countDownTimer = self:BindTimer(1, -1, function()
    self:SetText(self.ui.Text_Time, LT.Textf("BPTimeFormat", BpModel.Instance:GetBpCountDown()))
  end)
end

function BpTaskView:_InitTaskTabGroupView()
  local cellRT = self.ui.UI_Passport_Task_Choose:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.taskTabGroupView = self:CreateTableview(self.ui.ScrollView_Task_Tab, function()
    if not BpTaskModel.Instance.taskTabList then
      return 0
    end
    return #BpTaskModel.Instance.taskTabList
  end, function(view, index)
    do return self._TaskTabCellAtIndex, self, view end
    return self._TaskTabCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function BpTaskView:_TaskTabCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Passport_Task_Choose)
  local taskServerIdx = BpTaskModel.Instance.taskTabList[index]
  self:AddViewComponentOnce(cell.gameObject, CompBpTaskTabItem, taskServerIdx)
  return cell
end

function BpTaskView:_InitTaskItemGroupView()
  local cellRT = self.ui.UI_Task_Item_Detail_List_New:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.taskItemGroupView = self:CreateTableview(self.ui.ScrollView_Task_Item, function()
    if not BpTaskModel.Instance.curTaskList then
      return 0
    end
    return #BpTaskModel.Instance.curTaskList
  end, function(view, index)
    do return self._TaskItemCellAtIndex, self, view end
    return self._TaskItemCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function BpTaskView:_TaskItemCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Task_Item_Detail_List_New)
  local taskData = BpTaskModel.Instance.curTaskList[index]
  self:AddViewComponentOnce(cell.gameObject, CompBpTaskItem, taskData.uid)
  return cell
end

function BpTaskView:OpenBpShowPanel()
  BpModel.Instance:SetCurPage(BpPage.Review)
end

function BpTaskView:OnExitView()
  if self.countDownTimer then
    self:StopTimer(self.countDownTimer)
    self.countDownTimer = nil
  end
  Super.OnExitView(self)
end

return BpTaskView
