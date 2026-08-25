local CurrencyDefine = {}
CurrencyDefine.CurrencyBuyFunc = {
  [CommonDefine.CurrencyType.Energy] = PlayerDataUtils.ShowEnergyRestorePanel,
  [CommonDefine.CurrencyType.SeniorMoney] = DiamondShopDataUtils.OpenRechargePanel,
  [CommonDefine.CurrencyType.PayMoney] = function()
    SdkMgr.Instance:OpenChargePanel()
  end,
  [CommonDefine.CurrencyType.SkinTicket] = TurntableDataUtils.ShowSkinTicketBuyPanel,
  [CommonDefine.CurrencyType.ResidentSummonMoney] = function()
    SummonDataUtils.OpenItemBuyPanel(17681)
  end,
  [CommonDefine.CurrencyType.SpecialSummonMoney] = function()
    SummonDataUtils.OpenItemBuyPanel(17627)
  end
}

function CurrencyDefine.AddBuyFunc(currencyId, buyFunc)
  CurrencyDefine.CurrencyBuyFunc[currencyId] = buyFunc
end

return CurrencyDefine
