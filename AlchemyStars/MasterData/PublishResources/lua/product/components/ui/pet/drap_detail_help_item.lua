_class("DrapDetailHelpItem", UICustomWidget)

function DrapDetailHelpItem:Constructor()
end

function DrapDetailHelpItem:OnShow(uiParams)
  self._Icon = self:GetUIComponent("Image", "icon")
  self._uiDragAtlas = self:GetAsset("UIDragImages.spriteatlas", LoadType.SpriteAtlas)
end

function DrapDetailHelpItem:SetData(iconName)
  self._Icon.sprite = self._uiDragAtlas:GetSprite(iconName)
end
