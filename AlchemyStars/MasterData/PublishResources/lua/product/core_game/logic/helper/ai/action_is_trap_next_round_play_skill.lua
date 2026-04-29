require("ai_node_new")
_class("ActionIsTrapNextRoundPlaySkill", AINewNode)
ActionIsTrapNextRoundPlaySkill = ActionIsTrapNextRoundPlaySkill

function ActionIsTrapNextRoundPlaySkill:OnUpdate(dt)
  local attrCmpt = self.m_entityOwn:Attributes()
  local totalRound = attrCmpt:GetAttribute("TotalRound")
  local curRound = attrCmpt:GetAttribute("CurrentRound")
  if totalRound == curRound then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
