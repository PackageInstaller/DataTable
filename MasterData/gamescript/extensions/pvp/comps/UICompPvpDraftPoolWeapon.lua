local UICompPvpDraftPoolWeapon, Super = NewViewComponent("UICompPvpDraftPoolWeapon", UICompPvpDraftPoolBase)

function UICompPvpDraftPoolWeapon:_GetCollectImage()
  do return PVPCollectionDataUtils.GetWeaponCollectionPortrait end
  return PVPCollectionDataUtils.GetWeaponCollectionPortrait, self._collectionTid
end

function UICompPvpDraftPoolWeapon:_GetCollectName()
  do return PvpCollectCfgUtils.GetCollectionPvpSkillName end
  return PvpCollectCfgUtils.GetCollectionPvpSkillName, self._collectionTid
end

function UICompPvpDraftPoolWeapon:_RefreshQualityBg()
  self:SetActive(self.ui.Image_Quality, true)
end

function UICompPvpDraftPoolWeapon:_IsCanNotSelect()
  do return PvpDraftModel.Instance.IsPlayerCollectionTypeFully, PvpDraftModel.Instance end
  return PvpDraftModel.Instance.IsPlayerCollectionTypeFully, PvpDraftModel.Instance, self._collectionTid
end

return UICompPvpDraftPoolWeapon
