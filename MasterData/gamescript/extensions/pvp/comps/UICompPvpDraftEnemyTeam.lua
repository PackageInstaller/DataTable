local UICompPvpDraftEnemyTeam, Super = NewViewComponent("UICompPvpDraftEnemyTeam", UICompPvpDraftPlayerTeam)

function UICompPvpDraftEnemyTeam:_GetPlayerData()
  do return PvpDraftModel.Instance.GetEnemyPlayerData end
  return PvpDraftModel.Instance.GetEnemyPlayerData, PvpDraftModel.Instance
end

return UICompPvpDraftEnemyTeam
