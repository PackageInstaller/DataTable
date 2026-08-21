_class("UIActivityN4CCLevelElement", UICustomWidget)
UIActivityN4CCLevelElement = UIActivityN4CCLevelElement

function UIActivityN4CCLevelElement:OnShow(uiParams)
  self:InitWidget()
  self._atlas = self:GetAsset("UIN4CC.spriteatlas", LoadType.SpriteAtlas)
end

function UIActivityN4CCLevelElement:InitWidget()
  self.element1 = self:GetUIComponent("Image", "element1")
  self.element2 = self:GetUIComponent("Image", "element2")
  self.element1Go = self:GetGameObject("element1")
  self.element2Go = self:GetGameObject("element2")
end

function UIActivityN4CCLevelElement:SetData(e1, e2)
  self.element1Go:SetActive(e1 ~= nil)
  self.element2Go:SetActive(e2 ~= nil)
  if e1 then
    self.element1.sprite = self._atlas:GetSprite(e1)
  end
  if e2 then
    self.element1.sprite = self._atlas:GetSprite(e2)
  end
end
