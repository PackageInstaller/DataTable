require("base_state_node")
_class("Mission_CheckMatchResult", CTestRobot_Base)
Mission_CheckMatchResult = Mission_CheckMatchResult

function Mission_CheckMatchResult:OnWorking()
  local runData = self.m_pManager:GetMissionRunData()
  local isVictory = runData:GetLastBattleResult()
  if isVictory then
    self.m_pManager:Log(self, "Victory! ")
    self.m_nLogicResult = 0
  else
    local retryCount = runData:GetRetryCount()
    if retryCount < TestConst.MissionMaxRetry then
      self.m_pManager:Log(self, "Failed. Retrying sequence engaging. ")
      self.m_nLogicResult = 1
    else
      self.m_pManager:Log(self, "Failed too many times. Skipped. ")
      self.m_nLogicResult = 2
    end
  end
  Mission_CheckMatchResult.super.OnWorking(self)
end
