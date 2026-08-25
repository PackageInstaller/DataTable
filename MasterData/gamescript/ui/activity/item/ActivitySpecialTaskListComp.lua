local ActivitySpecialTaskListComp, Super = System.NewClass("ActivitySpecialTaskListComp", ActivityTaskListComp)

function ActivitySpecialTaskListComp:ctor(res, activityTid, model)
  Super.ctor(self, res, activityTid, model)
  self.returnAwardTaskTid = ActivityDataUtils.GetSpecialTaskListActivityAwardTaskTid(self.activityTid)
end

function ActivitySpecialTaskListComp:OnBind(binder)
  Super.OnBind(self, binder)
  self:_OnBindReturnAwardBtnShow(binder)
  self:_OnBindReturnAwardBtn(binder)
end

function ActivitySpecialTaskListComp:_OnBindReturnAwardBtnShow(binder)
  local isReturnActivity = ActivityDataUtils.IsReturnActivity(self.activityTid)
  local hasReturnAward = self:_HasReturnAward()
  binder:SetActive(self.ui.Image_Return, isReturnActivity and hasReturnAward)
  binder:BindToVisible(self.ui.Image_Finish, System.fn(self, self._HasGotReturnPrize))
end

function ActivitySpecialTaskListComp:_HasReturnAward()
  if not self.returnAwardTaskTid then
    return false
  end
  local taskCfg = TaskDataUtils.GetConfig(self.returnAwardTaskTid)
  if not taskCfg or not taskCfg.CompleteAward then
    return false
  end
  local hasReturnAward = false
  for i = 1, #taskCfg.CompleteAward, 2 do
    local tid = taskCfg.CompleteAward[i]
    local num = taskCfg.CompleteAward[i + 1]
    if tid and num and num > 0 then
      hasReturnAward = true
      break
    end
  end
  return hasReturnAward
end

function ActivitySpecialTaskListComp:_HasGotReturnPrize()
  local specialTaskListData = self.activityData
  if not specialTaskListData then
    return false
  end
  if not self.returnAwardTaskTid then
    return false
  end
  local taskData = specialTaskListData.taskList and specialTaskListData.taskList[self.returnAwardTaskTid]
  if not taskData then
    return false
  end
  return taskData.state == CommonDefine.CommonState.Finish
end

function ActivitySpecialTaskListComp:_OnBindReturnAwardBtn(binder)
  binder:BindZ1Button(self.ui.Btn_Return_1, System.fn(self, self._OnClickReturnAwardBtn), System.fn(self, self._GetReturnAwardBtnState))
end

function ActivitySpecialTaskListComp:_OnClickReturnAwardBtn()
  UIManager.Instance:Reopen(Urls.ActivityReturnAwardPanel, self.activityTid)
end

function ActivitySpecialTaskListComp:_GetReturnAwardBtnState()
  if not self.activityData then
    return CommonDefine.BtnType.Unclickable
  end
  return CommonDefine.BtnType.High
end

function ActivitySpecialTaskListComp:_GetTaskList()
  local taskListActivityData = self.activityData
  local taskList = {}
  if taskListActivityData and taskListActivityData.taskList then
    for taskTid, taskData in pairs(taskListActivityData.taskList) do
      if taskData and taskTid ~= self.returnAwardTaskTid then
        table.insert(taskList, taskData)
      end
    end
  end
  table.sort(taskList, System.fn(self, self._GetSortValue))
  self.taskList = taskList
  return self.taskList
end

return ActivitySpecialTaskListComp
