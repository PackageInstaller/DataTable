local AwakerFilterListView, Super = NewClass("AwakerFilterListView", BaseView)
AwakerFilterListView.uiResCls = UI_Social_Panel_HelpList_FilterResource
local UnableSelectReason = CommonDefine.AwakerFilterUnableSelectReason or {}

function AwakerFilterListView:ctor(filterType)
  Super.ctor(self)
  self.filterType = filterType
  self.model = AwakerFilterListModel.Instance
  self.controller = AwakerFilterListController.Instance
  self.controller:SetFilterType(self.filterType)
  self._awakerList = nil
end

function AwakerFilterListView:OnBuildView()
  Super.OnBuildView(self)
  self:SetText(self.ui.Text_Title, LT.Text("AwakerColletion"))
  self:SetText(self.ui.Text_Confirm, LT.Text("Common_Button_Confirm"))
  self:_InitToggleList()
  self:_InitAwakerHeadTableview()
end

function AwakerFilterListView:OnEnterView()
  Super.OnEnterView(self)
  self:SetActive(self.ui.Btn_Tip, true)
  self.controller:ResetEditingFromSaved()
  self:SetToggle(self.model:GetCurrentSelectedSchool())
  self:RefreshAwakerHeadTableView()
  self:_RefreshFilterText()
end

function AwakerFilterListView:OnExitView()
  self.controller:ResetEditingFromSaved()
  Super.OnExitView(self)
end

function AwakerFilterListView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnAwakerFilterListChange, self._OnFilterChange, self)
end

function AwakerFilterListView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Back, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._CancelAll))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._SaveFilter))
  self:AddButtonClickListener(self.ui.Btn_Tip, System.fn(self, self._OnClickTip))
end

function AwakerFilterListView:_InitToggleList()
  local list = DT.GetOriginalConstant("AwakerTalent_TabList")
  self.curSchoolId = self.model:GetCurrentSelectedSchool()
  self.toggleList = {
    {
      uiNode = self.ui.Toggle_All,
      schoolId = list[1]
    },
    {
      uiNode = self.ui.Toggle_Hundun,
      schoolId = list[2]
    },
    {
      uiNode = self.ui.Toggle_Shenhai,
      schoolId = list[3]
    },
    {
      uiNode = self.ui.Toggle_Xuerou,
      schoolId = list[4]
    },
    {
      uiNode = self.ui.Toggle_Chaowei,
      schoolId = list[5]
    }
  }
  for _, node in pairs(self.toggleList) do
    self:AddZ1ToggleValueChangedListener(node.uiNode, function()
      self:SetToggle(node.schoolId)
    end)
  end
end

function AwakerFilterListView:_OnFilterChange()
  self:_RefreshFilterText()
  self:RefreshAwakerHeadTableView()
end

function AwakerFilterListView:_SaveFilter()
  self.controller:SaveFilter()
  self:Close()
end

function AwakerFilterListView:_CancelAll()
  self.controller:ToggleSelectAll()
end

function AwakerFilterListView:_OnClickTip()
  local anchor = self.ui.Btn_Tip or self.ui.Btn_Confirm
  UIManager.Instance:Reopen(Urls.AlertToolTipsPanel, {
    title = LT.Text("FilterAwakerOptionsTipsTitle"),
    desc = LT.Text("FilterAwakerOptionsTipsDesc")
  }, anchor)
end

function AwakerFilterListView:RefreshAwakerHeadTableView()
  if self.awakerHeadTableView then
    self.awakerHeadTableView:ReloadData()
  end
end

function AwakerFilterListView:_RefreshFilterText()
  local displaySelectedCount = self.model:GetDisplaySelectedAwakerCount()
  if displaySelectedCount > 0 then
    print("--------------refresh filter text: cancel all", displaySelectedCount)
    self:SetText(self.ui.Text_Cancel, LT.Text("CancelSelectAllAwaker"))
  else
    print("--------------refresh filter text: select all", displaySelectedCount)
    self:SetText(self.ui.Text_Cancel, LT.Text("SelectAllAwaker"))
  end
  local selectedCount = #self.model.selectedAwakerList
  local maxCount = self.model:GetFilterMaxAwakerCount()
  self:SetText(self.ui.Text_SelectedCount, selectedCount .. "/" .. maxCount)
end

function AwakerFilterListView:SetToggle(schoolId)
  self.curSchoolId = schoolId
  for _, node in pairs(self.toggleList) do
    self:SetZ1Toggle(node.uiNode, node.schoolId == schoolId, true)
  end
  self.controller:SelectSchool(schoolId)
  self.model:ClearUnselectedAwakerStamp()
  self.model:RefreshCachedDisplayList()
  self._awakerList = self.model:GetCachedDisplayList()
  self:RefreshAwakerHeadTableView()
end

function AwakerFilterListView:_InitAwakerHeadTableview()
  local cellGameObj = self.ui.UI_Social_Item_HelpList_AwakerHead
  local cellTf = cellGameObj.transform
  local w = cellTf.sizeDelta.x
  local h = cellTf.sizeDelta.y
  self.awakerHeadTableView = self:CreateTableview(self.ui.ScrollView_Awaker_List, function()
    return #self._awakerList
  end, function(view, index)
    local awakerTid = self._awakerList[index]
    do return self._ItemCellAtIndex, self, view end
    return self._ItemCellAtIndex, self, view, awakerTid
  end, function()
    return w, h
  end)
end

function AwakerFilterListView:_ItemCellAtIndex(view, awakerTid)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Social_Item_HelpList_AwakerHead)
  local cellUI = UIBaseResource(cell.gameObject)
  local headIcon = AwakerDataUtils.GetLittleIcon(awakerTid, true)
  local qualityIcon = AwakerDataUtils.GetAwakerQualityColor(awakerTid)
  self:SetImage(cellUI.Image_AwakerHead, headIcon)
  self:SetImage(cellUI.Image_Quality, qualityIcon)
  local isSelected = self.model:IsAwakerSelected(awakerTid)
  cellUI.Group_Select:SetActive(isSelected)
  local unableSelectReason = self.model:GetAwakerUnableSelectReason(awakerTid)
  cellUI.Group_Disable:SetActive(nil ~= unableSelectReason)
  if unableSelectReason == UnableSelectReason.SchoolConflict then
    self:SetText(cellUI.Text_Disable, LT.Text("SchoolNotAagreeWith"))
  elseif unableSelectReason == UnableSelectReason.MutualConflict then
    self:SetText(cellUI.Text_Disable, LT.Text("FilterAwakerUnableSelect"))
  end
  self:AddButtonClickListener(cellUI.Btn_Click, function()
    local reason = self.model:GetAwakerUnableSelectReason(awakerTid)
    if reason == UnableSelectReason.SchoolConflict then
      Alert.ShowStr("SchoolNotAagreeWith")
      return
    elseif reason == UnableSelectReason.MutualConflict then
      Alert.ShowStr("FilterAwakerUnableSelect")
      return
    end
    self.controller:ToggleAwaker(awakerTid)
  end)
  return cell
end

return AwakerFilterListView
