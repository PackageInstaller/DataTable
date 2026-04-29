require("ai_node_new")
_class("ActionIsDirection", AINewNode)
ActionIsDirection = ActionIsDirection

function ActionIsDirection:OnBegin()
  self._dir = Vector2.up
  self.dir.x = self:GetLogicData(-1)
  self.dir.y = self:GetLogicData(-2)
end

function ActionIsDirection:OnUpdate(dt)
  if self.m_entityOwn:GridLocation().Direction == self.dir then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
