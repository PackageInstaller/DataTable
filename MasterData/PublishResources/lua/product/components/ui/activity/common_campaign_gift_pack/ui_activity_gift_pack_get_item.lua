_class("UIActivityGiftPackGetItem", UICustomWidget)
UIActivityGiftPackGetItem = UIActivityGiftPackGetItem

function UIActivityGiftPackGetItem:OnShow()
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
end

function UIActivityGiftPackGetItem:Flush(award)
  if not award then
    Log.fatal("### award is nil.")
    return
  end
  self._imgIcon:LoadImage(award:GetIcon())
  self._txtName:SetText(award:GetName())
  self._txtCount:SetText("x" .. award:GetCount())
  self.ra = RoleAsset:New()
  self.ra.assetid = award:GetTemplateId()
  self.ra.count = award:GetCount()
end

function UIActivityGiftPackGetItem:BgOnClick(go)
  if self.ra.assetid >= RoleAssetID.RoleAssetPetSkinBegin and self.ra.assetid <= RoleAssetID.RoleAssetPetSkinEnd then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self.ra.assetid - 4000000)
  else
    self:ShowDialog("UIItemTips", self.ra, go, "UIActivityGiftPackDetail")
  end
end
