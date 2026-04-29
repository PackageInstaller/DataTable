require("action_is_base")
_class("ActionCheckCurseTowerIndex", ActionIsBase)
ActionCheckCurseTowerIndex = ActionCheckCurseTowerIndex

function ActionCheckCurseTowerIndex:OnUpdate()
  local aiCmpt = self.m_entityOwn:AI()
  local curseTowerCmpt = self.m_entityOwn:CurseTower()
  if not curseTowerCmpt then
    return AINewNodeStatus.Failure
  end
  local myTowerIndex = curseTowerCmpt:GetTowerIndex()
  local levelRound = self._world:BattleStat():GetLevelTotalRoundCount()
  local battleFlagsCmpt = self._world:BattleFlags()
  local currentTowerIndex = battleFlagsCmpt:GetCurrentCurseTowerIndex()
  local canCurseRound = battleFlagsCmpt:GetCurrentCurseTowerRound()
  if canCurseRound ~= levelRound then
    return AINewNodeStatus.Failure
  end
  if currentTowerIndex ~= myTowerIndex then
    return AINewNodeStatus.Failure
  end
  return AINewNodeStatus.Success
end
