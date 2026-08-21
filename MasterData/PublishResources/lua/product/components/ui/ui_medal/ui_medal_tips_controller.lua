_class("UIMedalTipsController", UIController)
UIMedalTipsController = UIMedalTipsController

function UIMedalTipsController:OnShow(uiParams)
  self.itemId = uiParams[1]
  self._atlas = self:GetAsset("UIMedal.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
  self:Refresh()
end

function UIMedalTipsController:InitWidget()
  self.imgIcon = self:GetUIComponent("Image", "imgIcon")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtdesc = self:GetUIComponent("UILocalizationText", "txtdesc")
  self.txtGetWay = self:GetUIComponent("UILocalizationText", "txtGetWay")
end

function UIMedalTipsController:Refresh()
  if not self.itemId then
    return
  end
  local cfgItem = Cfg.cfg_item[self.itemId]
  if cfgItem then
    self.txtName:SetText(StringTable.Get(cfgItem.Name))
    self.txtdesc:SetText(StringTable.Get(cfgItem.RpIntro))
  end
  local cfgMedal = Cfg.cfg_item_medal[self.itemId]
  if cfgMedal then
    self.txtGetWay:SetText(StringTable.Get(cfgMedal.GetPathDesc))
    self.imgIcon.sprite = self._atlas:GetSprite(cfgMedal.Icon)
    self.imgIcon:SetNativeSize()
  end
end

function UIMedalTipsController:BgOnClick(go)
  self:CloseDialog()
end
