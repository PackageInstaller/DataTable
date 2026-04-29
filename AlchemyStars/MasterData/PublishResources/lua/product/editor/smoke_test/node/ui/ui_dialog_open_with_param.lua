require("base_state_node")
_class("CTestRobot_ShowUIByRunData", CTestRobot_ShowUI)
CTestRobot_ShowUIByRunData = CTestRobot_ShowUIByRunData

function CTestRobot_ShowUIByRunData:_ShowUI()
  local showParam = self.m_pRunData
  self:PrintLog("ShowUI By UserData, UI = ", self.m_stName)
  return GameGlobal.UIStateManager():ShowDialog(self.m_stName, showParam)
end
