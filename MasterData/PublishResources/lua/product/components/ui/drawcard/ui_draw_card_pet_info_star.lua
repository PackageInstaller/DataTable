_class("UIDrawCardPetInfoStar", UICustomWidget)
UIDrawCardPetInfoStar = UIDrawCardPetInfoStar

function UIDrawCardPetInfoStar:OnShow()
  self._image = self:GetUIComponent("Image", "star")
end

function UIDrawCardPetInfoStar:SetData(image)
  local atlas = self:GetAsset("UIDrawCard.spriteatlas", LoadType.SpriteAtlas)
  self._image.sprite = atlas:GetSprite(image)
end

function UIDrawCardPetInfoStar:OnHide()
end
