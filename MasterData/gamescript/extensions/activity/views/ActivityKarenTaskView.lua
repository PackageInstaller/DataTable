local ActivityKarenTaskView, Super = NewClass("ActivityKarenTaskView", BaseView)
ActivityKarenTaskView.uiResCls = UI_Events_Panel_TaskResource

function ActivityKarenTaskView:ctor(activityData)
  Super.ctor(self)
  self.activityData = activityData
  self._taskDataList = {}
end

function ActivityKarenTaskView:RegisterNotifications()
end

function ActivityKarenTaskView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.OnActivityTaskComplete, System.fn(self, self._OnActivityTaskComplete))
  self:BindEvent(EventMgr.Instance.TaskInfoUpdated, System.fn(self, self._OnTaskInfoUpdated))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Button_OneKeyGet, System.fn(self, self._OnClickBtnOneKeyGet))
  self:_CreateTaskDataTableView()
end

function ActivityKarenTaskView:_OnClickBtnOneKeyGet()
  if not self:_CheckHaveReceiveTask() then
    return
  end
  local taskDataList = self:_GetReceiveTaskDataList()
  local tidList = {}
  for _, taskData in pairs(taskDataList) do
    table.insert(tidList, taskData.tid)
  end
  ActivityDataUtils.ReqGainAwardList(self.activityData.activityTid, tidList, function()
    for _, taskData in pairs(taskDataList) do
      taskData.state = CommonDefine.TaskState.Done
    end
  end)
end

function ActivityKarenTaskView:_OnTaskInfoUpdated(taskData)
  if not table.contains(self:_GetReceiveTaskTidList(), taskData.tid) then
    return
  end
  self:_UpdateViewData()
  self:_RefreshView()
end

function ActivityKarenTaskView:_OnActivityTaskComplete(activityTid)
  if self.activityData.activityTid ~= activityTid then
    return
  end
  self:_UpdateViewData()
  self:_RefreshView()
end

function ActivityKarenTaskView:OnEnterView()
  self:_UpdateViewData()
  self:_RefreshView()
end

function ActivityKarenTaskView:_RefreshView()
  self._taskListView:ReloadData()
  self:_RefreshOneClickReceiveBtn()
  self:_RefreshCountDown()
  self:BindTimer(1, -1, System.fn(self, self._RefreshCountDown))
end

function ActivityKarenTaskView:_RefreshCountDown()
  local endTs = TimeCfgUtils.Get_Future_DailyRefresh_TimeStamp()
  local curTs = TimeUtils.GetServerTime()
  local countDown = endTs - curTs
  self:SetText(self.ui.Text_Time, self:_GetCountDown(countDown))
end

function ActivityKarenTaskView:_GetCountDown(countDown)
  local _, h, m, _ = TimeUtils.ConvertTime(countDown)
  do return LT.Textf, "ResetTaskTimeCountdown", h end
  return LT.Textf, "ResetTaskTimeCountdown", h, m
end

function ActivityKarenTaskView:_RefreshOneClickReceiveBtn()
  self:SetActive(self.ui.Button_OneKeyGet, self:_CheckHaveReceiveTask())
end

function ActivityKarenTaskView:_CreateTaskDataTableView()
  local cellRT = self.ui.UI_Event_Task_Item.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self._taskListView = self:CreateTableview(self.ui.ScrollView_TaskCon, function()
    if not self._taskDataList then
      return 0
    end
    return #self._taskDataList
  end, function(view, index)
    do return self._TaskCellAtIndex, self, view end
    return self._TaskCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function ActivityKarenTaskView:_TaskCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Event_Task_Item)
  local viewData = {
    taskData = self._taskDataList[index],
    activityTid = self.activityData.activityTid
  }
  self:AddViewComponentOnce(cell.gameObject, CompActivityKarenTaskItem, viewData)
  return cell
end

function ActivityKarenTaskView:_UpdateViewData()
  self._taskDataList = self:_GetTaskDataList()
end

function ActivityKarenTaskView:_GetTaskDataList()
  local rst = ActivityKarenUtils.GetDailyTaskDataList(self.activityData)
  rst = TaskDataUtils.SortTasksData(rst)
  return rst
end

function ActivityKarenTaskView:_CheckHaveReceiveTask()
  return #self:_GetReceiveTaskDataList() > 0
end

function ActivityKarenTaskView:_GetReceiveTaskDataList()
  local rst = {}
  for _, taskData in pairs(self._taskDataList) do
    if taskData.state == CommonDefine.TaskState.Receive then
      table.insert(rst, taskData)
    end
  end
  return rst
end

function ActivityKarenTaskView:_GetReceiveTaskTidList()
  local rst = {}
  for _, taskData in pairs(self:_GetTaskDataList() or {}) do
    table.insert(rst, taskData.tid)
  end
  return rst
end

return ActivityKarenTaskView
