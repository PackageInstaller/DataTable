_class("UISakuraDrawShopBtn", UICustomWidget)
UISakuraDrawShopBtn = UISakuraDrawShopBtn

function UISakuraDrawShopBtn:_GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "_icon")
  self._numText = self:GetUIComponent("UILocalizationText", "_numText")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "_main")
  self._red = self:GetGameObject("_red")
end

function UISakuraDrawShopBtn:OnShow()
  self:_GetComponents()
end

function UISakuraDrawShopBtn:OnHide()
  self:_DetachEvents()
end

function UISakuraDrawShopBtn:SetData(campaign, currencyId, redFlag, disableClick)
  self._campaign = campaign
  self._redFlag = redFlag
  if disableClick then
    self._canvasGroup.blocksRaycasts = false
  else
    self._canvasGroup.blocksRaycasts = true
  end
  self:_AttachEvents()
  self._currencyId = currencyId
  if not self._currencyId then
    local shopCfg = Cfg.cfg_activity_draw_shop_client[self._campaign._id]
    if shopCfg then
      self._currencyId = shopCfg.CurrencyId
    end
  end
  local totalNum = ClientCampaignDrawShop.GetMoney(self._currencyId)
  self._numText:SetText(totalNum)
  self._icon:LoadImage(ClientCampaignDrawShop.GetCurrencyImageName(self._currencyId))
  self:_CheckActivityShopRedPoint()
end

function UISakuraDrawShopBtn:btnOnClick()
  Log.info("UISakuraDrawShopBtn:btnOnClick")
  self:ShowDialog("UISakuraDrawShopController")
end

function UISakuraDrawShopBtn:_AttachEvents()
  if self._redFlag then
    self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  end
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
end

function UISakuraDrawShopBtn:_DetachEvents()
  if self._redFlag then
    self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  end
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
end

function UISakuraDrawShopBtn:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckActivityShopRedPoint()
  end
end

function UISakuraDrawShopBtn:_OnItemCountChanged()
  local totalNum = ClientCampaignDrawShop.GetMoney(self._currencyId)
  self._numText:SetText(totalNum)
end

function UISakuraDrawShopBtn:_CheckActivityShopRedPoint()
  if self._redFlag then
  else
    self._red:SetActive(false)
  end
  return
end
