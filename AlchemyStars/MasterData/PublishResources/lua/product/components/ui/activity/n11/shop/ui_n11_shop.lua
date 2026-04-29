_class("UIN11Shop", UIActivityShopControllerBase)
UIN11Shop = UIN11Shop

function UIN11Shop:Constructor()
  UIN11Shop.super.Constructor(self)
  UIActivityShopControllerBase.ItemGroupHeight = 682
  self.strsLeftTime = {
    "str_n11_shop_open_left_time_d_h",
    "str_n11_shop_open_left_time_h_m",
    "str_n11_shop_open_left_time_m"
  }
end

function UIN11Shop:OnShow(uiParams)
  UIN11Shop.super.OnShow(self, uiParams)
  self.txtShopName = self:GetUIComponent("UILocalizedTMP", "txtShopName")
  self.req = ResourceManager:GetInstance():SyncLoadAsset("ui_n11_shop_name.mat", LoadType.Mat)
  if self.req and self.req.Obj then
    self.mat = self.req.Obj
    local oldMaterial = self.txtShopName.fontMaterial
    self.txtShopName.fontMaterial = self.mat
    self.txtShopName.fontMaterial:SetTexture("_MainTex", oldMaterial:GetTexture("_MainTex"))
  end
end

function UIN11Shop:DefaultBackFunc()
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  mCampaign:CampaignSwitchState(true, UIStateType.UIN11Main, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN11Shop:_RefreshCurrency()
  if not self._currencyId then
    self._currencyId = self._commonCfg.CurrencyId
  end
  local count = self:GetModule(ItemModule):GetItemCount(self._currencyId) or 0
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#545454>%s</color><color=#F2C641>%s</color>", preZero, tostring(count))
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

function UIN11Shop:_ShowRemainingTime()
  UIN11Main.FlushCDText(self._endTimeText, self._shopCloseTime, self.strsLeftTime, true)
end
