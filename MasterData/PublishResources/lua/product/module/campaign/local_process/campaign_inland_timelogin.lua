_class("CCampaignInlandTimeLogin", ICampaignComponentLocalProcessBase)
CCampaignInlandTimeLogin = CCampaignInlandTimeLogin

function CCampaignInlandTimeLogin:Constructor()
  self._timeLoginComponent = nil
  self._timeLoginCompInfo = nil
  self._personProgressComponent = nil
  self._personProgressCompInfo = nil
  self._campaignObj = nil
end

function CCampaignInlandTimeLogin:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_TIMELOGIN
end

function CCampaignInlandTimeLogin:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignInlandTimeLogin:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetTimeLoginComponent()
  self:_GetPersonProgressComponent()
end

function CCampaignInlandTimeLogin:_GetTimeLoginComponent()
  self._timeLoginComponent = self._campaignObj:GetComponent(ECCampaignInlandTimeLoginComponentID.Time_LOGIN)
  if not self._timeLoginComponent then
    return
  end
  self._timeLoginCompInfo = self._timeLoginComponent:ComponentInfo()
end

function CCampaignInlandTimeLogin:_GetPersonProgressComponent()
  self._personProgressComponent = self._campaignObj:GetComponent(ECCampaignInlandTimeLoginComponentID.PERSON_PROGRESS)
  if not self._personProgressComponent then
    return
  end
  self._personProgressCompInfo = self._personProgressComponent:ComponentInfo()
end

function CCampaignInlandTimeLogin:GetComponent(componentID)
  if ECCampaignInlandTimeLoginComponentID.Time_LOGIN == componentID then
    return self._timeLoginComponent
  end
  if ECCampaignInlandTimeLoginComponentID.PERSON_PROGRESS == componentID then
    return self._personProgressComponent
  end
  return nil
end

function CCampaignInlandTimeLogin:GetComponentInfo(componentID)
  if ECCampaignInlandTimeLoginComponentID.Time_LOGIN == componentID then
    return self._timeLoginCompInfo
  end
  if ECCampaignInlandTimeLoginComponentID.PERSON_PROGRESS == componentID then
    return self._personProgressCompInfo
  end
  return nil
end
