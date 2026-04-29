_class("CCampaignInlandBusiness", ICampaignComponentLocalProcessBase)
CCampaignInlandBusiness = CCampaignInlandBusiness

function CCampaignInlandBusiness:Constructor()
  self._businessComponet = nil
  self._businessComponetInfo = nil
  self._totalProgressComponent = nil
  self._totalProgressComponentInfo = nil
  self._talentProgressComponent = nil
  self._talentProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignInlandBusiness:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_BUSINESS
end

function CCampaignInlandBusiness:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignInlandBusiness:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetBusinessCommonComponent()
  self:_GetTotalProgressComponent()
  self:_GetTalentProgressComponent()
end

function CCampaignInlandBusiness:_GetBusinessCommonComponent()
  self._businessComponet = self._campaignObj:GetComponent(ECampaignBusinessComponentID.BUSINESS)
  if not self._businessComponet then
    return
  end
  self._businessComponetInfo = self._businessComponet:ComponentInfo()
end

function CCampaignInlandBusiness:_GetTotalProgressComponent()
  self._totalProgressComponent = self._campaignObj:GetComponent(ECampaignBusinessComponentID.TOTAL_PROCESS)
  if not self._totalProgressComponent then
    return
  end
  self._totalProgressComponentInfo = self._totalProgressComponent:ComponentInfo()
end

function CCampaignInlandBusiness:_GetTalentProgressComponent()
  self._talentProgressComponent = self._campaignObj:GetComponent(ECampaignBusinessComponentID.REWARD_PROCESS)
  if not self._talentProgressComponent then
    return
  end
  self._talentProgressComponentInfo = self._talentProgressComponent:ComponentInfo()
end

function CCampaignInlandBusiness:GetComponent(componentID)
  if ECampaignBusinessComponentID.BUSINESS == componentID then
    return self._businessComponet
  end
  if ECampaignBusinessComponentID.TOTAL_PROCESS == componentID then
    return self._totalProgressComponent
  end
  if ECampaignBusinessComponentID.REWARD_PROCESS == componentID then
    return self._talentProgressComponent
  end
  return nil
end

function CCampaignInlandBusiness:GetComponentInfo(componentID)
  if ECampaignBusinessComponentID.BUSINESS == componentID then
    return self._businessComponetInfo
  end
  if ECampaignBusinessComponentID.TOTAL_PROCESS == componentID then
    return self._totalProgressComponentInfo
  end
  if ECampaignBusinessComponentID.REWARD_PROCESS == componentID then
    return self._talentProgressComponentInfo
  end
  return nil
end
