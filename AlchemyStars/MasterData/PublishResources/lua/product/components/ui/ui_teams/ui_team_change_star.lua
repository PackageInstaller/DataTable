_class("UITeamChangeStar", UICustomWidget)
UITeamChangeStar = UITeamChangeStar

function UITeamChangeStar:Constructor()
  self._atlas = self:GetAsset("UITeamChange.spriteatlas", LoadType.SpriteAtlas)
end

function UITeamChangeStar:SetData(blue)
  self._starImg = self:GetUIComponent("Image", "img")
  if blue then
    self._starImg.sprite = self._atlas:GetSprite("spirit_xing1_frame")
  else
    self._starImg.sprite = self._atlas:GetSprite("spirit_xing2_frame")
  end
end
