_class("CCampaignReviewN13", ICampaignComponentLocalProcessBase)
CCampaignReviewN13 = CCampaignReviewN13

function CCampaignReviewN13:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._buildComponent = nil
  self._buildComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN13:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N13
end

function CCampaignReviewN13:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN13:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetPointProgressComponent()
  self:_GetBuildComponent()
end

function CCampaignReviewN13:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewN13:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN13:_GetBuildComponent()
  self._buildComponent = self._campaignObj:GetComponent(ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_BUILD)
  if not self._buildComponent then
    return
  end
  self._buildComponentInfo = self._buildComponent:ComponentInfo()
end

function CCampaignReviewN13:GetComponent(componentID)
  if ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  if ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_BUILD == componentID then
    return self._buildComponent
  end
  return nil
end

function CCampaignReviewN13:GetComponentInfo(componentID)
  if ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  if ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_BUILD == componentID then
    return self._buildComponentInfo
  end
  return nil
end
