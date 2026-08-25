local UICompCopyBattleStatisticFilterBar, Super = NewViewComponent("UICompCopyBattleStatisticFilterBar")
local Vector3 = CS.UnityEngine.Vector3

function UICompCopyBattleStatisticFilterBar:ctor(uiNode, view, viewModel, onFilterChanged)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Panel_CopyStatisticsResource(uiNode)
  self._viewModel = viewModel
  self._battleTypeTableView = nil
  self._battleTypeOptionList = {}
  self._dataTypeTableView = nil
  self._dataTypeOptionList = {}
  self._roundFilterTableView = nil
  self._roundFilterOptionList = {}
  self._onFilterChanged = onFilterChanged
end

function UICompCopyBattleStatisticFilterBar:OnEnterComponent()
  self:AddButtonClickListener(self.ui.Btn_BattleType, System.fn(self, self._OnClickBattleType))
  self:AddButtonClickListener(self.ui.Btn_DataType, System.fn(self, self._OnClickDataType))
  self:AddButtonClickListener(self.ui.Btn_Round, System.fn(self, self._OnClickRoundFilter))
  self:_BindDropdownCustomInputs()
  self:_CreateBattleTypeTableView()
  self:_CreateDataTypeTableView()
  self:_CreateRoundFilterTableView()
  self:HideAllDropdowns()
  self:Refresh()
end

function UICompCopyBattleStatisticFilterBar:Refresh()
  if self.ui.Text_BattleType then
    self:SetText(self.ui.Text_BattleType, self._viewModel:GetBattleFilterText(self._viewModel.battleFilterIndex))
  end
  if self.ui.Text_Round then
    self:SetText(self.ui.Text_Round, self._viewModel:GetRoundFilterText())
  end
  if self.ui.Text_DataType then
    self:SetText(self.ui.Text_DataType, self._viewModel:GetDataTypeText())
  end
  self:_RefreshDropdownArrows()
end

function UICompCopyBattleStatisticFilterBar:HideAllDropdowns()
  local dropdowns = {
    self.ui.ScrollView_BattleType,
    self.ui.ScrollView_DataType,
    self.ui.ScrollView_Round
  }
  for _, go in ipairs(dropdowns) do
    if go then
      self:SetActive(go, false)
    end
  end
  self:_RefreshDropdownArrows()
end

function UICompCopyBattleStatisticFilterBar:_BindDropdownCustomInputs()
  self:_BindDropdownCustomInput(self.ui.Btn_BattleType, self.ui.ScrollView_BattleType)
  self:_BindDropdownCustomInput(self.ui.Btn_DataType, self.ui.ScrollView_DataType)
  self:_BindDropdownCustomInput(self.ui.Btn_Round, self.ui.ScrollView_Round)
end

function UICompCopyBattleStatisticFilterBar:_BindDropdownCustomInput(btnGo, scrollGo)
  local ownerGo = self:_GetDropdownOwnerGo(btnGo, scrollGo)
  if not ownerGo then
    return
  end
  self:AddUICustomInputlistener(ownerGo, System.bind(self._OnDropdownCustomInput, self, scrollGo))
end

function UICompCopyBattleStatisticFilterBar:_GetDropdownOwnerGo(btnGo, scrollGo)
  if scrollGo and not IsNil(scrollGo) and scrollGo.transform and scrollGo.transform.parent then
    return scrollGo.transform.parent.gameObject
  end
  if btnGo and not IsNil(btnGo) and btnGo.transform and btnGo.transform.parent then
    return btnGo.transform.parent.gameObject
  end
  return nil
end

function UICompCopyBattleStatisticFilterBar:_OnDropdownCustomInput(scrollGo, hover)
  if hover then
    return
  end
  if scrollGo and not IsNil(scrollGo) and scrollGo.activeSelf then
    self:HideAllDropdowns()
  end
end

function UICompCopyBattleStatisticFilterBar:_ToggleDropdown(scrollGo)
  if not scrollGo then
    return
  end
  local cur = scrollGo.activeSelf
  self:HideAllDropdowns()
  self:SetActive(scrollGo, not cur)
  self:_RefreshDropdownArrows()
end

function UICompCopyBattleStatisticFilterBar:_SetDropdownArrowOpen(arrowGo, isOpen, closedRotation)
  if not arrowGo or IsNil(arrowGo) then
    return
  end
  local rotation = closedRotation or 0
  if isOpen then
    rotation = rotation + 180
  end
  arrowGo.transform.localEulerAngles = Vector3(0, 0, rotation)
end

function UICompCopyBattleStatisticFilterBar:_RefreshDropdownArrows()
  self:_SetDropdownArrowOpen(self.ui.Image_Arrow_BattleType, self.ui.ScrollView_BattleType and self.ui.ScrollView_BattleType.activeSelf == true, -90)
  self:_SetDropdownArrowOpen(self.ui.Image_Arrow_DataType, self.ui.ScrollView_DataType and true == self.ui.ScrollView_DataType.activeSelf, 90)
  self:_SetDropdownArrowOpen(self.ui.Image_Arrow_Round, self.ui.ScrollView_Round and true == self.ui.ScrollView_Round.activeSelf, 90)
end

function UICompCopyBattleStatisticFilterBar:_OnClickBattleType()
  local scroll = self.ui.ScrollView_BattleType
  if not scroll then
    return
  end
  local wasOpen = scroll.activeSelf
  self:_ToggleDropdown(scroll)
  if scroll.activeSelf and not wasOpen then
    self._battleTypeOptionList = self._viewModel:GetBattleTypeOptions()
    if self._battleTypeTableView then
      self._battleTypeTableView:ReloadData()
    end
  end
end

function UICompCopyBattleStatisticFilterBar:_OnClickDataType()
  local scroll = self.ui.ScrollView_DataType
  if not scroll then
    return
  end
  local wasOpen = scroll.activeSelf
  self:_ToggleDropdown(scroll)
  if scroll.activeSelf and not wasOpen then
    self._dataTypeOptionList = self._viewModel:GetDataTypeOptions()
    if self._dataTypeTableView then
      self._dataTypeTableView:ReloadData()
    end
  end
end

function UICompCopyBattleStatisticFilterBar:_OnClickRoundFilter()
  local scroll = self.ui.ScrollView_Round
  if not scroll then
    return
  end
  local wasOpen = scroll.activeSelf
  self:_ToggleDropdown(scroll)
  if scroll.activeSelf and not wasOpen then
    self._roundFilterOptionList = self._viewModel:GetRoundFilterOptions()
    if self._roundFilterTableView then
      self._roundFilterTableView:ReloadData()
    end
  end
end

function UICompCopyBattleStatisticFilterBar:_GetDropdownRowTemplate()
  return self.ui.UI_Pvp_Item_Season
end

function UICompCopyBattleStatisticFilterBar:_CreateBattleTypeTableView()
  local owner = self.ui.ScrollView_BattleType
  if not owner then
    return
  end
  local templateGo = self:_GetDropdownRowTemplate()
  if not templateGo then
    Logger.Error("UICompCopyBattleStatisticFilterBar: battle type list template missing UI_Pvp_Item_Season.")
    return
  end
  local cellRT = templateGo.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self._battleTypeTableView = self:CreateTableview(owner, System.fn(self, self._BattleTypeOptionCount), System.fn(self, self._BattleTypeOptionCellAtIndex), function()
    return width, height
  end)
end

function UICompCopyBattleStatisticFilterBar:_CreateDataTypeTableView()
  local owner = self.ui.ScrollView_DataType
  if not owner then
    return
  end
  local templateGo = self:_GetDropdownRowTemplate()
  if not templateGo then
    Logger.Error("UICompCopyBattleStatisticFilterBar: data type list template missing UI_Pvp_Item_Season.")
    return
  end
  local cellRT = templateGo.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self._dataTypeTableView = self:CreateTableview(owner, System.fn(self, self._DataTypeOptionCount), System.fn(self, self._DataTypeOptionCellAtIndex), function()
    return width, height
  end)
end

function UICompCopyBattleStatisticFilterBar:_CreateRoundFilterTableView()
  local owner = self.ui.ScrollView_Round
  if not owner then
    return
  end
  local templateGo = self:_GetDropdownRowTemplate()
  if not templateGo then
    Logger.Error("UICompCopyBattleStatisticFilterBar: round list template missing UI_Pvp_Item_Season.")
    return
  end
  local cellRT = templateGo.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self._roundFilterTableView = self:CreateTableview(owner, System.fn(self, self._RoundFilterOptionCount), System.fn(self, self._RoundFilterOptionCellAtIndex), function()
    return width, height
  end)
end

function UICompCopyBattleStatisticFilterBar:_BattleTypeOptionCount()
  return self._battleTypeOptionList and #self._battleTypeOptionList or 0
end

function UICompCopyBattleStatisticFilterBar:_BattleTypeOptionCellAtIndex(view, index)
  local row = self._battleTypeOptionList and self._battleTypeOptionList[index]
  local templateGo = self:_GetDropdownRowTemplate()
  local cell = self.view:DequeueCell(view, templateGo)
  if row and templateGo then
    local comp = self:AddViewComponentOnce(cell.gameObject, UICompCopyBattleStatisticBattleTypeOption, row.label, row.battleIndex, self._viewModel.battleFilterIndex, System.fn(self, self._OnPickBattleTypeOption))
    comp:Refresh(row.label, row.battleIndex, self._viewModel.battleFilterIndex, System.fn(self, self._OnPickBattleTypeOption))
  end
  return cell
end

function UICompCopyBattleStatisticFilterBar:_DataTypeOptionCount()
  return self._dataTypeOptionList and #self._dataTypeOptionList or 0
end

function UICompCopyBattleStatisticFilterBar:_DataTypeOptionCellAtIndex(view, index)
  local row = self._dataTypeOptionList and self._dataTypeOptionList[index]
  local templateGo = self:_GetDropdownRowTemplate()
  local cell = self.view:DequeueCell(view, templateGo)
  if row and templateGo then
    self:AddViewComponentOnce(cell.gameObject, UICompCopyBattleStatisticBattleTypeOption, row.label, row.dataTypeDim, self._viewModel.roundDataTypeDim, System.fn(self, self._OnPickDataTypeOption))
  end
  return cell
end

function UICompCopyBattleStatisticFilterBar:_RoundFilterOptionCount()
  return self._roundFilterOptionList and #self._roundFilterOptionList or 0
end

function UICompCopyBattleStatisticFilterBar:_RoundFilterOptionCellAtIndex(view, index)
  local row = self._roundFilterOptionList and self._roundFilterOptionList[index]
  local templateGo = self:_GetDropdownRowTemplate()
  local cell = self.view:DequeueCell(view, templateGo)
  if row and templateGo then
    self:AddViewComponentOnce(cell.gameObject, UICompCopyBattleStatisticBattleTypeOption, row.label, row.roundIndex, self._viewModel.roundFilterIndex, System.fn(self, self._OnPickRoundFilterOption))
  end
  return cell
end

function UICompCopyBattleStatisticFilterBar:_OnPickBattleTypeOption(battleIndex)
  self._viewModel:SetBattleFilterIndex(battleIndex)
  self:HideAllDropdowns()
  self:Refresh()
  if self._onFilterChanged then
    self._onFilterChanged()
  end
end

function UICompCopyBattleStatisticFilterBar:_OnPickDataTypeOption(dataTypeDim)
  self._viewModel:SetRoundDataTypeDim(dataTypeDim)
  self:HideAllDropdowns()
  self:Refresh()
  if self._onFilterChanged then
    self._onFilterChanged()
  end
end

function UICompCopyBattleStatisticFilterBar:_OnPickRoundFilterOption(roundIndex)
  self._viewModel:SetRoundFilterIndex(roundIndex)
  self:HideAllDropdowns()
  self:Refresh()
  if self._onFilterChanged then
    self._onFilterChanged()
  end
end

return UICompCopyBattleStatisticFilterBar
