local GearItemObstacle, Super = System.NewClass("GearItemObstacle", GearItemBase)

function GearItemObstacle:OnTriggerChild(data)
  self:EnterObstacle(data)
end

function GearItemObstacle:EnterObstacle(data)
  self.isMoveAfterTrigger = true
  self:OpenEventPanel(data)
end

function GearItemObstacle:OnRemove()
  if self.isMoveAfterTrigger then
    self.isMoveAfterTrigger = false
    local x, y = self:GetGridPos()
    EventMgr.Instance.GearRoleMove:Dispatch(x, y)
  end
  Super.OnRemove(self)
end

return GearItemObstacle
