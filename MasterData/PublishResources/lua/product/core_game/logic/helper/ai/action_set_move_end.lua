require("ai_node_new")
_class("ActionSetMoveEnd", AINewNode)
ActionSetMoveEnd = ActionSetMoveEnd

function ActionSetMoveEnd:OnBegin()
  local state = self:GetLogicData(-1)
  local aiCmpt = self.m_entityOwn:AI()
  aiCmpt:SetMoveState(AIMoveState.MoveEnd)
  self:PrintLog("无移动行为，设置为移动结束状态")
end
