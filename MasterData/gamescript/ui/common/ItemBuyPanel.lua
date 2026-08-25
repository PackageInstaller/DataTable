local ItemBuyPanel, Super = System.NewClass("ItemBuyPanel", UIBasePanel)
ItemBuyPanel.uiResCls = UI_Shop_Popup_TipsResource
local Slider = CS.UnityEngine.UI.Slider
local MINBUYCOUNT = 1

function ItemBuyPanel:ctor(buyData)
  Super.ctor(self)
  self.buyTid = buyData.buyTid
  self.costTid = buyData.costTid
  self.costNum = buyData.costNum
  self.buyFunc = buyData.buyFunc
  self.title = buyData.title
  self.maxBuyCount = buyData.maxBuyCount
  self.cointList = buyData.cointList or {
    self.buyTid,
    self.costTid
  }
  self.addNum = Vue.ref(math.min(self.maxBuyCount, MINBUYCOUNT))
  self.remainCount = Vue.ref(0)
end

function ItemBuyPanel:OnBind(binder)
  self.binder = binder
  self:BindVisible()
  binder:SetText(self.ui.Text_Title, self.title or LT.Text("Shop_Buy_Btn"))
  self:BindBuyItem()
  self:BindCostItem()
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, self.cointList, true))
  self:BindButton()
  binder:BindToText(self.ui.Text_Min, function()
    do return LT.Text, math.min(MINBUYCOUNT, self.maxBuyCount) end
    return LT.Text, math.min(MINBUYCOUNT, self.maxBuyCount)
  end)
  binder:BindToText(self.ui.Text_Max, function()
    do return LT.Text end
    return LT.Text, self.maxBuyCount
  end)
  binder:BindToText(self.ui.Text_Quantity, function()
    do return LT.Text end
    return LT.Text, self.addNum.value
  end)
  binder:SetText(self.ui.Text_Item_Num, "")
  binder:BindToText(self.ui.Text_Group_No_Money_Title, function()
    do return LT.Text end
    return LT.Text, "ShopExchangeQuantity"
  end)
  binder:BindToText(self.ui.Text_Group_Buy_Title, function()
    do return LT.Text end
    return LT.Text, "ShopExchangeQuantity"
  end)
  self:BindSlider()
  self.ui.Text_Group_Buy_Residue:SetActive(false)
  self.ui.Text_Group_No_Money_Residue:SetActive(false)
end

function ItemBuyPanel:OnConfirmClick()
  if self.buyFunc then
    self.buyFunc(self.addNum.value)
  end
end

function ItemBuyPanel:BindVisible()
  self.binder:BindToVisible(self.ui.Group_No_Money, function()
    local noMoney = self.costNum > ItemDataUtils.GetItemNum(self.costTid)
    return noMoney
  end)
  self.binder:BindToVisible(self.ui.Group_Buy, function()
    local enoughMoney = self.costNum <= ItemDataUtils.GetItemNum(self.costTid)
    return enoughMoney
  end)
end

function ItemBuyPanel:BindBuyItem()
  local cfg = ItemDataUtils.GetItemConfig(self.buyTid)
  self.binder:SetText(self.ui.Text_Item_Name, cfg.Name)
  self.binder:BindComponent(CommonIconItemType2(self.ui.UI_Common_Item_WuPin_Type2, {
    itemTid = self.buyTid
  }))
  self.binder:SetText(self.ui.Text_Describe, cfg.Desc)
  self.binder:BindToText(self.ui.Text_Have, function()
    do return LT.Textf, "Shop_Now_Num_Goods_Str", ItemDataUtils.GetItemNum(self.buyTid) end
    return LT.Textf, "Shop_Now_Num_Goods_Str", ItemDataUtils.GetItemNum(self.buyTid)
  end)
end

function ItemBuyPanel:BindCostItem()
  self.binder:SetImage(self.ui.Image_Icon, ItemDataUtils.GetIcon(self.costTid))
  self.binder:BindToText(self.ui.Text_Price, function()
    local cnt = self.addNum.value > 0 and self.addNum.value or 1
    do return LT.Text end
    return LT.Text, self.costNum * cnt
  end)
  self.binder:BindToTextColor(self.ui.Text_Price, function()
    local cnt = self.addNum.value > 0 and self.addNum.value or 1
    local costNum = self.costNum * cnt
    if costNum > ItemDataUtils.GetItemNum(self.costTid) then
      return CommonDefine.ColorType.Dark
    end
    return CommonDefine.ColorType.Light
  end)
end

function ItemBuyPanel:BindButton()
  local binder = self.binder
  self:CreateComfirmAndCancelButton()
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindZ1Button(self.ui.Btn_Help, System.fn(self, self.ShowItemTips))
  binder:BindZ1Button(self.ui.Btn_Add, System.fn(self, self.OnAddClick))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Max, System.fn(self, self.OnMaxClick))
  binder:BindZ1Button(self.ui.Btn_Subtract, System.fn(self, self.OnReduceClick))
end

function ItemBuyPanel:OnMaxClick()
  if self:CheckShowSoldOut() then
    return
  end
  local nextNum = self.maxBuyCount
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(nextNum))
  self.addNum.value = nextNum
end

function ItemBuyPanel:OnReduceClick()
  local nextNum = math.max(MINBUYCOUNT, self.addNum.value - 1)
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(nextNum))
  self.addNum.value = nextNum
end

function ItemBuyPanel:BindSlider()
  self.binder:BindToSliderValueChange(self.ui.Slider_Buy, function()
    self.addNum.value = math.floor(self.ui.Slider_Buy:GetComponent(typeof(Slider)).value)
  end)
  self.binder:BindToSliderMaxValue(self.ui.Slider_Buy, function()
    return self.maxBuyCount
  end)
  self.binder:BindToSliderMinValue(self.ui.Slider_Buy, function()
    if 1 == self.maxBuyCount then
      return MINBUYCOUNT - 1
    end
    do return math.min, MINBUYCOUNT end
    return math.min, MINBUYCOUNT, self.maxBuyCount
  end)
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.min(MINBUYCOUNT, self.maxBuyCount))
end

function ItemBuyPanel:CreateComfirmAndCancelButton()
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick),
    text = LT.Text("Event_Shop_BuyBtn_Y"),
    stateFunc = function()
      local canBuy = true
      return canBuy and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
    end
  }
  local cancelBtnTipsData = {
    clickFunc = function()
      self:Close()
    end,
    text = LT.Text("Event_Shop_BuyBtn_N"),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("ShopConfirmExchange")
  }
  self.binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_M, commonPopupConfirmTipsData))
end

function ItemBuyPanel:ShowItemTips()
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Help, nil, self.buyTid)
end

function ItemBuyPanel:OnAddClick()
  if self:CheckShowSoldOut() then
    return
  end
  local nextNum = math.min(self.maxBuyCount, self.addNum.value + 1)
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(nextNum))
  self.addNum.value = nextNum
end

function ItemBuyPanel:CheckShowSoldOut()
  if self.maxBuyCount <= 0 then
    Alert.ShowStr(LT.Text("StoreSoldOut"))
    return true
  end
end

return ItemBuyPanel
