_class("UIActivityN31ShopItem", UICustomWidget)
UIActivityN31ShopItem = UIActivityN31ShopItem

function UIActivityN31ShopItem:Constructor()
end

function UIActivityN31ShopItem:OnShow()
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
  self._empty = self:GetGameObject("Empty")
  self._go = self:GetGameObject()
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._bg = self:GetUIComponent("Image", "BG")
  self._emptyAnim = self:GetUIComponent("Animation", "Empty")
end

function UIActivityN31ShopItem:SetVisible(status)
  self._go:SetActive(status)
  if status then
    self._anim:Play("uieff_N31_ShopBigItem")
  end
end

function UIActivityN31ShopItem:Refresh(itemInfo, comp, goodID, callback, playAnim)
  if itemInfo == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._itemInfo = itemInfo
  self._callback = callback
  local itemId = self._itemInfo.m_reward.assetid
  local count = self._itemInfo.m_reward.count
  self._counttLabel:SetText("x" .. count)
  local cfgItem = Cfg.cfg_item[itemId]
  if not cfgItem then
    return
  end
  self._nameLabel:SetText(StringTable.Get(cfgItem.Name))
  local specialIconCfg = Cfg.cfg_activity_shop_special_item_icon_client[itemId]
  if self._itemInfo.m_exchange_limit_count == -1 then
    self._empty:SetActive(false)
    self._reamainCountLabel:SetText(StringTable.Get("str_n31_item_unlimit_count"))
  else
    self._reamainCountLabel:SetText("x" .. self._itemInfo.m_can_exchange_count)
    if self._itemInfo.m_can_exchange_count == 0 then
      self._empty:SetActive(true)
      if goodID and goodID == itemInfo.m_id then
        local animStr = "uieff_UIActivityN31ShopSmallItem_Finish"
        if goodID <= 3 then
          animStr = "uieff_UIActivityN31Shop_BigItem_Finish"
        end
        self._emptyAnim:Play(animStr)
      end
    else
      self._empty:SetActive(false)
    end
  end
  if playAnim then
    if self._itemInfo.m_is_special then
      self._anim:Play("uieff_N31_ShopBigItem")
    else
      self._anim:Play("uieff_N31_ShopSmallItem")
    end
  end
  self._icon:SetActive(itemInfo.m_id ~= 1)
  self._petIcon:SetActive(itemInfo.m_id == 1)
  if itemInfo.m_id == 1 then
    self._petIconLoader:LoadImage(specialIconCfg.SpecialIcon)
  else
    self._iconLoader:LoadImage(cfgItem.Icon)
  end
  local icon1, realCount = comp:GetCostItemIconText()
  self._costIconLoader:LoadImage(icon1)
  local showNumberTex = "<color=#E00000>" .. self._itemInfo.m_cost_count .. "</color>"
  if realCount >= self._itemInfo.m_cost_count then
    self._costLabel:SetText(self._itemInfo.m_cost_count)
  else
    self._costLabel:SetText(showNumberTex)
  end
end

function UIActivityN31ShopItem:BGOnClick()
  if self._itemInfo.m_exchange_limit_count ~= -1 and self._itemInfo.m_can_exchange_count == 0 then
    ToastManager.ShowToast(StringTable.Get("str_n31_item_has_empty_tips"))
    return
  end
  if self._callback then
    self._callback(self._itemInfo)
  end
end
