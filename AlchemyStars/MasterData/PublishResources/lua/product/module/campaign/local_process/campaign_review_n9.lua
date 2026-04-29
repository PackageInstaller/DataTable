_class("CCampaignReviewN9", ICampaignComponentLocalProcessBase)
CCampaignReviewN9 = CCampaignReviewN9

function CCampaignReviewN9:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN9:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N9
end

function CCampaignReviewN9:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN9:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetPointProgressComponent()
end

function CCampaignReviewN9:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewN9ComponentID.ECAMPAIGN_REVIEW_ReviewN9_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewN9:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN9ComponentID.ECAMPAIGN_REVIEW_ReviewN9_POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN9:GetComponent(componentID)
  if ECampaignReviewN9ComponentID.ECAMPAIGN_REVIEW_ReviewN9_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignReviewN9ComponentID.ECAMPAIGN_REVIEW_ReviewN9_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  return nil
end

function CCampaignReviewN9:GetComponentInfo(componentID)
  if ECampaignReviewN9ComponentID.ECAMPAIGN_REVIEW_ReviewN9_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignReviewN9ComponentID.ECAMPAIGN_REVIEW_ReviewN9_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  return nil
end
