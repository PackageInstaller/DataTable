_class("StateDiscoveryInit", StateDiscoveryBase)
StateDiscoveryInit = StateDiscoveryInit

function StateDiscoveryInit:OnEnter(TT, ...)
  StateDiscoveryInit.super:OnEnter(TT, ...)
  self:Init()
  self._imgSR.raycastTarget = true
end

function StateDiscoveryInit:OnExit(TT)
  self._imgSR.raycastTarget = false
end
