require("ai_node_new")
_class("ActionSetFlag", AINewNode)
ActionSetFlag = ActionSetFlag

function ActionSetFlag:Constructor()
end

function ActionSetFlag:OnUpdate()
  local flag = self:GetLogicData(-1)
  local aiComponent = self.m_entityOwn:AI()
  aiComponent:SetRuntimeData(flag, true)
  return AINewNodeStatus.Success
end
