require("common_async_base")
_class("PopStarPro_BuildTeam", Common_AsyncBase)
PopStarPro_BuildTeam = PopStarPro_BuildTeam

function PopStarPro_BuildTeam:Constructor(_, teamIndex)
  self._teamIndex = teamIndex or TestConst.MissionTeamIndex
end

function PopStarPro_BuildTeam:TaskFunc(TT, result)
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
  local missionID = runData:GetMissionID()
  local missionCfg = Cfg.cfg_component_line_popstar_mission[missionID]
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_INLAND_N7_LINE_POPSTAR)
  local popStarMissionComponent = localProcess:GetComponent(ECampaignN7CenterComponentID.ECAMPAIGN_N7_POPSTAR_LINE_POPSTAR_MISSION)
  if not popStarMissionComponent then
    return
  end
  for i = 1, 3 do
    local missionModule = GameGlobal.GetModule(MissionModule)
    local teamCtx = missionModule:TeamCtx()
    teamCtx:Init(TeamOpenerType.PopStarPro, {
      missionID,
      popStarMissionComponent:GetCampaignMissionComponentId(),
      popStarMissionComponent:GetCampaignMissionParamKeyMap(),
      missionCfg.CampId,
      missionCfg.Fetters,
      popStarMissionComponent
    })
    local info = popStarMissionComponent:ComponentInfo()
    teamCtx:InitPopStarTeam(info.formation_pet_list)
    local team = teamCtx:Teams():Get(TestConst.MissionTeamIndex)
    local linePopStarCpt = popStarMissionComponent
    local res = AsyncRequestRes:New()
    local tb = {
      id = team.id,
      name = team.name,
      pet_list = petPstIds
    }
    linePopStarCpt:HandleLinePopStarChangeFormation(TT, res, tb)
    if res:GetSucc() then
      teamCtx.popStarTeam:UpdateTeam(team)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      result:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      self.m_nLogicResult = 1
      return
    else
      result:SetCustomData("result", res.m_result)
    end
  end
  result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  result:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self.m_nLogicResult = 3
  Log.exception(self._className, "UpdateMainFormationInfo failed, result: ", tostring(result:GetCustomData("result")))
end
