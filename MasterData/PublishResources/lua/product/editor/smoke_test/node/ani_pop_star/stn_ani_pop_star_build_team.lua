require("common_async_base")
_class("AniPopStar_BuildTeamByRunData", Common_AsyncBase)
AniPopStar_BuildTeamByRunData = AniPopStar_BuildTeamByRunData

function AniPopStar_BuildTeamByRunData:Constructor(_, teamIndex)
  self._teamIndex = teamIndex or TestConst.MissionTeamIndex
end

function AniPopStar_BuildTeamByRunData:TaskFunc(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  if runData:IsRandomTeam() then
    local status = result
    local petPoolOptions = SmokeTestTeamBuildPoolOptions:New()
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
    if not self._manager:BuildRandomTeam(runData, petPoolOptions) then
      self.m_nLogicResult = 2
      return
    end
    local currentTeamPetBuildData = runData:GetCurrentTeamBuild()
    self._manager:PreparePetsByBuildDataList(TT, currentTeamPetBuildData, result)
    if result:IsErrorOccured() then
      self.m_nLogicResult = 3
      return
    end
    local petPetIDs = runData:GeneratePetPstID()
    local missionModule = GameGlobal.GetModule(MissionModule)
    local teamCtx = missionModule:TeamCtx()
    local anipopModule = GameGlobal.GetModule(AnipopModule)
    local res, info = anipopModule:UpdateAnipopFormationInfo(TT, teamCtx.aniPopStarTeamId, TestConst.MissionTeamName, petPetIDs)
    if not res:GetResult() then
      Log.exception(self._className, "UpdateMazeFormationInfo failed. ")
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      self.m_nLogicResult = 3
      return
    end
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
    status:SetCustomData("PetPstIDs", petPstIds)
  else
    self._manager:AsyncBuildAniPopStarTeamByRunData(TT, self._teamIndex, result)
    if result:IsErrorOccured() then
      self.m_nLogicResult = 3
      return
    end
  end
  local petPstID = result:GetCustomData("PetPstIDs")
  runData:SetCurrentTeamPstIDList(petPstID)
  self.m_nLogicResult = 1
  return
end
