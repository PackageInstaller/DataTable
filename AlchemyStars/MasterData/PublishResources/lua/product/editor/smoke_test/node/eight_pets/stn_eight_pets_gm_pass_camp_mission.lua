require("common_async_base")
_class("EightPets_GM_PassCampMission", Common_AsyncBase)
EightPets_GM_PassCampMission = EightPets_GM_PassCampMission

function EightPets_GM_PassCampMission:Constructor(_manager)
end

function EightPets_GM_PassCampMission:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local missionID = runData:GetMissionID()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local res = AsyncRequestRes:New()
  campaignModule:GetCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_EIGHT_PETS_MISSION)
  local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_INLAND_EIGHT_PETS_MISSION)
  local eightComponent = localProcess:GetComponent(ECampaignN33EightPetsMissionComponentID.ECAMPAIGN_N33_Eight_Pets_MISSION)
  local componentID = eightComponent:GetCampaignMissionComponentId()
  local paramKeyMap = eightComponent:GetCampaignMissionParamKeyMap()
  self._manager:AsyncGM_PassCampMission(TT, status, componentID, paramKeyMap[1], missionID)
end
