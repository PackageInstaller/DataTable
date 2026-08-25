local ActorStateComponent, Super = System.NewClass("ActorStateComponent", Component)

function ActorStateComponent:ctor()
  Super.ctor(self)
  self.state = nil
  self.stateType = CommonDefine.RoleStateType.Idle
  self.states = {}
end

function ActorStateComponent:Awake(binder)
  Super.Awake(self)
  self:InitState()
  self:ChangeFsmState(self.stateType)
end

function ActorStateComponent:InitState()
end

function ActorStateComponent:ChangeFsmState(type)
  self.stateType = type
  if self.state then
    self.state:Exit()
  end
  self.state = self.states[self.stateType]
  self.state:Enter()
end

function ActorStateComponent:Move(x, y)
end

function ActorStateComponent:MoveEnd()
end

function ActorStateComponent:IsIdle()
  return self.stateType == CommonDefine.RoleStateType.Idle
end

function ActorStateComponent:ChangeDir()
  if self.stateType == CommonDefine.RoleStateType.Idle then
    self.state:ChangeDir()
  end
end

function ActorStateComponent:ResetToIdle()
  if self.stateType == CommonDefine.RoleStateType.Idle then
    self.state:Enter()
  end
end

function ActorStateComponent:OnDestroy()
  Super.OnDestroy(self)
  if self.state then
    self.state:Exit()
  end
  self.states = {}
end

return ActorStateComponent
