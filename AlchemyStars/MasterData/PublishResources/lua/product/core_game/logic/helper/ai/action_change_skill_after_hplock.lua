require("ai_node_new")
_class("ActionChangeSkillAfterHPLock", AINewNode)
ActionChangeSkillAfterHPLock = ActionChangeSkillAfterHPLock

function ActionChangeSkillAfterHPLock:Constructor()
  self._hasTrigger = false
  self.skillID = self:GetLogicData(-1)
  self._blockRound = nil
end

function ActionChangeSkillAfterHPLock:OnUpdate(dt)
  if self._hasTrigger then
    return AINewNodeStatus.Failure
  end
  local buffCmpt = self.m_entityOwn:BuffComponent()
  if buffCmpt:HpHasLocked() or self._blockRound then
    local battleStat = self._world:BattleStat()
    local curRound = battleStat:GetLevelTotalRoundCount()
    if not self._blockRound then
      self._blockRound = curRound
    end
    if curRound - self._blockRound >= 1 then
      self._hasTrigger = true
      return AINewNodeStatus.Success
    else
      return AINewNodeStatus.Failure
    end
  else
    return AINewNodeStatus.Failure
  end
end
