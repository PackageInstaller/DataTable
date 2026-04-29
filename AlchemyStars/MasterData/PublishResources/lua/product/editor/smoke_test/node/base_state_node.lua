require("l_action_base")
_class("CTestRobot_Base", LActionNode_Base)
CTestRobot_Base = CTestRobot_Base

function CTestRobot_Base:Constructor(pManager)
  self.m_pManager = pManager
  self.m_pGameCenter = GameGlobal
  self._manager = pManager
end

function CTestRobot_Base:GetModule(moduleName)
  return self.m_pGameCenter.GetModule(moduleName)
end

function CTestRobot_Base:Log(...)
  self.m_pManager:Log(self, ...)
end

function CTestRobot_Base:__tostring()
  return self._className
end
