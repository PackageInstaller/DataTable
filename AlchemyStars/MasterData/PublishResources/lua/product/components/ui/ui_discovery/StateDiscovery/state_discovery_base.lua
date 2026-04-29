_class("StateDiscoveryBase", State)
StateDiscoveryBase = StateDiscoveryBase

function StateDiscoveryBase:Init()
  self.fsm = self:GetFsm()
  self._ui = self.fsm:GetData()
  self._data = self._ui._data
  self._sr = self._ui._sr
  self._imgSR = self._ui._imgSR
  self._cg = self._ui._cg
  self._scaleStep = self._ui._scaleStep
  self._scaleMin = self._ui._scaleMin
  self._scaleMax = self._ui._scaleMax
end

function StateDiscoveryBase:Destroy()
  StateDiscoveryBase.super:Destroy()
  self._ui = nil
end
