_class("UIN14FishingGameOrderLine", UICustomWidget)
UIN14FishingGameOrderLine = UIN14FishingGameOrderLine

function UIN14FishingGameOrderLine:OnShow(uiParams)
  self._lineImg = {
    [true] = "n14_fish_pb_dingdan",
    [false] = "n14_fish_pb_bg_dingdan"
  }
  self:_GetComponents()
end

function UIN14FishingGameOrderLine:_GetComponents()
  self._line = self:GetUIComponent("Image", "Line")
  self._atlas = self:GetAsset("UIN14FishingGame.spriteatlas", LoadType.SpriteAtlas)
end

function UIN14FishingGameOrderLine:SetData(itemIndex, isFinish, isEnd)
  Log.debug("itemIndex: ", itemIndex, "    isFInish: ", isFinish, "    isEnd: ", isEnd)
  self._line.gameObject:SetActive(isEnd == false)
  self._line.sprite = self._atlas:GetSprite(self._lineImg[isFinish])
end
