_class("UIN18CampaignEconomic", UICustomWidget)
UIN18CampaignEconomic = UIN18CampaignEconomic

function UIN18CampaignEconomic:OnShow()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtShopCount = self:GetUIComponent("UILocalizationText", "txtShopCount")
  self:AttachEvent(GameEventType.ItemCountChanged, self.FlushCurrencyCount)
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.FlushCurrencyCount)
end

function UIN18CampaignEconomic:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.FlushCurrencyCount)
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.FlushCurrencyCount)
  self.imgIcon:DestoryLastImage()
end

function UIN18CampaignEconomic:Flush()
  self.data = N18Data:New()
  local res = self.data:RequestCampaign(TaskToken:New(), ECampaignType.CAMPAIGN_TYPE_N18)
  if res then
  end
  self:FlushCurrencyIcon()
  self:FlushCurrencyCount()
end

function UIN18CampaignEconomic:FlushCurrencyIcon()
  local currencyId = self.data:GetCurrencyId()
  local cfgItem = Cfg.cfg_item[currencyId]
  if cfgItem then
    self.imgIcon:LoadImage(cfgItem.Icon)
  end
end

function UIN18CampaignEconomic:FlushCurrencyCount()
  local currencyId = self.data:GetCurrencyId()
  local count = self:GetModule(ItemModule):GetItemCount(currencyId) or 0
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#6D6862>%s</color><color=#F1D670>%s</color>", preZero, tostring(count))
  self.txtShopCount:SetText(fmtStr)
end
