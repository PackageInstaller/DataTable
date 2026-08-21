require("common_async_base")
_class("DifficultyMission_BuildTeamN31", Common_AsyncBase)
DifficultyMission_BuildTeamN31 = DifficultyMission_BuildTeamN31

function DifficultyMission_BuildTeamN31:Constructor(_, teamIndex)
  self._teamIndex = teamIndex or TestConst.MissionTeamIndex
end

function DifficultyMission_BuildTeamN31:TaskFunc(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  local petPoolOptions = SmokeTestTeamBuildPoolOptions:New()
  if runData:IsRandomTeam() then
    local isTeamBuilt = self._manager:BuildRandomTeam(runData, petPoolOptions)
    if not isTeamBuilt then
      self.m_nLogicResult = 2
      return
    end
  end
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  for _, petData in ipairs(runData:GetCurrentTeamBuild()) do
    local cmdAddPet = string.format("add_asset %s %d 1", LocalDB.GetString("OpenIdTest"), petData:GetTemplateID())
    self:Log(self, "GMCommand: ", cmdAddPet)
    local addPetResult = gmproxy:SendCmdTask(TT, cmdAddPet)
    if addPetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      self.m_nLogicResult = 3
      return
    end
    local cmdChangePet = petData:GenerateGMCommand()
    self:Log(self, "GMCommand: ", cmdChangePet)
    local changePetResult = gmproxy:SendCmdTask(TT, cmdChangePet)
    if changePetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      self.m_nLogicResult = 3
      return
    end
  end
  local nodeID = runData:GetNodeID()
  local stageID = runData:GetMissionID()
  local pstIDs = runData:GeneratePetPstID()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local campaignID = runData:GetCampaignID()
  self._campaign = UIActivityHelper.LoadCampaign(TT, res, ECampaignType.CAMPAIGN_TYPE_DIFFICULTY_WEEK_TOWER, campaignID)
  local localProcess = self._campaign:GetLocalProcess()
  self._difficultyMissionComponent = localProcess:GetComponent(ECampaignDiffcultyWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_DIFFICULT_MISSION)
  local cfgDifficultyParentMission = Cfg.cfg_difficulty_parent_mission[nodeID]
  local subMissionList = cfgDifficultyParentMission.SubMissionList or {}
  for _, missionID in ipairs(subMissionList) do
    self._difficultyMissionComponent:HandleDifficultyResetSubMissionRecord(TT, AsyncRequestRes:New(), nodeID, missionID)
  end
  local res = self._difficultyMissionComponent:HandleDifficultyChangeFormation(TT, AsyncRequestRes:New(), nodeID, stageID, pstIDs)
  self.m_nLogicResult = 1
end
