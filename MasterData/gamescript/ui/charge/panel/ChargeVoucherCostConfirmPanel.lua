local ChargeVoucherCostConfirmPanel, Super = System.NewClass("ChargeVoucherCostConfirmPanel", UIBasePanel)
ChargeVoucherCostConfirmPanel.uiResCls = UI_Common_Popup_Tip_3Resource

function ChargeVoucherCostConfirmPanel:ctor(initData)
  Super.ctor(self)
  self.data = initData
end

function ChargeVoucherCostConfirmPanel:OnBind(binder)
  self.binder = binder
  self.ui.UI_Common_Btn_Back1:SetActive(true)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:BindBtnAndContent(binder)
  self:BindVisible()
  self:BindCost(binder)
end

function ChargeVoucherCostConfirmPanel:__OnClickLeftBtn()
  if self.data and self.data.leftBtnFunc then
    self.data.leftBtnFunc()
  end
  self:Close()
end

function ChargeVoucherCostConfirmPanel:__OnClickRightBtn()
  if self.data and self.data.rightBtnFunc then
    self.data.rightBtnFunc()
  end
  self:Close()
end

function ChargeVoucherCostConfirmPanel:BindVisible()
  self.ui.Text_Bottom:SetActive(false)
  self.ui.Toggle_Screening:SetActive(false)
  self.ui.Group_Need:SetActive(true)
end

function ChargeVoucherCostConfirmPanel:BindCost(binder)
  if not self.data or not self.data.voucherData then
    return
  end
  local itemId = self.data.voucherData.tid
  local need = self.data.voucherData.num
  binder:BindToImage(self.ui.Image_icon_2, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, itemId
  end)
  binder:SetText(self.ui.Text_coin, need)
end

function ChargeVoucherCostConfirmPanel:BindBtnAndContent(binder)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  local tipsConfig = DT.TipsType[20098]
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.__OnClickRightBtn),
    text = LT.Text(tipsConfig.RightBtnDesc)
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.__OnClickLeftBtn),
    text = LT.Text(tipsConfig.LeftBtnDesc)
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text(tipsConfig.Title),
    maskClickFunc = System.fn(self, self.Close)
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
  local tipsText = LT.Textf(tipsConfig.Desc, self.data.voucherData.num)
  binder:SetText(self.ui.Text_Tips, tipsText)
end

function ChargeVoucherCostConfirmPanel:Close()
  Super.Close(self)
end

return ChargeVoucherCostConfirmPanel
