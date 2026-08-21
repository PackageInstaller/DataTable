_class("UIShopRecommendTwoItem", UICustomWidget)
UIShopRecommendTwoItem = UIShopRecommendTwoItem

function UIShopRecommendTwoItem:OnShow()
  self.shopModule = GameGlobal.GetModule(ShopModule)
  self:GetComponents()
end

function UIShopRecommendTwoItem:SetData(idx, data, pos, callback)
  self.data = data
  self.idx = idx
  self.id = self.data:GetID(self.idx)
  self.callback = callback
  local icon = self.data:GetPic(self.idx)
  self._Icon:LoadImage(icon)
  self._rect.anchoredPosition = pos
  local tabType = self.data:GetTabType(self.idx)
  local price = self.shopModule:GetGoodsPrice(tabType, self.id)
  self._priceTex:SetText(price)
  self._price:SetActive(not string.isnullorempty(price))
  local params = self.data:GetGiftParams(self.idx)
  local len = 0
  if params then
    len = #params
  end
  self._gift_desc_2_go:SetActive(1 < len)
  if 1 < len then
    local param2 = params[2]
    local desc2 = param2[1]
    local icon2 = param2[2]
    self._gift_icon_2.gameObject:SetActive(icon2 ~= nil)
    if icon2 then
      self._gift_icon_2.sprite = self.commonAtlas:GetSprite(icon2)
    end
    self._gift_desc_2:SetText(StringTable.Get(desc2))
  end
  self._gift_desc_1_go:SetActive(0 < len)
  if 0 < len then
    local param1 = params[1]
    local desc1 = param1[1]
    local icon1 = param1[2]
    self._gift_icon_1.gameObject:SetActive(icon1 ~= nil)
    if icon1 then
      self._gift_icon_1.sprite = self.commonAtlas:GetSprite(icon1)
    end
    self._gift_desc_1:SetText(StringTable.Get(desc1))
  end
  local giftName = self.data:GetName(self.idx)
  self._gift_name_go:SetActive(giftName ~= nil)
  if giftName then
    self._giftName:SetText(StringTable.Get(giftName))
  end
end

function UIShopRecommendTwoItem:GetComponents()
  self._Icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._price = self:GetGameObject("price")
  self._priceTex = self:GetUIComponent("UILocalizationText", "priceTex")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._gift_desc_1_go = self:GetGameObject("gift_desc_1_go")
  self._gift_desc_2_go = self:GetGameObject("gift_desc_2_go")
  self._gift_name_go = self:GetGameObject("nameGo")
  self._gift_icon_1 = self:GetUIComponent("Image", "gift_icon_1")
  self._gift_icon_2 = self:GetUIComponent("Image", "gift_icon_2")
  self._gift_desc_1 = self:GetUIComponent("UILocalizationText", "gift_desc_1")
  self._gift_desc_2 = self:GetUIComponent("UILocalizationText", "gift_desc_2")
  self._giftName = self:GetUIComponent("UILocalizedTMP", "giftName")
  self.commonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UIShopRecommendTwoItem:IconOnClick(go)
  if self.callback then
    self.callback(self.id)
  end
end

function UIShopRecommendTwoItem:BtnOnClick(go)
  if self.callback then
    self.callback(self.id)
  end
end
