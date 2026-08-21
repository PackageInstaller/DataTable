_class("UICampaignEconomic", UICustomWidget)
UICampaignEconomic = UICampaignEconomic

function UICampaignEconomic:OnShow()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtShopCount = self:GetUIComponent("UILocalizationText", "txtShopCount")
  self:AttachEvent(GameEventType.ItemCountChanged, self.FlushCurrencyCount)
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.FlushCurrencyCount)
  self.data = self:GetModule(CampaignModule):GetN11Data()
  self:Flush()
end

function UICampaignEconomic:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.FlushCurrencyCount)
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.FlushCurrencyCount)
  self.imgIcon:DestoryLastImage()
end

function UICampaignEconomic:Flush()
  self:FlushCurrencyIcon()
  self:FlushCurrencyCount()
end

function UICampaignEconomic:FlushCurrencyIcon()
  local currencyId = self.data:GetCurrencyId()
  local cfgItem = Cfg.cfg_item[currencyId]
  if cfgItem then
    self.imgIcon:LoadImage(cfgItem.Icon)
  end
end

function UICampaignEconomic:FlushCurrencyCount()
  local currencyId = self.data:GetCurrencyId()
  local count = self:GetModule(ItemModule):GetItemCount(currencyId) or 0
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#545454>%s</color><color=#F2C641>%s</color>", preZero, tostring(count))
  self.txtShopCount:SetText(fmtStr)
end
