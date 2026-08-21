require("common_async_base")
_class("GM_MiniMazeTalentMax", Common_AsyncBase)
GM_MiniMazeTalentMax = GM_MiniMazeTalentMax

function GM_MiniMazeTalentMax:TaskFunc(TT, status)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local campaignID, _, __ = campaignModule:ParseCfgComponentID(self._manager:GetMissionRunData():GetComponentConfigID())
  self._manager:AsyncGM_MiniMazeTalentMax(TT, status, campaignID)
end
