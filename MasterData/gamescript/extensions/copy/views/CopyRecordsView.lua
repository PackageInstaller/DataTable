local CopyRecordsView, Super = NewClass("CopyRecordsView", BaseView)
CopyRecordsView.uiResCls = "UI/UI_Dungeous/UI_Dungeous_Prefab/UI_Dungeons_Popup_Clearance.prefab"

function CopyRecordsView:ctor(stageId)
  Super.ctor(self)
  self.stageId = stageId
  self._sortType = cd.CopyRecordsSortType.TimeDescend
  AwakerFilterListController.Instance:SetFilterType(CommonDefine.AwakerFilterType.CopyRecords)
end

function CopyRecordsView:RegisterNotifications()
  self:BindEvent(EventMgr.Instance.CopyRecordUpdate, System.fn(self, self.OnCopyRecordUpdate))
  self:RegisterNotify(NotifyId.OnSaveAwakerFilter, self._OnSaveAwakerFilter, self)
end

function CopyRecordsView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.OnBtnClose))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Trinket_Litre, System.fn(self, self.OnBtnSort))
  self:AddButtonClickListener(self.ui.Btn_Refresh, System.fn(self, self.OnClickBtnRefresh))
  self:AddButtonClickListener(self.ui.Btn_FilterAwaker, System.fn(self, self.OnBtnFilterAwaker))
end

function CopyRecordsView:OnBuildView()
  Super.OnBuildView(self)
  self:CreateRecordTableView()
end

function CopyRecordsView:OnEnterView()
  Super.OnEnterView(self)
  self._curRecordPage = 1
  self:SetText(self.ui.Text_Fliter_Type, LT.Text("RecordsSortTypeTime"))
  self:SetActive(self.ui.Btn_FilterAwaker, true)
  self:_RefreshFilterAwakerBtnState()
  self:SetZ1Toggle(self.ui.Btn_Trinket_Litre, self._sortType == cd.CopyRecordsSortType.TimeDescend, true)
  self:OnSwitchSortType()
end

function CopyRecordsView:OnExitView()
  Super.OnExitView(self)
  CopyRecordsModel.Instance:ClearStageRecords(self.stageId)
  AwakerFilterListController.Instance:ClearFilterData(CommonDefine.AwakerFilterType.CopyRecords)
end

function CopyRecordsView:OnBtnClose()
  self:Close()
end

function CopyRecordsView:OnCopyRecordUpdate()
  self._recordDatas = self:GetRecordDatas() or {}
  self._recordTableView:ReloadData()
  self.ui.Group_Null_Black:SetActive(0 == #self._recordDatas)
end

function CopyRecordsView:GetRecordDatas()
  do return CopyRecordsModel.Instance.GetStageRecords, CopyRecordsModel.Instance, self.stageId, self:GetSortType() end
  return CopyRecordsModel.Instance.GetStageRecords, CopyRecordsModel.Instance, self.stageId, self:GetSortType()
end

function CopyRecordsView:GetSortType()
  return self._sortType
end

function CopyRecordsView:CreateRecordTableView()
  local sizeDelta = self.ui.UI_Dungeons_Item_Clearance.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._recordTableView = self:CreateTableview(self.ui.ScrollView_Clearance, function()
    return #self._recordDatas
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_Clearance)
    local recordData = self._recordDatas[index]
    self:AddViewComponentOnce(cell.gameObject, CopyRecordsItem, recordData)
    if index == #self._recordDatas then
      CopyRecordsModel.Instance:ReqNextPageRecords(self.stageId, self:GetSortType())
    end
    return cell
  end, function()
    return w, h
  end)
end

function CopyRecordsView:OnBtnSort(isOn)
  if nil == isOn then
    if self._sortType == cd.CopyRecordsSortType.TimeAscend then
      self._sortType = cd.CopyRecordsSortType.TimeDescend
    else
      self._sortType = cd.CopyRecordsSortType.TimeAscend
    end
  else
    self._sortType = isOn and cd.CopyRecordsSortType.TimeDescend or cd.CopyRecordsSortType.TimeAscend
  end
  self:OnSwitchSortType()
end

function CopyRecordsView:OnSwitchSortType()
  self._recordTableView:SetOffset(0, false)
  local records = self:GetRecordDatas()
  if not records or not table.next(records) then
    CopyRecordsController.Instance:ReqQueryStageRecord(self.stageId, self._curRecordPage, self:GetSortType())
  else
    self:OnCopyRecordUpdate()
  end
end

function CopyRecordsView:OnClickBtnRefresh()
  self._curRecordPage = self._curRecordPage + 1
  CopyRecordsController.Instance:ReqQueryStageRecord(self.stageId, self._curRecordPage, self:GetSortType())
end

function CopyRecordsView:OnBtnFilterAwaker()
  UIManager.Instance:Reopen(Urls.AwakerFilterListView, CommonDefine.AwakerFilterType.CopyRecords)
end

function CopyRecordsView:_RefreshFilterAwakerBtnState()
  local isFiltering = AwakerFilterListController.Instance:GetCopyRecordsFilterAwakerMap() ~= nil
  local btnState = isFiltering and CommonDefine.BtnType.High or CommonDefine.BtnType.Normal
  self:SetButtonState(self.ui.Btn_FilterAwaker, btnState)
  local btnText = isFiltering and LT.Text("AwakerHasColletion") or LT.Text("AwakerColletion")
  self:SetButtonText(self.ui.Btn_FilterAwaker, btnText)
end

function CopyRecordsView:_OnSaveAwakerFilter(filterType)
  if filterType ~= CommonDefine.AwakerFilterType.CopyRecords then
    return
  end
  self:_RefreshFilterAwakerBtnState()
  self._curRecordPage = 1
  CopyRecordsModel.Instance:ClearStageRecords(self.stageId)
  self._recordDatas = self:GetRecordDatas() or {}
  if self._recordTableView then
    self._recordTableView:ReloadData()
    self._recordTableView:SetOffset(0, false)
  end
  CopyRecordsController.Instance:ReqQueryStageRecord(self.stageId, self._curRecordPage, self:GetSortType())
end

return CopyRecordsView
