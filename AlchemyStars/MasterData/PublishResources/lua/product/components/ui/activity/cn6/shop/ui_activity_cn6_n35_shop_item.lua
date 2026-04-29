_class("UIActivityCN6N35ShopItem", UICustomWidget)
UIActivityCN6N35ShopItem = UIActivityCN6N35ShopItem

function UIActivityCN6N35ShopItem:OnShow()
  self._petIcon = self:GetGameObject("PetIcon")
  self._petIconLoader = self:GetUIComponent("RawImageLoader", "PetIcon")
  self._petIconRect = self:GetUIComponent("RectTransform", "PetIcon")
  self._icon = self:GetGameObject("Icon")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._reamainCountLabel = self:GetUIComponent("UILocalizationText", "ReamainCount")
  self._counttLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._costLabel = self:GetUIComponent("UILocalizationText", "Cost")
  self._costIconLoader = self:GetUIComponent("RawImageLoader", "CostIcon")
  self._costRect = self:GetUIComponent("RectTransform", "CostRect")
  self._remainTitle = self:GetGameObject("RemainTitle")
  self._empty = self:GetGameObject("Empty")
  self._go = self:GetGameObject()
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIActivityCN6N35ShopItem:SetVisible(status)
  self._go:SetActive(status)
end

function UIActivityCN6N35ShopItem:Refresh(itemInfo, comp, callback)
  if itemInfo == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._itemInfo = itemInfo
  self._callback = callback
  if self._itemInfo.m_exchange_limit_count == -1 then
    self._empty:SetActive(false)
    self._reamainCountLabel.gameObject:SetActive(false)
    self._remainTitle:SetActive(false)
    if self._costRect then
      self._costRect.anchoredPosition = Vector2(-40, 0)
    end
  else
    self._reamainCountLabel:SetText("x" .. self._itemInfo.m_can_exchange_count)
    if self._itemInfo.m_can_exchange_count == 0 then
      self._empty:SetActive(true)
    else
      self._empty:SetActive(false)
    end
  end
  local itemId = self._itemInfo.m_reward.assetid
  local count = self._itemInfo.m_reward.count
  self._counttLabel:SetText("x" .. count)
  local cfgItem = Cfg.cfg_item[itemId]
  if not cfgItem then
    return
  end
  self._nameLabel:SetText(StringTable.Get(cfgItem.Name))
  local specialIconCfg = Cfg.cfg_activity_shop_special_item_icon_client[itemId]
  if specialIconCfg and specialIconCfg.UseInBigCell then
    self._petIconLoader:LoadImage(specialIconCfg.SpecialIcon)
    self._icon:SetActive(false)
    self._petIcon:SetActive(true)
    if specialIconCfg.PosInBigCell then
      local b = string.split(specialIconCfg.PosInBigCell, "|")
      local posX = tonumber(b[1])
      local posY = tonumber(b[2])
      self._petIconRect.anchoredPosition = Vector2(posX, posY)
    end
    if specialIconCfg.SizeInBigCell then
      local b = string.split(specialIconCfg.SizeInBigCell, "|")
      local w = tonumber(b[1])
      local h = tonumber(b[2])
      self._petIconRect.sizeDelta = Vector2(w, h)
    end
  else
    self._icon:SetActive(true)
    self._petIcon:SetActive(false)
    self._iconLoader:LoadImage(cfgItem.Icon)
  end
  local icon1, realCount = comp:GetCostItemIconText()
  self._costIconLoader:LoadImage(icon1)
  if realCount >= self._itemInfo.m_cost_count then
    self._costLabel:SetText(UIActivityCustomHelper.GetItemCountStr(6, self._itemInfo.m_cost_count, "#ffffff", "#ffffff"))
  else
    self._costLabel:SetText(UIActivityCustomHelper.GetItemCountStr(6, self._itemInfo.m_cost_count, "#ffffff", "#5df9ff"))
  end
end

function UIActivityCN6N35ShopItem:BGOnClick()
  if self._itemInfo.m_exchange_limit_count ~= -1 and self._itemInfo.m_can_exchange_count == 0 then
    return
  end
  if self._callback then
    self._callback(self._itemInfo)
  end
end
