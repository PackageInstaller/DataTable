local AssistFilterListView, Super = NewClass("AssistFilterListView", BaseView)
AssistFilterListView.uiResCls = UI_Social_Panel_HelpList_FilterResource

function AssistFilterListView:ctor(refreshCallback)
  Super.ctor(self)
  self.refreshCallback = refreshCallback
  self.model = AssistFilterModel.Instance
end

function AssistFilterListView:OnEnterView()
  self.model:RefreshOnPanelOpen()
  self:SetText(self.ui.Text_Title, LT.Text("AwakerColletion"))
  self:SetText(self.ui.Text_Confirm, LT.Text("Common_Button_Confirm"))
  self:_RefreshFilterText()
  local list = DT.GetOriginalConstant("AwakerTalent_TabList")
  self.curSchoolId = list[1]
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
  self:SetToggle(self.curSchoolId)
  self:_InitTableview()
  self:SetActive(self.ui.Btn_Tip, false)
end

function AssistFilterListView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnAssistFilterListChange, self._InitTableview, self)
  self:RegisterLocalNotify(NotifyId.OnAssistFilterListChange, self._RefreshFilterText, self)
end

function AssistFilterListView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Back, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._CancelAll))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._SaveFilter))
end

function AssistFilterListView:_SaveFilter()
  self.model:SaveFilter()
  self:Close()
  self.refreshCallback()
end

function AssistFilterListView:_CancelAll()
  self.model:ToggleSelectAll()
end

function AssistFilterListView:_RefreshFilterText()
  if self.model:GetSelectedAwakerCount() > 0 then
    self:SetText(self.ui.Text_Cancel, LT.Text("CancelSelectAllAwaker"))
  else
    self:SetText(self.ui.Text_Cancel, LT.Text("SelectAllAwaker"))
  end
  local allAwakerCount, allselectedAwakerCount = self.model:GetAllSelectAssistAwakerCount()
  self:SetText(self.ui.Text_SelectedCount, allselectedAwakerCount .. "/" .. allAwakerCount)
end

function AssistFilterListView:SetToggle(schoolId)
  self.curSchoolId = schoolId
  for _, node in pairs(self.toggleList) do
    self:SetZ1Toggle(node.uiNode, node.schoolId == schoolId, true)
  end
  self.model:SetSchool(schoolId)
end

function AssistFilterListView:_InitTableview()
  local w = self.ui.UI_Social_Item_HelpList_AwakerHead.transform.sizeDelta.x
  local h = self.ui.UI_Social_Item_HelpList_AwakerHead.transform.sizeDelta.y
  local wholeList = self.model:GetWholeList()
  self.tableView = self:CreateTableview(self.ui.ScrollView_Awaker_List, function()
    return wholeList and #wholeList or 0
  end, function(view, index)
    do return self._ItemCellAtIndex, self, view end
    return self._ItemCellAtIndex, self, view, wholeList[index]
  end, function()
    return w, h
  end)
  self.tableView:ReloadData()
end

function AssistFilterListView:_ItemCellAtIndex(view, awakerTid)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Social_Item_HelpList_AwakerHead)
  local cellUI = UI_Social_Item_HelpList_AwakerHeadResource(cell)
  local headIcon, qualityIcon = self.model:GetIcon(awakerTid)
  self:SetImage(cellUI.Image_AwakerHead, headIcon)
  self:SetImage(cellUI.Image_Quality, qualityIcon)
  cellUI.Group_Select:SetActive(self.model.selectList[awakerTid])
  self:AddButtonClickListener(cellUI.Btn_Click, function()
    local isOn = self.model:ToggleSingleAwaker(awakerTid)
    cellUI.Group_Select:SetActive(isOn)
    self:_RefreshFilterText()
  end)
  return cell
end

return AssistFilterListView
