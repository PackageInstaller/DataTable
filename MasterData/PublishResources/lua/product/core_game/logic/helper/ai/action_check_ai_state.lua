require("action_is_base")
_class("ActionCheckAIState", ActionIsBase)
ActionCheckAIState = ActionCheckAIState

function ActionCheckAIState:OnUpdate()
  local aiCmpt = self.m_entityOwn:AI()
  local curState = aiCmpt:GetAITreeState()
  return AINewNodeStatus.Other + curState
end
