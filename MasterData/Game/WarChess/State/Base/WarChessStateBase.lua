local WarChessStateBase = class("WarChessStateBase")

function WarChessStateBase:ctor(wcCtrl)
  self.wcCtrl = wcCtrl
end

function WarChessStateBase:EnterState(enterArgs)
  self:OnEnterState(enterArgs)
end

function WarChessStateBase:OnEnterState()
end

function WarChessStateBase:ExitState()
  self:OnExitState()
end

function WarChessStateBase:OnExitState()
end

function WarChessStateBase:IsCanOpenMenu()
  return true
end

return WarChessStateBase
