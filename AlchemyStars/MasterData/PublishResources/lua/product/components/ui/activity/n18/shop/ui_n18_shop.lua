_class("UIN18Shop", UIActivityShopControllerBase)
UIN18Shop = UIN18Shop

function UIN18Shop:Constructor()
  UIN18Shop.super.Constructor(self)
  UIActivityShopControllerBase.ItemGroupHeight = 682
end

function UIN18Shop:DefaultBackFunc()
  self:SwitchState(UIStateType.UIN18Main)
end

function UIN18Shop:_RefreshCurrency()
  if not self._currencyId then
    self._currencyId = self._commonCfg.CurrencyId
  end
  local count = self:GetModule(ItemModule):GetItemCount(self._currencyId) or 0
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#6D6862>%s</color><color=#F1D670>%s</color>", preZero, tostring(count))
  self.itemCount:SetText(fmtStr)
  if self.pointIcon then
    local currencyIcon = ""
    local cfgItem = Cfg.cfg_item[self._currencyId]
    if cfgItem then
      currencyIcon = cfgItem.Icon
      self.pointIcon:LoadImage(currencyIcon)
    end
  end
end

function UIN18Shop:_GetFormatString(stamp)
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = StringTable.Get("str_activity_n16_shop_close_at", timeStr)
  return showStr
end
