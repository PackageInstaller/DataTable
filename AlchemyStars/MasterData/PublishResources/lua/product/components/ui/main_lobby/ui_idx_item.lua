_class("UIIdxItem", UICustomWidget)
UIIdxItem = UIIdxItem

function UIIdxItem:OnShow()
  self._atlas = self:GetAsset("UIMainLobby.spriteatlas", LoadType.SpriteAtlas)
  self._img = self:GetUIComponent("Image", "img")
end

function UIIdxItem:OnHide()
  self._idx = nil
  self._atlas = nil
  self._img = nil
end

function UIIdxItem:SetData(idx, currIdx)
  self._idx = idx
  self:Flush(currIdx)
end

function UIIdxItem:Flush(currIdx)
  if not self._atlas then
    return
  end
  if not self._img then
    return
  end
  if self._idx == currIdx then
    self._img.sprite = self._atlas:GetSprite("main_zjm_di16")
  else
    self._img.sprite = self._atlas:GetSprite("main_zjm_di15")
  end
end
