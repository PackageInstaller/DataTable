require("ui_shop_secret_good")
_class("UIShopSecretGoodBattlePass", UIShopSecretGood)
UIShopSecretGoodBattlePass = UIShopSecretGoodBattlePass

function UIShopSecretGoodBattlePass:OnChildShow()
  self.uiNormalGO = self:GetGameObject("uiNormal")
  self.logo = self:GetUIComponent("RawImageLoader", "logo")
  self.uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.flagTextCollectGo = self:GetGameObject("flagTextCollect")
  self.flagTextSpecialGo = self:GetGameObject("flagTextSpecial")
  self.skinNameNormalGo = self:GetGameObject("skinNameNormal")
  self.skinNameSpecialGo = self:GetGameObject("skinNameSpecial")
  self.skinNameNormal = self:GetUIComponent("UILocalizedTMP", "skinNameNormal")
  self.skinNameSpecial = self:GetUIComponent("UILocalizedTMP", "skinNameSpecial")
  self._atlasBg = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
  self.isLockGO = self:GetGameObject("isLock")
  self.lockText = self:GetUIComponent("UILocalizationText", "lockText")
  self.moneyIcon1 = self:GetChildComponent(self.moneyIcon1GO, "Image", "moneyicon1")
  self.moneyIcon2 = self:GetChildComponent(self.moneyIcon2GO, "Image", "moneyicon2")
  self.price1Txt = self:GetUIComponent("UILocalizationText", "price")
  self.tag1GO = self:GetGameObject("tag1")
  self.tag1txt = self:GetUIComponent("UILocalizationText", "tag1txt")
end

function UIShopSecretGoodBattlePass:RefreshPrice(subTabType, goodData, targetShopId)
  self.subTabType = subTabType
  self.goodData = goodData
  self.targetShopId = targetShopId
  self.costType = RoleAssetID.RoleAssetGlow
  self.costCount = 0
  if self.goodData then
    self.costType = self.goodData:GetSaleType()
    self.costCount = self.goodData:GetSalePrice()
    local itemModule = GameGlobal.GetModule(ItemModule)
    local converType = self.goodData:GetConvertType()
    if converType and 0 < converType then
      local convercount = itemModule:GetItemCount(self.goodData:GetConvertType())
      local convertPrice = self.goodData:GetConvertPrice()
      if convercount >= convertPrice then
        self.costType = self.goodData:GetConvertType()
        self.price1Txt:SetText(convertPrice)
        self.costCount = convertPrice
      end
    end
    self.moneyIcon1.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(self.costType))
    self.moneyIcon2.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(self.costType))
    local timeLimit = self.goodData:GetRefreshTimeStr()
    self.tag1GO.gameObject:SetActive(timeLimit ~= nil)
    if timeLimit then
      self.tag1txt:SetText(timeLimit)
    end
  end
end

function UIShopSecretGoodBattlePass:RefreshSkin()
  self.isLock = false
  self.lockToastText = ""
  if self.goodData then
    local itemId = self.goodData:GetItemId()
    if itemId >= RoleAssetID.RoleAssetPetSkinBegin and itemId <= RoleAssetID.RoleAssetPetSkinEnd then
      local skinid = itemId - RoleAssetID.RoleAssetPetSkinBegin
      local cfg_pet_skin = Cfg.cfg_pet_skin[skinid]
      if not cfg_pet_skin then
        return
      end
      local showIcon = cfg_pet_skin.SkinShopCG
      local petid = cfg_pet_skin.PetId
      local cfg_pet = Cfg.cfg_pet[petid]
      local logo = cfg_pet.Logo
      self.logo:LoadImage(logo)
      self.icon:LoadImage(showIcon)
      self.nameShadow:SetText(StringTable.Get(cfg_pet.Name))
      self.nameTxt:SetText(StringTable.Get(cfg_pet.Name))
      self.nameShadow2:SetText(StringTable.Get(cfg_pet.Name))
      self.nameTxt2:SetText(StringTable.Get(cfg_pet.Name))
      self.flagTextCollectGo:SetActive(cfg_pet_skin.SkinType == 2)
      self.flagTextSpecialGo:SetActive(cfg_pet_skin.SkinType == 3)
      self.skinNameNormalGo:SetActive(cfg_pet_skin.SkinType ~= 3)
      self.skinNameSpecialGo:SetActive(cfg_pet_skin.SkinType == 3)
      self.skinNameNormal:SetText(StringTable.Get(cfg_pet_skin.SkinName))
      self.skinNameSpecial:SetText(StringTable.Get(cfg_pet_skin.SkinName))
      if cfg_pet_skin.SkinType == 1 then
        self.qualityIcon.sprite = self._atlasBg:GetSprite("shop_shizhuang_di01")
      elseif cfg_pet_skin.SkinType == 2 then
        self.qualityIcon.sprite = self._atlasBg:GetSprite("shop_shizhuang_di01")
      elseif cfg_pet_skin.SkinType == 3 then
        self.qualityIcon.sprite = self._atlasBg:GetSprite("shop_shizhuang_di02")
      elseif cfg_pet_skin.SkinType == 4 then
        self.qualityIcon.sprite = self._atlasBg:GetSprite("shop_shizhuang_di06")
      elseif cfg_pet_skin.SkinType == 5 then
        self.qualityIcon.sprite = self._atlasBg:GetSprite("shop_shizhuang_di06")
      else
        self.qualityIcon.sprite = self._atlasBg:GetSprite("shop_shizhuang_di01")
      end
    end
  end
end

function UIShopSecretGoodBattlePass:ActivityEndCb(activityEndCb)
  self._activityEndCb = activityEndCb
end

function UIShopSecretGoodBattlePass:ShopBuySuccess(goodId)
  goodId = nil
end

function UIShopSecretGoodBattlePass:RefreshLock(islock, lockText)
  self.isLock = islock
  self.isLockGO:SetActive(islock)
  if islock then
    self.lockText:SetText(StringTable.Get(lockText))
    self.lockToastText = lockText
  else
    self.lockText:SetText("")
  end
end

function UIShopSecretGoodBattlePass:BgOnClick()
  if self.isLock then
    ToastManager.ShowToast(StringTable.Get(self.lockToastText))
    return
  end
  local remainCount = self.goodData:GetRemainCount()
  if remainCount <= 0 then
    return
  end
  local itemId = self.goodData:GetItemId()
  if itemId >= RoleAssetID.RoleAssetPetSkinBegin and itemId <= RoleAssetID.RoleAssetPetSkinEnd then
    local goodid = self.goodData:GetGoodId()
    local item = SkinsShopItem:New(goodid)
    item:SetPrice(self.costCount)
    item:SetPriceItemId(self.costType)
    item:SetIsShowLeftTime(false)
    item:SetType(SkinsPayType.ConvertCost)
    item:SetCostPrice(self.goodData:GetSalePrice())
    item:SetCostPriceItemId(self.goodData:GetSaleType())
    item:SetConvertType(SkinsConvertPayType.BattlePass)
    local skinid = self.goodData:GetItemId() - RoleAssetID.RoleAssetPetSkinBegin
    item:SetSkinId(skinid)
    local cfg_top_tips = Cfg.cfg_top_tips[self.costType]
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
