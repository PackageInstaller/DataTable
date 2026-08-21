_class("UICN17N46FishingGameOrderLine", UICustomWidget)
UICN17N46FishingGameOrderLine = UICN17N46FishingGameOrderLine

function UICN17N46FishingGameOrderLine:OnShow(uiParams)
  self._lineImg = {
    [true] = "n14_fish_pb_dingdan",
    [false] = "n14_fish_pb_bg_dingdan"
  }
  self:_GetComponents()
end

function UICN17N46FishingGameOrderLine:_GetComponents()
  self._line = self:GetUIComponent("Image", "Line")
  self._atlas = self:GetAsset("UIN14FishingGame.spriteatlas", LoadType.SpriteAtlas)
end

function UICN17N46FishingGameOrderLine:SetData(itemIndex, isFinish, isEnd)
  Log.debug("itemIndex: ", itemIndex, "    isFInish: ", isFinish, "    isEnd: ", isEnd)
  self._line.gameObject:SetActive(isEnd == false)
  self._line.sprite = self._atlas:GetSprite(self._lineImg[isFinish])
end
