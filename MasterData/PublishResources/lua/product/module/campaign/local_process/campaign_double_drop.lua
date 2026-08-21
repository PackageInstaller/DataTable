_class("CCampaingDoubleDrop", ICampaignComponentLocalProcessBase)
CCampaingDoubleDrop = CCampaingDoubleDrop

function CCampaingDoubleDrop:Constructor()
  self._rewardDoubleComponent = nil
  self._rewardDoubleComponentInfo = nil
  self._campaignObj = nil
end

function CCampaingDoubleDrop:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_HAVESTTIME
end

function CCampaingDoubleDrop:CampaignObjInfo()
  return self._campaignObj
end

function CCampaingDoubleDrop:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetRewardDoubleComponent()
end

function CCampaingDoubleDrop:_GetRewardDoubleComponent()
  self._rewardDoubleComponent = self._campaignObj:GetComponent(ECampaignRewardDoubleComponentID.ECAMPAIGN_REWARD_DOUBLE)
  if not self._rewardDoubleComponent then
    return
  end
  self._rewardDoubleComponentInfo = self._rewardDoubleComponent:ComponentInfo()
end

function CCampaingDoubleDrop:GetComponent(componentID)
  if ECampaignRewardDoubleComponentID.ECAMPAIGN_REWARD_DOUBLE == componentID then
    return self._rewardDoubleComponent
  end
  return nil
end

function CCampaingDoubleDrop:GetComponentInfo(componentID)
  if ECampaignRewardDoubleComponentID.ECAMPAIGN_REWARD_DOUBLE == componentID then
    return self._rewardDoubleComponentInfo
  end
  return nil
end
