require("ai_node_new")
_class("ActionRoundSwitchMultiHP", AINewNode)
ActionRoundSwitchMultiHP = ActionRoundSwitchMultiHP

function ActionRoundSwitchMultiHP:Constructor()
end

function ActionRoundSwitchMultiHP:OnUpdate()
  local monsterIDComponent = self.m_entityOwn:MonsterID()
  local battleCmpt = self._world:BattleStat()
  local curRound = battleCmpt:GetLevelTotalRoundCount()
  if monsterIDComponent:IsRoundSwitchMultiHP(curRound) then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
