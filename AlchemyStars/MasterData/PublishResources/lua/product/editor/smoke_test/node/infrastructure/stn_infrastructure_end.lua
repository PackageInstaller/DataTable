require("base_state_node")
_class("Infrastructure_End", CTestRobot_Base)
Infrastructure_End = Infrastructure_End

function Infrastructure_End:OnWorking()
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  WorkWXPoster.SendInfo("测试结束")
  self.m_pManager:PrintLog(self._className, "测试结束")
  self.m_pManager:WriteProgressEnd()
  self.m_pManager:OnTestRobot_End()
  return Infrastructure_End.super.OnWorking(self)
end

function Infrastructure_End:OnEnd(...)
  local nReturn = Infrastructure_End.super.OnEnd(self, ...)
  if self.m_pActionTree then
    local listScanID = self.m_pActionTree:GetScanActionID()
    local nTreeID = self.m_pActionTree:GetTreeID()
    self:PrintLog("ScanPath TreeID = ", nTreeID, ", Path = [", table.concat(listScanID, ","), "]")
  end
  return nReturn
end
