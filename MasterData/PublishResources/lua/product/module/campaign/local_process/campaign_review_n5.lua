_class("CCampaignReviewN5", ICampaignComponentLocalProcessBase)
CCampaignReviewN5 = CCampaignReviewN5

function CCampaignReviewN5:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN5:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N5
end

function CCampaignReviewN5:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN5:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetPointProgressComponent()
end

function CCampaignReviewN5:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewN5ComponentID.ECAMPAIGN_REVIEW_ReviewN5_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewN5:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN5ComponentID.ECAMPAIGN_REVIEW_ReviewN5_POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN5:GetComponent(componentID)
  if ECampaignReviewN5ComponentID.ECAMPAIGN_REVIEW_ReviewN5_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignReviewN5ComponentID.ECAMPAIGN_REVIEW_ReviewN5_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  return nil
end

function CCampaignReviewN5:GetComponentInfo(componentID)
  if ECampaignReviewN5ComponentID.ECAMPAIGN_REVIEW_ReviewN5_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignReviewN5ComponentID.ECAMPAIGN_REVIEW_ReviewN5_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  return nil
end
