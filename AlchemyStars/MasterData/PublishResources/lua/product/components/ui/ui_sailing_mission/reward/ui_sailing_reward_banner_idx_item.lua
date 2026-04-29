_class("UISailingRewardBannerIdxItem", UICustomWidget)
UISailingRewardBannerIdxItem = UISailingRewardBannerIdxItem

function UISailingRewardBannerIdxItem:OnShow()
  self._atlas = self:GetAsset("UISailingReward.spriteatlas", LoadType.SpriteAtlas)
  self._img = self:GetUIComponent("Image", "img")
end

function UISailingRewardBannerIdxItem:OnHide()
  self._idx = nil
  self._atlas = nil
  self._img = nil
end

function UISailingRewardBannerIdxItem:SetData(idx, currIdx)
  self._idx = idx
  self:Flush(currIdx)
end

function UISailingRewardBannerIdxItem:Flush(currIdx)
  if not self._atlas then
    return
  end
  if not self._img then
    return
  end
  if self._idx == currIdx then
    self._img.sprite = self._atlas:GetSprite("N22_dhh_jlts_ym02")
  else
    self._img.sprite = self._atlas:GetSprite("N22_dhh_jlts_ym01")
  end
end
