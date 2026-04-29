_class("UISeasonHelperBannerIdxItem", UICustomWidget)
UISeasonHelperBannerIdxItem = UISeasonHelperBannerIdxItem

function UISeasonHelperBannerIdxItem:OnShow()
  self._atlas = self:GetAsset("UIS1Help.spriteatlas", LoadType.SpriteAtlas)
  self._img = self:GetUIComponent("Image", "img")
end

function UISeasonHelperBannerIdxItem:OnHide()
  self._idx = nil
  self._atlas = nil
  self._img = nil
end

function UISeasonHelperBannerIdxItem:SetData(idx, currIdx)
  self._idx = idx
  self:Flush(currIdx)
end

function UISeasonHelperBannerIdxItem:Flush(currIdx)
  if not self._atlas then
    return
  end
  if not self._img then
    return
  end
  if self._idx == currIdx then
    self._img.sprite = self._atlas:GetSprite("help_bz_icon03")
  else
    self._img.sprite = self._atlas:GetSprite("help_bz_icon04")
  end
end
