require("ai_node_new")
_class("ActionUpdateCurseTowerIndex", AINewNode)
ActionUpdateCurseTowerIndex = ActionUpdateCurseTowerIndex

function ActionUpdateCurseTowerIndex:OnBegin()
  local curseTowerCmpt = self.m_entityOwn:CurseTower()
  if not curseTowerCmpt then
    self:PrintLog("user is not curse tower!")
    return AINewNodeStatus.Failure
  end
  curseTowerCmpt:SetTowerState(CurseTowerState.Active)
  local myTowerIndex = curseTowerCmpt:GetTowerIndex()
  local nextTowerIndex = myTowerIndex + 1
  if 4 < nextTowerIndex then
    nextTowerIndex = 1
  end
  local levelRound = self._world:BattleStat():GetLevelTotalRoundCount()
  local nextCurseRound = levelRound + 1
  local battleFlagsCmpt = self._world:BattleFlags()
  battleFlagsCmpt:SetCurrentCurseTowerIndex(nextTowerIndex)
  battleFlagsCmpt:SetCurrentCurseTowerRound(nextCurseRound)
  self:PrintLog("nextTowerIndex=", nextTowerIndex)
end
