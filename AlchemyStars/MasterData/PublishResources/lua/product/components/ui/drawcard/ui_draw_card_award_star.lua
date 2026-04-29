_class("UIDrawCardAwardStar", UICustomWidget)
UIDrawCardAwardStar = UIDrawCardAwardStar

function UIDrawCardAwardStar:Constructor()
  self._atlas = self:GetAsset("UIDrawCard.spriteatlas", LoadType.SpriteAtlas)
end
