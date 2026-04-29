_class("CCampaignSummerII", ICampaignComponentLocalProcessBase)
CCampaignSummerII = CCampaignSummerII

function CCampaignSummerII:Constructor()
  self._summerIIMissionComponent = nil
  self._summerIIMissionCompInfo = nil
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._personProgress1Component = nil
  self._personProgress1CompInfo = nil
  self._campaignObj = nil
end

function CCampaignSummerII:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_SUMMER_II
end

function CCampaignSummerII:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignSummerII:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetSummerIIMissionComponent()
  self:_GetStoryComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetPersonProgress1Component()
end

function CCampaignSummerII:_GetSummerIIMissionComponent()
  self._summerIIMissionComponent = self._campaignObj:GetComponent(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION)
  if not self._summerIIMissionComponent then
    return
  end
  self._summerIIMissionCompInfo = self._summerIIMissionComponent:ComponentInfo()
end

function CCampaignSummerII:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaignSummerII:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:GetComponentInfo()
end

function CCampaignSummerII:_GetPersonProgress1Component()
  self._personProgress1Component = self._campaignObj:GetComponent(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1)
  if not self._personProgress1Component then
    return
  end
  self._personProgress1CompInfo = self._personProgress1Component:ComponentInfo()
end

function CCampaignSummerII:GetComponent(componentID)
  if ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION == componentID then
    return self._summerIIMissionComponent
  end
  if ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_STORY == componentID then
    return self._storyComponent
  end
  if ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1 == componentID then
    return self._personProgress1Component
  end
  return nil
end

function CCampaignSummerII:GetComponentInfo(componentID)
  if ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION == componentID then
    return self._summerIIMissionCompInfo
  end
  if ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_STORY == componentID then
    return self._storyComponentInfo
  end
  if ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1 == componentID then
    return self._personProgress1CompInfo
  end
  return nil
end
