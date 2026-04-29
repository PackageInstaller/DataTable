require("ai_node_new")
_class("ActionChangeSkillAfterSwitchMultiHP", AINewNode)
ActionChangeSkillAfterSwitchMultiHP = ActionChangeSkillAfterSwitchMultiHP

function ActionChangeSkillAfterSwitchMultiHP:Constructor()
  self._hasTrigger = false
  self.skillID = self:GetLogicData(-1)
  self._blockRound = nil
end

function ActionChangeSkillAfterSwitchMultiHP:OnUpdate()
  if self._hasTrigger then
    return AINewNodeStatus.Failure
  end
  local monsterIDComponent = self.m_entityOwn:MonsterID()
  local battleCmpt = self._world:BattleStat()
  local curRound = battleCmpt:GetLevelTotalRoundCount()
  for _, multiHPSwitchRound in ipairs(monsterIDComponent._multiHPSwitchRound) do
    if 1 <= curRound - multiHPSwitchRound then
      self._hasTrigger = true
      return AINewNodeStatus.Success
    else
      return AINewNodeStatus.Failure
    end
  end
  return AINewNodeStatus.Failure
end
