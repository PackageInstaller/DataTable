_class("UIAircraftEnterBuildStarItem", UICustomWidget)
UIAircraftEnterBuildStarItem = UIAircraftEnterBuildStarItem

function UIAircraftEnterBuildStarItem:OnShow(uiParams)
end

function UIAircraftEnterBuildStarItem:SetData(sprite)
  local img = self:GetUIComponent("Image", "img")
  img.sprite = sprite
end
