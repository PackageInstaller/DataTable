local ItemBuyView, Super = NewClass("ItemBuyView", BaseView)
ItemBuyView.uiResCls = UI_Shop_Popup_TipsResource
local T_Slider = typeof(CS.UnityEngine.UI.Slider)
local MINBUYCOUNT = 1

function ItemBuyView:ctor(buyData)
  Super.ctor(self)
  self._shopId = buyData.shopId
  self._buyTid = buyData.buyTid
  self._costTid = buyData.costTid
  self._costNum = buyData.costNum
  self._buyFunc = buyData.buyFunc
  self._title = buyData.title
  self._maxBuyCount = buyData.maxBuyCount
  self._coinList = buyData.cointList or {
    self._buyTid,
    self._costTid
  }
end

function ItemBuyView:RegisterEvents()
  Super.RegisterEvents(self)
  self:AddSliderListener(self.ui.Slider_Buy, System.fn(self, self._OnSliderValueChanged))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._OnClickMask))
  self:AddButtonClickListener(self.ui.Btn_Help, System.fn(self, self._OnClickHelp))
  self:AddButtonClickListener(self.ui.Btn_Add, System.fn(self, self._OnClickAdd))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Max, System.fn(self, self._OnClickMax))
  self:AddButtonClickListener(self.ui.Btn_Subtract, System.fn(self, self._OnClickReduce))
end

function ItemBuyView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._RefreshView, self)
end

function ItemBuyView:OnEnterView()
  Super.OnEnterView(self)
  self._addNum = MINBUYCOUNT
  self:_SetBuyItem()
  self:_SetCostItem()
  self:_RefreshView()
  self:_SetCurrencyGroup()
  self:_SetConfirmButtons()
  self:SetText(self.ui.Text_Title, self._title or LT.Text("Shop_Buy_Btn"))
end

function ItemBuyView:OnExitView()
  Super.OnExitView(self)
end

function ItemBuyView:_RefreshView()
  if self._shopId then
    self._maxBuyCount = SummonDataUtils.GetMaxTicketBuyCount(self._shopId)
  end
  self._addNum = MathUtils.Clamp(self._addNum, MINBUYCOUNT, self._maxBuyCount)
  self:_UpdateSlider()
  self:_SetViewText()
  self:_RefreshQuantity()
  self:_RefreshCost()
  self:_RefreshVisible()
end

function ItemBuyView:_UpdateSlider()
  local slider = self.ui.Slider_Buy:GetComponent(T_Slider)
  local targetNum = MathUtils.Clamp(self._addNum, MINBUYCOUNT, self._maxBuyCount)
  slider.minValue = math.min(MINBUYCOUNT, self._maxBuyCount)
  slider.maxValue = self._maxBuyCount
  slider.value = targetNum
  self._addNum = targetNum
end

function ItemBuyView:_SetBuyItem()
  local cfg = ItemDataUtils.GetItemConfig(self._buyTid)
  self:SetText(self.ui.Text_Item_Name, cfg.Name)
  self:SetText(self.ui.Text_Describe, cfg.Desc)
  local itemData = {
    itemTid = self._buyTid
  }
  self:AddViewComponent(self.ui.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2, itemData)
end

function ItemBuyView:_SetCostItem()
  self:SetImage(self.ui.Image_Icon, ItemDataUtils.GetIcon(self._costTid))
end

function ItemBuyView:_SetCurrencyGroup()
  self:AddViewComponent(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, self._coinList, true)
end

function ItemBuyView:_SetConfirmButtons()
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self._OnClickConfirm),
    text = LT.Text("Event_Shop_BuyBtn_Y"),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self._OnClickCancel),
    text = LT.Text("Event_Shop_BuyBtn_N"),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local data = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("ShopConfirmExchange")
  }
  self:AddViewComponent(self.ui.UI_Common_Popup_Tips_Confirm_M, UICompCommonPopupConfirmTips, data)
end

function ItemBuyView:_SetViewText()
  self:SetText(self.ui.Text_Min, LT.Text(math.min(MINBUYCOUNT, self._maxBuyCount)))
  self:SetText(self.ui.Text_Max, LT.Text(self._maxBuyCount))
  self:SetText(self.ui.Text_Item_Num, "")
  self:SetText(self.ui.Text_Group_No_Money_Title, LT.Text("ShopExchangeQuantity"))
  self:SetText(self.ui.Text_Group_Buy_Title, LT.Text("ShopExchangeQuantity"))
  self:SetText(self.ui.Text_Have, LT.Textf("Shop_Now_Num_Goods_Str", ItemDataUtils.GetItemNum(self._buyTid)))
  self.ui.Text_Group_Buy_Residue:SetActive(false)
  self.ui.Text_Group_No_Money_Residue:SetActive(false)
end

function ItemBuyView:_RefreshQuantity()
  local addNum = math.min(self._addNum, self._maxBuyCount)
  self:SetText(self.ui.Text_Quantity, LT.Text(addNum))
  self:SetButtonState(self.ui.Btn_Add, self._addNum < self._maxBuyCount and CommonDefine.BtnType.Normal or CommonDefine.BtnType.Unclickable)
  self:SetButtonState(self.ui.Btn_Subtract, self._addNum > MINBUYCOUNT and CommonDefine.BtnType.Normal or CommonDefine.BtnType.Unclickable)
end

function ItemBuyView:_RefreshCost()
  local cnt = self._addNum > 0 and self._addNum or MINBUYCOUNT
  local costNum = self._costNum * cnt
  self:SetText(self.ui.Text_Price, LT.Text(costNum))
  if costNum > ItemDataUtils.GetItemNum(self._costTid) then
    self:SetTextColorType(self.ui.Text_Price, CommonDefine.ColorType.Dark)
  else
    self:SetTextColorType(self.ui.Text_Price, CommonDefine.ColorType.Light)
  end
end

function ItemBuyView:_RefreshVisible()
  local noMoney = self._costNum > ItemDataUtils.GetItemNum(self._costTid)
  self.ui.Group_No_Money:SetActive(noMoney)
  self.ui.Group_Buy:SetActive(not noMoney)
  local onlyOneCount = self._maxBuyCount == MINBUYCOUNT
  self:SetActive(self.ui.Group_Slider, not noMoney and not onlyOneCount)
  self:SetActive(self.ui.Image_One_Good, not noMoney and onlyOneCount)
end

function ItemBuyView:_OnSliderValueChanged()
  self._addNum = math.floor(self.ui.Slider_Buy:GetComponent(T_Slider).value)
  self:_RefreshQuantity()
  self:_RefreshCost()
  self:_RefreshVisible()
end

function ItemBuyView:_OnClickMask()
  self:Close()
end

function ItemBuyView:_OnClickHelp()
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Help, nil, self._buyTid)
end

function ItemBuyView:_OnClickAdd()
  if self:_CheckShowSoldOut() then
    return
  end
  local nextNum = math.min(self._maxBuyCount, self._addNum + 1)
  self:SetSliderValue(self.ui.Slider_Buy, math.floor(nextNum))
  self._addNum = nextNum
  self:_RefreshQuantity()
  self:_RefreshCost()
  self:_RefreshVisible()
end

function ItemBuyView:_OnClickReduce()
  local nextNum = math.max(MINBUYCOUNT, self._addNum - 1)
  self:SetSliderValue(self.ui.Slider_Buy, math.floor(nextNum))
  self._addNum = nextNum
  self:_RefreshQuantity()
  self:_RefreshCost()
  self:_RefreshVisible()
end

function ItemBuyView:_OnClickMax()
  if self:_CheckShowSoldOut() then
    return
  end
  local nextNum = self._maxBuyCount
  self:SetSliderValue(self.ui.Slider_Buy, math.floor(nextNum))
  self._addNum = nextNum
  self:_RefreshQuantity()
  self:_RefreshCost()
  self:_RefreshVisible()
end

function ItemBuyView:_OnClickConfirm()
  ShopController.Instance:CheckBulkBuyConfirm({
    costItemId = self._costTid,
    totalCost = self._costNum * self._addNum,
    gainItemTid = self._buyTid,
    gainNum = self._addNum
  }, function()
    self:_DoConfirmBuy()
  end)
end

function ItemBuyView:_DoConfirmBuy()
  if self._buyFunc then
    self._buyFunc(self._addNum)
  end
end

function ItemBuyView:_OnClickCancel()
  self:Close()
end

function ItemBuyView:_CheckShowSoldOut()
  if self._maxBuyCount <= 0 then
    Alert.ShowStr(LT.Text("StoreSoldOut"))
    return true
  end
  return false
end

return ItemBuyView
