_class("UIMedalListTab", UICustomWidget)
UIMedalListTab = UIMedalListTab

function UIMedalListTab:Constructor()
  self._atlas = self:GetAsset("UIMedal.spriteatlas", LoadType.SpriteAtlas)
end

function UIMedalListTab:OnShow(uiParams)
  self:InitWidget()
end

function UIMedalListTab:InitWidget()
  self.imgIcon = self:GetUIComponent("Image", "imgIcon")
  self.txtFilter = self:GetUIComponent("UILocalizationText", "txtFilter")
  self.red = self:GetGameObject("red")
  self.select = self:GetGameObject("select")
  self.imgTabBg = self:GetUIComponent("Image", "imgTabBg")
  self._ani = self:GetUIComponent("Animation", "_ani")
end

function UIMedalListTab:SetData(filterInfo, bSelect, callback)
  self.filterInfo = filterInfo
  self.callback = callback
  self:SetSelect(bSelect)
  self.txtFilter:SetText(StringTable.Get(self.filterInfo.Name))
  self.imgIcon.sprite = self._atlas:GetSprite(self.filterInfo.Icon)
  self.imgIcon:SetNativeSize()
end

function UIMedalListTab:SetSelect(bSelect, withAni)
  self.select:SetActive(bSelect)
  if bSelect then
    self.imgTabBg.sprite = self._atlas:GetSprite("N22_xzzl_di03")
    self.txtFilter.fontSize = 36
    self.txtFilter.resizeTextMaxSize = 36
  else
    self.imgTabBg.sprite = self._atlas:GetSprite("N22_xzzl_di04")
    self.txtFilter.fontSize = 30
    self.txtFilter.resizeTextMaxSize = 30
  end
  self.imgTabBg:SetNativeSize()
  if withAni then
    if bSelect then
      self._ani:Play("uieff_UIMedalListTab_dianjiBig")
    else
      self._ani:Play("uieff_UIMedalListTab_dianjiSmall")
    end
  end
end

function UIMedalListTab:SetNew(bNew)
  self.red:SetActive(bNew)
end

function UIMedalListTab:ImgTabOnClick(go)
  if self.callback then
    self.callback(self)
  end
end

function UIMedalListTab:GetFilterID()
  return self.filterInfo.ID
end
