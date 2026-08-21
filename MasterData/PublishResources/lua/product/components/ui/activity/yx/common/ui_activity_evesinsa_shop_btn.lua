_class("UIActivityEveSinsaShopBtn", UICustomWidget)
UIActivityEveSinsaShopBtn = UIActivityEveSinsaShopBtn

function UIActivityEveSinsaShopBtn:_GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "_icon")
  self._numText = self:GetUIComponent("UILocalizationText", "_numText")
  self._titleText = self:GetUIComponent("UILocalizationText", "_titleText")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "_main")
  self._red = self:GetGameObject("_red")
end

function UIActivityEveSinsaShopBtn:OnShow()
  self:_GetComponents()
end

function UIActivityEveSinsaShopBtn:OnHide()
  self:_DetachEvents()
end

function UIActivityEveSinsaShopBtn:SetData(campaign, redFlag, disableClick)
  self._campaign = campaign
  self._redFlag = redFlag
  if disableClick then
    self._canvasGroup.blocksRaycasts = false
  else
    self._canvasGroup.blocksRaycasts = true
  end
  self:_AttachEvents()
  local shopCfg = Cfg.cfg_activity_shop_common_client[self._campaign._id]
  self._currencyId = shopCfg.CurrencyId
  local totalNum = ClientCampaignShop.GetMoney(self._currencyId)
  self._numText:SetText(totalNum)
  self._icon:LoadImage(ClientCampaignShop.GetCurrencyImageName(shopCfg.CurrencyId))
  if self._titleText then
    self._titleText:SetText(StringTable.Get("str_activity_evesinsa_shop_name"))
  end
  self:_CheckActivityShopRedPoint()
end

function UIActivityEveSinsaShopBtn:btnOnClick()
  Log.info("UIActivityEveSinsaShopBtn:btnOnClick")
  ClientCampaignShop.OpenCampaignShop(self._campaign._type, self._campaign._id)
end

function UIActivityEveSinsaShopBtn:_AttachEvents()
  if self._redFlag then
    self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  end
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
end

function UIActivityEveSinsaShopBtn:_DetachEvents()
  if self._redFlag then
    self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  end
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
end

function UIActivityEveSinsaShopBtn:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckActivityShopRedPoint()
  end
end

function UIActivityEveSinsaShopBtn:_OnItemCountChanged()
  local totalNum = ClientCampaignShop.GetMoney(self._currencyId)
  self._numText:SetText(totalNum)
end

function UIActivityEveSinsaShopBtn:_CheckActivityShopRedPoint()
  if self._red then
    local bShow = self._redFlag and self._campaign:CheckComponentRed(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_EXCHANGE1, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_EXCHANGE2)
    self._red:SetActive(bShow)
  end
end
