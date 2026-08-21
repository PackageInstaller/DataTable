require("ui_side_enter_item_campaign")
_class("UIActivityDanTangEnter", UISideEnterItem_Campaign)
UIActivityDanTangEnter = UIActivityDanTangEnter

function UIActivityDanTangEnter:_CalcRed()
  local module = self:GetModule(CampaignModule)
  local preSample = module:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_S0)
  local preRed = false
  if preSample then
    preRed = preSample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD)
  end
  local mainRed = false
  local red = (preRed or mainRed) and 1 or 0
  return red
end
