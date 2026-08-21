_class("UIShopConfirmDetailController", UIController)
UIShopConfirmDetailController = UIShopConfirmDetailController
local MAX_COUNT = 99

function UIShopConfirmDetailController:Constructor()
  self.atlas = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
  self.uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UIShopConfirmDetailController:OnShow(uiParams)
  self.goodData = uiParams[1]
  self.subTabType = uiParams[2]
  self.isPet = self.goodData:IsPet()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self.nameTrans = self:GetUIComponent("Transform", "name")
  self.descTxt = self:GetUIComponent("UILocalizationText", "desc")
  self.descRect = self:GetUIComponent("RectTransform", "desc")
  self.btnStarGO = self:GetGameObject("btnstar")
  self.btnGo = self:GetGameObject("btnGo")
  self.countGroupGO = self:GetGameObject("countgroup")
  self.countGroupRect = self:GetUIComponent("RectTransform", "countgroup")
  self._currentCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self.moneyIcon = self:GetUIComponent("Image", "moneyicon")
  self.priceTxt = self:GetUIComponent("UILocalizationText", "price")
  self.countFollowTxt = self:GetUIComponent("UILocalizationText", "countfollow")
  self.remainTxt = self:GetUIComponent("UILocalizationText", "remain")
  self.remainGO = self:GetGameObject("remaintxt")
  self:Refresh()
end

function UIShopConfirmDetailController:SetTextColor()
  local ownMoney = ClientShop.GetMoney(self.saleType)
  if ownMoney >= self.price then
    self.priceTxt.color = Color.white
  else
    self.priceTxt.color = Color.red
  end
end

function UIShopConfirmDetailController:Refresh()
  if not self.goodData then
    return
  end
  local cfgItem = Cfg.cfg_item[self.goodData:GetItemId()]
  if not cfgItem then
    return
  end
  self.count = 1
  local itemId = cfgItem.ID
  local icon = cfgItem.Icon
  self.saleType = self.goodData:GetSaleType()
  self.singlePrice = self.goodData:GetSalePrice()
  self.saleShowType, self.saleShowPrice = self:GetSaleTypePrice()
  self.icon:LoadImage(icon)
  self.nameTxt:SetText(StringTable.Get(cfgItem.Name))
  local itemCount = self:GetModule(ItemModule):GetItemCount(itemId)
  self._currentCount:SetText(StringTable.Get("str_shop_current_item_count", itemCount))
  self.descTxt:SetText(StringTable.Get(cfgItem.Intro))
  self.moneyIcon.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(self.saleShowType))
  if self.isPet then
    self.btnStarGO:SetActive(true)
    self.btnGo:SetActive(true)
  else
    self.btnStarGO:SetActive(false)
    self.btnGo:SetActive(false)
  end
  self.remainCount = self.goodData:GetRemainCount()
  self.countGroupGO:SetActive(true)
  if self.goodData:IsUnLimit() then
    self.remainGO:SetActive(false)
    self.countGroupRect.anchoredPosition = Vector2(0, 151)
  else
    self.remainGO:SetActive(true)
    self.remainTxt:SetText(self.remainCount)
    self.countGroupRect.anchoredPosition = Vector2(0, 169)
  end
  self:SetCountPriceTxt()
  self:DoAnimation()
end

function UIShopConfirmDetailController:GetSaleTypePrice()
  local saleType = self.goodData:GetSaleType()
  local salePrice = self.goodData:GetSalePrice()
  local itemId = self.goodData:GetItemId()
  if itemId >= RoleAssetID.RoleAssetPetSkinBegin and itemId <= RoleAssetID.RoleAssetPetSkinEnd or Cfg.cfg_item[itemId].ItemSubType == ItemSubType.ItemSubType_Furniture then
    local itemModule = GameGlobal.GetModule(ItemModule)
    local converType = self.goodData:GetConvertType()
    if converType and 0 < converType then
      local convercount = itemModule:GetItemCount(self.goodData:GetConvertType())
      local convertPrice = self.goodData:GetConvertPrice()
      if convercount >= convertPrice then
        saleType = converType
        salePrice = convertPrice
      end
    end
  end
  return saleType, salePrice
end

function UIShopConfirmDetailController:DoAnimation()
  self._cg = self:GetUIComponent("CanvasGroup", "UICanvas")
  self._panel = self:GetUIComponent("RectTransform", "panel")
  self._infoTrans = self:GetUIComponent("Transform", "info")
  self._cg.alpha = 0
  self:Lock("UIShopConfirmDetailController:DoAnimation")
  self:StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    self._cg:DOFade(1, 0.3)
    GameGlobal.Timer():AddEvent(400, function()
      self:UnLock("UIShopConfirmDetailController:DoAnimation")
    end)
  end, self)
end

function UIShopConfirmDetailController:OnHide()
end

function UIShopConfirmDetailController:btnstarOnClick(go)
  self:ShowDialog("UIShopPetDetailController", self.goodData:GetItemId())
end

function UIShopConfirmDetailController:btnbuyOnClick(go)
  if not ClientShop.CheckBuy(self.saleType, self.price) then
    if self.saleType == RoleAssetID.RoleAssetGlow then
      self:CloseDialog()
    end
    return
  end
  self:StartTask(function(TT)
    local shopModule = self:GetModule(ShopModule)
    self:Lock("UIShopConfirmDetailController:btnbuyOnClick")
    local result = shopModule:BuyItem(TT, self.subTabType, self.goodData:GetGoodId(), self.count, self.saleType, self.goodData:GetSalePrice())
    self:UnLock("UIShopConfirmDetailController:btnbuyOnClick")
    if result and ClientShop.CheckShopCode(result) then
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = self.goodData:GetItemId()
      roleAsset.count = self.count * self.goodData:GetItemCount()
      local assetList = {roleAsset}
      if self:GetModule(PetModule):IsPetID(roleAsset.assetid) then
        self:ShowDialog("UIPetObtain", assetList, function()
          GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
          self:ShowDialog("UIGetItemController", assetList, function()
            GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopBuySuccess, self.goodData:GetGoodId())
          end)
          self:CloseDialog()
        end)
      else
        self:ShowDialog("UIGetItemController", assetList, function()
          GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopBuySuccess, self.goodData:GetGoodId())
        end)
        self:CloseDialog()
      end
    end
  end, self)
end

function UIShopConfirmDetailController:SetCountPriceTxt()
  self.countFollowTxt:SetText(self.count)
  self.price = self.count * self.saleShowPrice
  self.priceTxt:SetText(self.price)
  self:SetTextColor()
end

function UIShopConfirmDetailController:minOnClick(go)
  self.count = 1
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDecDown)
  self:SetCountPriceTxt()
end

function UIShopConfirmDetailController:removeOnClick(go)
  if self.count > 1 then
    self.count = self.count - 1
  else
    self.count = 1
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDecDown)
  self:SetCountPriceTxt()
end

function UIShopConfirmDetailController:addOnClick(go)
  local ownMoney = ClientShop.GetMoney(self.saleShowType)
  local maxCount = math.floor(ownMoney / self.saleShowPrice)
  if maxCount <= 0 then
    self.count = 1
  else
    self.count = self.count + 1
    if maxCount <= self.count then
      self.count = maxCount
    end
    if self.count >= self.remainCount then
      self.count = self.remainCount
    end
    if self.count >= MAX_COUNT then
      self.count = MAX_COUNT
    end
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAddUp)
  self:SetCountPriceTxt()
end

function UIShopConfirmDetailController:maxOnClick(go)
  local ownMoney = ClientShop.GetMoney(self.saleType)
  local maxCount = math.floor(ownMoney / self.saleShowPrice)
  if maxCount <= 0 then
    maxCount = 1
  else
    if maxCount >= self.remainCount then
      maxCount = self.remainCount
    end
    if maxCount >= MAX_COUNT then
      maxCount = MAX_COUNT
    end
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAddUp)
  self.count = maxCount
  self:SetCountPriceTxt()
end

function UIShopConfirmDetailController:btnbgOnClick(go)
  self:CloseDialog()
end
