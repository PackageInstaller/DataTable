require("common_async_base")
_class("GM_PassMiniMazeMission", Common_AsyncBase)
GM_PassMiniMazeMission = GM_PassMiniMazeMission

function GM_PassMiniMazeMission:TaskFunc(TT, status)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local campaignID, _, __ = campaignModule:ParseCfgComponentID(self._manager:GetMissionRunData():GetComponentConfigID())
  self._manager:AsyncGM_PassMiniMazeMission(TT, status, campaignID)
end
