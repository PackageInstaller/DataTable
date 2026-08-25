local HitBoxArriveCondition, Super = System.NewClass("HitBoxArriveCondition", HitBoxBaseCondition)

function HitBoxArriveCondition:ctor()
  Super.ctor(self)
end

function HitBoxArriveCondition:OnEnter()
  Super.OnEnter(self)
end

function HitBoxArriveCondition:OnTriggerEnter()
  Super.OnTriggerEnter(self)
  EventMgr.Instance.HitBoxTrigger:Dispatch(self.uid, self.triggerItemType)
end

function HitBoxArriveCondition:OnExit()
  Super.OnExit(self)
end

return HitBoxArriveCondition
