local DormFightCameraStateBase = class("DormFightCameraStateBase")

function DormFightCameraStateBase:Init(owner)
  self._owner = owner
  self:OnInit()
end

function DormFightCameraStateBase:OnInit()
end

function DormFightCameraStateBase:OnEnter(prevState)
end

function DormFightCameraStateBase:OnExit(nextState)
end

function DormFightCameraStateBase:OnUpdate(deltaTime)
end

return DormFightCameraStateBase
