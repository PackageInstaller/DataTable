local ActivityTaskListPanel, Super = System.NewClass("ActivityTaskListPanel", UIBasePanel)
ActivityTaskListPanel.uiResCls = UI_Pvp_Popup_Tips2Resource

function ActivityTaskListPanel:ctor(activityTid, taskList, extraData)
  Super.ctor(self)
  self.activityTid = activityTid
  self.taskList = taskList
  self.extraData = extraData
end

function ActivityTaskListPanel:OnBind(binder)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:UpdateTaskList()
  self:CreataTaskTable()
  self:RefreshTableView()
  binder:SetActive(self.ui.Text_C_Highest, false)
  binder:SetActive(self.ui.Text_Highest, false)
  binder:SetActive(self.ui.Text_Bottom, true)
  binder:BindToText(self.ui.Text_Bottom, function()
    return self.extraData.bottomText
  end)
  if self.extraData.title then
    binder:SetText(self.ui.Text_C_Title, self.extraData.title)
  end
  binder:SetActive(self.ui.Button_OneKeyGet, false)
  binder:BindZ1Button(self.ui.Button_OneKeyGet, function()
    local canReceiveTaskList = self:GetCanReceiveTaskList()
    if #canReceiveTaskList > 0 then
      ActivityDataUtils.ReqGainAwardList(self.activityTid, canReceiveTaskList)
    else
      Alert.ShowStr(LT.Text("ReRoundNoReward"))
    end
  end, function()
    if #self:GetCanReceiveTaskList() > 0 then
      return CommonDefine.Z1ButtonState.High
    else
      return CommonDefine.Z1ButtonState.Unclickable
    end
  end, function()
    do return LT.Text end
    return LT.Text, "DispatchReceiveAll"
  end)
end

function ActivityTaskListPanel:GetCanReceiveTaskList()
  local canReceiveTaskList = {}
  for _, task in pairs(self.taskList) do
    if task.state == CommonDefine.TaskState.Receive then
      local taskCfg = DT.Task[self.taskTid] or {}
      local isStageFirstClear = true
      if taskCfg.UnlockCondType == CommonDefine.TaskUnlockCondType.StageFirstClear then
        local stageId = taskCfg.UnlockCondPara[1]
        if not MainCopyDataUtils.IsStageDataFirstFinish(stageId) then
          isStageFirstClear = false
        end
      end
      if isStageFirstClear then
        table.insert(canReceiveTaskList, task)
      end
    end
  end
  return canReceiveTaskList
end

function ActivityTaskListPanel:UpdateTaskList()
  table.sort(self.taskList, function(a, b)
    local cfgA = DT.Task[a.tid]
    local cfgB = DT.Task[b.tid]
    local taskDataA = TaskDataUtils.GetTaskData(a.tid) or {}
    local taskDataB = TaskDataUtils.GetTaskData(b.tid) or {}
    if taskDataA.state ~= taskDataB.state then
      if taskDataA.state == CommonDefine.TaskState.Done then
        return false
      end
      if taskDataB.state == CommonDefine.TaskState.Done then
        return true
      end
    end
    return cfgA.BaseSortID < cfgB.BaseSortID
  end)
end

function ActivityTaskListPanel:CreataTaskTable()
  local baseGameObj = self.ui.UI_Pvp_Item_Popup_Award3
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.tableView = self:CreateTableview(self.ui.ScrollView_Popup_Award, function()
    return #self.taskList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local taskData = self.taskList[idx]
    itemComps[gameObj] = self.binder:BindComponent(ActivityTaskPopItem(gameObj, self.activityTid, taskData.tid, System.fn(self, self.RefreshTableView)))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function ActivityTaskListPanel:RefreshTableView()
  self:UpdateTaskList()
  self.tableView:ReloadData()
end

return ActivityTaskListPanel
