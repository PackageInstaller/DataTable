local ActivityTaskBattleTeachingItem, Super = System.NewComponent("ActivityTaskBattleTeachingItem", ActivityTaskBaseItem)

function ActivityTaskBattleTeachingItem:ctor(res, taskData, activityData)
  Super.ctor(self, taskData, activityData)
  self.ui = UI_Events_Item_BattleTeachingResource(res)
end

function ActivityTaskBattleTeachingItem:OnBind(binder)
  Super.OnBind(self, binder)
  self:_OnBindStartBattleBtn(binder)
end

function ActivityTaskBattleTeachingItem:_OnBindStartBattleBtn(binder)
  binder:BindZ1Button(self.ui.Btn_Start, System.fn(self, self._OnClickBtnStart), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "BattleTeachingEntryBtnTxt"
  end)
  binder:BindToVisible(self.ui.Btn_Start, System.fn(self, self._GetStartBattleBtnVisible))
end

function ActivityTaskBattleTeachingItem:_OnClickBtnStart()
  local targetStageTid = self:_GetStageTid()
  GuideManager.Instance:ClearBattleTriggeredGuideList()
  WorldStageManager.Instance:CheckOpen(targetStageTid, function()
    local targetActivityTid = ActivityCfgUtils.GetActivityTidByType(ActivityDefine.ActivityType.TaskList, ActivityDefine.ActivitySystemType.BattleTeachingActivity)
    StageExitPanelManager.Instance:PushPanel(Urls.ActivityMainPanel, {targetActivityTid = targetActivityTid})
  end)
end

function ActivityTaskBattleTeachingItem:_GetStartBattleBtnVisible()
  return self.taskData.state == CommonDefine.CommonState.Running
end

function ActivityTaskBattleTeachingItem:_GetTaskName()
  do return LT.Text end
  return LT.Text, self.taskConfig.Name
end

function ActivityTaskBattleTeachingItem:_GetTaskDesc()
  do return LT.Text end
  return LT.Text, self.taskConfig.Desc
end

function ActivityTaskBattleTeachingItem:GainPrize()
  self:ToReqGainAward()
end

function ActivityTaskBattleTeachingItem:_GetStageTid()
  local taskTid = self.taskData.tid
  local taskCfg = DT.Task[taskTid]
  return taskCfg and taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[1]
end

return ActivityTaskBattleTeachingItem
