local CommonState = CommonDefine.CommonState
local ActivityTaskBaseItem, Super = System.NewComponent("ActivityTaskBaseItem")

function ActivityTaskBaseItem:ctor(taskData, activityData)
  Super.ctor(self)
  self.taskData = taskData
  self.taskConfig = DT.Task[taskData.tid]
  self.activityData = activityData
  self.activityTid = activityData.activityTid
  self.taskAwardList = {}
end

function ActivityTaskBaseItem:_GetTaskDesc()
  Logger.Error("Please override _GetTaskDesc")
end

function ActivityTaskBaseItem:_GetTaskName()
  Logger.Error("Please override _GetTaskName")
end

function ActivityTaskBaseItem:_OnClickJumpBtn()
  FuncJumpManager.Instance:JumpFunc(self.taskConfig.JumpTo[1])
end

function ActivityTaskBaseItem:_OnClickReceiveBtn()
  local taskData = self.taskData
  if not taskData then
    return
  end
  local taskListActivityData = self.activityData
  local taskListActivityBaseData = taskListActivityData and taskListActivityData.base or {}
  if taskListActivityBaseData.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  if taskData.state ~= CommonState.GainPrize then
    return
  end
  if GetEnergyCheckUtils.TaskConfigCheckEnergyOver(self.taskConfig) then
    GetEnergyCheckUtils.TipsShow(System.fn(self, self.GainPrize))
  else
    self:GainPrize()
  end
end

function ActivityTaskBaseItem:GainPrize()
  if self.taskConfig and self.taskConfig.CompleteAward then
    self:ToReqGainAward()
  end
end

function ActivityTaskBaseItem:ToReqGainAward(extraParams, onRequestCallback)
  local taskListActivityData = self.activityData
  extraParams = extraParams or {}
  ActivityDataUtils.ReqGainAward(self.activityTid, self.taskData.tid, extraParams, function(result)
    if result then
      taskListActivityData.taskList[self.taskData.tid].state = CommonDefine.CommonState.Finish
      ActivityManager.Instance.model:UpdateFinishState(self.activityData.activityTid)
      if onRequestCallback then
        onRequestCallback()
      end
    end
  end, true)
end

function ActivityTaskBaseItem:OnBind(binder)
  self.binder = binder
  self:_OnBindTaskBaseInfo(binder)
  self:_OnBindTaskStateInfo(binder)
  self:_OnBindTaskRewardList(binder)
end

function ActivityTaskBaseItem:_OnBindTaskBaseInfo(binder)
  if self:GetTaskNameNode() then
    binder:BindToText(self:GetTaskNameNode(), System.fn(self, self._GetTaskName))
  end
  if self:GetTaskDescNode() then
    binder:BindToText(self:GetTaskDescNode(), System.fn(self, self._GetTaskDesc))
  end
end

function ActivityTaskBaseItem:_OnBindTaskStateInfo(binder)
  if self:GetReceiveBtnNode() then
    binder:BindToVisible(self:GetReceiveBtnNode(), System.fn(self, self._GetReceiveBtnVisible))
    binder:BindZ1Button(self:GetReceiveBtnNode(), System.fn(self, self._OnClickReceiveBtn), function()
      return CommonDefine.BtnType.High
    end, nil, System.fn(self, self._GetRedFunc))
  end
  if self:GetTransitionBtnNode() then
    binder:BindToVisible(self:GetTransitionBtnNode(), System.fn(self, self._GetTransitionBtnVisible))
    binder:BindButtonClick(self:GetTransitionBtnNode(), System.fn(self, self._OnClickJumpBtn))
  end
  if self:GetReceivedNode() then
    binder:BindToVisible(self:GetReceivedNode(), System.fn(self, self._GetReceivedNodeVisible))
  end
end

function ActivityTaskBaseItem:_OnBindTaskRewardList(binder)
  if self:GetTaskRewardScrollViewNode() then
    binder:BindToCircularListView(self:GetTaskRewardScrollViewNode(), System.fn(self, self._GetAwardList), System.fn(self, self._FillAwardCell))
  end
  if self:GetTaskRewardContentNode() then
    local contentNodeLayout = self:GetTaskRewardContentNode():GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
    contentNodeLayout.enabled = true
  end
end

function ActivityTaskBaseItem:_GetReceiveBtnVisible()
  return self.taskData.state == CommonState.GainPrize
end

function ActivityTaskBaseItem:_GetTransitionBtnVisible()
  return self.taskData.state == CommonState.Running and self.taskConfig.JumpTo ~= nil
end

function ActivityTaskBaseItem:_GetReceivedNodeVisible()
  return self.taskData.state == CommonState.Finish
end

function ActivityTaskBaseItem:_GetRedFunc()
  if self.taskData.state == CommonState.GainPrize then
    return RedPointDataUtils.RedAttrType.Red
  end
  return false
end

function ActivityTaskBaseItem:_GetAwardList()
  self.taskAwardList = {}
  if self.taskConfig and self.taskConfig.CompleteAward then
    for _tid, _num in table.iteraDouble(self.taskConfig.CompleteAward) do
      if _tid and _num then
        table.insert(self.taskAwardList, {tid = _tid, num = _num})
      end
    end
  end
  return self.taskAwardList
end

function ActivityTaskBaseItem:GetTaskRewardScrollViewNode()
  return self.ui.ScrollView
end

function ActivityTaskBaseItem:GetTaskRewardContentNode()
  return self.ui.Content
end

function ActivityTaskBaseItem:GetTransitionBtnNode()
  return self.ui.Image_Location
end

function ActivityTaskBaseItem:GetReceivedNode()
  return self.ui.Image_Finish
end

function ActivityTaskBaseItem:GetTaskNameNode()
  return self.ui.Text_Title
end

function ActivityTaskBaseItem:GetTaskDescNode()
  return self.ui.Text_Desc
end

function ActivityTaskBaseItem:GetReceiveBtnNode()
  return self.ui.Btn_Recieve
end

function ActivityTaskBaseItem:_FillAwardCell(awardBinder, awardGo, awardIndex)
  if not self.taskAwardList then
    return
  end
  local award = self.taskAwardList[awardIndex]
  local itemData = {
    itemTid = award.tid,
    itemCount = award.num,
    darkShowFunc = System.fn(self, self._GetReceivedNodeVisible)
  }
  awardBinder:BindComponent(CommonIconItemType2(awardGo, itemData))
end

return ActivityTaskBaseItem
