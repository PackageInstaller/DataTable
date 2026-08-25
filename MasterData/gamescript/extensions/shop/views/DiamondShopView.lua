local CostItemTid = CommonDefine.CurrencyType.PayMoney
local BuyItemTid = CommonDefine.CurrencyType.SeniorMoney
local MinBuyNum = 0
local ChangeNumPerClick = tonumber(DT.GetConstant("ExchangeNumAddPerClick"))
local ExchangeNumPerGold = 1
local DiamondShopView, Super = NewClass("DiamondShopView", BaseView)
DiamondShopView.uiResCls = UI_Other_Donate_TipsResource

function DiamondShopView:OnBuildView()
  Super.OnBuildView(self)
  self:SetText(self.ui.Text_Describe, LT.Text("DiamondDonateDesc"))
  self:SetText(self.ui.Text_Source, ItemDataUtils.GetItemName(CostItemTid))
  self:SetText(self.ui.Text_Core, ItemDataUtils.GetItemName(BuyItemTid))
  self:SetButtonText(self.ui.Btn_Confirm, LT.Text("Event_ItemUseConfirm"))
  local currencyList = DT.Constant.ExchangePanelCurrencies.Data
  self:AddViewComponentOnce(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, currencyList, nil, true)
end

function DiamondShopView:RegisterEvents()
  Super.RegisterEvents(self)
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Max, System.fn(self, self._OnClickMax))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Min, System.fn(self, self._OnClickMin))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Add, System.fn(self, self._OnOnClickAdd))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Subtract, System.fn(self, self._OnClickSubtract))
  self:AddButtonClickListener(self.ui.Btn_Fund, System.fn(self, self._OnClickFund))
  self:AddInputValueChangeListener(self.ui.InputField_Account, function()
    self:_SetBuyNum(tonumber(self:GetInputText(self.ui.InputField_Account)) or 0)
  end)
  self:AddButtonClickListener(self.ui.Btn_Mask, function()
    self:Close()
  end)
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, function()
    self:Close()
  end)
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
end

function DiamondShopView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
  self:RegisterNotify(NotifyId.OnGetDiamondExchangeAwards, self._OnGetDiamondExchangeAwards, self)
end

function DiamondShopView:OnEnterView()
  Super.OnEnterView(self)
  self:_SetBuyNum(ChangeNumPerClick)
end

function DiamondShopView:_SetBuyNum(num)
  self.curBuyNum = math.max(MinBuyNum, num)
  self.curCostCurrencyNum = self.curBuyNum * ExchangeNumPerGold
  self:_RefreshView()
end

function DiamondShopView:_RefreshView()
  self:SetText(self.ui.Text_Number, MainShopDataUtils.GetExchangeNum())
  self:_RefreshCostItemNum()
  self:_RefreshReddot()
end

function DiamondShopView:_RefreshReddot()
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, nil, function()
    if DiamondShopDataUtils.ExistDiamondExchangeCanReceived() then
      return RedPointDataUtils.RedAttrType.Red
    end
    return false
  end)
end

function DiamondShopView:_RefreshCostItemNum()
  self:SetInputText(self.ui.InputField_Account, self.curBuyNum)
  local curCostCurrencyNum = self.curCostCurrencyNum
  local textColor = CommonDefine.ColorType.Dark
  if curCostCurrencyNum <= ItemDataUtils.GetItemNum(CostItemTid) then
    textColor = CommonDefine.ColorType.Light
  end
  self:SetText(self.ui.Text_Currency, curCostCurrencyNum)
  self:SetTextColorType(self.ui.Text_Currency, textColor)
end

function DiamondShopView:_OnClickMax()
  self:_SetBuyNum(ItemDataUtils.GetItemNum(CostItemTid))
end

function DiamondShopView:_OnClickMin()
  self:_SetBuyNum(MinBuyNum)
end

function DiamondShopView:_OnOnClickAdd()
  self:_SetBuyNum(self.curBuyNum + ChangeNumPerClick)
end

function DiamondShopView:_OnClickSubtract()
  self:_SetBuyNum(self.curBuyNum - ChangeNumPerClick)
end

function DiamondShopView:_OnClickConfirm()
  if 0 == self.curBuyNum then
    Alert.ShowStr("ExchangeNumZeroText")
    return
  elseif ItemDataUtils.GetItemNum(CostItemTid) < self.curCostCurrencyNum then
    DiamondShopDataUtils.ChargeNotEnoughTips(System.fn(self, self.Close))
    return
  end
  DiamondShopDataUtils.ReqExchange(self.curCostCurrencyNum, function()
    if not self.ui or IsNil(self.ui.uiNode) then
      return
    end
    self:_RefreshView()
  end)
end

function DiamondShopView:_OnClickFund()
  UIManager.Instance:Reopen(Urls.DiamondDonateFundView)
end

function DiamondShopView:_OnBagItemDataChanged(uid, tid)
  if CostItemTid == tid then
    self.curBuyNum = ChangeNumPerClick
    self:_RefreshView()
  end
end

function DiamondShopView:_OnGetDiamondExchangeAwards()
  self:_RefreshReddot()
end

return DiamondShopView
