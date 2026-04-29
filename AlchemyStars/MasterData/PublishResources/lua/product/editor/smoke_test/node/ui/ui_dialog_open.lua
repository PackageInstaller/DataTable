require("base_state_node")
_class("CTestRobot_ShowUI", CTestRobot_Base)
CTestRobot_ShowUI = CTestRobot_ShowUI

function CTestRobot_ShowUI:Constructor(pManger, stName, showParam)
  self.m_stName = stName
  self.m_showParam = showParam
  self.m_nWaitID = 0
end

function CTestRobot_ShowUI:OnBegin(...)
  local nReturn = CTestRobot_ShowUI.super.OnBegin(self, ...)
  self.m_nWaitID = self:_ShowUI()
  return nReturn
end

function CTestRobot_ShowUI:OnWorking()
  if self.m_nWaitID > 0 and not TaskHelper:GetInstance():IsTaskFinished(self.m_nWaitID) then
    return false
  end
  return CTestRobot_ShowUI.super.OnWorking(self)
end

function CTestRobot_ShowUI:_ShowUI()
  local showParam
  if self.m_showParam then
    if type(self.m_showParam) == "table" then
      showParam = table.unpack(self.m_showParam)
    else
      showParam = self.m_showParam
    end
  end
  self:PrintLog("ShowUI, UI = ", self.m_stName)
  return GameGlobal.UIStateManager():ShowDialog(self.m_stName, showParam)
end
