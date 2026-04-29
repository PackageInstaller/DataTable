require("common_async_base")
_class("DifficultyMission_BuildTeamN29", Common_AsyncBase)
DifficultyMission_BuildTeamN29 = DifficultyMission_BuildTeamN29

function DifficultyMission_BuildTeamN29:Constructor(_, teamIndex)
  self._teamIndex = teamIndex or TestConst.MissionTeamIndex
end

function DifficultyMission_BuildTeamN29:TaskFunc(TT, result)
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
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N29, ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION, ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION)
    self._localProcess = self._campaign:GetLocalProcess()
    self._difficultyMissionComponent = self._localProcess:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION)
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
