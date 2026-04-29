_class("UIMainLobbyScrollIdx", UICustomWidget)
UIMainLobbyScrollIdx = UIMainLobbyScrollIdx

function UIMainLobbyScrollIdx:OnShow()
  self._atlas = self:GetAsset("UIMainLobbyFinal.spriteatlas", LoadType.SpriteAtlas)
  self._img = self:GetUIComponent("Image", "img")
end

function UIMainLobbyScrollIdx:OnHide()
  self._idx = nil
  self._atlas = nil
  self._img = nil
end

function UIMainLobbyScrollIdx:SetData(idx, currIdx)
  self._idx = idx
  self:Flush(currIdx)
end

function UIMainLobbyScrollIdx:Flush(currIdx)
  if not self._atlas then
    return
  end
  if not self._img then
    return
  end
  if self._idx == currIdx then
    self._img.sprite = self._atlas:GetSprite("main_zjm_new_di28")
  else
    self._img.sprite = self._atlas:GetSprite("main_zjm_new_di27")
  end
end
