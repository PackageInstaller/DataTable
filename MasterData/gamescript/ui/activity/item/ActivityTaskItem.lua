local CommonState = CommonDefine.CommonState
local ActivityTaskItem, Super = System.NewComponent("ActivityTaskItem")

function ActivityTaskItem:ctor(res, taskData, activityData)
  Super.ctor(self)
  self.ui = UI_Events_Item_SurveyDiaryResource(res)
  self.taskData = taskData
  self.taskConfig = DT.Task[taskData.tid]
  self.activityData = activityData
  self.activityTid = activityData.activityTid
  self.taskAwardList = {}
end

function ActivityTaskItem:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Title, System.fn(self, self._GetTaskDesc))
  binder:BindToVisible(self.ui.Btn_Receive, System.fn(self, self._IsBtnVisible))
  binder:BindToVisible(self.ui.Image_Location, System.fn(self, self._IsTipsVisible))
  binder:BindToVisible(self.ui.Image_Finish, System.fn(self, self._IsFinish))
  binder:BindButtonClick(self.ui.Image_Location, System.fn(self, self._OnJumpBtnClick))
  binder:BindZ1Button(self.ui.Btn_Receive, System.fn(self, self._OnBtnClick), function()
    return CommonDefine.BtnType.High
  end, nil, function()
    return RedPointDataUtils.RedAttrType.Red
  end)
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GetAwardList), System.fn(self, self._UpdateAwardItem))
  local contentNodeLayout = self.ui.Content:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
  contentNodeLayout.enabled = true
end

function ActivityTaskItem:_GetTaskDesc()
  local desc = LT.Text(self.taskConfig.Desc)
  local countText = ""
  local condValue = TaskDataUtils.GetTaskProgressLimit(self.taskData.tid)
  if condValue and "" ~= condValue then
    countText = string.format("<color=#6E6C6C>(%s/%s)</color>", self.taskData.count, condValue)
  end
  local result = desc .. countText
  return result
end

function ActivityTaskItem:_IsBtnVisible()
  return self.taskData.state == CommonState.GainPrize
end

function ActivityTaskItem:_IsTipsVisible()
  local isStateVisible = self.taskData.state == CommonState.Running
  local isCfgVisible = self.taskConfig.JumpTo ~= nil
  local inVisibleTaskList = ApplicationUtils.IsWindowsOrEditor() and DT.GetOriginalConstant("PcDeviceLocationInVisibleTaskList") or DT.GetOriginalConstant("MobileDeviceLocationInVisibleTaskList")
  local isDeviceVisible = not table.contains(inVisibleTaskList, self.taskData.tid)
  return isStateVisible and isCfgVisible and isDeviceVisible
end

function ActivityTaskItem:_IsFinish()
  return self.taskData.state == CommonState.Finish
end

function ActivityTaskItem:_OnBtnClick()
  self:_OnGainPrize(self.taskData)
end

function ActivityTaskItem:_OnJumpBtnClick()
  FuncJumpManager.Instance:JumpFunc(self.taskConfig.JumpTo[1])
end

function ActivityTaskItem:_GetAwardList()
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

function ActivityTaskItem:_UpdateAwardItem(awardBinder, awardGo, awardIndex)
  if not self.taskAwardList then
    return
  end
  local award = self.taskAwardList[awardIndex]
  local itemData = {
    itemTid = award.tid,
    itemCount = award.num,
    darkShowFunc = System.fn(self, self._IsFinish)
  }
  awardBinder:BindComponent(CommonIconItemType2(awardGo, itemData))
end

function ActivityTaskItem:_OnGainPrize(taskData)
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

function ActivityTaskItem:ToReqGainAward(extraParams, onRequestCallback)
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

function ActivityTaskItem:GainPrize()
  if self.taskConfig and self.taskConfig.CompleteAward then
    self:ToReqGainAward()
  end
end

return ActivityTaskItem
