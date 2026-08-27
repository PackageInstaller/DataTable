local DormFightCtrlBase = class("DormFightCtrlBase")

function DormFightCtrlBase:ctor(owner)
  self.owner = owner
  table.insert(owner.ctrls, self)
end

function DormFightCtrlBase:OnInit()
end

function DormFightCtrlBase:OnUpdate(deltaTime)
end

function DormFightCtrlBase:OnEnterFightScene()
end

function DormFightCtrlBase:OnFightStart()
end

function DormFightCtrlBase:OnFightTrueStart()
end

function DormFightCtrlBase:OnFightEnd()
end

function DormFightCtrlBase:OnExitFightScene()
end

return DormFightCtrlBase
