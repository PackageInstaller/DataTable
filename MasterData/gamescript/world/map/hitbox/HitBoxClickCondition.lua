local HitBoxClickCondition, Super = System.NewClass("HitBoxClickCondition", HitBoxBaseCondition)

function HitBoxClickCondition:ctor()
  Super.ctor(self)
end

function HitBoxClickCondition:OnEnter()
  Super.OnEnter(self)
  self.checkSuccess = false
end

function HitBoxClickCondition:OnTriggerEnter()
  Super.OnTriggerEnter(self)
  EventMgr.Instance.MoveJoyHitBox:RegisterEvent(System.fn(self, self.OnHitBox))
end

function HitBoxClickCondition:OnTriggerExit()
  Super.OnTriggerExit(self)
  EventMgr.Instance.MoveJoyHitBox:RemoveEvent(System.fn(self, self.OnHitBox))
end

function HitBoxClickCondition:OnHitBox(uid)
  if uid == self.uid and self:GetIsTriggered() then
    EventMgr.Instance.HitBoxTrigger:Dispatch(self.uid, self.triggerItemType)
  end
end

function HitBoxClickCondition:OnExit()
  Super.OnExit(self)
  EventMgr.Instance.MoveJoyHitBox:RemoveEvent(System.fn(self, self.OnHitBox))
end

return HitBoxClickCondition
