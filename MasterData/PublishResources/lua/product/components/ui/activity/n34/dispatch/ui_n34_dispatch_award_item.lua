_class("UIN34DispatchAwardItem", UICustomWidget)
UIN34DispatchAwardItem = UIN34DispatchAwardItem

function UIN34DispatchAwardItem:OnShow(uiParams)
  self:InitWidget()
end

function UIN34DispatchAwardItem:InitWidget()
  self.qualitybg = self:GetUIComponent("Image", "qualitybg")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self._atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UIN34DispatchAwardItem:SetData(AwardData)
  if not AwardData then
    return
  end
  local id = AwardData[1]
  local count = AwardData[2]
  local cfg = Cfg.cfg_item[id]
  local icon = cfg.Icon
  self.imgIcon:LoadImage(icon)
  local quality = cfg.Color
  self.qualitybg.sprite = self._atlas:GetSprite("spirit_shengji_se" .. quality)
  self.txtCount:SetText(count)
end
