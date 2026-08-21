_class("UIShopHomelandIndex", UICustomWidget)
UIShopHomelandIndex = UIShopHomelandIndex

function UIShopHomelandIndex:OnShow(uiParams)
  self._atlas = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
  self:_GetComponents()
end

function UIShopHomelandIndex:_GetComponents()
  self._image = self:GetUIComponent("Image", "Image")
end

function UIShopHomelandIndex:SetData(selected)
  if selected then
    self._image.sprite = self._atlas:GetSprite("base_shop_di19")
  else
    self._image.sprite = self._atlas:GetSprite("base_shop_di18")
  end
end
