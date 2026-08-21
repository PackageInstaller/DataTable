_class("UITrailLevelItem", UICustomWidget)
UITrailLevelItem = UITrailLevelItem

function UITrailLevelItem:OnShow()
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._element1Img = self:GetUIComponent("Image", "Element1")
  self._element2Img = self:GetUIComponent("Image", "Element2")
  self._element1Go = self:GetGameObject("Element1")
  self._element2Go = self:GetGameObject("Element2")
  self._statusGo = self:GetGameObject("Status")
  self._go = self:GetGameObject("Go")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UITrailLevelItem:OnHide()
  self.atlasProperty = nil
end

function UITrailLevelItem:Refresh(levelData)
  if levelData == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._levelData = levelData
  self._iconImg:LoadImage(self._levelData:GetIcon())
  self._nameLabel:SetText(self._levelData:GetName())
  local elementIcon1 = self._levelData:GetElementIcon1()
  if string.isnullorempty(elementIcon1) then
    self._element1Go:SetActive(false)
  else
    self._element1Go:SetActive(true)
    self._element1Img.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(elementIcon1))
  end
  local elementIcon2 = self._levelData:GetElementIcon2()
  if string.isnullorempty(elementIcon2) then
    self._element2Go:SetActive(false)
  else
    self._element2Go:SetActive(true)
    self._element2Img.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(elementIcon2))
  end
  self._statusGo:SetActive(self._levelData:IsComplete())
  self._anim:Stop()
  self._anim:Play("uieff_UITrailLevelItem_in")
end

function UITrailLevelItem:BgOnClick()
  self:ShowDialog("UITrailLevelDetail", self._levelData:GetId())
end
