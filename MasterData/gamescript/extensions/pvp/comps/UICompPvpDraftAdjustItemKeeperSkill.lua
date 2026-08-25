local UICompPvpDraftAdjustItemKeeperSkill, Super = NewViewComponent("UICompPvpDraftAdjustItemKeeperSkill", UICompPvpDraftAdjustItemBase)

function UICompPvpDraftAdjustItemKeeperSkill:_GetCollectImage()
  do return PvpCollectCfgUtils.GetCfgField, "DetailsImage" end
  return PvpCollectCfgUtils.GetCfgField, "DetailsImage", self._collectionTid
end

function UICompPvpDraftAdjustItemKeeperSkill:_OnClick()
  local skillId = PvpCollectCfgUtils.GetCollectionPvpSkillTid(self._collectionTid)
  local panelData = {cardUid = 0, cardTid = skillId}
  UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
end

function UICompPvpDraftAdjustItemKeeperSkill:_RefreshQualityBg()
  self:SetActive(self.ui.Image_Quality, false)
end

return UICompPvpDraftAdjustItemKeeperSkill
