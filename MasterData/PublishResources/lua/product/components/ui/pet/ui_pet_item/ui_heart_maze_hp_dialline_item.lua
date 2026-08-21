_class("UIHeartMazeHpDialLineItem", UICustomWidget)
UIHeartMazeHpDialLineItem = UIHeartMazeHpDialLineItem

function UIHeartMazeHpDialLineItem:Constructor()
end

function UIHeartMazeHpDialLineItem:OnShow()
  self._img = self:GetUIComponent("Image", "img")
  self._rect = self:GetUIComponent("RectTransform", "img")
end

function UIHeartMazeHpDialLineItem:SetData(idx, posx, sp, show)
  self._index = idx
  self._rect.anchoredPosition = Vector2(posx, 0)
  self._img.enabled = show
  self._img.sprite = sp
  self._img:SetNativeSize()
end
