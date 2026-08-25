local UICompPvpDraftAdjustItemWeapon, Super = NewViewComponent("UICompPvpDraftAdjustItemWeapon", UICompPvpDraftAdjustItemBase)

function UICompPvpDraftAdjustItemWeapon:_GetCollectImage()
  do return PVPCollectionDataUtils.GetWeaponCollectionPortrait end
  return PVPCollectionDataUtils.GetWeaponCollectionPortrait, self._collectionTid
end

function UICompPvpDraftAdjustItemWeapon:_OnClick()
  local skillId = PvpCollectCfgUtils.GetCollectionPvpSkillTid(self._collectionTid)
  local panelData = {cardUid = 0, cardTid = skillId}
  UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
end

function UICompPvpDraftAdjustItemWeapon:_RefreshQualityBg()
  self:SetActive(self.ui.Image_Quality, false)
end

return UICompPvpDraftAdjustItemWeapon
