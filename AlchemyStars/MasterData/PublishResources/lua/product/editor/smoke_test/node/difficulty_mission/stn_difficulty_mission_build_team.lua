require("common_async_base")
_class("DifficultyMission_BuildTeam", Common_AsyncBase)
DifficultyMission_BuildTeam = DifficultyMission_BuildTeam

function DifficultyMission_BuildTeam:Constructor(_, teamIndex)
  self._teamIndex = teamIndex or TestConst.MissionTeamIndex
end

function DifficultyMission_BuildTeam:TaskFunc(TT, result)
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
  local diffModule = GameGlobal.GetModule(DifficultyMissionModule)
  if runData:GetNeedMissionID() then
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign = UIActivityCampaign:New()
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N27, ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN, ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET, ECampaignN27ComponentID.ECAMPAIGN_N27_POWER2ITEM, ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_BLACK_DIFFICULT_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY, ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
    self._localProcess = self._campaign:GetLocalProcess()
    self._difficultyMissionComponent = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_BLACK_DIFFICULT_MISSION)
  end
  local cfgDifficultyParentMission = Cfg.cfg_difficulty_parent_mission[nodeID]
  local subMissionList = cfgDifficultyParentMission.SubMissionList or {}
  for _, missionID in ipairs(subMissionList) do
    if runData:GetNeedMissionID() then
      self._difficultyMissionComponent:HandleDifficultyResetSubMissionRecord(TT, AsyncRequestRes:New(), nodeID, missionID)
    else
      diffModule:HandleResetSubMissionRecord(TT, nodeID, missionID)
    end
  end
  if runData:GetNeedMissionID() then
    local nodeid = runData:GetNodeID()
    local stageid = runData:GetMissionID()
    local res = self._difficultyMissionComponent:HandleDifficultyChangeFormation(TT, AsyncRequestRes:New(), nodeid, stageid, pstIDs)
  else
    local res = diffModule:HandleChangeFormation(TT, nodeID, stageID, pstIDs)
  end
  self.m_nLogicResult = 1
end
