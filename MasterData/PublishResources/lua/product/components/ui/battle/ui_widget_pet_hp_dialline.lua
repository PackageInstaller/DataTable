_class("UIWidgetPetHpDialLine", UICustomWidget)
UIWidgetPetHpDialLine = UIWidgetPetHpDialLine

function UIWidgetPetHpDialLine:Constructor()
  self._atlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
end

function UIWidgetPetHpDialLine:OnShow()
  self._img = self:GetUIComponent("Image", "dialLine")
  self._rect = self:GetUIComponent("RectTransform", "dialLine")
end

function UIWidgetPetHpDialLine:SetData(idx, posx, middleImg, show)
  self._index = idx
  self._rect.anchoredPosition = Vector2(posx, 0)
  self._img.enabled = show
  if middleImg then
    self._img.sprite = self._atlas:GetSprite("thread_junei_xuetiao6")
  else
    self._img.sprite = self._atlas:GetSprite("thread_junei_xuetiao5")
  end
  self._img:SetNativeSize()
end

function UIWidgetPetHpDialLine:FlushShow(show)
  self._img.enabled = show
end
