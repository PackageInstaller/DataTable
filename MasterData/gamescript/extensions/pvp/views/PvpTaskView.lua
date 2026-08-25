local T_ContentSizeFitter = typeof(CS.UnityEngine.UI.ContentSizeFitter)
local PvpTaskView, Super = NewClass("PvpTaskView", BaseView)
PvpTaskView.uiResCls = UI_Pvp_Panel_TaskResource

function PvpTaskView:ctor()
  Super.ctor(self)
  self:_InitViewData()
end

function PvpTaskView:OnBuildView()
  self:_CreateParentTaskListView()
  self:_CreateChildTaskListView()
end

function PvpTaskView:OnEnterView()
  self:_UpdateViewData()
  self:_RefreshView()
  self:_JumpToHeadTask()
  self:_RefreshTitle()
end

function PvpTaskView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_OneKey, System.fn(self, self._OnBtnOneKey))
  self:BindEvent(EventMgr.Instance.TaskInfoUpdated, System.fn(self, self._OnTaskInfoUpdated))
end

function PvpTaskView:_OnTaskInfoUpdated(taskData)
  local targetTaskType = TaskCfgUtils.GetCfgField("TaskType", taskData.tid)
  if targetTaskType ~= self:_GetTargetTaskType() then
    return
  end
  self:_UpdateViewData()
  self:_RefreshView()
end

function PvpTaskView:_OnBtnOneKey()
  if not self:_IsAllTaskHaveReceived() then
    return
  end
  TaskController.Instance:ReqOnTaskGainAllPrize(self:_GetTargetTaskSvrIdx(), function()
    self:_UpdateViewData()
    self:_RefreshView()
  end)
end

function PvpTaskView:_InitViewData()
  self._parentTaskTidList = self:_GetParentTaskTidList()
  self._selectParentTaskTid = self._parentTaskTidList[1]
  self._childTaskTidList = {}
end

local TaskStateSortWeight = {
  [CommonDefine.TaskState.Receive] = 1,
  [CommonDefine.TaskState.Doing] = 2,
  [CommonDefine.TaskState.UnDone] = 2,
  [CommonDefine.TaskState.Done] = 3
}

function PvpTaskView:_UpdateViewData()
  self._childTaskTidList = self:_GetChildTaskTidList(self._selectParentTaskTid)
  table.sort(self._childTaskTidList, function(a, b)
    local aData = TaskDataUtils.GetTaskData(a)
    local bData = TaskDataUtils.GetTaskData(b)
    local aWeight = TaskStateSortWeight[aData.state] or 0
    local bWeight = TaskStateSortWeight[bData.state] or 0
    if aWeight ~= bWeight then
      return aWeight < bWeight
    end
    local aCfg = TaskCfgUtils.GetCfg(a)
    local bCfg = TaskCfgUtils.GetCfg(b)
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
end

function PvpTaskView:_SetSelectParentTaskTid(parentTaskTid)
  self._selectParentTaskTid = parentTaskTid
end

function PvpTaskView:_GetChildTaskTidList(parentTaskTid)
  local rst = {}
  local childTaskTidList = TaskCfgUtils.GetTaskTidListByTaskType(self:_GetTargetTaskType())
  for _, childTaskTid in pairs(childTaskTidList) do
    local belongGroup = TaskCfgUtils.GetCfgField("BelongTaskGroup", childTaskTid)
    if belongGroup == parentTaskTid then
      table.insert(rst, childTaskTid)
    end
  end
  return rst
end

function PvpTaskView:_GetParentTaskProgress(parentTaskTid)
  local targetChildTaskTidList = self:_GetChildTaskTidList(parentTaskTid)
  local completeCount = 0
  local totalCount = #targetChildTaskTidList
  for _, taskTid in pairs(targetChildTaskTidList) do
    local taskData = TaskDataUtils.GetTaskData(taskTid)
    if taskData and taskData.state == CommonDefine.TaskState.Done then
      completeCount = completeCount + 1
    end
  end
  return completeCount, totalCount
end

function PvpTaskView:_IsTaskGroupHaveReceived(parentTaskTid)
  local childTaskTidList = self:_GetChildTaskTidList(parentTaskTid)
  for _, taskTid in pairs(childTaskTidList) do
    local taskData = TaskDataUtils.GetTaskData(taskTid)
    if taskData and taskData.state == CommonDefine.TaskState.Receive then
      return true
    end
  end
  return false
end

function PvpTaskView:_IsAllTaskHaveReceived()
  for _, parentTaskTid in pairs(self._parentTaskTidList) do
    if self:_IsTaskGroupHaveReceived(parentTaskTid) then
      return true
    end
  end
  return false
end

function PvpTaskView:_ReqTaskReward(taskData)
  if not taskData then
    return
  end
  if taskData.state ~= CommonDefine.TaskCommonState.CanFinish then
    return
  end
  TaskDataUtils.TaskComplete(taskData.uid, function()
    self:_UpdateViewData()
    self:_RefreshView()
  end)
end

function PvpTaskView:_GetTargetTaskType()
  return CommonDefine.TaskType.TaskType_PVPRewardTask
end

function PvpTaskView:_GetTargetTaskSvrIdx()
  return CommonDefine.TaskServerIndex.PVPRewardChildTask
end

function PvpTaskView:_GetParentTaskTidList()
  do return DT.GetOriginalConstant end
  return DT.GetOriginalConstant, "PVPRewardTask"
end

function PvpTaskView:_RefreshView()
  self:_RefreshParentTaskListView()
  self:_RefreshChildTaskListView()
  self:_RefreshBtnOneKeyState()
end

function PvpTaskView:_RefreshTitle()
  self:SetText(self.ui.Text_Title, LT.Text("PvpTaskViewTitle"))
end

function PvpTaskView:_RefreshBtnOneKeyState()
  self:SetActive(self.ui.Btn_OneKey, self:_IsAllTaskHaveReceived())
end

function PvpTaskView:_RefreshParentTaskListView()
  self._parentTaskListView:ReloadData()
end

function PvpTaskView:_RefreshChildTaskListView()
  self._childTaskListView:ReloadData()
end

function PvpTaskView:_CreateParentTaskListView()
  local sizeDelta = self.ui.UI_Event_Reward_Tab.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._parentTaskListView = self:CreateTableview(self.ui.ScrollView_TabCon, function()
    return #self._parentTaskTidList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Event_Reward_Tab)
    self:_FillParentTaskCell(cell, index)
    return cell
  end, function()
    return w, h
  end)
end

function PvpTaskView:_FillParentTaskCell(cell, index)
  local ui = UI_Event_Reward_TabResource(cell.gameObject)
  local taskTid = self._parentTaskTidList[index]
  local completeCount, totalCount = self:_GetParentTaskProgress(taskTid)
  local isSelect = self._selectParentTaskTid == taskTid
  self:SetText(ui.Text_Title, self:_GetParentTaskTitle(taskTid))
  self:SetText(ui.Text_Progress, string.format("%s/%s", completeCount, totalCount))
  self:SetTextColorType(ui.Text_Title, isSelect and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
  self:SetTextColorType(ui.Text_Progress, isSelect and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
  self:SetActive(ui.Group_RedDot, self:_IsTaskGroupHaveReceived(taskTid))
  self:SetActive(ui.Group_High, isSelect)
  self:AddButtonClickListener(ui.uiNode, function()
    self:_SetSelectParentTaskTid(taskTid)
    self:_UpdateViewData()
    self:_RefreshView()
    self:_JumpToHeadTask()
  end)
end

function PvpTaskView:_GetParentTaskTitle(taskTid)
  do return LT.Text, TaskCfgUtils.GetCfgField("Desc", taskTid) end
  return LT.Text, TaskCfgUtils.GetCfgField("Desc", taskTid)
end

function PvpTaskView:_JumpToHeadTask()
  if self._childTaskListView.isReady then
    local offset = self._childTaskListView:GetOffsetByIndex(0)
    self._childTaskListView:SetOffset(offset, false)
  else
    function self._childTaskListView.reloadFinishCallback()
      self._childTaskListView.reloadFinishCallback = nil
      
      local offset = self._childTaskListView:GetOffsetByIndex(0)
      self._childTaskListView:SetOffset(offset, false)
    end
  end
end

function PvpTaskView:_CreateChildTaskListView()
  local sizeDelta = self.ui.UI_Event_Reward_Item.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._childTaskListView = self:CreateTableview(self.ui.ScrollView_TaskCon, function()
    return #self._childTaskTidList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Event_Reward_Item)
    self:_FillChildTaskCell(cell, index)
    return cell
  end, function()
    return w, h
  end)
end

function PvpTaskView:_FillChildTaskCell(cell, index)
  local ui = UI_Event_Reward_ItemResource(cell.gameObject)
  local taskTid = self._childTaskTidList[index]
  local taskData = TaskDataUtils.GetTaskData(taskTid)
  self:SetActive(ui.Btn_Receive, taskData.state == CommonDefine.TaskState.Receive)
  self:SetActive(ui.Group_Got, taskData.state == CommonDefine.TaskState.Done)
  self:SetActive(ui.Group_NotReceive, taskData.state < CommonDefine.TaskState.Receive)
  self:SetText(ui.Text_Desc, TaskDataUtils.GetTaskProgressDesc(taskTid, "%s<color=#A3A6AB>(%s/%s)</color>"))
  self:AddButtonClickListener(ui.Btn_Receive, function()
    self:_ReqTaskReward(taskData)
  end)
  local layoutGroup = ui.Content:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
  layoutGroup.spacing = -31
  local contentSizer = ui.Content:GetComponent(T_ContentSizeFitter)
  contentSizer.enabled = true
  local containerTs = ui.Content.transform
  local rewardList = TaskCfgUtils.GetTaskCompleteAward(taskTid)
  self:ReserveChildren(containerTs, #rewardList, ui.UI_Common_Item_WuPin_Type2)
  for i = 1, #rewardList do
    local child = containerTs:GetChild(i - 1)
    local go = child and child.gameObject
    if not go then
    else
      go:SetActive(true)
      local viewData = {
        itemTid = rewardList[i].tid,
        itemCount = rewardList[i].num
      }
      self:AddViewComponentOnce(go, CompPublicIconItemType2, viewData)
    end
  end
  for i = #rewardList + 1, containerTs.childCount do
    local child = containerTs:GetChild(i - 1)
    local go = child and child.gameObject
    if go then
      go:SetActive(false)
    end
  end
end

return PvpTaskView
