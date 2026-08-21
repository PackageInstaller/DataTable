_class("CCampaignReviewN3", ICampaignComponentLocalProcessBase)
CCampaignReviewN3 = CCampaignReviewN3

function CCampaignReviewN3:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._lineMissionStage2Componet = nil
  self._lineMissionStage2CompInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN3:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N3
end

function CCampaignReviewN3:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN3:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetLineMissionStage2Component()
  self:_GetPointProgressComponent()
end

function CCampaignReviewN3:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewN3:_GetLineMissionStage2Component()
  self._lineMissionStage2Componet = self._campaignObj:GetComponent(ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_STAGE2_LINE_MISSION)
  if not self._lineMissionStage2Componet then
    return
  end
  self._lineMissionStage2CompInfo = self._lineMissionStage2Componet:ComponentInfo()
end

function CCampaignReviewN3:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN3:GetComponent(componentID)
  if ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_STAGE2_LINE_MISSION == componentID then
    return self._lineMissionStage2Componet
  end
  if ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  return nil
end

function CCampaignReviewN3:GetComponentInfo(componentID)
  if ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_STAGE2_LINE_MISSION == componentID then
    return self._lineMissionStage2CompInfo
  end
  if ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  return nil
end
