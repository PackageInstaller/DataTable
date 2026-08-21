_class("CCampaignReviewN18", ICampaignComponentLocalProcessBase)
CCampaignReviewN18 = CCampaignReviewN18

function CCampaignReviewN18:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN18:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N18
end

function CCampaignReviewN18:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN18:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetPointProgressComponent()
end

function CCampaignReviewN18:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewN18ComponentID.ECAMPAIGN_REVIEW_ReviewN18_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewN18:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN18ComponentID.ECAMPAIGN_REVIEW_ReviewN18_POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN18:GetComponent(componentID)
  if ECampaignReviewN18ComponentID.ECAMPAIGN_REVIEW_ReviewN18_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignReviewN18ComponentID.ECAMPAIGN_REVIEW_ReviewN18_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  return nil
end

function CCampaignReviewN18:GetComponentInfo(componentID)
  if ECampaignReviewN18ComponentID.ECAMPAIGN_REVIEW_ReviewN18_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignReviewN18ComponentID.ECAMPAIGN_REVIEW_ReviewN18_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  return nil
end
