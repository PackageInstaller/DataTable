require("common_async_base")
_class("PopStarPro_GM_PassCampMission", Common_AsyncBase)
PopStarPro_GM_PassCampMission = PopStarPro_GM_PassCampMission

function PopStarPro_GM_PassCampMission:Constructor(_manager)
end

function PopStarPro_GM_PassCampMission:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local missionID = 0
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local res = AsyncRequestRes:New()
  campaignModule:GetCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_N7_LINE_POPSTAR)
  local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_INLAND_N7_LINE_POPSTAR)
  local popStarMissionComponent = localProcess:GetComponent(ECampaignN7CenterComponentID.ECAMPAIGN_N7_POPSTAR_LINE_POPSTAR_MISSION)
  if not popStarMissionComponent then
    return
  end
  local componentID = popStarMissionComponent:GetCampaignMissionComponentId()
  local paramKeyMap = popStarMissionComponent:GetCampaignMissionParamKeyMap()
  self._manager:AsyncGM_PassCampMission(TT, status, componentID, paramKeyMap[1], missionID)
end
