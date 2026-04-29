_class("UIPetEquipTab", UICustomWidget)
UIPetEquipTab = UIPetEquipTab

function UIPetEquipTab:OnShow(uiParams)
  self:InitWidget()
  self._atlas = self:GetAsset("UIPetEquip.spriteatlas", LoadType.SpriteAtlas)
end

function UIPetEquipTab:InitWidget()
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.imageBg = self:GetUIComponent("Image", "imgBg")
  self.redPointGo = self:GetGameObject("redPoint")
end

function UIPetEquipTab:SetData(name, clickCallback)
  self.clickCallback = clickCallback
  self.txtName:SetText(StringTable.Get(name))
end

function UIPetEquipTab:SetSelect(bSelect)
  if bSelect then
    self.imageBg.sprite = self._atlas:GetSprite("spirit_lg_btn02")
    self.txtName.color = Color(1, 1, 1)
  else
    self.imageBg.sprite = self._atlas:GetSprite("spirit_lg_btn01")
    self.txtName.color = Color(0.3686274509803922, 0.3686274509803922, 0.3686274509803922)
  end
end

function UIPetEquipTab:BgOnClick(go)
  if self.clickCallback then
    self.clickCallback()
  end
end

function UIPetEquipTab:SetPoint(visible)
  self.redPointGo:SetActive(visible)
end
