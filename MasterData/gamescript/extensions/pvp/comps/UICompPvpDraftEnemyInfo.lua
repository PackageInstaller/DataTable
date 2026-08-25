local UICompPvpDraftEnemyInfo, Super = NewViewComponent("UICompPvpDraftEnemyInfo", UICompPvpDraftPlayerInfo)

function UICompPvpDraftEnemyInfo:OnBuildComponent()
  self._teamInfoComp = self:AddViewComponentOnce(self.ui.UI_PVP_Item_RotationTeamInfo, UICompPvpDraftEnemyTeam)
end

function UICompPvpDraftEnemyInfo:_GetPlayerData()
  do return PvpDraftModel.Instance.GetEnemyPlayerData end
  return PvpDraftModel.Instance.GetEnemyPlayerData, PvpDraftModel.Instance
end

function UICompPvpDraftEnemyInfo:_GetShowCollectionTid()
  local rst = PvpDraftModel.Instance:GetEnemySelectCollectionTid()
  rst = rst or self:_GetLastCollectionTid()
  return rst
end

return UICompPvpDraftEnemyInfo
