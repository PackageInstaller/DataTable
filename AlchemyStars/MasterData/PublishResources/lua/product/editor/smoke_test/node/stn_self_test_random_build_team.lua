require("common_async_base")
_class("SelfTest_RandomBuildTeam", Common_AsyncBase)
SelfTest_RandomBuildTeam = SelfTest_RandomBuildTeam

function SelfTest_RandomBuildTeam:TaskFunc(TT, result)
  local runData = self._manager:GetMissionRunData()
  local petPoolOptions = SmokeTestTeamBuildPoolOptions:New()
  local buildResult = self._manager:BuildRandomTeam(runData, petPoolOptions)
  if not buildResult then
    self.m_nLogicResult = 2
    return
  end
  self._manager:Log("Build once. ")
  self.m_nLogicResult = 1
end
