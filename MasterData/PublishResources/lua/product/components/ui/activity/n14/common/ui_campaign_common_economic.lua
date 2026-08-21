_class("UICampaignCommonEconomic", UICustomWidget)
UICampaignCommonEconomic = UICampaignCommonEconomic

function UICampaignCommonEconomic:OnShow()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtShopCount = self:GetUIComponent("UILocalizationText", "txtShopCount")
  self:AttachEvent(GameEventType.ItemCountChanged, self.FlushCurrencyCount)
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.FlushCurrencyCount)
end

function UICampaignCommonEconomic:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.FlushCurrencyCount)
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.FlushCurrencyCount)
  self.imgIcon:DestoryLastImage()
end

function UICampaignCommonEconomic:Flush()
  self.data = N14Data:New()
  local res = self.data:RequestCampaign(TaskToken:New(), ECampaignType.CAMPAIGN_TYPE_N14)
  if res then
  end
  self:FlushCurrencyIcon()
  self:FlushCurrencyCount()
end

function UICampaignCommonEconomic:FlushCurrencyIcon()
  local currencyId = self.data:GetCurrencyId()
  local cfgItem = Cfg.cfg_item[currencyId]
  if cfgItem then
    self.imgIcon:LoadImage(cfgItem.Icon)
  end
end

function UICampaignCommonEconomic:FlushCurrencyCount()
  local currencyId = self.data:GetCurrencyId()
  local count = self:GetModule(ItemModule):GetItemCount(currencyId) or 0
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#545454>%s</color><color=#fff0ad>%s</color>", preZero, tostring(count))
  self.txtShopCount:SetText(fmtStr)
end
