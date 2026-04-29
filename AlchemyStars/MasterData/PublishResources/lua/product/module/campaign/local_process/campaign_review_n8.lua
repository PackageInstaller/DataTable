_class("CCampaignReviewN8", ICampaignComponentLocalProcessBase)
CCampaignReviewN8 = CCampaignReviewN8

function CCampaignReviewN8:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN8:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N8
end

function CCampaignReviewN8:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN8:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
end

function CCampaignReviewN8:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewN8ComponentID.ECAMPAIGN_REVIEW_ReviewN8_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewN8:GetComponent(componentID)
  if ECampaignReviewN8ComponentID.ECAMPAIGN_REVIEW_ReviewN8_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  return nil
end

function CCampaignReviewN8:GetComponentInfo(componentID)
  if ECampaignReviewN8ComponentID.ECAMPAIGN_REVIEW_ReviewN8_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  return nil
end
