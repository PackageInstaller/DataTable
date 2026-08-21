require("base_state_node")
_class("CTestRobot_ShowUIState", CTestRobot_Base)
CTestRobot_ShowUIState = CTestRobot_ShowUIState

function CTestRobot_ShowUIState:Constructor(pManger, stName, showParam)
  self.m_stName = stName
  self.m_showParam = showParam
  self.m_nWaitID = 0
end

function CTestRobot_ShowUIState:OnBegin(...)
  local nReturn = CTestRobot_ShowUIState.super.OnBegin(self, ...)
  self.m_nWaitID = self:_ShowUI()
  return nReturn
end

function CTestRobot_ShowUIState:OnWorking()
  return CTestRobot_ShowUIState.super.OnWorking(self)
end

function CTestRobot_ShowUIState:_ShowUI()
  local showParam
  if self.m_showParam then
    if type(self.m_showParam) == "table" then
      showParam = table.unpack(self.m_showParam)
    else
      showParam = self.m_showParam
    end
  end
  self:PrintLog("ShowUIState, UI = ", self.m_stName)
  return GameGlobal.UIStateManager():SwitchState(self.m_stName, showParam)
end
