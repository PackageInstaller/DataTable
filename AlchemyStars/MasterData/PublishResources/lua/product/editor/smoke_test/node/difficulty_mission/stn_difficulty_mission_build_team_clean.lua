require("common_async_base")
_class("DifficultyMission_BuildTeamClean", Common_AsyncBase)
DifficultyMission_BuildTeamClean = DifficultyMission_BuildTeamClean

function DifficultyMission_BuildTeamClean:Constructor(_, nodeid, stageid)
  self._nodeid = nodeid
  self._stageid = stageid
end

function DifficultyMission_BuildTeamClean:TaskFunc(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
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
  local cfgDifficultyParentMission = Cfg.cfg_difficulty_parent_mission[nodeID]
  local subMissionList = cfgDifficultyParentMission.SubMissionList or {}
  for _, missionID in ipairs(subMissionList) do
    diffModule:HandleResetSubMissionRecord(TT, nodeID, missionID)
  end
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N27, ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN, ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET, ECampaignN27ComponentID.ECAMPAIGN_N27_POWER2ITEM, ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_BLACK_DIFFICULT_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY, ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
  self._localProcess = self._campaign:GetLocalProcess()
  local diffCpt = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_BLACK_DIFFICULT_MISSION)
  local nodeid = runData:GetNodeID()
  local stageid = runData:GetMissionID()
  local res = diffCpt:HandleDifficultyChangeFormation(TT, AsyncRequestRes:New(), self._nodeid, self._stageid, {})
  self.m_nLogicResult = 1
end
