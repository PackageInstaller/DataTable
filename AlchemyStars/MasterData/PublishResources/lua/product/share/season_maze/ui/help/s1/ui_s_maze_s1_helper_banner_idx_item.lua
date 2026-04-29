_class("UISMazeS1HelperBannerIdxItem", UICustomWidget)
UISMazeS1HelperBannerIdxItem = UISMazeS1HelperBannerIdxItem

function UISMazeS1HelperBannerIdxItem:OnShow()
  self._atlas = self:GetAsset("UIS5Main.spriteatlas", LoadType.SpriteAtlas)
  self._img = self:GetUIComponent("Image", "img")
end

function UISMazeS1HelperBannerIdxItem:OnHide()
  self._idx = nil
  self._atlas = nil
  self._img = nil
end

function UISMazeS1HelperBannerIdxItem:SetData(idx, currIdx)
  self._idx = idx
  self:Flush(currIdx)
end

function UISMazeS1HelperBannerIdxItem:Flush(currIdx)
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
