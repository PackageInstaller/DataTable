_class("UIXH1ShopItemSmall", UICustomWidget)
UIXH1ShopItemSmall = UIXH1ShopItemSmall

function UIXH1ShopItemSmall:OnShow(uiParams)
  self:InitWidget()
end

function UIXH1ShopItemSmall:InitWidget()
  self._infoCanvasGroup = self:GetUIComponent("CanvasGroup", "InfoArea")
  self._selledAreaGO = self:GetGameObject("SelledArea")
  self._infoBg = self:GetUIComponent("Image", "InfoBg")
  self._disabledInfoBg = self:GetUIComponent("Image", "DisabledInfoBg")
  self._itemNameText = self:GetUIComponent("UILocalizationText", "ItemNameText")
  self._itemIcon = self:GetUIComponent("RawImageLoader", "ItemIcon")
  self._itemIconGO = self:GetGameObject("ItemIcon")
  self._itemIconPet = self:GetUIComponent("RawImageLoader", "ItemIconPet")
  self._itemIconPetGO = self:GetGameObject("ItemIconPet")
  self._itemIconPetRect = self:GetUIComponent("RectTransform", "ItemIconPet")
  self._itemCountText = self:GetUIComponent("UILocalizationText", "ItemCountText")
  self._itemCountAreaGO = self:GetGameObject("ItemCountArea")
  self._itemRestText = self:GetUIComponent("UILocalizationText", "ItemRestText")
  self._itemRestAreaGO = self:GetGameObject("ItemRestArea")
  self._moneyIcon = self:GetUIComponent("RawImageLoader", "MoneyIcon")
  self._priceText = self:GetUIComponent("UILocalizationText", "PriceText")
  self._data = {}
  self._itemClickLock = "UICampaignShopSelectItemLock"
  self.trans = self:GetGameObject().transform
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self._ActivityShopBuySuccess)
end

function UIXH1ShopItemSmall:OnHide()
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self._ActivityShopBuySuccess)
end

function UIXH1ShopItemSmall:SetData()
end

function UIXH1ShopItemSmall:InfoAreaOnClick(go)
  local useNormalDlg = false
  if not self._data:IsUnLimit() then
    local remainCount = self._data:GetRemainCount()
    if remainCount <= 0 then
      return
    end
    if remainCount == 1 then
      useNormalDlg = true
    end
  end
  self:StartTask(function(TT)
    self:Lock(self._itemClickLock)
    if useNormalDlg then
      self:ShowDialog("UICampaignShopConfirmNormalController", self._data, self.subTabType)
    else
      self:ShowDialog("UICampaignShopConfirmDetailController", self._data, self.subTabType)
    end
    self:UnLock(self._itemClickLock)
  end)
end

function UIXH1ShopItemSmall:InitData(data)
  self._data = data
  self:_fillPriceArea()
  self:_fillItemBaseArea()
  self:_fillItemCountArea()
  self:_FillRemainArea()
end

function UIXH1ShopItemSmall:_fillPriceArea()
  local currencyId = self._data:GetSaleType()
  self._moneyIcon:LoadImage(ClientCampaignShop.GetCurrencyImageName(currencyId))
  self._priceText:SetText(self._data:GetSalePrice())
end

function UIXH1ShopItemSmall:_fillItemBaseArea()
  local icon = ""
  local cfgItem = Cfg.cfg_item[self._data:GetItemId()]
  if not cfgItem then
    return
  end
  self._itemNameText:SetText(StringTable.Get(cfgItem.Name))
  local specialIconCfg = Cfg.cfg_activity_shop_special_item_icon_client[self._data:GetItemId()]
  if specialIconCfg and specialIconCfg.UseInSmallCell then
    icon = specialIconCfg.SpecialIcon
    self._itemIconPet:LoadImage(icon)
    self._itemIconGO:SetActive(false)
    self._itemIconPetGO:SetActive(true)
    if specialIconCfg.PosInSmallCell then
      local b = string.split(specialIconCfg.PosInSmallCell, "|")
      local posX = tonumber(b[1])
      local posY = tonumber(b[2])
      self._itemIconPetRect.anchoredPosition = Vector2(posX, posY)
    end
    if specialIconCfg.SizeInSmallCell then
      local b = string.split(specialIconCfg.SizeInSmallCell, "|")
      local w = tonumber(b[1])
      local h = tonumber(b[2])
      self._itemIconPetRect.sizeDelta = Vector2(w, h)
    end
  else
    icon = cfgItem.Icon
    self._itemIcon:LoadImage(icon)
    self._itemIconGO:SetActive(true)
    self._itemIconPetGO:SetActive(false)
  end
end

function UIXH1ShopItemSmall:_fillItemCountArea()
  local count = self._data:GetItemCount()
  local text1 = count <= 1 and "" or StringTable.Get("str_shop_good_count") .. count
  if count <= 1 then
    self._itemCountAreaGO:SetActive(false)
  else
    self._itemCountAreaGO:SetActive(true)
    local text1 = StringTable.Get("str_shop_good_count") .. count
    self._itemCountText:SetText(text1)
  end
end

function UIXH1ShopItemSmall:_FillRemainArea()
  local showRemain = self._data:ShowRemain()
  local remainCount = self._data:GetRemainCount()
  if showRemain == false then
    self._itemRestAreaGO:SetActive(false)
  elseif self._data:IsUnLimit() then
    self._itemRestAreaGO:SetActive(false)
  elseif remainCount <= 0 then
    self._itemRestAreaGO:SetActive(false)
  else
    self._itemRestAreaGO:SetActive(true)
    self._itemRestText:SetText(StringTable.Get("str_activity_evesinsa_shop_remain", remainCount))
  end
  if self._data:IsUnLimit() then
    self._selledAreaGO:SetActive(false)
    self._infoCanvasGroup.blocksRaycasts = true
  elseif remainCount <= 0 then
    self._selledAreaGO:SetActive(true)
    self._infoCanvasGroup.blocksRaycasts = false
  else
    self._selledAreaGO:SetActive(false)
    self._infoCanvasGroup.blocksRaycasts = true
  end
end

function UIXH1ShopItemSmall:_ActivityShopBuySuccess(goodsId)
  if self._data and self._data:GetGoodsId() == goodsId then
    local remainCount = self._data:GetRemainCount()
    if remainCount <= 0 then
    end
  end
end
