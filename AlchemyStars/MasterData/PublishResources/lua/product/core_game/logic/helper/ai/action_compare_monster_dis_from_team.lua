require("ai_node_new")
_class("ActionCompareMonsterDisFromTeam", AINewNode)
ActionCompareMonsterDisFromTeam = ActionCompareMonsterDisFromTeam

function ActionCompareMonsterDisFromTeam:OnUpdate()
  local monsterClassID = self:GetLogicData(-1)
  local compareType = self:GetLogicData(-2)
  local casterEntity = self.m_entityOwn
  local targetEntity
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  if monsterGroup then
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() and monsterClassID == monsterEntity:MonsterID():GetMonsterClassID() then
        targetEntity = monsterEntity
        break
      end
    end
  end
  if not targetEntity then
    return AINewNodeStatus.Failure
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local distanceCaster = Vector2.Distance(casterEntity:GetGridPosition(), teamPos)
  local distanceTarget = Vector2.Distance(targetEntity:GetGridPosition(), teamPos)
  local satisfied = false
  if compareType == ComparisonOperator.EQ then
    satisfied = distanceCaster == distanceTarget
  elseif compareType == ComparisonOperator.NE then
    satisfied = distanceCaster ~= distanceTarget
  elseif compareType == ComparisonOperator.GT then
    satisfied = distanceCaster > distanceTarget
  elseif compareType == ComparisonOperator.GE then
    satisfied = distanceCaster >= distanceTarget
  elseif compareType == ComparisonOperator.LT then
    satisfied = distanceCaster < distanceTarget
  elseif compareType == ComparisonOperator.LE then
    satisfied = distanceCaster <= distanceTarget
  end
  if satisfied == true then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
