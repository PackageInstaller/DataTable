local TargetCompleteCond = TaskDefine.CompleteCond.TaskLoginDays
local ActivitySummerChapter1Comp, Super = System.NewClass("ActivitySummerChapter1Comp", ActivityAwakerTopicComp)

function ActivitySummerChapter1Comp:OnBind(binder)
  Super.OnBind(self, binder)
  self:_BindSignEntry()
end

function ActivitySummerChapter1Comp:_BindSignEntry()
  self.binder:BindToText(self.ui.Text_SignProgress, function()
    local taskDataList = ActivityDataUtils.GetActivityTaskDataListByCompleteCond(self.activityData, TargetCompleteCond)
    local receivedNum = 0
    for _, taskData in ipairs(taskDataList) do
      if taskData.state == CommonDefine.TaskState.Done then
        receivedNum = receivedNum + 1
      end
    end
    return receivedNum
  end)
  self.binder:BindToText(self.ui.Text_TotalProgress, function()
    local taskDataList = ActivityDataUtils.GetActivityTaskDataListByCompleteCond(self.activityData, TargetCompleteCond)
    return #taskDataList
  end)
  self.binder:BindButtonClick(self.ui.Btn_Sign, System.fn(self, self._OnClickBtnSign))
  self.binder:BindToVisible(self.ui.Red_Sign, function()
    do return end
    return RedPointDataUtils.GetSummerChapter1SignEntryRed, nil
  end)
end

function ActivitySummerChapter1Comp:_OnClickBtnSign()
  UIManager.Instance:Reopen(Urls.ActivitySummerSevenDaySignPanel, self.activityData)
end

function ActivitySummerChapter1Comp:BindAchievementProgress()
  self.binder:SetActive(self.ui.Btn_Reward, false)
end

return ActivitySummerChapter1Comp
