require("ai_node_new")
_class("ActionForceEnd", AINewNode)
ActionForceEnd = ActionForceEnd

function ActionForceEnd:OnBegin()
  local aiComponent = self.m_entityOwn:AI()
  aiComponent:SetMoveState(AIMoveState.MoveEnd)
  aiComponent:ClearMobilityTotal()
  self:PrintLog(" 强制结束，清空行动力")
end
