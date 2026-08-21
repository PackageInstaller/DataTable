_class("UISimpleHauteCoutureShopItem", UICustomWidget)
UISimpleHauteCoutureShopItem = UISimpleHauteCoutureShopItem

function UISimpleHauteCoutureShopItem:OnShow()
  self:_GetComponents()
  self:GetComponents()
  self._canBuy = true
end

function UISimpleHauteCoutureShopItem:_GetComponents()
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
end

function UISimpleHauteCoutureShopItem:SetVisible(status)
  self._go:SetActive(status)
end

function UISimpleHauteCoutureShopItem:Refresh(itemInfo, comp, randomLotteryComponent, callback)
  self._randomLotteryComponent = randomLotteryComponent
  self._cfgMain = self._randomLotteryComponent:GetCfgMain()
  if itemInfo == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._itemInfo = itemInfo
  self._callback = callback
  if self._itemInfo.m_exchange_limit_count == -1 then
    self._empty:SetActive(false)
    self._reamainCountLabel:SetText(StringTable.Get("str_junior_skin_draw_shop_item_unlimit_count"))
  else
    self._reamainCountLabel:SetText(StringTable.Get("str_junior_skin_draw_shop_item_count", "x" .. self._itemInfo.m_can_exchange_count))
    if self._itemInfo.m_can_exchange_count == 0 then
      self._empty:SetActive(true)
      self._canBuy = false
    else
      self._empty:SetActive(false)
      self._canBuy = true
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
  self._iconLoader:LoadImage(cfgItem.Icon)
  local icon1, realCount = comp:GetCostItemIconText()
  self._costIconLoader:LoadImage(icon1)
  if realCount >= self._itemInfo.m_cost_count then
    self._costLabel:SetText("<color=#ffffff>" .. self._itemInfo.m_cost_count .. "</color>")
  else
    self._costLabel:SetText("<color=#DE4242>" .. self._itemInfo.m_cost_count .. "</color>")
  end
  self:OnRefresh()
  if self._itemInfo.m_is_special then
    local petModule = self:GetModule(PetModule)
    local hasSkin = petModule:HaveSkin(self._cfgMain.SkinID)
    if hasSkin then
      self._canBuy = false
      self._empty:SetActive(true)
      self._reamainCountLabel:SetText(StringTable.Get("str_junior_skin_draw_shop_item_count", "x0"))
    end
    self._iconLoader:LoadImage(self._cfgMain.GoodPic)
  end
end

function UISimpleHauteCoutureShopItem:GetComponents()
end

function UISimpleHauteCoutureShopItem:OnRefresh()
end

function UISimpleHauteCoutureShopItem:BGOnClick()
  if not self._canBuy then
    ToastManager.ShowToast(StringTable.Get("str_junior_skin_draw_common_shop_item_has_empty_tips"))
    return
  end
  if self._callback then
    self._callback(self._itemInfo)
  end
end
