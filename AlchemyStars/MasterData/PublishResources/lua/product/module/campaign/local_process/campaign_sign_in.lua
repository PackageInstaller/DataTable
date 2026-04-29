_class("CCampaignSignIn", ICampaignComponentLocalProcessBase)
CCampaignSignIn = CCampaignSignIn

function CCampaignSignIn:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._campaignObj = nil
end

function CCampaignSignIn:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_SIGN_IN
end

function CCampaignSignIn:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignSignIn:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
end

function CCampaignSignIn:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignSignInComponentID.ECAMPAIGN_SIGN_IN_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:GetComponentInfo()
end

function CCampaignSignIn:GetComponent(componentID)
  if ECampaignSignInComponentID.ECAMPAIGN_SIGN_IN_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  return nil
end

function CCampaignSignIn:GetComponentInfo(componentID)
  if ECampaignSignInComponentID.ECAMPAIGN_SIGN_IN_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  return nil
end
