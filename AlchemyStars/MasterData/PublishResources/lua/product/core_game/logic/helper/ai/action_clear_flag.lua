require("ai_node_new")
_class("ActionClearFlag", AINewNode)
ActionClearFlag = ActionClearFlag

function ActionClearFlag:Constructor()
end

function ActionClearFlag:OnUpdate()
  local flag = self:GetLogicData(-1)
  local aiComponent = self.m_entityOwn:AI()
  aiComponent:SetRuntimeData(flag, false)
  return AINewNodeStatus.Success
end
