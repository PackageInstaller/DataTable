_class("UIN14FishingGameWayLine", UICustomWidget)
UIN14FishingGameWayLine = UIN14FishingGameWayLine

function UIN14FishingGameWayLine:OnShow(uiParams)
  self._lineImg = {
    [true] = "n14_fish_line1",
    [false] = "n14_fish_line2"
  }
  self:_GetComponents()
end

function UIN14FishingGameWayLine:_GetComponents()
  self._line = self:GetUIComponent("Image", "Line")
  self._atlas = self:GetAsset("UIN14FishingGame.spriteatlas", LoadType.SpriteAtlas)
end

function UIN14FishingGameWayLine:SetData(state)
  self._line.sprite = self._atlas:GetSprite(self._lineImg[state])
end
