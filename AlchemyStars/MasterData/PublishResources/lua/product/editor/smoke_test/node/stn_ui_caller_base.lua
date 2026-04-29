require("base_state_node")
_class("CTestRobot_UICaller", CTestRobot_Base)
CTestRobot_UICaller = CTestRobot_UICaller

function CTestRobot_UICaller:Constructor(pManger, stName, stFunction, ...)
  self.m_stName = stName
  self.m_stFunction = stFunction
  self.m_listParam = {
    ...
  }
end

function CTestRobot_UICaller:OnWorking()
  self:_CallFunction()
  return CTestRobot_UICaller.super.OnWorking(self)
end

function CTestRobot_UICaller:_FindUI(stName)
  local pUIManger = self.m_pGameCenter.UIStateManager()
  return pUIManger:GetController(stName)
end

function CTestRobot_UICaller:_CallFunction(...)
  local pFindUI = self:_FindUI(self.m_stName)
  if nil == pFindUI then
    self:PrintLog("UICaller Not Find UI, UI = ", self.m_stName, ", Caller = ", self.m_stFunction)
    return
  end
  local pFunction = pFindUI[self.m_stFunction]
  if nil == pFunction then
    self:PrintLog("UICaller Not Find Function, UI = ", self.m_stName, ", Caller = ", self.m_stFunction)
    return
  end
  self:PrintLog("UICaller, UI = ", self.m_stName, ", Caller = ", self.m_stFunction)
  return pFunction(pFindUI, table.unpack(self.m_listParam))
end
