require("common_async_base")
_class("Season_GM_SeasonSetProcess", Common_AsyncBase)
Season_GM_SeasonSetProcess = Season_GM_SeasonSetProcess

function Season_GM_SeasonSetProcess:Constructor(_manager)
end

function Season_GM_SeasonSetProcess:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local dailyProcess = runData:GetDailyProcess()
  if dailyProcess and 0 <= dailyProcess then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    local res = AsyncRequestRes:New()
    campaignModule:GetCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON)
    local seasonModule = GameGlobal.GetModule(SeasonModule)
    local seasonObj = seasonModule:GetCurSeasonObj()
    local campaignID = seasonObj:GetSeasonID()
    local seasonMissionComponent = seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
    local componentID = seasonMissionComponent:GetCampaignMissionComponentId()
    local componentCfgID = seasonMissionComponent:GetComponentCfgId()
    local componentEnumID = ECCampaignSeasonComponentID.SEASON_MISSION
    local paramKeyMap = seasonMissionComponent:GetCampaignMissionParamKeyMap()
    self._manager:AsyncGM_SeasonSetProcess(TT, status, campaignID, componentEnumID, dailyProcess)
  end
end
