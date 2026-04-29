_class("CCampaignSignInTwo", ICampaignComponentLocalProcessBase)
CCampaignSignInTwo = CCampaignSignInTwo

function CCampaignSignInTwo:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._campaignObj = nil
end

function CCampaignSignInTwo:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_SIGN_IN_TWO
end

function CCampaignSignInTwo:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignSignInTwo:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
end

function CCampaignSignInTwo:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignSignInComponentID.ECAMPAIGN_SIGN_IN_TWO_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:GetComponentInfo()
end

function CCampaignSignInTwo:GetComponent(componentID)
  if ECampaignSignInTwoComponentID.ECAMPAIGN_SIGN_IN_TWO_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  return nil
end

function CCampaignSignInTwo:GetComponentInfo(componentID)
  if ECampaignSignInTwoComponentID.ECAMPAIGN_SIGN_IN_TWO_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  return nil
end
