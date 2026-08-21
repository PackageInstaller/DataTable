_class("CCampaignInlandS0", ICampaignComponentLocalProcessBase)
CCampaignInlandS0 = CCampaignInlandS0

function CCampaignInlandS0:Constructor()
  self._timeRewardComponent = nil
  self._timeRewardComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignInlandS0:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_S0
end

function CCampaignInlandS0:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignInlandS0:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetTimeRewardComponent()
end

function CCampaignInlandS0:_GetTimeRewardComponent()
  self._timeRewardComponent = self._campaignObj:GetComponent(ECCampaignInlandS0ComponentID.TIME_REWARD)
  if not self._timeRewardComponent then
    return
  end
  self._timeRewardComponentInfo = self._timeRewardComponent:ComponentInfo()
end

function CCampaignInlandS0:GetComponent(componentID)
  if ECCampaignInlandS0ComponentID.TIME_REWARD == componentID then
    return self._timeRewardComponent
  end
  return nil
end

function CCampaignInlandS0:GetComponentInfo(componentID)
  if ECCampaignInlandS0ComponentID.TIME_REWARD == componentID then
    return self._timeRewardComponentInfo
  end
  return nil
end
