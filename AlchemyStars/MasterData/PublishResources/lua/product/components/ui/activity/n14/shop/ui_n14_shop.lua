_class("UIN14Shop", UIActivityShopControllerBase)
UIN14Shop = UIN14Shop

function UIN14Shop:Constructor()
  UIN14Shop.super.Constructor(self)
  UIActivityShopControllerBase.ItemGroupHeight = 682
end

function UIN14Shop:OnShow(uiParams)
  UIN14Shop.super.OnShow(self, uiParams)
  self.txtShopName = self:GetUIComponent("UILocalizedTMP", "txtShopName")
  self.txtShopName:SetText(StringTable.Get("str_N14_shop_name"))
  self.req = ResourceManager:GetInstance():SyncLoadAsset("ui_N14_shop_name.mat", LoadType.Mat)
  if self.req and self.req.Obj then
    self.mat = self.req.Obj
    self.txtShopName.fontMaterial = self.mat
  end
end

function UIN14Shop:DefaultBackFunc()
  self:SwitchState(UIStateType.UIN14Main)
end

function UIN14Shop:_RefreshCurrency()
  if not self._currencyId then
    self._currencyId = self._commonCfg.CurrencyId
  end
  local count = self:GetModule(ItemModule):GetItemCount(self._currencyId) or 0
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#545454>%s</color><color=#fff0ad>%s</color>", preZero, tostring(count))
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
