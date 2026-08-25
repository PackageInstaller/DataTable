local featrueItemMap = {
  [CommonDefine.CurrencyType.Energy] = CommonDefine.FeatureId.ResCopy
}
local CommonCurrencyGroupItem, Super = System.NewComponent("CommonCurrencyGroupItem")

function CommonCurrencyGroupItem:ctor(uiNode, coinList, showBg, hidePlusBtn, clickBlockFilter)
  Super.ctor(self)
  self.ui = UI_Common_Item_Coin_GroupResource(uiNode)
  self.coinList = coinList
  self.showBg = showBg and true or false
  self.hidePlusBtn = hidePlusBtn and true or false
  self.clickBlockFilter = clickBlockFilter
end

function CommonCurrencyGroupItem:OnBind(binder)
  self.binder = binder
  if self.ui.Image then
    self.ui.Image:SetActive(self.showBg)
  end
  for index = 1, 5 do
    local coinUI = self.ui["Coin_" .. index]
    local coinId = self.coinList and self.coinList[index] or nil
    if coinId then
      if coinId and not coinUI then
        coinUI = self.binder:Instantiate(self.ui.Coin_1, self.ui.uiNode.transform)
      end
      binder:BindToRaw(function(itemBinder, nVal)
        itemBinder:SetActive(coinUI, nVal)
        if nVal then
          local clickCallBack
          if not self.hidePlusBtn then
            clickCallBack = CurrencyDefine.CurrencyBuyFunc[coinId]
          end
          itemBinder:BindComponent(CoinInfoComponent(coinUI, coinId, clickCallBack, nil, self.clickBlockFilter))
        end
      end, function()
        return coinId and self.IsFeatrueUnlockItem(coinId)
      end)
    elseif coinUI then
      coinUI:SetActive(false)
    end
  end
end

function CommonCurrencyGroupItem.IsFeatrueUnlockItem(itemTid)
  if featrueItemMap[itemTid] then
    local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.ResCopy, 0)
    return unlock
  end
  return true
end

function CommonCurrencyGroupItem:OnOpenChargePanel()
  UIManager.Instance:CloseByUrl(Urls.AlertConfirm2Panel)
  UIManager.Instance:Reopen(Urls.ChargeMainPanel)
end

function CommonCurrencyGroupItem:OpenResidentSummonMoneyBuyPanel()
  SummonDataUtils.OpenItemBuyPanel(17681)
end

function CommonCurrencyGroupItem:OpenSpecialSummonMoneyBuyPanel()
  SummonDataUtils.OpenItemBuyPanel(17627)
end

function CommonCurrencyGroupItem:_OpenTicketBuyConfirmPanel()
  MainShopViewUtils.OpenActivityTicketBuyPanel(CommonDefine.CurrencyType.SummerChapter1Ticket)
end

return CommonCurrencyGroupItem
