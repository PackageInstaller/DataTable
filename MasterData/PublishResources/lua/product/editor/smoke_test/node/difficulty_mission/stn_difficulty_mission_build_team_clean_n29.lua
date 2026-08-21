require("common_async_base")
_class("DifficultyMission_BuildTeamCleanN29", Common_AsyncBase)
DifficultyMission_BuildTeamCleanN29 = DifficultyMission_BuildTeamCleanN29

function DifficultyMission_BuildTeamCleanN29:Constructor(_, nodeid, stageid)
  self._nodeid = nodeid
  self._stageid = stageid
end

function DifficultyMission_BuildTeamCleanN29:TaskFunc(TT, result)
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
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N29, ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION, ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION)
  self._localProcess = self._campaign:GetLocalProcess()
  local diffCpt = self._localProcess:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION)
  local nodeid = runData:GetNodeID()
  local stageid = runData:GetMissionID()
  local res = diffCpt:HandleDifficultyChangeFormation(TT, AsyncRequestRes:New(), self._nodeid, self._stageid, {})
  self.m_nLogicResult = 1
end
