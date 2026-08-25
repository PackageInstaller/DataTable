local CompActivityKarenTaskItem, Super = NewViewComponent("CompActivityKarenTaskItem")

function CompActivityKarenTaskItem:ctor(uiNode, view, viewData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Event_Task_ItemResource(uiNode)
  self.taskData = viewData.taskData
  self.activityTid = viewData.activityTid
  self._rewardInfoList = {}
end

function CompActivityKarenTaskItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Receive, System.fn(self, self._OnClickReceive))
  self:AddButtonClickListener(self.ui.Image_Location, System.fn(self, self._OnClickLocation))
end

function CompActivityKarenTaskItem:_OnClickLocation()
  FuncJumpManager.Instance:JumpFunc(self:_GetItemGetsTid())
end

function CompActivityKarenTaskItem:_OnClickReceive()
  if self.taskData.state ~= CommonDefine.TaskState.Receive then
    return
  end
  ActivityDataUtils.ReqGainAward(self.activityTid, self.taskData.tid, nil, function()
    self.taskData.state = CommonDefine.TaskState.Done
  end)
end

function CompActivityKarenTaskItem:OnEnterComponent()
  self:_CreateRewardTableView()
  self:_UpdateViewData()
  self:_RefreshView()
end

function CompActivityKarenTaskItem:_UpdateViewData()
  self._rewardInfoList = TaskDataUtils.GetTaskCompleteAward(self.taskData.tid)
end

function CompActivityKarenTaskItem:_RefreshView()
  self:_RefreshTaskBaseInfo()
  self:_RefreshTaskState()
end

function CompActivityKarenTaskItem:_RefreshTaskBaseInfo()
  local taskTid = self.taskData.tid
  local taskCfg = TaskCfgUtils.GetCfg(taskTid)
  self.binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, taskCfg.Name
  end)
  self.binder:BindToText(self.ui.Text_Desc, function()
    local count = self.taskData and self.taskData.count or 0
    local taskProgressLimit = TaskDataUtils.GetTaskProgressLimit(taskTid)
    do return string.format, "%s(%s/%s)", LT.Text(taskCfg.Desc), count end
    return string.format, "%s(%s/%s)", LT.Text(taskCfg.Desc), count, taskProgressLimit
  end)
  self._rewardTableView:ReloadData()
end

function CompActivityKarenTaskItem:_CreateRewardTableView()
  local sizeDelta = self.ui.UI_Common_Item_WuPin_Type2.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._rewardTableView = self:CreateTableview(self.ui.ScrollView_Award, function()
    return #self._rewardInfoList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
    local viewData = {
      itemTid = self._rewardInfoList[index].tid,
      itemCount = self._rewardInfoList[index].num
    }
    self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, viewData)
    return cell
  end, function()
    return w, h
  end)
end

function CompActivityKarenTaskItem:_RefreshTaskState()
  local taskState = self.taskData.state
  self.binder:BindToVisible(self.ui.Btn_Receive, function()
    return taskState == CommonDefine.TaskState.Receive
  end)
  self.binder:BindToVisible(self.ui.Group_Got, function()
    return taskState == CommonDefine.TaskState.Done
  end)
  self.binder:BindToVisible(self.ui.Group_NotReceive, function()
    return taskState == CommonDefine.TaskState.Doing and not self:_GetItemGetsTid()
  end)
  self.binder:BindToVisible(self.ui.Image_Location, function()
    return taskState == CommonDefine.TaskState.Doing and self:_GetItemGetsTid()
  end)
end

function CompActivityKarenTaskItem:_GetItemGetsTid()
  local taskTid = self.taskData.tid
  do return TaskDataUtils.GetTaskJumpTo end
  return TaskDataUtils.GetTaskJumpTo, taskTid
end

return CompActivityKarenTaskItem
