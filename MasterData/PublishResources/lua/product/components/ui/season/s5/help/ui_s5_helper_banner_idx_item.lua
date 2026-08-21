_class("UIS5HelperBannerIdxItem", UICustomWidget)
UIS5HelperBannerIdxItem = UIS5HelperBannerIdxItem

function UIS5HelperBannerIdxItem:OnShow()
  self._atlas = self:GetAsset("UIS5Main.spriteatlas", LoadType.SpriteAtlas)
  self._img = self:GetUIComponent("Image", "img")
end

function UIS5HelperBannerIdxItem:OnHide()
  self._idx = nil
  self._atlas = nil
  self._img = nil
end

function UIS5HelperBannerIdxItem:SetData(idx, currIdx)
  self._idx = idx
  self:Flush(currIdx)
end

function UIS5HelperBannerIdxItem:Flush(currIdx)
  if not self._atlas then
    return
  end
  if not self._img then
    return
  end
  if self._idx == currIdx then
    self._img.sprite = self._atlas:GetSprite("exp_s5_help_di05")
  else
    self._img.sprite = self._atlas:GetSprite("exp_s5_help_di06")
  end
end
