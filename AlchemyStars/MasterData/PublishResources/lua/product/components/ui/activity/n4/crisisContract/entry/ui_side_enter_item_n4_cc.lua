require("ui_side_enter_item_campaign")
_class("UISideEnterItemN4CC", UISideEnterItem_Campaign)
UISideEnterItemN4CC = UISideEnterItemN4CC

function UISideEnterItemN4CC:_CalcNew()
  if not self._campaign then
    return false
  end
  local sample = self._campaign:GetSample()
  local new = sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_CAN_CHALLENGE)
  return new
end
