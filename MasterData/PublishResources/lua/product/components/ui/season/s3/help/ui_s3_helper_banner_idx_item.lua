_class("UIS3HelperBannerIdxItem", UICustomWidget)
UIS3HelperBannerIdxItem = UIS3HelperBannerIdxItem

function UIS3HelperBannerIdxItem:OnShow()
  self._atlas = self:GetAsset("UIS3Main.spriteatlas", LoadType.SpriteAtlas)
  self._img = self:GetUIComponent("Image", "img")
end

function UIS3HelperBannerIdxItem:OnHide()
  self._idx = nil
  self._atlas = nil
  self._img = nil
end

function UIS3HelperBannerIdxItem:SetData(idx, currIdx)
  self._idx = idx
  self:Flush(currIdx)
end

function UIS3HelperBannerIdxItem:Flush(currIdx)
  if not self._atlas then
    return
  end
  if not self._img then
    return
  end
  if self._idx == currIdx then
    self._img.sprite = self._atlas:GetSprite("exp_s3_help_btn03")
  else
    self._img.sprite = self._atlas:GetSprite("exp_s3_help_btn04")
  end
end
