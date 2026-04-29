require("stn_infrastructure_end")
_class("Infrastructure_SilentEnd", Infrastructure_End)
Infrastructure_SilentEnd = Infrastructure_SilentEnd

function Infrastructure_SilentEnd:OnWorking()
  self.m_pManager:OnTestRobot_End()
  return Infrastructure_SilentEnd.super.OnWorking(self)
end

function Infrastructure_SilentEnd:OnEnd(...)
  local nReturn = Infrastructure_SilentEnd.super.OnEnd(self, ...)
  self.m_pManager:WriteProgressEnd()
  self.m_pManager:OnTestRobot_End()
  self.m_pManager:StopAutoTest()
  return nReturn
end
