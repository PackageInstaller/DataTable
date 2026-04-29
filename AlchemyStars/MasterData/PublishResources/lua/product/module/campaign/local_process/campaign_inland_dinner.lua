_class("CCampaignInlandDinner", ICampaignComponentLocalProcessBase)
CCampaignInlandDinner = CCampaignInlandDinner

function CCampaignInlandDinner:Constructor()
  self._dinnerComponent = nil
  self._dinnerCompInfo = nil
  self._campaignObj = nil
end

function CCampaignInlandDinner:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_DINNER
end

function CCampaignInlandDinner:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignInlandDinner:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetNewYearDinnerComponent()
end

function CCampaignInlandDinner:_GetNewYearDinnerComponent()
  self._dinnerComponent = self._campaignObj:GetComponent(ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER)
  if not self._dinnerComponent then
    return
  end
  self._dinnerCompInfo = self._dinnerComponent:ComponentInfo()
end

function CCampaignInlandDinner:GetComponent(componentID)
  if ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER == componentID then
    return self._dinnerComponent
  end
  return nil
end

function CCampaignInlandDinner:GetComponentInfo(componentID)
  if ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER == componentID then
    return self._dinnerCompInfo
  end
  return nil
end
