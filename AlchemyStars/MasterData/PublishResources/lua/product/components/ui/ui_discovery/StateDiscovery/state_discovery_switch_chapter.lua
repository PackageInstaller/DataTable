_class("StateDiscoverySwitchChapter", StateDiscoveryBase)
StateDiscoverySwitchChapter = StateDiscoverySwitchChapter

function StateDiscoverySwitchChapter:OnEnter(TT, ...)
  StateDiscoverySwitchChapter.super:OnEnter(TT, ...)
  self:Init()
  self._ui:Lock("StateDiscoverySwitchChapter")
  self._ui:Flush()
  self:ChangeState(StateDiscovery.Init)
end

function StateDiscoverySwitchChapter:OnExit(TT)
  self._ui:UnLock("StateDiscoverySwitchChapter")
end
