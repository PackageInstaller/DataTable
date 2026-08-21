_class("UIActivityAnniversaryLoginHelper", Object)
UIActivityAnniversaryLoginHelper = UIActivityAnniversaryLoginHelper

function UIActivityAnniversaryLoginHelper:Constructor()
end

function UIActivityAnniversaryLoginHelper.CheckComponentRedPoint(campaign, ...)
  if not (campaign and campaign:GetLocalProcess()) or not campaign:CheckCampaignOpen() then
    return false
  end
  local args = {
    ...
  }
  for _, v in pairs(args) do
    local component = campaign:GetComponent(v)
    local list = component:GetTimeRewardsList()
    for __, vv in ipairs(list) do
      if vv.rec_reward_status == ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV then
        return true
      end
    end
  end
  return false
end

function UIActivityAnniversaryLoginHelper.CheckCampaignRedPoint(campaign)
  return UIActivityAnniversaryLoginHelper.CheckComponentRedPoint(campaign, ECampaignAnniversaryComponentID.ECAMPAIGN_ANNIVERSARY, ECampaignAnniversaryComponentID.ECAMPAIGN_RESOURCE_BOX)
end
