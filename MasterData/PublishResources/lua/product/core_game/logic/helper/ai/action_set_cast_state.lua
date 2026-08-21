require("ai_node_new")
_class("ActionSetCastState", AINewNode)
ActionSetCastState = ActionSetCastState

function ActionSetCastState:OnBegin()
  local state = self:GetLogicData(-1)
  local aiCmpt = self.m_entityOwn:AI()
  aiCmpt:SetCastState(state)
  self:PrintLog(state)
end
