_class("CCampaignReviewN15", ICampaignComponentLocalProcessBase)
CCampaignReviewN15 = CCampaignReviewN15

function CCampaignReviewN15:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN15:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N15
end

function CCampaignReviewN15:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN15:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetPointProgressComponent()
end

function CCampaignReviewN15:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewN15ComponentID.ECAMPAIGN_REVIEW_ReviewN15_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewN15:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN15ComponentID.ECAMPAIGN_REVIEW_ReviewN15_POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN15:GetComponent(componentID)
  if ECampaignReviewN15ComponentID.ECAMPAIGN_REVIEW_ReviewN15_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignReviewN15ComponentID.ECAMPAIGN_REVIEW_ReviewN15_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  return nil
end

function CCampaignReviewN15:GetComponentInfo(componentID)
  if ECampaignReviewN15ComponentID.ECAMPAIGN_REVIEW_ReviewN15_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignReviewN15ComponentID.ECAMPAIGN_REVIEW_ReviewN15_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  return nil
end
