require("ai_node_new")
_class("ActionIsHPLessThan", AINewNode)
ActionIsHPLessThan = ActionIsHPLessThan

function ActionIsHPLessThan:OnUpdate()
  local hp = self.m_entityOwn:Attributes():GetCurrentHP()
  local hpMax = self.m_entityOwn:Attributes():GetAttribute("MaxHP")
  local percent = self:GetLogicData(-1)
  if percent > hp / hpMax then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
