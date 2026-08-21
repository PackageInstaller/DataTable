require("base_state_node")
_class("CTestRobot_UICallerReturn", CTestRobot_UICaller)
CTestRobot_UICallerReturn = CTestRobot_UICallerReturn

function CTestRobot_UICallerReturn:OnWorking()
  local bCheckTeam = self:_CallFunction()
  if not bCheckTeam then
    self.m_nLogicResult = 0
  else
    self.m_nLogicResult = 1
  end
  return CTestRobot_UICallerReturn.super.OnWorking(self)
end
