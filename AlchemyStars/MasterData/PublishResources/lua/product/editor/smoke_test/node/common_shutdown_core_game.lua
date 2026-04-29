require("base_state_node")
_class("CTestRobot_Common_ShutdownCoreGame", CTestRobot_Base)
CTestRobot_Common_ShutdownCoreGame = CTestRobot_Common_ShutdownCoreGame

function CTestRobot_Common_ShutdownCoreGame:OnWorking()
  GameGlobal:GetInstance():ExitCoreGame()
  return CTestRobot_Common_ShutdownCoreGame.super.OnWorking(self)
end
