local TrinketFilterAttrsPanel, Super = System.NewClass("TrinketFilterAttrsPanel", UIBasePanel)
TrinketFilterAttrsPanel.uiResCls = UI_Alchemy_Popup_AttributeResource
local TrinketFilterState = CommonDefine.TrinketFilterState

function TrinketFilterAttrsPanel:ctor()
  Super.ctor(self)
end

function TrinketFilterAttrsPanel:OnBind(binder)
  self.binder = binder
  self:BindAttrsList(binder)
  self:BindCommonPopupConfirm(binder)
end

function TrinketFilterAttrsPanel:BindAttrsList(binder)
  local showAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
  self.tableview = self.ui.ScrollView:GetComponent(typeof(CS.UITableview))
  
  function self.tableview.tableCellAtIndex(view, index)
    local cell = view:DequeueCell()
    if not cell then
      cell = view:AddChild(self.ui.UI_Alchemy_Popup_Attribute_Item1)
      binder:UpdateLocalizedTextAndResouce(cell.gameObject)
    end
    local attrId = showAttrIds[index + 1]
    local uiRes = UI_Alchemy_Popup_Attribute_Item1Resource(cell.gameObject)
    self:_FillCellBaseInfo(uiRes, attrId)
    self:_FillCellToggles(uiRes, attrId)
    return cell
  end
  
  function self.tableview.numberCellsInTableview()
    return #showAttrIds
  end
  
  self.tableview:ReloadData()
end

function TrinketFilterAttrsPanel:_FillCellBaseInfo(uiRes, attrId)
  local attrType = DT.ActorAttrType[attrId]
  self.binder:SetImage(uiRes.Image_Icon, attrType.Icon)
  self.binder:SetText(uiRes.Text_All, LT.Text(attrType.Text))
end

function TrinketFilterAttrsPanel:_FillCellToggles(uiRes, attrId)
end

function TrinketFilterAttrsPanel:SelectAttr(attrId, isSelected)
  self.selectAttrsId[attrId] = isSelected and TrinketFilterState.FilterInclude or TrinketFilterState.FilterExclude
end

function TrinketFilterAttrsPanel:BindCommonPopupConfirm(binder)
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
    textTitleCN = self:_GetTitle()
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_M, commonPopupConfirmTipsData))
end

function TrinketFilterAttrsPanel:OnClickConfirm()
end

function TrinketFilterAttrsPanel:OnClickClose()
  self:Close()
end

function TrinketFilterAttrsPanel:OnUnbind()
  if self.tableview then
    self.tableview:Travel(function(cell)
      local uiRes = UI_Alchemy_Popup_Attribute_Item1Resource(cell.gameObject)
      local toggleNoComp = uiRes.Toggle_Not:GetComponent(typeof(CS.Z1Client.Z1Toggle))
      local toggleHaveComp = uiRes.Toggle_Have:GetComponent(typeof(CS.Z1Client.Z1Toggle))
      toggleHaveComp.onValueChanged:RemoveAllListeners()
      toggleNoComp.onValueChanged:RemoveAllListeners()
    end)
    self.tableview = nil
  end
end

function TrinketFilterAttrsPanel:_GetTitle()
end

return TrinketFilterAttrsPanel
