require("base_state_node")
_class("Common_CheckProgress", CTestRobot_Base)
Common_CheckProgress = Common_CheckProgress

function Common_CheckProgress:OnWorking()
  local runData = self.m_pManager:GetMissionRunData()
  if runData:IsRandomTeam() then
    self.m_nLogicResult = 0
  else
    self.m_nLogicResult = 1
  end
  return Common_CheckProgress.super.OnWorking(self)
end
