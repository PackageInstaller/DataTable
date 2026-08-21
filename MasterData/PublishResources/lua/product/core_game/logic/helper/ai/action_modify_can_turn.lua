require("ai_node_new")
_class("ActionModifyCanTurn", AINewNode)
ActionModifyCanTurn = ActionModifyCanTurn

function ActionModifyCanTurn:Constructor()
  local n = 0
end

function ActionModifyCanTurn:OnBegin()
  local aiComponent = self.m_entityOwn:AI()
  local canTurn = self:GetLogicData(-1)
  aiComponent:SetCanTurn(canTurn)
end

function ActionModifyCanTurn:OnUpdate(dt)
  return AINewNodeStatus.Success
end
