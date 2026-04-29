require("main_lobby_center_camp_data")
_class("UISideEnterMainN4CCData", MainLobbyCenterCampData)
UISideEnterMainN4CCData = UISideEnterMainN4CCData

function UISideEnterMainN4CCData:CheckNew()
  local btnKey = self._cfg.BtnKey
  local cfg = Cfg.cfg_main_side_enter_btn[btnKey]
  local campType = cfg.CampaignType
  local campID = cfg.CampaignId
  local campModule = GameGlobal.GetModule(CampaignModule)
  local sampleInfo
  if campID then
    sampleInfo = campModule:GetReviewCampaignSampleByCampaignId(campID)
  else
    sampleInfo = campModule:GetSampleByType(campType)
  end
  return sampleInfo and sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_CAN_CHALLENGE) and 1 or 0
end
