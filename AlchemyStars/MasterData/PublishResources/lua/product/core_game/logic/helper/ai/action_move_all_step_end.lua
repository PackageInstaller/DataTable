require("ai_node_new")
_class("ActionMoveAllStepEnd", AINewNode)
ActionMoveAllStepEnd = ActionMoveAllStepEnd

function ActionMoveAllStepEnd:OnBegin()
  local aiCmpt = self.m_entityOwn:AI()
  if aiCmpt then
    aiCmpt:ClearMobilityTotal()
    aiCmpt:SetMoveState(AIMoveState.MoveEnd)
    self:PrintLog(" 强制结束，清空行动力")
  end
end
