local PVPFightRecordPanel, Super = System.NewClass("PVPFightRecordPanel", BaseView)
PVPFightRecordPanel.uiResCls = UI_Pvp_Popup_Tips2Resource

function PVPFightRecordPanel:ctor()
  Super.ctor(self)
end

function PVPFightRecordPanel:OnBuildView()
  Super.OnBuildView(self)
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self.ui.Button_OneKeyGet:SetActive(true)
  self:AddButtonClickListener(self.ui.Button_OneKeyGet, System.fn(self, self.OnClickOneKey))
  self:UpdateTaskList()
  self:CreataTaskTable()
  self:RefreshTableView()
  self:_RefreshHighestText()
  self:_RefreshOneKeyButtonState()
end

function PVPFightRecordPanel:_RefreshHighestText()
  local preBuiltMaxScore = SeasonRotationModel.Instance:GetPvpPrebuildSeasonData() and SeasonRotationModel.Instance:GetPvpPrebuildSeasonData().maxScore or 0
  local draftMaxScore = SeasonRotationModel.Instance:GetPvpDraftSeasonData() and SeasonRotationModel.Instance:GetPvpDraftSeasonData().maxScore or 0
  self:SetText(self.ui.Text_Highest, math.max(preBuiltMaxScore, draftMaxScore))
end

function PVPFightRecordPanel:_RefreshOneKeyButtonState()
  self:SetButtonState(self.ui.Button_OneKeyGet, self:HasReward() and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
end

function PVPFightRecordPanel:UpdateTaskList()
  local taskList = TaskDataUtils.GetTaskListByType(CommonDefine.TaskType.TaskType_PVPHistory)
  table.sort(taskList, function(a, b)
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
  self.taskList = taskList
end

function PVPFightRecordPanel:HasReward()
  local taskList = TaskDataUtils.GetTaskListByType(CommonDefine.TaskType.TaskType_PVPHistory)
  for _, taskData in ipairs(taskList) do
    if taskData.state == CommonDefine.TaskState.Receive then
      return true
    end
  end
end

function PVPFightRecordPanel:OnClickOneKey()
  TaskController.Instance:ReqOnTaskGainAllPrize(CommonDefine.TaskServerIndex.PVPHistory, function()
    self:RefreshTableView()
  end)
end

function PVPFightRecordPanel:CreataTaskTable()
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
    itemComps[gameObj] = self.binder:BindComponent(PVPFightRecordItem(gameObj, taskData.tid, System.fn(self, self.RefreshTableView)))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function PVPFightRecordPanel:RefreshTableView()
  self:UpdateTaskList()
  self.tableView:ReloadData()
  self:_RefreshOneKeyButtonState()
end

return PVPFightRecordPanel
