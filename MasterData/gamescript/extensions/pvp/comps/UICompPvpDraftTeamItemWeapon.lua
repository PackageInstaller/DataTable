local UICompPvpDraftTeamItemWeapon, Super = NewViewComponent("UICompPvpDraftTeamItemWeapon", UICompPvpDraftTeamItemBase)

function UICompPvpDraftTeamItemWeapon:_GetCollectImage()
  do return PVPCollectionDataUtils.GetWeaponCollectionPortrait end
  return PVPCollectionDataUtils.GetWeaponCollectionPortrait, self._collectionTid
end

function UICompPvpDraftTeamItemWeapon:_RefreshQualityBg()
  self:SetActive(self.ui.Image_Quality, false)
end

return UICompPvpDraftTeamItemWeapon
