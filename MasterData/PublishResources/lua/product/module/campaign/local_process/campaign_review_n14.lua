_class("CCampaignReviewN14", ICampaignComponentLocalProcessBase)
CCampaignReviewN14 = CCampaignReviewN14

function CCampaignReviewN14:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN14:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N14
end

function CCampaignReviewN14:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN14:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetPointProgressComponent()
end

function CCampaignReviewN14:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewN14ComponentID.ECAMPAIGN_REVIEW_ReviewN14_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewN14:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN14ComponentID.ECAMPAIGN_REVIEW_ReviewN14_POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN14:GetComponent(componentID)
  if ECampaignReviewN14ComponentID.ECAMPAIGN_REVIEW_ReviewN14_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignReviewN14ComponentID.ECAMPAIGN_REVIEW_ReviewN14_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  return nil
end

function CCampaignReviewN14:GetComponentInfo(componentID)
  if ECampaignReviewN14ComponentID.ECAMPAIGN_REVIEW_ReviewN14_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignReviewN14ComponentID.ECAMPAIGN_REVIEW_ReviewN14_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  return nil
end
