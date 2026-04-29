require("common_async_base")
_class("WorldBoss_BuildTeam", Common_AsyncBase)
WorldBoss_BuildTeam = WorldBoss_BuildTeam

function WorldBoss_BuildTeam:Constructor(_, teamIndex)
  self._teamIndex = teamIndex or TestConst.MissionTeamIndex
end

function WorldBoss_BuildTeam:TaskFunc(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  local petPoolOptions = SmokeTestTeamBuildPoolOptions:New()
  if runData:IsRandomTeam() then
    if not self._manager:BuildRandomTeam(runData, petPoolOptions) then
      self.m_nLogicResult = 2
      return
    end
  else
    self._manager:AsyncBuildWorldBossTeamByRunData(TT, self._teamIndex, result)
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
  local pstIDs = runData:GeneratePetPstID()
  local worldBossModule = GameGlobal.GetModule(WorldBossModule)
  local updateFormationResult = worldBossModule:ReqWorldBossChangeFormationInfo(TT, pstIDs)
  if updateFormationResult.m_call_err ~= CallResultType.Normal then
    self._manager:Log(self._className, "Update team failed. result=", updateFormationResult.m_result)
    result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    result:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    self.m_nLogicResult = 3
    return
  end
  result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  result:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
  result:SetCustomData("PetPstIDs", pstIDs)
  self.m_nLogicResult = 1
end
