local MainShopEnergyMonthCardTips, Super = System.NewClass("MainShopEnergyMonthCardTips", UIBasePanel)
MainShopEnergyMonthCardTips.uiResCls = UI_Recharge_Exchange_TipsResource

function MainShopEnergyMonthCardTips:ctor()
  Super.ctor(self)
end

function MainShopEnergyMonthCardTips:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(MainShopEnergyMonthCardTipsModel)
  self.model = model
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnClickConfirm),
    text = LT.Text("Shop_Buy_Btn"),
    stateFunc = System.fn(self, self.ConfirmBtnStateFunc)
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.OnClickCancel)
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    maskClickFunc = System.fn(self, self.Close)
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_M, commonPopupConfirmTipsData))
  binder:BindToText(self.ui.Text_Name, function()
    do return LT.Text end
    return LT.Text, model.itemCfg.Name
  end)
  binder:BindToText(self.ui.Text_Description, function()
    do return LT.Text end
    return LT.Text, model.itemCfg.Desc
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    return model.itemCfg.Icon
  end)
  binder:BindToText(self.ui.Text_Price, function()
    do return LT.Text end
    return LT.Text, model.price
  end)
  binder:BindToTextColor(self.ui.Text_Price, function()
    local totalCurrency = ItemDataUtils.GetItemNum(model.costItemTid) or 0
    if totalCurrency < model.price then
      return CommonDefine.ColorType.Dark
    else
      return CommonDefine.ColorType.Normal
    end
  end)
  binder:BindToImage(self.ui.Image_Currency_Icon, function()
    do return ItemDataUtils.GetIcon end
    return ItemDataUtils.GetIcon, model.costItemTid
  end)
  binder:BindToText(self.ui.Text_Quantity, function()
    local endTs = MainShopDataUtils.GetEnergyMonthCardTs()
    do return LT.Textf, "EnergyMonthCardCountDownDesc", MainShopDataUtils.GetMonthCardRemainDays(endTs) end
    return LT.Textf, "EnergyMonthCardCountDownDesc", MainShopDataUtils.GetMonthCardRemainDays(endTs)
  end)
  binder:BindToVisible(self.ui.Text_Quantity, function()
    local state = MainShopDataUtils.GetEnergyMonthCardState()
    return state == CommonDefine.MonthCardState.InEffect
  end)
  binder:BindToVisible(self.ui.Image_Frame, function()
    local state = MainShopDataUtils.GetEnergyMonthCardState()
    return state == CommonDefine.MonthCardState.InEffect
  end)
  binder:BindToCircularListView(self.ui.ScrollView, function()
    return model.showRewardGroup
  end, function(itemBinder, obj, index)
    itemBinder:BindComponent(MainShopGiftBagContentItem(obj, model.showRewardGroup[index]))
  end)
  local coinList = DT.Constant.GiftBagCurrencies.Data
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, coinList, true))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, function()
    UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("EnergyMonthCardRuleTitle"), LT.Text("EnergyMonthCardRuleContent"))
  end)
  binder:BindToVisible(self.ui.UI_Common_Btn_Question, function()
    return true
  end)
end

function MainShopEnergyMonthCardTips:OnClickConfirm()
  if self:RemainTimeOutLimit() then
    Alert.ShowStr(LT.Textf("EnergyMonthCardOutLimitDayTips", LT.Text(self.model.itemCfg.Name), DT.GetConstant("EnergyMonthlyCardBuyLimit")))
    return
  end
  if self:NotEnoughMoney() then
    DiamondShopDataUtils.ChargeNotEnoughTips(System.fn(self, self.Close))
    return
  end
  MainShopDataUtils.PurchaseMonthCard(System.fn(self, self.PurchaseCallBack), CommonDefine.MonthCardType.Energy)
end

function MainShopEnergyMonthCardTips:ConfirmBtnStateFunc()
  if self:RemainTimeOutLimit() then
    return CommonDefine.BtnType.Unclickable
  end
  if self:NotEnoughMoney() then
    return CommonDefine.BtnType.Unclickable
  end
  return CommonDefine.BtnType.High
end

function MainShopEnergyMonthCardTips:RemainTimeOutLimit()
  local endTs = MainShopDataUtils.GetEnergyMonthCardTs()
  local remainDays = MainShopDataUtils.GetMonthCardRemainDays(endTs)
  return remainDays > DT.GetConstant("EnergyMonthlyCardBuyLimit")
end

function MainShopEnergyMonthCardTips:NotEnoughMoney()
  local totalCurrency = ItemDataUtils.GetItemNum(self.model.costItemTid) or 0
  return totalCurrency < self.model.price
end

function MainShopEnergyMonthCardTips:PurchaseCallBack()
  MainShopDataUtils.RequestMonthCardInfo(function(svrData)
    MainShopDataUtils.UpdateEnergyMonthBySvrData(svrData)
  end, CommonDefine.MonthCardType.Energy)
  self:Close()
end

function MainShopEnergyMonthCardTips:OnClickCancel()
  self:Close()
end

return MainShopEnergyMonthCardTips
