require("ai_node_new")
_class("ActionIsSkipTurn", AINewNode)
ActionIsSkipTurn = ActionIsSkipTurn

function ActionIsSkipTurn:Constructor()
end

function ActionIsSkipTurn:OnUpdate(dt)
  local bSkipTurn = false
  local buffCmpt = self.m_entityOwn:BuffComponent()
  if buffCmpt then
    bSkipTurn = buffCmpt:HasFlag(BuffFlags.SkipTurn)
  end
  if bSkipTurn then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
