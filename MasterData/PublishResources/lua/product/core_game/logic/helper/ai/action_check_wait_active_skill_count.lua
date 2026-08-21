require("ai_node_new")
_class("ActionCheckWaitActiveSkillCount", AINewNode)
ActionCheckWaitActiveSkillCount = ActionCheckWaitActiveSkillCount

function ActionCheckWaitActiveSkillCount:OnUpdate()
  local target = self:GetLogicData(-1) or 1
  local attributeCmpt = self.m_entityOwn:Attributes()
  local curValue = attributeCmpt:GetAttribute("WaitActiveSkillCount") or 1
  if target >= curValue then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
