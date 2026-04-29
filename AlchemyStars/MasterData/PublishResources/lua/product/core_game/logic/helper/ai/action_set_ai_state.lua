require("ai_node_new")
_class("ActionSetAIState", AINewNode)
ActionSetAIState = ActionSetAIState

function ActionSetAIState:OnBegin()
  local state = self:GetLogicData(-1)
  local aiCmpt = self.m_entityOwn:AI()
  aiCmpt:SetAITreeState(state)
  self:PrintLog("state=", state)
end
