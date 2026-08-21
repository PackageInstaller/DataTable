require("base_state_node")
_class("Infrastructure_Begin", CTestRobot_Base)
Infrastructure_Begin = Infrastructure_Begin

function Infrastructure_Begin:OnWorking()
  self.m_pManager:OnTestRobot_Begin()
  return Infrastructure_Begin.super.OnWorking(self)
end
