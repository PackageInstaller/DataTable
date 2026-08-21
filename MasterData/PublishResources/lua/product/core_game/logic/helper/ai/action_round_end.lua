require("ai_node_new")
_class("ActionRoundEnd", AINewNode)
ActionRoundEnd = ActionRoundEnd

function ActionRoundEnd:OnBegin()
  local aiCmpt = self.m_entityOwn:AI()
  if aiCmpt then
    aiCmpt:SetAIRoundEnd(true)
    aiCmpt:SetMoveState(AIMoveState.MoveEnd)
    self:PrintLog(" 本次回合结束")
  end
end
