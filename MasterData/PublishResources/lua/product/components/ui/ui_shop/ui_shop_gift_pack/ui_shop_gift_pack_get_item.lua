_class("UIShopGiftPackGetItem", UICustomWidget)
UIShopGiftPackGetItem = UIShopGiftPackGetItem

function UIShopGiftPackGetItem:OnShow()
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._imgIconRect = self:GetUIComponent("RectTransform", "imgIcon")
  self._imgIconRectDefaultSize = Vector2(self._imgIconRect.sizeDelta.x, self._imgIconRect.sizeDelta.y)
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self._rollingText = self:GetUIComponent("RollingText", "txtName")
end

function UIShopGiftPackGetItem:Flush(award)
  if not award then
    Log.fatal("### award is nil.")
    return
  end
  self.ra = RoleAsset:New()
  self.ra.assetid = award:GetTemplateId()
  local count = award:GetCount()
  self.ra.count = count
  self:FlushImage(award)
  self._txtName:SetText(award:GetName())
  self._rollingText:RefreshText(award:GetName())
  self._txtCount:SetText("x" .. count)
end

function UIShopGiftPackGetItem:bgOnClick(go)
  if self.ra.assetid >= RoleAssetID.RoleAssetPetSkinBegin and self.ra.assetid <= RoleAssetID.RoleAssetPetSkinEnd then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self.ra.assetid - 4000000)
  else
    local safeArea = self:RootUIOwner()._anim
    local deltaPosition = go.transform.position - safeArea.transform.position
    self:ShowDialog("UICommonItemInfo", self.ra, deltaPosition)
  end
end

function UIShopGiftPackGetItem:FlushImage(award)
  self._imgIcon:LoadImage(award:GetIcon())
  local isHead = false
  local itemId = award:GetTemplateId()
  if 3750000 <= itemId and itemId <= 3759999 then
    isHead = true
  end
  if isHead then
    local whRate = 1
    if 3751000 <= itemId and itemId <= 3751999 then
      whRate = 0.8421052631578947
    elseif 3752000 <= itemId and itemId <= 3752999 then
      whRate = 0.6388888888888888
    elseif 3753000 <= itemId and itemId <= 3753999 then
      whRate = 0.6388888888888888
    end
    self._imgIconRect.sizeDelta = Vector2(self._imgIconRect.sizeDelta.x, self._imgIconRect.sizeDelta.x * whRate)
  else
    self._imgIconRect.sizeDelta = self._imgIconRectDefaultSize
  end
end
