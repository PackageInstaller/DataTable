_class("UICN17N46FishingGameWayLine", UICustomWidget)
UICN17N46FishingGameWayLine = UICN17N46FishingGameWayLine

function UICN17N46FishingGameWayLine:OnShow(uiParams)
  self._lineImg = {
    [true] = "n14_fish_line1",
    [false] = "n14_fish_line2"
  }
  self:_GetComponents()
end

function UICN17N46FishingGameWayLine:_GetComponents()
  self._line = self:GetUIComponent("Image", "Line")
  self._atlas = self:GetAsset("UIN14FishingGame.spriteatlas", LoadType.SpriteAtlas)
end

function UICN17N46FishingGameWayLine:SetData(state)
  self._line.sprite = self._atlas:GetSprite(self._lineImg[state])
end
