require("ai_node_new")
_class("ActionIsBase", AINewNode)
ActionIsBase = ActionIsBase

function ActionIsBase:OnUpdate()
  if AINewNode.IsEntityDead(self.m_entityOwn) then
    return AINewNodeStatus.Failure
  end
  return AINewNodeStatus.Failure
end

function ActionIsBase:_IsBodyInSkillRange(bodyArea, skillRange)
  for i = 1, #bodyArea do
    for j = 1, #skillRange do
      if bodyArea[i] == skillRange[j] then
        return true
      end
    end
  end
  return false
end

function ActionIsBase:_IsTargetInSkillRange(entityTarget, skillRange)
  if AINewNode.IsEntityDead(self.m_entityOwn) then
    return false
  end
  local targetPos = entityTarget:GridLocation().Position
  local bodyArea = entityTarget:GetCoverAreaList(targetPos)
  local bInSkillRange = self:_IsBodyInSkillRange(bodyArea, skillRange)
  return bInSkillRange
end
