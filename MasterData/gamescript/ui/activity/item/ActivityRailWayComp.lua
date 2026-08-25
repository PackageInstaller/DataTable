local ActivityRailWayComp, Super = System.NewClass("ActivityRailWayComp", ActivityAwakerTopicComp)

function ActivityRailWayComp:ctor(res, activityTid, model, params)
  Super.ctor(self, res, activityTid, model, params)
end

function ActivityRailWayComp:OnBind(binder)
  Super.OnBind(self, binder)
  self:BindRank()
end

function ActivityRailWayComp:BindShopItem()
end

function ActivityRailWayComp:BindLottery()
end

function ActivityRailWayComp:BindAchievementProgress()
  local parentTaskList = ActivityDataUtils.GetTaskList(self.activityTid)
  self.binder:BindToVisible(self.ui.Btn_Reward, function()
    local taskList = self.activityData.taskList
    return taskList and table.next(taskList)
  end)
  self.binder:BindZ1Button(self.ui.Btn_Reward, function()
    local taskList = self.activityData.taskList
    UIManager.Instance:Reopen(Urls.ActivityAchievementPanel, self.activityData, parentTaskList, taskList, {
      title = LT.Text("RailWayActivityRewardTitle")
    })
  end)
  self.binder:BindToText(self.ui.Text_AchieveProgress, function()
    local taskList = self.activityData.taskList
    local percent = self:GetTaskProgressPercent(taskList, parentTaskList)
    do return string.format, "%s%%" end
    return string.format, "%s%%", percent
  end)
  self.binder:BindComponent(NewRedCom(self.ui.Red_Achieve)):BindActivityTask(self.activityData)
end

function ActivityRailWayComp:BindSubPlotRecord()
  local stageGroupTid = table.unpack(self.activityConfig.ActivityPara3)
  self.binder:BindZ1Button(self.ui.Btn_Record, function()
    CopyDataUtils.OnClickSubPlotEntry(stageGroupTid, self.activityTid, true)
  end)
  self.binder:BindComponent(RedDotComponent(self.ui.NewTag_Record, nil, nil, function()
    local isLocked = CopyDataUtils.IsStageGroupFeatureLocked(stageGroupTid)
    local isNew = SubplotRedUtils.GetAllDiifRedByGroupTid(stageGroupTid)
    local isShowNew = not isLocked and isNew
    if isShowNew then
      return RedPointDataUtils.RedAttrType.IsNew
    end
    return false
  end))
end

function ActivityRailWayComp:BindResonanceProgress()
  if not self.ui.Btn_Resonance then
    return
  end
  self.binder:BindComponent(ResonanceGroupComp(CommonDefine.ResonanceGroupRailway, self.ui.Btn_Resonance, self.ui.Text_ResonanceProgress, self.ui.Text_TotalProgress, self.ui.Red_Resonance, self.activityTid, self, true))
end

function ActivityRailWayComp:BindRank()
  self.binder:BindZ1Button(self.ui.Btn_Rank, System.fn(self, self._OnClickRank))
end

function ActivityRailWayComp:_OnClickRank()
  RailWayController.Instance:OpenRankView()
end

function ActivityRailWayComp:BindBtnChallenge()
  self.binder:SetActive(self.ui.Btn_Challenge, true)
  self.binder:BindZ1Button(self.ui.Btn_Challenge, System.fn(self, self._OnClickChallenge))
  self.binder:BindComponent(RedDotComponent(self.ui.NewTag_Challenge, nil, nil, function()
    do return end
    return RedPointDataUtils.IsRailWayEntryRed, nil
  end))
end

function ActivityRailWayComp:_OnClickChallenge()
  RailWayController.Instance:OpenRailWayMainView()
end

return ActivityRailWayComp
