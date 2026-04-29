_class("UIActivityN20ShopItem", UICustomWidget)
UIActivityN20ShopItem = UIActivityN20ShopItem

function UIActivityN20ShopItem:OnShow()
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._reamainCountLabel = self:GetUIComponent("UILocalizationText", "ReamainCount")
  self._counttLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._costLabel = self:GetUIComponent("UILocalizationText", "Cost")
  self._costIconLoader = self:GetUIComponent("RawImageLoader", "CostIcon")
  self._empty = self:GetGameObject("Empty")
  self._go = self:GetGameObject()
end

function UIActivityN20ShopItem:SetVisible(status)
  self._go:SetActive(status)
end

function UIActivityN20ShopItem:Refresh(itemInfo, comp, callback)
  if itemInfo == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._empty:SetActive(false)
  self._itemInfo = itemInfo
  self._callback = callback
  if self._itemInfo.m_exchange_limit_count == -1 then
    self._reamainCountLabel:SetText(StringTable.Get("str_n20_item_unlimit_count"))
  else
    self._reamainCountLabel:SetText(self._itemInfo.m_can_exchange_count)
    if self._itemInfo.m_can_exchange_count == 0 then
      self._empty:SetActive(true)
    end
  end
  self._costLabel:SetText(self._itemInfo.m_cost_count)
  local itemId = self._itemInfo.m_reward.assetid
  local count = self._itemInfo.m_reward.count
  self._counttLabel:SetText("x" .. count)
  local cfgItem = Cfg.cfg_item[itemId]
  if not cfgItem then
    return
  end
  self._nameLabel:SetText(StringTable.Get(cfgItem.Name))
  local icon = ""
  local specialIconCfg = Cfg.cfg_activity_shop_special_item_icon_client[itemId]
  if specialIconCfg then
    icon = specialIconCfg.SpecialIcon
  else
    icon = cfgItem.Icon
  end
  self._iconLoader:LoadImage(icon)
  local icon1, realCount = comp:GetCostItemIconText()
  self._costIconLoader:LoadImage(icon1)
  if realCount >= self._itemInfo.m_cost_count then
    self._costLabel.color = Color(1, 1, 1, 1)
  else
    self._costLabel.color = Color(1, 0, 0, 1)
  end
end

function UIActivityN20ShopItem:BGOnClick()
  if self._itemInfo.m_exchange_limit_count ~= -1 and self._itemInfo.m_can_exchange_count == 0 then
    ToastManager.ShowToast(StringTable.Get("str_n20_item_has_empty_tips"))
    return
  end
  if self._callback then
    self._callback(self._itemInfo)
  end
end
