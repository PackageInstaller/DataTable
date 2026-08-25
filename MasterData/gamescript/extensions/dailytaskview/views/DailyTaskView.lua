local DailyChallengeSkipConsume = DT.GetConstant("DailyChallengeSkipConsume")
local TitleCell = 1
local ContentCell = 2
local DailyTaskView, Super = NewClass("DailyTaskView", BaseView)
DailyTaskView.uiResCls = UI_Main_Popup_ActiveTasksResource

function DailyTaskView:ctor()
  Super.ctor(self)
  self:_InitViewData()
end

function DailyTaskView:OnBuildView()
  Super.OnBuildView(self)
  self:_CreateTaskTableView()
end

function DailyTaskView:OnEnterView()
  self:_RefreshView()
end

function DailyTaskView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
end

function DailyTaskView:_OnBagItemDataChanged(_, tid)
  if DailyChallengeSkipConsume == tid then
    self:_RefreshView()
  end
end

function DailyTaskView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Rule, System.fn(self, self._OnClickRule))
end

function DailyTaskView:_OnClickRule()
  PlayerDataUtils.OpenIllustrate(nil, LT.Text("ActiveTaskRuleDesc"))
end

function DailyTaskView:_OnBtnOneKeyReward()
  if not DailyChallengeModel.Instance:IsHaveWeekReward() then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnDailyChallengeGainAllPrize", function()
    DailyChallengeController.Instance:ReqOnOpenDailyChallenge(function()
    end)
  end)
end

function DailyTaskView:_InitViewData()
  self._taskShowList = {}
  self._countDownViewInfoDict = {}
  self:_UpdateViewData()
end

function DailyTaskView:_UpdateViewData()
  self._taskShowList = {}
  table.insert(self._taskShowList, {
    label = TitleCell,
    text = LT.Text("ActivityTaskDailyTitle")
  })
  table.insert(self._taskShowList, {
    label = ContentCell,
    taskTid = DataCenter.taskData.dailyTaskTid
  })
  table.insert(self._taskShowList, {
    label = TitleCell,
    text = LT.Text("ActivityTaskWeeklyTitle")
  })
  local weekRewardInfos = DailyChallengeController.Instance:GetWeekRewardInfos()
  for _, weekRewardInfo in ipairs(weekRewardInfos or {}) do
    table.insert(self._taskShowList, {label = ContentCell, rewardInfo = weekRewardInfo})
  end
end

function DailyTaskView:GetDailyTaskRedPoint()
  do return end
  return RedPointDataUtils.GetDailyTaskRedPoint
end

function DailyTaskView:GetWeekTaskRedPoint()
  do return end
  return RedPointDataUtils.GetWeekTaskRedPoint
end

function DailyTaskView:GetButtonRedObj(owner)
  local buttonComp = self:GetButton(owner)
  return buttonComp.RedDotObj
end

function DailyTaskView:_RefreshView()
  self:_RefreshTaskTableView()
  self:_RefreshCoinGroup()
  if self._taskTableView.isReady then
    self:_InitCountDownTimer()
  else
    function self._taskTableView.reloadFinishCallback()
      self._taskTableView.reloadFinishCallback = nil
      
      self:_InitCountDownTimer()
    end
  end
end

function DailyTaskView:_InitCountDownTimer()
  self:_RefreshCountDown()
  self:BindTimer(1, -1, System.fn(self, self._RefreshCountDown))
end

function DailyTaskView:_RefreshCountDown()
  for _, countDownViewInfo in pairs(self._countDownViewInfoDict) do
    local textUiNode = countDownViewInfo.textUiNode
    local countDown = countDownViewInfo.countDown
    self:SetActive(textUiNode, true)
    local d, h, m = TimeUtils.ConvertTime(countDown)
    local showStr = LT.Textf("BattlePassLeftTimeLess", h, m)
    if countDown >= 86400 then
      showStr = LT.Textf("BattlePassLeftTimeMore", d, h)
    end
    self:SetText(textUiNode, showStr)
  end
end

function DailyTaskView:_RefreshCoinGroup()
  local currencyList = {DailyChallengeSkipConsume}
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Coin_Group, UICompCommonCurrencyGroupItem, currencyList)
end

function DailyTaskView:_RefreshTaskTableView()
  self._taskTableView:ReloadData()
end

function DailyTaskView:_RefreshTabBtnState()
  for page, subView in pairs(self._subViews) do
    if subView.btnGameObj then
      local isSelected = page == self._curPage
      self:SetButtonChosen(subView.btnGameObj, isSelected)
    end
  end
end

function DailyTaskView:_CreateTaskTableView()
  local contentCellObj = self.ui.UI_Main_Item_ActiveTasks
  local titleCellObj = self.ui.UI_Main_Item_ActiveTasksTitle
  self._taskTableView = self:CreateTableview(self.ui.ScrollView_TaskCon, function()
    return #self._taskShowList
  end, function(view, index)
    local showInfo = self._taskShowList[index]
    local cell
    if showInfo.label == TitleCell then
      cell = self:DequeueCell(view, titleCellObj)
      self:_FillTitleCell(cell, showInfo)
    else
      cell = self:DequeueCell(view, contentCellObj)
      self:_FillContentCell(cell, showInfo)
    end
    return cell
  end, function(_, index)
    local showInfo = self._taskShowList[index]
    if showInfo.label == TitleCell then
      return titleCellObj.transform.sizeDelta.x, titleCellObj.transform.sizeDelta.y
    else
      return contentCellObj.transform.sizeDelta.x, contentCellObj.transform.sizeDelta.y
    end
  end)
end

function DailyTaskView:_FillTitleCell(cell, showInfo)
  local ui = UI_Main_Item_ActiveTasksTitleResource(cell.gameObject)
  self:SetText(ui.Text_Title, showInfo.text)
  local nextDailyRefreshTs = TimeCfgUtils.Get_Future_DailyRefresh_TimeStamp()
  local countDown = showInfo.text == LT.Text("ActivityTaskDailyTitle") and nextDailyRefreshTs - TimeUtils.GetServerTime() or TimeCfgUtils.GetNextMonday()
  self:SetActive(ui.Text_Task_Time, false)
  self._countDownViewInfoDict[showInfo.text] = {
    textUiNode = ui.Text_Task_Time,
    countDown = countDown
  }
end

function DailyTaskView:_FillContentCell(cell, showInfo)
  if showInfo.taskTid then
    self:AddViewComponentOnce(cell.gameObject, DailyTaskItem, showInfo.taskTid)
  else
    self:AddViewComponentOnce(cell.gameObject, WeeklyTaskItem, showInfo.rewardInfo)
  end
end

return DailyTaskView
