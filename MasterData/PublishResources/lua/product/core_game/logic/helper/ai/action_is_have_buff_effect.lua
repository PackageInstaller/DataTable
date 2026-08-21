require("ai_node_new")
_class("ActionIsHaveBuffEffect", AINewNode)
ActionIsHaveBuffEffect = ActionIsHaveBuffEffect

function ActionIsHaveBuffEffect:OnUpdate()
  local com = self.m_entityOwn:BuffComponent()
  local buffEffect = self:GetLogicData(-1)
  local buffID = self:GetLogicData(-2)
  if com and (com:HasBuffEffect(buffEffect) or com:GetBuffById(buffID)) then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
