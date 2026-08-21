_class("UIShopConfirmNormalController", UIController)
UIShopConfirmNormalController = UIShopConfirmNormalController

function UIShopConfirmNormalController:Constructor()
  self.atlas = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
  self.uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UIShopConfirmNormalController:OnShow(uiParams)
  self.goodData = uiParams[1]
  self.subTabType = uiParams[2]
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self._currentCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self.nameTrans = self:GetUIComponent("Transform", "name")
  self.descTxt = self:GetUIComponent("UILocalizationText", "desc")
  self.descRect = self:GetUIComponent("RectTransform", "desc")
  self.btnStarGO = self:GetGameObject("btnstar")
  self.btnGo = self:GetGameObject("btnGo")
  self.moneyIcon = self:GetUIComponent("Image", "moneyicon")
  self.priceTxt = self:GetUIComponent("UILocalizationText", "price")
  self:Refresh()
end

function UIShopConfirmNormalController:SetTextColor()
  local ownMoney = ClientShop.GetMoney(self.saleShowType)
  if ownMoney >= self.saleShowPrice then
    self.priceTxt.color = Color.white
  else
    self.priceTxt.color = Color.red
  end
end

function UIShopConfirmNormalController:Refresh()
  if not self.goodData then
    return
  end
  local cfgItem = Cfg.cfg_item[self.goodData:GetItemId()]
  if not cfgItem then
    return
  end
  self.isPet = self.goodData:IsPet()
  self.saleType = self.goodData:GetSaleType()
  self.price = self.goodData:GetSalePrice()
  self.saleShowType, self.saleShowPrice = self:GetSaleTypePrice()
  local itemId = cfgItem.ID
  local icon = cfgItem.Icon
  self.icon:LoadImage(icon)
  self.nameTxt:SetText(StringTable.Get(cfgItem.Name))
  local itemCount = 0
  if self.isPet then
    if self:GetModule(PetModule):GetPetByTemplateId(itemId) ~= nil then
      itemCount = 1
    end
  else
    itemCount = self:GetModule(ItemModule):GetItemCount(itemId)
  end
  self._currentCount:SetText(StringTable.Get("str_shop_current_item_count", itemCount))
  self.descTxt:SetText(StringTable.Get(cfgItem.Intro))
  self.priceTxt:SetText(self.saleShowPrice)
  self:SetTextColor()
  self.moneyIcon.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(self.saleShowType))
  if self.isPet then
    self.btnStarGO:SetActive(true)
    self.btnGo:SetActive(true)
  else
    self.btnStarGO:SetActive(false)
    self.btnGo:SetActive(false)
  end
  self:DoAnimation()
end

function UIShopConfirmNormalController:GetSaleTypePrice()
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

function UIShopConfirmNormalController:DoAnimation()
  self._cg = self:GetUIComponent("CanvasGroup", "UICanvas")
  self._panel = self:GetUIComponent("RectTransform", "panel")
  self._infoTrans = self:GetUIComponent("Transform", "info")
  self._cg.alpha = 0
  self:Lock("UIShopConfirmNormalController:DoAnimation")
  self:StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    self._cg:DOFade(1, 0.3)
    GameGlobal.Timer():AddEvent(400, function()
      self:UnLock("UIShopConfirmNormalController:DoAnimation")
    end)
  end, self)
end

function UIShopConfirmNormalController:OnHide()
end

function UIShopConfirmNormalController:btnstarOnClick(go)
  self:ShowDialog("UIShopPetDetailController", self.goodData:GetItemId())
end

function UIShopConfirmNormalController:btnbuyOnClick(go)
  if not ClientShop.CheckBuy(self.saleType, self.price) then
    if self.saleType == RoleAssetID.RoleAssetGlow then
      self:CloseDialog()
    end
    return
  end
  self:StartTask(function(TT)
    local shopModule = self:GetModule(ShopModule)
    self:Lock("UIShopConfirmNormalController:btnbuyOnClick")
    local result = shopModule:BuyItem(TT, self.subTabType, self.goodData:GetGoodId(), 1, self.saleType, self.goodData:GetSalePrice())
    self:UnLock("UIShopConfirmNormalController:btnbuyOnClick")
    if result and ClientShop.CheckShopCode(result) then
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = self.goodData:GetItemId()
      roleAsset.count = self.goodData:GetItemCount()
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

function UIShopConfirmNormalController:btnbgOnClick(go)
  self:CloseDialog()
end
