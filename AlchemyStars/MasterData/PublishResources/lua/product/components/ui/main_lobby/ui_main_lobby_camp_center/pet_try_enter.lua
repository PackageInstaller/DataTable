require("main_lobby_center_camp_data")
_class("PetTryEnter", MainLobbyCenterCampData)
PetTryEnter = PetTryEnter

function PetTryEnter:CheckNew()
  return 0
end

function PetTryEnter:CheckRed()
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
  return sampleInfo and sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) and 1 or 0
end
