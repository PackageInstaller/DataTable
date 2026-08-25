local UICompPvpDraftTeamItemKeeperSkill, Super = NewViewComponent("UICompPvpDraftTeamItemKeeperSkill", UICompPvpDraftTeamItemBase)

function UICompPvpDraftTeamItemKeeperSkill:_GetCollectImage()
  do return PvpCollectCfgUtils.GetCfgField, "CollectImage" end
  return PvpCollectCfgUtils.GetCfgField, "CollectImage", self._collectionTid
end

function UICompPvpDraftTeamItemKeeperSkill:_RefreshQualityBg()
  self:SetActive(self.ui.Image_Quality, false)
end

return UICompPvpDraftTeamItemKeeperSkill
