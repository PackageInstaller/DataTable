local TaskAppointRstTipsView, Super = NewClass("TaskAppointRstTipsView", BaseView)
TaskAppointRstTipsView.uiResCls = UI_Research_Popup_ReportResource

function TaskAppointRstTipsView:ctor(data)
  Super.ctor(self)
  self.data = data
  self:InitViewData()
end

function TaskAppointRstTipsView:InitViewData()
  self.showDataList = {}
  for taskTid, taskAppointRstData in pairs(self.data) do
    table.insert(self.showDataList, taskAppointRstData)
  end
  table.sort(self.showDataList, function(a, b)
    local aSortVal = DT.Task[a.taskTid].BaseSortID
    local bSortVal = DT.Task[b.taskTid].BaseSortID
    return aSortVal < bSortVal
  end)
end

function TaskAppointRstTipsView:RegisterEvents()
  self:_InitRstCompListView()
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self.OnConfirm))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
end

function TaskAppointRstTipsView:OnEnterView()
  Super.OnEnterView(self)
  self:SetButtonText(self.ui.Btn_Confirm, LT.Text("DispatchAgain"))
  self:SetButtonText(self.ui.Btn_Cancel, LT.Text("DispatchClose"))
  local taskTid = self.showDataList[1] and self.showDataList[1].taskTid or 0
  if 0 ~= taskTid then
    self.ui.Btn_Confirm:SetActive(table.contains(DT.GetOriginalConstant("Task_Appoint_Common_Tasks"), taskTid))
  end
  self:PlayTableViewFadeInAnim(self.ui.ScrollView)
end

function TaskAppointRstTipsView:_InitRstCompListView()
  local cellRT = self.ui.UI_Research_Item_Task.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.rstCompListView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.showDataList then
      return 0
    end
    return #self.showDataList
  end, function(view, index)
    do return self._RstCompCellAtIndex, self, view end
    return self._RstCompCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
  
  function self.rstCompListView.reloadFinishCallback()
    EventMgr.Instance.TaskDispatchCompleted:Dispatch()
  end
  
  self.rstCompListView:ReloadData()
end

function TaskAppointRstTipsView:_RstCompCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Research_Item_Task)
  local rstData = self.showDataList[index]
  self:AddViewComponentOnce(cell.gameObject, CompTaskDispatchRstItem, rstData)
  return cell
end

function TaskAppointRstTipsView:OnEnterViewFinished()
end

function TaskAppointRstTipsView:OnConfirm()
  local sendTbl = {}
  for _, appointRstData in pairs(self.showDataList) do
    local awakerList = appointRstData.awakerList
    local taskTid = appointRstData.taskData.tid
    sendTbl[taskTid] = awakerList
  end
  TaskController.Instance:ReqOnTaskAwakerDelegateBatch(table.deepclone(sendTbl), function()
    Alert.ShowStr(LT.Text("DispatchSucessfulTip"))
    self:Close()
  end)
end

return TaskAppointRstTipsView
