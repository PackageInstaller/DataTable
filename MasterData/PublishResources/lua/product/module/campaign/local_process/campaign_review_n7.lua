_class("CCampaignReviewN7", ICampaignComponentLocalProcessBase)
CCampaignReviewN7 = CCampaignReviewN7

function CCampaignReviewN7:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN7:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N7
end

function CCampaignReviewN7:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN7:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetPointProgressComponent()
end

function CCampaignReviewN7:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewN7ComponentID.ECAMPAIGN_REVIEW_ReviewN7_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewN7:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN7ComponentID.ECAMPAIGN_REVIEW_ReviewN7_POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN7:GetComponent(componentID)
  if ECampaignReviewN7ComponentID.ECAMPAIGN_REVIEW_ReviewN7_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignReviewN7ComponentID.ECAMPAIGN_REVIEW_ReviewN7_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  return nil
end

function CCampaignReviewN7:GetComponentInfo(componentID)
  if ECampaignReviewN7ComponentID.ECAMPAIGN_REVIEW_ReviewN7_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignReviewN7ComponentID.ECAMPAIGN_REVIEW_ReviewN7_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  return nil
end
