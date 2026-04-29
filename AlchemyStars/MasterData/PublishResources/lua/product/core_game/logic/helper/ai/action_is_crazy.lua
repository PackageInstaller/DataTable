require("ai_node_new")
_class("ActionIsCrazy", AINewNode)
ActionIsCrazy = ActionIsCrazy

function ActionIsCrazy:OnUpdate()
  if self.m_entityOwn:HasCrazyMode() then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end

_class("ActionBeCrazy", AINewNode)
ActionBeCrazy = ActionBeCrazy

function ActionBeCrazy:OnUpdate()
  self.m_entityOwn:ReplaceCrazyMode()
  return AINewNodeStatus.Success
end
