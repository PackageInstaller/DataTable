local DiamondShopPanel, Super = System.NewClass("DiamondShopPanel", UIBasePanel)
DiamondShopPanel.uiResCls = UI_Recharge_ExchangeResource

function DiamondShopPanel:ctor()
  Super.ctor(self)
end

function DiamondShopPanel:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(DiamondShopPanelModel)
  self.model = model
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnClickConfirm),
    stateFunc = function()
      local state = CommonDefine.BtnType.High
      return state
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.OnClickCancel)
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("ExchangeTitle")
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_M, commonPopupConfirmTipsData))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Max, System.fn(self, self.OnClickMax), function()
    local state = CommonDefine.BtnType.Normal
    return state
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Min, System.fn(self, self.OnClickMin), function()
    local state = CommonDefine.BtnType.Normal
    return state
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Add, System.fn(self, self.OnClickAdd), function()
    local state = CommonDefine.BtnType.Normal
    return state
  end, function()
    do return LT.Text end
    return LT.Text, "+"
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Subtract, System.fn(self, self.OnClickSubtract), function()
    local state = CommonDefine.BtnType.Normal
    return state
  end, function()
    do return LT.Text end
    return LT.Text, "-"
  end)
  binder:BindToText(self.ui.Text_Cost_Num, function()
    return self.model.curCostCurrencyNum
  end)
  binder:BindToRaw(function()
    FrameWaiter.OnNextFrame(function()
      CS.Framework.UIUtilTool.RefreshLayout(self.ui.Text_Cost_Num)
      CS.Framework.UIUtilTool.RefreshLayout(self.ui.Group_Cost)
    end)
  end, function()
    return self.model.curCostCurrencyNum
  end)
  binder:BindToTextColor(self.ui.Text_Cost_Num, function()
    local ret = CommonDefine.ColorType.Dark
    if ItemDataUtils.GetItemNum(self.model.costItemTid) >= self.model.curCostCurrencyNum then
      ret = CommonDefine.ColorType.Light
    end
    return ret
  end)
  binder:BindToText(self.ui.Text_Before, function()
    do return LT.Text, string.format("%s%s", DT.Item[CommonDefine.CurrencyType.PayMoney].Name, "x1") end
    return LT.Text, string.format("%s%s", DT.Item[CommonDefine.CurrencyType.PayMoney].Name, "x1")
  end)
  binder:BindToText(self.ui.Text_After, function()
    do return LT.Text, string.format("%s%s", DT.Item[CommonDefine.CurrencyType.SeniorMoney].Name, "x1") end
    return LT.Text, string.format("%s%s", DT.Item[CommonDefine.CurrencyType.SeniorMoney].Name, "x1")
  end)
  binder:BindToRaw(function(itemBinder, nVal, _)
    itemBinder:SetInputText(self.ui.InputField_Account, nVal)
  end, function()
    return self.model.curBuyNum
  end)
  binder:BindToInputValueChange(self.ui.InputField_Account, function()
    local newVal = tonumber(binder:GetInputText(self.ui.InputField_Account)) or 0
    self.model:UpdateBuyNum(newVal)
    binder:SetInputText(self.ui.InputField_Account, self.model.curBuyNum)
  end)
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, DT.Constant.ExchangePanelCurrencies.Data, true, true))
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  self:_OnBindAcculateExchange()
end

function DiamondShopPanel:_OnBindAcculateExchange()
  self.binder:BindToText(self.ui.Text_Quantity, function()
    do return LT.Text, MainShopDataUtils.GetExchangeNum() end
    return LT.Text, MainShopDataUtils.GetExchangeNum()
  end)
end

function DiamondShopPanel:OnClickMax()
  self.model:UpdateBuyNum(self.model.maxBuyNum)
end

function DiamondShopPanel:OnClickMin()
  self.model:UpdateBuyNum(self.model.minBuyNum)
end

function DiamondShopPanel:OnClickAdd()
  self.model:UpdateBuyNum(self.model.curBuyNum + self.model.changeNumPerClick)
end

function DiamondShopPanel:OnClickSubtract()
  self.model:UpdateBuyNum(self.model.curBuyNum - self.model.changeNumPerClick)
end

function DiamondShopPanel:OnClickConfirm()
  if 0 == self.model.curBuyNum then
    Alert.ShowStr("ExchangeNumZeroText")
    return
  elseif ItemDataUtils.GetItemNum(self.model.costItemTid) < self.model.curCostCurrencyNum then
    DiamondShopDataUtils.ChargeNotEnoughTips(System.fn(self, self.ClosePanel))
    return
  end
  local perPayBuyDiamond = 1
  self.model:SetCostCurrencyNum(math.ceil(self.model.curCostCurrencyNum / perPayBuyDiamond))
  DiamondShopDataUtils.ReqExchange(self.model.curCostCurrencyNum)
end

function DiamondShopPanel:OnClickCancel()
  self:ClosePanel()
end

function DiamondShopPanel:ClosePanel()
  self:Close()
end

return DiamondShopPanel
