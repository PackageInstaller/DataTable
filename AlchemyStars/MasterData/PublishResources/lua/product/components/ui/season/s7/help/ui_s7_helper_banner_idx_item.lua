_class("UIS7HelperBannerIdxItem", UICustomWidget)
UIS7HelperBannerIdxItem = UIS7HelperBannerIdxItem

function UIS7HelperBannerIdxItem:OnShow()
  self._atlas = self:GetAsset("UIS7Main.spriteatlas", LoadType.SpriteAtlas)
  self._img = self:GetUIComponent("Image", "img")
end

function UIS7HelperBannerIdxItem:OnHide()
  self._idx = nil
  self._atlas = nil
  self._img = nil
end

function UIS7HelperBannerIdxItem:SetData(idx, currIdx)
  self._idx = idx
  self:Flush(currIdx)
end

function UIS7HelperBannerIdxItem:Flush(currIdx)
  if not self._atlas then
    return
  end
  if not self._img then
    return
  end
  if self._idx == currIdx then
    self._img.sprite = self._atlas:GetSprite("exp_S7_help_di05")
  else
    self._img.sprite = self._atlas:GetSprite("exp_S7_help_di06")
  end
end
