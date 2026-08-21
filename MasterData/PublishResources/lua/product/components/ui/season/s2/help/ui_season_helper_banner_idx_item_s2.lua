_class("UISeasonHelperBannerIdxItemS2", UICustomWidget)
UISeasonHelperBannerIdxItemS2 = UISeasonHelperBannerIdxItemS2

function UISeasonHelperBannerIdxItemS2:OnShow()
  self._atlas = self:GetAsset("UIS2Main.spriteatlas", LoadType.SpriteAtlas)
  self._img = self:GetUIComponent("Image", "img")
end

function UISeasonHelperBannerIdxItemS2:OnHide()
  self._idx = nil
  self._atlas = nil
  self._img = nil
end

function UISeasonHelperBannerIdxItemS2:SetData(idx, currIdx)
  self._idx = idx
  self:Flush(currIdx)
end

function UISeasonHelperBannerIdxItemS2:Flush(currIdx)
  if not self._atlas then
    return
  end
  if not self._img then
    return
  end
  if self._idx == currIdx then
    self._img.sprite = self._atlas:GetSprite("exp_s2_help_di05")
  else
    self._img.sprite = self._atlas:GetSprite("exp_s2_help_di06")
  end
end
