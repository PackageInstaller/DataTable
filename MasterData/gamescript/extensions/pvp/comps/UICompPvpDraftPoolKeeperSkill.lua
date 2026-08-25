local UICompPvpDraftPoolKeeperSkill, Super = NewViewComponent("UICompPvpDraftPoolKeeperSkill", UICompPvpDraftPoolBase)

function UICompPvpDraftPoolKeeperSkill:_GetCollectImage()
  do return PvpCollectCfgUtils.GetCfgField, "DetailsImage" end
  return PvpCollectCfgUtils.GetCfgField, "DetailsImage", self._collectionTid
end

function UICompPvpDraftPoolKeeperSkill:_GetCollectName()
  do return PvpCollectCfgUtils.GetCollectionPvpSkillName end
  return PvpCollectCfgUtils.GetCollectionPvpSkillName, self._collectionTid
end

function UICompPvpDraftPoolKeeperSkill:_RefreshQualityBg()
  self:SetActive(self.ui.Image_Quality, true)
end

function UICompPvpDraftPoolKeeperSkill:_IsCanNotSelect()
  do return PvpDraftModel.Instance.IsPlayerCollectionTypeFully, PvpDraftModel.Instance end
  return PvpDraftModel.Instance.IsPlayerCollectionTypeFully, PvpDraftModel.Instance, self._collectionTid
end

return UICompPvpDraftPoolKeeperSkill
