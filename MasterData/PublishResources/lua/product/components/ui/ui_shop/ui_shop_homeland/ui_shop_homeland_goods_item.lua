_class("UIShopHomelandGoodsItem", UICustomWidget)
UIShopHomelandGoodsItem = UIShopHomelandGoodsItem

function UIShopHomelandGoodsItem:Constructor()
  self._atlas = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
end

function UIShopHomelandGoodsItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIShopHomelandGoodsItem:_GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._discount = self:GetUIComponent("UILocalizationText", "Discount")
  self._discountImg = self:GetGameObject("DiscountImg")
  self._discountPrice = self:GetGameObject("DiscountPrice")
  self._discountPriceOriginal = self:GetUIComponent("UILocalizationText", "DiscountPriceOriginal")
  self._discountPriceNow = self:GetUIComponent("UILocalizationText", "DiscountPriceNow")
  self._price = self:GetUIComponent("UILocalizationText", "Price")
  self._priceObj = self:GetGameObject("Price")
  self._priceImgObj = self:GetGameObject("PriceImg")
  self._lock = self:GetGameObject("Lock")
  self._animation = self:GetUIComponent("Animation", "Animation")
  self._sellCount = self:GetUIComponent("UILocalizationText", "SellCount")
  self._sellCountImg = self:GetGameObject("SellCountImg")
  self._gotBackground = self:GetUIComponent("Image", "GotBackground")
  self._lockTextCircleOutline = self:GetUIComponent("H3D.UGUI.CircleOutline", "LockText")
  self._priceImg = self:GetUIComponent("Image", "PriceImg")
end

function UIShopHomelandGoodsItem:SetData(key, data, marketType, shopId)
  self._data = data
  self._marketType = marketType
  local isDiscounting = self._data:IsDiscount()
  self._name:SetText(StringTable.Get(self._data.cfg.Name))
  self._icon:LoadImage(self._data.cfg.Icon)
  self._discountPrice:SetActive(isDiscounting)
  self._priceObj:SetActive(not isDiscounting)
  if isDiscounting then
    self._discount:SetText("-" .. self._data.cfg.Discount .. "%")
    self._price:SetText("")
    self._discountPriceOriginal:SetText(self._data.cfg.RawPrice)
    self._discountPriceNow:SetText(self._data.cfg.NewPrice)
  else
    self._price:SetText(self._data.cfg.RawPrice)
  end
  local sellOut = self._data:IsSellOut()
  self._lock:SetActive(sellOut)
  local theme = UIShopHomelandTheme[shopId]
  if theme then
    self._priceImg.sprite = self._atlas:GetSprite(theme.ItemPriceImg)
    self._gotBackground.sprite = self._atlas:GetSprite(theme.ItemGotBackground)
    self._lockTextCircleOutline.effectColor = theme.ItemLockTextOutLine
  end
  self._priceImgObj:SetActive(not sellOut)
  self._discountImg:SetActive(not sellOut and isDiscounting)
  if self._data.saleNum < 888888888 and not self._data:IsSellOut() then
    self._sellCountImg:SetActive(true)
    self._sellCount:SetText(self._data.saleNum - self._data.selledCount)
    self._sellCount:SetText(StringTable.Get("str_shop_secret_good_remain") .. self._data:GetRemainCount())
  else
    self._sellCountImg:SetActive(false)
  end
  if self.view then
    self.view.gameObject:SetActive(false)
  end
  self._animationTask = self:StartTask(function(TT)
    YIELD(TT, (key - 1) * 55)
    if self.view then
      self.view.gameObject:SetActive(true)
      self._animation:Play("UIShopHomelandGoodsItem")
    end
  end, self)
end

function UIShopHomelandGoodsItem:BackgoundOnClick(go)
  if self._data:IsSellOut() then
    return
  end
  if self._data:GetRemainCount() <= 1 then
    self:ShowDialog("UIShopConfirmNormalController", self._data, self._marketType)
  else
    self:ShowDialog("UIShopConfirmDetailController", self._data, self._marketType)
  end
end

function UIShopHomelandGoodsItem:OnHide()
  if self._animationTask then
    GameGlobal.TaskManager():KillTask(self._animationTask)
    self._animationTask = nil
  end
end
