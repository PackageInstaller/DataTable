_class("UIHomeDomitoryIndexer", UICustomWidget)
UIHomeDomitoryIndexer = UIHomeDomitoryIndexer

function UIHomeDomitoryIndexer:OnShow()
  self._image = self:GetUIComponent("Image", "UIHomeDomitoryIndexItem")
  self._layout = self:GetUIComponent("LayoutElement", "UIHomeDomitoryIndexItem")
  self.atlas = self:GetAsset("UIHomelandDomitory.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomeDomitoryIndexer:Select(select)
  if select then
    self._layout.preferredWidth = 66
    self._image.sprite = self.atlas:GetSprite("n17_dorm_zjm_di13")
  else
    self._layout.preferredWidth = 30
    self._image.sprite = self.atlas:GetSprite("n17_dorm_zjm_di14")
  end
end
