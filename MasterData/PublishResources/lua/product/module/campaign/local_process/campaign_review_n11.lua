_class("CCampaignReviewN11", ICampaignComponentLocalProcessBase)
CCampaignReviewN11 = CCampaignReviewN11

function CCampaignReviewN11:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN11:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N11
end

function CCampaignReviewN11:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN11:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetPointProgressComponent()
end

function CCampaignReviewN11:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewN11ComponentID.ECAMPAIGN_REVIEW_ReviewN11_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewN11:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN11ComponentID.ECAMPAIGN_REVIEW_ReviewN11_LINE_MISSION)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN11:GetComponent(componentID)
  if ECampaignReviewN11ComponentID.ECAMPAIGN_REVIEW_ReviewN11_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignReviewN11ComponentID.ECAMPAIGN_REVIEW_ReviewN11_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  return nil
end

function CCampaignReviewN11:GetComponentInfo(componentID)
  if ECampaignReviewN11ComponentID.ECAMPAIGN_REVIEW_ReviewN11_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignReviewN11ComponentID.ECAMPAIGN_REVIEW_ReviewN11_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  return nil
end
