local ActivitySignReceiveMouchetteComp, Super = System.NewClass("ActivitySignReceiveMouchetteComp", ActivitySignReceiveAwakeComp)

function ActivitySignReceiveMouchetteComp:_CreateAwakerListView()
end

function ActivitySignReceiveMouchetteComp:_RefreshAwakerListView()
end

function ActivitySignReceiveMouchetteComp:_RefreshPortaitComp()
end

function ActivitySignReceiveMouchetteComp:OnUnbind()
end

function ActivitySignReceiveMouchetteComp:_GetReceiveBtnObj()
  return self.ui.Btn_Summon
end

function ActivitySignReceiveMouchetteComp:_ReqReceiveAwaker()
  local selectAwakerTid = self.selectItemTid
  ActivityDataUtils.ReqGainAward(self.activityTid, selectAwakerTid, {}, function(result)
    if result then
      table.insert(self.activityData.selectedReward, selectAwakerTid)
      if 0 == self:_GetCanReceiveAwakeNum() then
        ActivityManager.Instance.model:UpdateFinishState(self.activityData.activityTid)
      end
      self:_RefreshReceivedAwakerText()
    end
  end)
end

function ActivitySignReceiveMouchetteComp:_OnBindReceiveCount()
  self.binder:BindToRaw(function(_, num)
    if num > 0 then
      self.ui.Text_Task:SetActive(true)
      local targetTaskData = self:_GetTargetTaskData()
      local desc = TaskCfgUtils.GetCfgField("Desc", targetTaskData and targetTaskData.tid)
      local taskProgress = LT.Textf("DailyChallengeStarAward", targetTaskData and targetTaskData.count, TaskDataUtils.GetTaskProgressLimit(targetTaskData.tid))
      self.binder:SetText(self.ui.Text_Task, LT.Textf("ActivitySignReceiveTaskTextAndCount", LT.Text(desc), taskProgress))
      return
    end
    self.ui.Text_Task:SetActive(false)
  end, function()
    do return self._GetCanReceiveAwakeNum end
    return self._GetCanReceiveAwakeNum, self
  end)
end

return ActivitySignReceiveMouchetteComp
