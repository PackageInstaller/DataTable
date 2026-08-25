local ActorEntity, Super = System.NewClass("ActorEntity", Entity)

function ActorEntity:ctor(uid, tid)
  Super.ctor(self)
  self.uid = uid
  self.tid = tid
end

function ActorEntity:AsyncLoadEnd()
  EventMgr.Instance.CreateActor:Dispatch(self.uid, self)
end

function ActorEntity:GetPosition()
  Logger.Debug("GetPosition self.uid == " .. self.uid)
end

function ActorEntity:SetPosition(x, y, z)
  Logger.Debug("SetPosition self.uid == " .. self.uid)
end

function ActorEntity:GetHead()
end

return ActorEntity
