require("main_lobby_center_camp_data")
_class("ActivityDanTangEnter", MainLobbyCenterCampData)
ActivityDanTangEnter = ActivityDanTangEnter

function ActivityDanTangEnter:CheckRed()
  local module = GameGlobal.GetModule(CampaignModule)
  local preSample = module:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_S0)
  local preRed = false
  if preSample then
    preRed = preSample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD)
  end
  local mainRed = false
  local red = (preRed or mainRed) and 1 or 0
  return red
end
