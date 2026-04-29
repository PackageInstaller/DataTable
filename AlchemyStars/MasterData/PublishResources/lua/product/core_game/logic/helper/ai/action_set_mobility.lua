require("ai_node_new")
_class("ActionSetMobility", AINewNode)
ActionSetMobility = ActionSetMobility

function ActionSetMobility:OnBegin()
  local mobility = self:GetLogicData(-1)
  local aiCmpt = self.m_entityOwn:AI()
  aiCmpt:SetMobilityTotal(mobility)
end
