_class("UIActivityReturnSystemItemShop", UICustomWidget)
UIActivityReturnSystemItemShop = UIActivityReturnSystemItemShop

function UIActivityReturnSystemItemShop:Constructor()
  self._itemColorFrame = {
    [ItemColor.ItemColor_White] = "shop_shenmi_pin1",
    [ItemColor.ItemColor_Green] = "shop_shenmi_pin2",
    [ItemColor.ItemColor_Blue] = "shop_shenmi_pin3",
    [ItemColor.ItemColor_Purple] = "shop_shenmi_pin4",
    [ItemColor.ItemColor_Yellow] = "shop_shenmi_pin5",
    [ItemColor.ItemColor_Golden] = "shop_shenmi_pin6"
  }
  self._itemClickLock = "UIShopSecretGoodSelectItemLock"
  self._inited = false
end

function UIActivityReturnSystemItemShop:OnShow()
  self._nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self._itemCountTxt = self:GetUIComponent("UILocalizationText", "itemcount")
  self._countPanelGO = self:GetGameObject("countpanel")
  self._price1Txt = self:GetUIComponent("UILocalizationText", "price")
  self._remainTxt = self:GetUIComponent("UILocalizationText", "remain")
  self._remainGO = self:GetGameObject("remaingo")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._qualityIcon = self:GetUIComponent("Image", "qualityIcon")
  self._tag = {}
  for i = 1, 3 do
    self._tag[i] = {}
    self._tag[i].tagGO = self:GetGameObject("tag" .. i)
    self._tag[i].txt = self:GetUIComponent("UILocalizationText", "tag" .. i .. "txt")
  end
  self._tag[1].tagGO:SetActive(false)
  self._moneyIcon1 = self:GetUIComponent("RawImageLoader", "moneyicon1")
  self._moneyIcon1GO = self:GetGameObject("moneyicon1")
  self._yuanjiaTxt = self:GetUIComponent("UILocalizationText", "yuanjia")
  self._xianjiaTxt = self:GetUIComponent("UILocalizationText", "xianjia")
  self._isSellGO = self:GetGameObject("issell")
  self._isSellTr = self:GetUIComponent("RectTransform", "issell")
  self._rectTrans = self:GetGameObject().transform:GetComponent("RectTransform")
  self._tagPanelGO = self:GetGameObject("alltag")
  self._alltagRect = self:GetUIComponent("RectTransform", "alltag")
  self._atlas = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
  self._uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._trans = self:GetGameObject().transform
  self._animation = self._trans:GetComponent("Animation")
  self._lockGo = self:GetGameObject("lock")
  self._maskTxt = self:GetUIComponent("UILocalizationText", "maskTxt")
  self:AttachEvent(GameEventType.ShopBuySuccess, self.ShopBuySuccess)
end

function UIActivityReturnSystemItemShop:Refresh(campaignShopItem, targetShopId, max)
  self.campaignShopItem = campaignShopItem
  self.targetShopId = targetShopId
  if not self.campaignShopItem then
    return
  end
  local cfgItem = Cfg.cfg_item[self.campaignShopItem:GetItemId()]
  if not cfgItem then
    return
  end
  if self.targetShopId and self.targetShopId == self.campaignShopItem:GetGoodsId() then
    self:bgOnClick()
  end
  local lockItem = self.campaignShopItem:UnlockItems()
  if lockItem then
    local unlockID = 0
    local unlockNum = 0
    for i, v in pairs(lockItem) do
      unlockID = i
      unlockNum = v
    end
    local historyCount = max
    if unlockNum > historyCount then
      self._maskTxt:SetText(StringTable.Get("str_shop_returnsystem_limit", unlockNum))
      self._isLock = true
      self._lockGo:SetActive(true)
    else
      self._isLock = false
      self._lockGo:SetActive(false)
    end
  else
    self._isLock = false
    self._lockGo:SetActive(false)
  end
  self._icon:LoadImage(cfgItem.Icon)
  if self._qualityIcon then
    local frameName = self._itemColorFrame[cfgItem.Color]
    if frameName ~= "" then
      self._qualityIcon.gameObject:SetActive(true)
      self._qualityIcon.sprite = self._atlas:GetSprite(frameName)
    else
      self._qualityIcon.gameObject:SetActive(false)
    end
  end
  self._nameTxt:SetText(StringTable.Get(cfgItem.Name))
  local count = self.campaignShopItem:GetItemCount()
  if count <= 1 then
    self._countPanelGO:SetActive(false)
  else
    self._countPanelGO:SetActive(true)
    self._itemCountTxt:SetText(count)
  end
  local showRemain = self.campaignShopItem:ShowRemain()
  local remainCount = self.campaignShopItem:GetRemainCount()
  if not showRemain then
    self._remainGO:SetActive(false)
  elseif self.campaignShopItem:IsUnLimit() then
    self._remainGO:SetActive(false)
  elseif remainCount <= 0 then
    self._remainGO:SetActive(false)
  else
    local max = self.campaignShopItem:GetRemainTotalCount()
    self._remainGO:SetActive(true)
    self._remainTxt:SetText(StringTable.Get("str_shop_secret_good_remain") .. remainCount)
  end
  if remainCount == 0 then
    self._isSellGO:SetActive(true)
  else
    self._isSellGO:SetActive(false)
  end
  local showTag = self.campaignShopItem:ShowSaleTag()
  if showTag then
    local saleTag = self.campaignShopItem:GetSaleTag()
    if saleTag == 1 then
      self._tag[2].tagGO:SetActive(true)
      self._tag[3].tagGO:SetActive(false)
    elseif 0 < saleTag and saleTag < 100 then
      self._tag[2].tagGO:SetActive(false)
      self._tag[3].tagGO:SetActive(true)
      local showDiscount = 100 - saleTag
      self._tag[3].txt:SetText("-" .. showDiscount .. "%")
    elseif saleTag == 0 then
      self._tag[2].tagGO:SetActive(false)
      self._tag[3].tagGO:SetActive(false)
    end
  else
    self._tag[2].tagGO:SetActive(false)
    self._tag[3].tagGO:SetActive(false)
  end
  self._moneyIcon1GO:SetActive(true)
  self._moneyIcon1:LoadImage("icon_item_3000291")
  self._price1Txt:SetText(self.campaignShopItem:GetSalePrice())
  if self._inited == false then
    self._animation:Play("uieff_ShopItem_In")
    self._inited = true
  else
    self._isSellTr.anchoredPosition = Vector2(self._isSellTr.anchoredPosition.x, 17.5)
    self._alltagRect.anchoredPosition = Vector2(self._alltagRect.anchoredPosition.x, 124.5)
  end
end

function UIActivityReturnSystemItemShop:OnHide()
  self:DetachEvent(GameEventType.ShopBuySuccess, self.ShopBuySuccess)
end

function UIActivityReturnSystemItemShop:ShopBuySuccess(goodId)
  if self.campaignShopItem and self.campaignShopItem:GetGoodsId() == goodId then
    local remainCount = self.campaignShopItem:GetRemainCount()
    if remainCount <= 0 then
    end
  end
end

function UIActivityReturnSystemItemShop:BgOnClick()
  if self._isLock then
    Log.debug("未达到该商品解锁目标")
    local lockItem = self.campaignShopItem:UnlockItems()
    local unlockID = 0
    local unlockNum = 0
    for i, v in pairs(lockItem) do
      unlockID = i
      unlockNum = v
    end
    local cfgItem = Cfg.cfg_item[self.campaignShopItem:GetItemId()]
    local name = StringTable.Get(cfgItem.Name)
    ToastManager.ShowToast(StringTable.Get("str_shop_returnsystem_lock", unlockNum, name))
    return
  end
  local remainCount = self.campaignShopItem:GetRemainCount()
  if remainCount == 0 then
    ToastManager.ShowToast(StringTable.Get("str_shop_returnsystem_empty"))
    return
  end
  if not self.campaignShopItem:ShowRemain() then
    self:ShowDialog("UICampaignShopConfirmDetailController", self.campaignShopItem, self.subTabType)
  else
    self:ShowDialog("UICampaignShopConfirmDetailController", self.campaignShopItem, self.subTabType)
  end
end
