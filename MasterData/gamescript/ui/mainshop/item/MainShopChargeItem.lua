local MainShopChargeItem, Super = System.NewComponent("MainShopChargeItem")

function MainShopChargeItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Recharge_Reset_ItemResource(uiNode)
  self.chargeId = data.chargeId
  self.seniorMoneyId = CommonDefine.CurrencyType.SeniorMoney
  self.config = DT.Charge[self.chargeId]
  self.isDouble = data.isDouble
  self.sdkData = data.sdkData
  self.defaultPrice = data.defaultPrice
end

function MainShopChargeItem:OnBind(binder)
  self.binder = binder
  local itemGetNum = self.config.ItemGet and table.values(self.config.ItemGet)[1] or 0
  local firstPayGet = self.config.FirstPayGet and table.values(self.config.FirstPayGet)[1] or 0
  local nonFirstPayGet = self.config.nonFirstPayGet and table.values(self.config.nonFirstPayGet)[1] or 0
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if SteamSdk.Instance:IsNativeSteamSdk() then
      SteamSdk.Instance:CreateOrder(self.config.ID)
      return
    end
    SdkMgr.Instance:Pay(self.config.PayCode, self.config.ID)
  end)
  binder:BindToText(self.ui.Text_Double_Num, function()
    do return LT.Text, string.format("+%s", firstPayGet) end
    return LT.Text, string.format("+%s", firstPayGet)
  end)
  binder:BindToText(self.ui.Text_Extra_Num, function()
    do return LT.Text, string.format("+%s", nonFirstPayGet) end
    return LT.Text, string.format("+%s", nonFirstPayGet)
  end)
  binder:BindToText(self.ui.Text_Get_Tips, function()
    do return LT.Textf, "ShopChargeDesc", itemGetNum, LT.Text(DT.Item[CommonDefine.CurrencyType.PayMoney].Name) end
    return LT.Textf, "ShopChargeDesc", itemGetNum, LT.Text(DT.Item[CommonDefine.CurrencyType.PayMoney].Name)
  end)
  self:BindShowPrice()
  binder:BindToVisible(self.ui.Group_Nor, function()
    if 0 == nonFirstPayGet then
      return false
    end
    return not self.isDouble
  end)
  binder:BindToVisible(self.ui.Group_Double, function()
    return self.isDouble
  end)
  binder:BindToImage(self.ui.Image_Reset_Icon, function()
    return self.config.Icon or ""
  end)
  binder:BindToImage(self.ui.Image_Double_Icon, function()
    local itemTid = ChargeCfgUtils.GetFirstPayGetItemTid(self.chargeId)
    if not itemTid then
      return ""
    end
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, itemTid
  end)
  binder:BindToImage(self.ui.Image_Extra_Icon, function()
    local itemTid = ChargeCfgUtils.GetNonFirstPayGetGetItemTid(self.chargeId)
    if not itemTid then
      return ""
    end
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, itemTid
  end)
end

function MainShopChargeItem:ParseStrDot(str)
  local dotIndex = string.find(str, "%.")
  local beforeDot, afterDot
  if dotIndex then
    beforeDot = string.sub(str, 1, dotIndex - 1)
    afterDot = string.sub(str, dotIndex)
  end
  return beforeDot, afterDot
end

function MainShopChargeItem:GetShowCountryCode()
  local showCountryCode = SdkMgr.Instance.model.countryCode
  if SdkMgr.Instance:CheckIsGWPackage() or SdkMgr.Instance.model.countryCode == CommonDefine.CountryCode.CN then
    showCountryCode = CommonDefine.CountryCode.US
  end
  return showCountryCode
end

function MainShopChargeItem:BindShowPrice()
  local showCountryCode = self:GetShowCountryCode()
  local symbol = self.config.RegionPriceSymbol[showCountryCode] or ""
  local price = tostring(self.config.RegionPrice[showCountryCode]) or ""
  local haveDot = string.find(price, "%.")
  self.binder:BindToText(self.ui.Text_Cost_Tips, function()
    local showPrice = price
    if "" ~= price and haveDot then
      local beforeStr, _ = self:ParseStrDot(price)
      showPrice = beforeStr
    end
    do return LT.Text end
    return LT.Text, showPrice, price
  end)
  self.binder:BindToText(self.ui.Text_CostNun, function()
    if "" ~= price and haveDot then
      local _, afterStr = self:ParseStrDot(price)
      do return LT.Text end
      return LT.Text, afterStr
    end
    return ""
  end)
  self.binder:BindToText(self.ui.Text_Cost_Symbol, function()
    do return LT.Text, string.format("%s", symbol) end
    return LT.Text, string.format("%s", symbol)
  end)
end

return MainShopChargeItem
