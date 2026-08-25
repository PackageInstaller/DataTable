local AlchemyExchangeConfirmView, Super = NewClass("AlchemyExchangeConfirmView", AlchemyConfirmBaseView)
AlchemyExchangeConfirmView.uiResCls = UI_Alchemy_Popup_Recast_Tips_OptimizeResource

function AlchemyExchangeConfirmView:ctor(confirmCb)
  self.model = AlchemyExchangeExtModel.Instance
  Super.ctor(self, confirmCb)
end

function AlchemyExchangeConfirmView:_InitViewData()
  self.showItemGroup = self.model.realCostItemGroup
  self.curSelectExchangeData = self.model:GetCurSelectExchangeData()
  self.curExchangeItemNum = self.model:GetCurExchangeItemNum()
end

function AlchemyExchangeConfirmView:_OnInitConfirmTips()
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.OnCancleClick)
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    maskClickFunc = System.fn(self, self.Close),
    textTitleCN = LT.Text("ExchangeConfirm")
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_Confirm_M, CompPublicPopupConfirmTips, commonPopupConfirmTipsData)
  local realGetItemNum = self.curExchangeItemNum
  local realCostItemNum = realGetItemNum * self.curSelectExchangeData.costItemNum
  local itemName = ItemDataUtils.GetItemName(self.model.selectTid)
  local showTips = LT.Textf("ExchangeTips", realCostItemNum, realGetItemNum, itemName)
  self:SetText(self.ui.Text_Tips, showTips)
end

function AlchemyExchangeConfirmView:OnConfirmClick()
  if self.confirmCb then
    self.confirmCb()
  end
  self:Close()
end

function AlchemyExchangeConfirmView:OnCancleClick()
  self:Close()
end

function AlchemyExchangeConfirmView:AddAlchemyItemComp(obj, exchangeCostItemData)
  local tid, uid, num
  tid = exchangeCostItemData.tid
  num = exchangeCostItemData.num
  local itemData = ItemDataUtils.GetItemByTid(tid)
  if itemData then
    uid = itemData.uid
  end
  
  local function clickCb()
    ItemDataUtils.ShowItemDetailTips(self.binder, obj, uid, tid, true)
  end
  
  local viewData = {
    tid = tid,
    uid = uid,
    num = num,
    clickCb = clickCb
  }
  self:AddViewComponentOnce(obj, CompAlchemyBaseItem, viewData)
end

return AlchemyExchangeConfirmView
