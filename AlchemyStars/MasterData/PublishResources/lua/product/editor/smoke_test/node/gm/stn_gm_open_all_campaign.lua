require("common_async_base")
_class("GM_OpenAllCampaign", Common_AsyncBase)
GM_OpenAllCampaign = GM_OpenAllCampaign

function GM_OpenAllCampaign:TaskFunc(TT, status)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local campaignID, _, __ = campaignModule:ParseCfgComponentID(self._manager:GetMissionRunData():GetComponentConfigID())
  self._manager:AsyncGM_OpenAllCampaign(TT, status, campaignID)
  local resLoadInfoList = AsyncRequestRes:New()
  campaignModule:CampaignLoadInfoList(TT, resLoadInfoList)
  local resProtoLoadInfo = AsyncRequestRes:New()
  campaignModule:CampaignComProtoLoadInfo(TT, resProtoLoadInfo, campaignID)
end
