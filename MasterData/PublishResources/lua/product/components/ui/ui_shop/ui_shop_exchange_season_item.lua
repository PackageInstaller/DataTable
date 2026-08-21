_class("UIShopExchangeSeasonItem", UICustomWidget)
UIShopExchangeSeasonItem = UIShopExchangeSeasonItem

function UIShopExchangeSeasonItem:OnShow()
  self.ItemColorFrame = {
    [ItemColor.ItemColor_White] = "shop_duihuan_di01",
    [ItemColor.ItemColor_Green] = "shop_duihuan_di02",
    [ItemColor.ItemColor_Blue] = "shop_duihuan_di03",
    [ItemColor.ItemColor_Purple] = "shop_duihuan_di04",
    [ItemColor.ItemColor_Yellow] = "shop_duihuan_di05",
    [ItemColor.ItemColor_Golden] = "shop_duihuan_di06"
  }
  self._itemClickLock = "UIShopSecretGoodSelectItemLock"
  self._inited = false
  self:GetComponents()
end

function UIShopExchangeSeasonItem:GetComponents()
  self.moneyIcon = self:GetUIComponent("Image", "moneyicon")
  self.countpanel = self:GetGameObject("countpanel")
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self.nameShadowTxt = self:GetUIComponent("UILocalizationText", "nameShadow")
  self.itemCountTxt = self:GetUIComponent("UILocalizationText", "itemcount")
  self.price1Txt = self:GetUIComponent("UILocalizationText", "price")
  self._GrandPrizeGo = self:GetGameObject("GrandPrize")
  self.Logo = self:GetUIComponent("RawImageLoader", "Logo")
  self.remainTxt = self:GetUIComponent("UILocalizationText", "remain")
  self.remainGO = self:GetGameObject("remaingo")
  self.LogoMask = self:GetGameObject("LogoMask")
  self.PetNameGo = self:GetGameObject("PetName")
  self._flagAreaGo = self:GetGameObject("FlagArea")
  self._specialFlagAreaGo = self:GetGameObject("SpecialFlagArea")
  self._specialFlagAreaEffGo = self:GetGameObject("SpecialFlagAreaEff")
  self._normalFlagAreaEffGo = self:GetGameObject("NormalFlagAreaEff")
  self.SkinName1Go = self:GetGameObject("SkinName1")
  self.SkinName2Go = self:GetGameObject("SkinName2")
  self.PetName = self:GetUIComponent("UILocalizationText", "PetName")
  self.SkinName1 = self:GetUIComponent("UILocalizedTMP", "SkinName1")
  self.SkinName2 = self:GetUIComponent("UILocalizedTMP", "SkinName2")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.qualityIcon = self:GetUIComponent("Image", "qualityIcon")
  self.uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.atlas = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
  self.animation = self:GetGameObject():GetComponent("Animation")
end

function UIShopExchangeSeasonItem:SetData(ExchangeShopGoods)
  self.goodData = ExchangeShopGoods
  self.subTabType = MarketType.Shop_Season
  if self.LogoMask then
    self.LogoMask:SetActive(false)
  end
  if self.PetNameGo then
    self.PetNameGo:SetActive(false)
  end
  if self.SkinName1Go then
    self.SkinName1Go:SetActive(false)
  end
  if self.SkinName2Go then
    self.SkinName2Go:SetActive(false)
  end
  if self._flagAreaGo then
    self._flagAreaGo:SetActive(false)
  end
  if self._specialFlagAreaGo then
    self._specialFlagAreaGo:SetActive(false)
  end
  if self._specialFlagAreaEffGo then
    self._specialFlagAreaEffGo:SetActive(false)
  end
  if self._normalFlagAreaEffGo then
    self._normalFlagAreaEffGo:SetActive(false)
  end
  local showIcon
  local itemid = self.goodData:GetItemId()
  if self.goodData:GrandPrize() and itemid >= RoleAssetID.RoleAssetPetSkinBegin and itemid <= RoleAssetID.RoleAssetPetSkinEnd then
    local skinid = itemid - RoleAssetID.RoleAssetPetSkinBegin
    local cfg_pet_skin = Cfg.cfg_pet_skin[skinid]
    showIcon = cfg_pet_skin.SkinShopCG
    local petid = cfg_pet_skin.PetId
    local cfg_pet = Cfg.cfg_pet[petid]
    local logo = cfg_pet.Logo
    self.LogoMask:SetActive(true)
    self.PetNameGo:SetActive(true)
    self.PetName:SetText(StringTable.Get(cfg_pet.Name))
    self._flagAreaGo:SetActive(cfg_pet_skin.SkinType == 2)
    self._specialFlagAreaGo:SetActive(cfg_pet_skin.SkinType == 3)
    self._specialFlagAreaEffGo:SetActive(cfg_pet_skin.SkinType == 3)
    self._normalFlagAreaEffGo:SetActive(cfg_pet_skin.SkinType ~= 3)
    self.SkinName2Go:SetActive(cfg_pet_skin.SkinType == 3)
    self.SkinName1Go:SetActive(cfg_pet_skin.SkinType ~= 3)
    self.SkinName1:SetText(StringTable.Get(cfg_pet_skin.SkinName))
    self.SkinName2:SetText(StringTable.Get(cfg_pet_skin.SkinName))
    self.Logo:LoadImage(logo)
  end
  local cfgItem = Cfg.cfg_item[itemid]
  showIcon = showIcon or cfgItem.Icon
  self.icon:LoadImage(showIcon)
  if self.qualityIcon then
    local frameName = self.ItemColorFrame[cfgItem.Color]
    if frameName ~= "" then
      self.qualityIcon.gameObject:SetActive(true)
      self.qualityIcon.sprite = self.atlas:GetSprite(frameName)
    else
      self.qualityIcon.gameObject:SetActive(false)
    end
  end
  self.nameTxt:SetText(StringTable.Get(cfgItem.Name))
  self.nameShadowTxt:SetText(StringTable.Get(cfgItem.Name))
  local count = self.goodData:GetItemCount()
  self.itemCountTxt:SetText(count)
  local showRemain = self.goodData:ShowRemain()
  local remainCount = self.goodData:GetRemainCount()
  if showRemain == false then
    self.remainGO:SetActive(false)
  elseif self.goodData:IsUnLimit() then
    self.remainGO:SetActive(false)
  elseif remainCount <= 0 then
    self.remainGO:SetActive(false)
  else
    local max = self.goodData:GetRemainTotalCount()
    self.remainGO:SetActive(true)
    self.remainTxt:SetText(StringTable.Get("str_shop_secret_good_remain") .. remainCount)
  end
  local saleTag = self.goodData:GetSeasonSaleTag()
  if self._GrandPrizeGo then
    self._GrandPrizeGo:SetActive(saleTag == 1)
  end
  self.price1Txt:SetText(self.goodData:GetSalePrice())
  local costItem = self.goodData:GetSaleType()
  self.moneyIcon.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(costItem))
end

function UIShopExchangeSeasonItem:OnHide()
end

function UIShopExchangeSeasonItem:BgOnClick()
  local remainCount = self.goodData:GetRemainCount()
  if remainCount <= 0 then
    return
  end
  if self.goodData:GetItemId() >= RoleAssetID.RoleAssetPetSkinBegin and self.goodData:GetItemId() <= RoleAssetID.RoleAssetPetSkinEnd then
    local goodid = self.goodData:GetGoodId()
    local price = self.goodData:GetSalePrice()
    local item = SkinsShopItem:New(goodid)
    item:SetPrice(price)
    item:SetIsShowLeftTime(false)
    item:SetType(SkinsPayType.Item)
    local itemid = self.goodData:GetSaleType()
    item:SetPriceItemId(itemid)
    local skinid = self.goodData:GetItemId() - RoleAssetID.RoleAssetPetSkinBegin
    item:SetSkinId(skinid)
    local cfg_top_tips = Cfg.cfg_top_tips[itemid]
    if cfg_top_tips then
      local icon = cfg_top_tips.Icon
      item:SetPriceIcon(icon)
    end
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUT_SHOP_DETAIL, item)
  elseif self.goodData:GetRemainCount() <= 1 then
    self:ShowDialog("UIShopConfirmNormalController", self.goodData, self.subTabType)
  else
    self:ShowDialog("UIShopConfirmDetailController", self.goodData, self.subTabType)
  end
end

function UIShopExchangeSeasonItem:Special(isSpecial)
  self._isSpecialPrefab = isSpecial
end

function UIShopExchangeSeasonItem:PlayInAnimation()
  local animName
  if self._isSpecialPrefab then
    animName = "uieff_UIShopExchangeSeasonItemSpecial_In"
  else
    animName = "uieff_UIShopExchangeSeasonItemSpecial_In"
  end
  self.animation:Play(animName)
  return 417
end
