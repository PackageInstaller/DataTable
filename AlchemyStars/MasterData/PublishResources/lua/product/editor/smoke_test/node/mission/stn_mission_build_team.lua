require("common_async_base")
_class("Mission_BuildTeam", Common_AsyncBase)
Mission_BuildTeam = Mission_BuildTeam

function Mission_BuildTeam:Constructor(_, teamIndex)
  self._teamIndex = teamIndex or TestConst.MissionTeamIndex
end

function Mission_BuildTeam:TaskFunc(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  local petPoolOptions = SmokeTestTeamBuildPoolOptions:New()
  if runData:IsRandomTeam() then
    if not self._manager:BuildRandomTeam(runData, petPoolOptions) then
      self.m_nLogicResult = 2
      return
    end
  else
    self._manager:AsyncBuildTeamByRunData(TT, self._teamIndex, result)
    if result:IsErrorOccured() then
      self.m_nLogicResult = 3
      return
    else
      self.m_nLogicResult = 1
      return
    end
  end
  local currentTeamPetBuildData = runData:GetCurrentTeamBuild()
  self._manager:PreparePetsByBuildDataList(TT, currentTeamPetBuildData, result)
  if result:IsErrorOccured() then
    self.m_nLogicResult = 3
    return
  end
  local petPstIds = runData:GeneratePetPstID()
  local missionModule = GameGlobal.GetModule(MissionModule)
  for i = 1, 3 do
    local updateFormationResult = missionModule:UpdateMainFormationInfo(TT, TestConst.MissionTeamIndex, TestConst.MissionTeamName, petPstIds)
    if updateFormationResult:GetSucc() then
      result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      result:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      self.m_nLogicResult = 1
      return
    else
      result:SetCustomData("result", updateFormationResult.m_result)
    end
  end
  result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  result:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self.m_nLogicResult = 3
  Log.exception(self._className, "UpdateMainFormationInfo failed, result: ", tostring(result:GetCustomData("result")))
end
