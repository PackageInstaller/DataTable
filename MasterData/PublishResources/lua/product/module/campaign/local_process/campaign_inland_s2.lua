_class("CCampaignInlandS2", ICampaignComponentLocalProcessBase)
CCampaignInlandS2 = CCampaignInlandS2

function CCampaignInlandS2:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._campaignObj = nil
end

function CCampaignInlandS2:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_S2
end

function CCampaignInlandS2:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignInlandS2:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
end

function CCampaignInlandS2:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECCampaignInlandS2ComponentID.CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignInlandS2:GetComponent(componentID)
  if ECCampaignInlandS2ComponentID.CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  return nil
end

function CCampaignInlandS2:GetComponentInfo(componentID)
  if ECCampaignInlandS2ComponentID.CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  return nil
end
