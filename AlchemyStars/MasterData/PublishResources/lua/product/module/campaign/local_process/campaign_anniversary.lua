require("campaign_component_local_process_base")
_class("CCampaignAnniversary", ICampaignComponentLocalProcessBase)
CCampaignAnniversary = CCampaignAnniversary

function CCampaignAnniversary:Constructor()
  self._timeRewardComponent = nil
  self._timeRewardComponentInfo = nil
  self._resourceBoxComponent = nil
  self._resourceBoxComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignAnniversary:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_ANNIVERSARY
end

function CCampaignAnniversary:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignAnniversary:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetTimeRewardComponent()
  self:_GetResourceBoxComponent()
end

function CCampaignAnniversary:_GetTimeRewardComponent()
  self._timeRewardComponent = self._campaignObj:GetComponent(ECampaignAnniversaryComponentID.ECAMPAIGN_ANNIVERSARY)
  if not self._timeRewardComponent then
    return
  end
  self._timeRewardComponentInfo = self._timeRewardComponent:ComponentInfo()
end

function CCampaignAnniversary:_GetResourceBoxComponent()
  self._resourceBoxComponent = self._campaignObj:GetComponent(ECampaignAnniversaryComponentID.ECAMPAIGN_RESOURCE_BOX)
  if not self._resourceBoxComponent then
    return
  end
  self._resourceBoxComponentInfo = self._resourceBoxComponent:ComponentInfo()
end

function CCampaignAnniversary:GetComponent(componentID)
  if ECampaignAnniversaryComponentID.ECAMPAIGN_ANNIVERSARY == componentID then
    return self._timeRewardComponent
  end
  if ECampaignAnniversaryComponentID.ECAMPAIGN_RESOURCE_BOX == componentID then
    return self._resourceBoxComponent
  end
  return nil
end

function CCampaignAnniversary:GetComponentInfo(componentID)
  if ECampaignAnniversaryComponentID.ECAMPAIGN_ANNIVERSARY == componentID then
    return self._timeRewardComponentInfo
  end
  if ECampaignAnniversaryComponentID.ECAMPAIGN_RESOURCE_BOX == componentID then
    return self._resourceBoxComponentInfo
  end
  return nil
end
