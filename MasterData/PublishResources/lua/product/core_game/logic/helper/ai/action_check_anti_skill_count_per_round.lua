require("ai_node_new")
_class("ActionCheckAntiSkillCountPerRound", AINewNode)
ActionCheckAntiSkillCountPerRound = ActionCheckAntiSkillCountPerRound

function ActionCheckAntiSkillCountPerRound:OnUpdate()
  local attributeCmpt = self.m_entityOwn:Attributes()
  local curValue = attributeCmpt:GetAttribute("MaxAntiSkillCountPerRound") or 1
  if 1 <= curValue then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
