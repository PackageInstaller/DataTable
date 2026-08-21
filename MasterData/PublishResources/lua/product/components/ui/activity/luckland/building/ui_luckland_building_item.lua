_class("UILuckLandBuildingItem", UICustomWidget)
UILuckLandBuildingItem = UILuckLandBuildingItem

function UILuckLandBuildingItem:OnShow(uiParams)
  self:_InitWidget()
end

function UILuckLandBuildingItem:_InitWidget()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._content = self:GetUIComponent("UILocalizationText", "Content")
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UILuckLandBuildingItem:SetData(buildData)
  self._buildData = buildData
  self.view:GetGameObject():SetActive(self._buildData ~= nil)
  self:RefreshUIInfo()
end

function UILuckLandBuildingItem:RefreshUIInfo()
  if self._buildData then
    self._icon:LoadImage(self._buildData:Icon())
    self._name:SetText(StringTable.Get(self._buildData:Name()))
    self._content:SetText(StringTable.Get(self._buildData:Desc()))
  end
end

function UILuckLandBuildingItem:BgOnClick(go)
end

function UILuckLandBuildingItem:PlayAnimation()
  if self._buildData then
    self._animation:Play("uieff_UILuckLandBuildingItem_in")
  end
end
