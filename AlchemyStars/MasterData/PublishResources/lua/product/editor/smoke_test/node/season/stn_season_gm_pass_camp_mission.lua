require("common_async_base")
_class("Season_GM_PassCampMission", Common_AsyncBase)
Season_GM_PassCampMission = Season_GM_PassCampMission

function Season_GM_PassCampMission:Constructor(_manager)
end

function Season_GM_PassCampMission:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local missionID = runData:GetMissionID()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local res = AsyncRequestRes:New()
  campaignModule:GetCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON)
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonObj = seasonModule:GetCurSeasonObj()
  local seasonMissionComponent = seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  local componentID = seasonMissionComponent:GetCampaignMissionComponentId()
  local paramKeyMap = seasonMissionComponent:GetCampaignMissionParamKeyMap()
  self._manager:AsyncGM_PassCampMission(TT, status, componentID, paramKeyMap[1], missionID)
end
