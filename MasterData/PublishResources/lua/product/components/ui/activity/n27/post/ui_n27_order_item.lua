_class("UIN27OrderItem", UICustomWidget)
UIN27OrderItem = UIN27OrderItem

function UIN27OrderItem:InitWidget()
  self._nameText = self:GetUIComponent("UILocalizationText", "nameText")
  self._iconRawImage = self:GetUIComponent("RawImageLoader", "iconRaw")
  self._iconImage = self:GetUIComponent("Image", "iconImg")
  self._checkObj = self:GetGameObject("check")
  self._maskObj = self:GetGameObject("mask")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._iconRawImageObj = self:GetGameObject("iconRaw")
  self._iconImageObj = self:GetGameObject("iconImg")
end

function UIN27OrderItem:OnValue()
end

function UIN27OrderItem:PlayShowAnimation()
  self._anim:Play("uieff_UIN27OrderItem_in")
end

function UIN27OrderItem:PlayCheckAnimation()
  if self._check and not self._maskObj.activeSelf then
    self._anim:Play("uieff_UIN27OrderItem_check")
  end
  self._checkObj:SetActive(self._check)
  self._maskObj:SetActive(self._check)
end

function UIN27OrderItem:SetData(typeCfg, itemCfg, count, curCount)
  if typeCfg then
    self._atlas = self:GetAsset("PostInGame.spriteatlas", LoadType.SpriteAtlas)
    self._name = typeCfg.Name
    self._icon = typeCfg.TabIconSelect
    self._iconImage.sprite = self._atlas:GetSprite(self._icon)
    self._iconImageObj:SetActive(true)
    self._iconRawImageObj:SetActive(false)
  elseif itemCfg then
    self._name = itemCfg.ItemName
    self._icon = itemCfg.ItemIcon
    self._iconRawImage:LoadImage(self._icon)
    self._iconImageObj:SetActive(false)
    self._iconRawImageObj:SetActive(true)
  else
    Log.error("order存在空条件")
  end
  self._count = count
  self._check = count <= curCount
  self._nameText:SetText(StringTable.Get(self._name) .. "*" .. self._count)
end
