local TrinketFilterSiutPanel, Super = System.NewClass("TrinketFilterSiutPanel", UIBasePanel)
TrinketFilterSiutPanel.uiResCls = UI_Alchemy_Popup_SuitResource
local TrinketFilterState = CommonDefine.TrinketFilterState

function TrinketFilterSiutPanel:ctor(filterSuits, filterSuitsMap, callback, filterModel)
  Super.ctor(self)
  self.callback = callback
  self.filterSuits = filterSuits
  self.filterModel = filterModel
  self.selectTrinketSuits = table.clone(filterSuitsMap)
end

function TrinketFilterSiutPanel:OnBind(binder)
  self.binder = binder
  self:BindSuitList(binder)
  self:BindCommonPopupConfirm(binder)
end

function TrinketFilterSiutPanel:BindSuitList(binder)
  self.tableview = self.ui.ScrollView:GetComponent(typeof(CS.UITableview))
  
  function self.tableview.tableCellAtIndex(view, index)
    local cell = view:DequeueCell()
    if not cell then
      cell = view:AddChild(self.ui.UI_Team_Item_Suit)
      binder:UpdateLocalizedTextAndResouce(cell.gameObject)
    end
    local suitId = self.filterSuits[index + 1]
    local isSelected = self.selectTrinketSuits[suitId] == TrinketFilterState.FilterInclude
    local uiRes = UI_Team_Item_SuitResource(cell.gameObject)
    uiRes.Image_Current:SetActive(false)
    binder:SetImage(uiRes.Trinket_Icon, AwakerTrinketDataUtils.GetSuitIcon(suitId))
    binder:SetText(uiRes.Text_Number, self.filterModel:GetVisibleSuitItemNum(suitId))
    binder:SetText(uiRes.Text_Name, LT.Text(AwakerTrinketDataUtils.GetSuitName(suitId)))
    binder:SetActive(uiRes.Group_Sub_Select, isSelected)
    binder:SetActive(uiRes.Btn_Sub_Subtract, isSelected)
    binder:BindButtonClick(uiRes.Btn_Click, function()
      self:SelectSuit(suitId, true)
      self.tableview:Refresh()
    end)
    binder:BindButtonClick(uiRes.Btn_Sub_Subtract, function()
      self:SelectSuit(suitId, false)
      self.tableview:Refresh()
    end)
    return cell
  end
  
  function self.tableview.numberCellsInTableview()
    return #self.filterSuits
  end
  
  self.tableview:ReloadData()
end

function TrinketFilterSiutPanel:SelectSuit(suitId, isSelected)
  self.selectTrinketSuits[suitId] = isSelected and TrinketFilterState.FilterInclude or TrinketFilterState.FilterExclude
end

function TrinketFilterSiutPanel:BindCommonPopupConfirm(binder)
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnClickConfirm),
    text = LT.Text("UniversalConfirmButton")
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.OnClickClose),
    text = LT.Text("UniversalCancelButton")
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("SelectTrinketSuit")
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_M, commonPopupConfirmTipsData))
end

function TrinketFilterSiutPanel:OnClickClose()
  self:Close()
end

function TrinketFilterSiutPanel:OnClickConfirm()
  local callback = self.callback
  self.callback = nil
  local selectTrinketSuits = self.selectTrinketSuits
  self:Close()
  if callback then
    callback(selectTrinketSuits)
  end
end

function TrinketFilterSiutPanel:OnUnbind()
  self.callback = nil
  if self.tableview then
    self.tableview:Travel(function(cell)
    end)
    self.tableview = nil
  end
end

return TrinketFilterSiutPanel
