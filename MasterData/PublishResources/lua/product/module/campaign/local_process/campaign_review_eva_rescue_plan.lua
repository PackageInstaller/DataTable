_class("CCampaignReviewEvaRescuePlan", ICampaignComponentLocalProcessBase)
CCampaignReviewEvaRescuePlan = CCampaignReviewEvaRescuePlan

function CCampaignReviewEvaRescuePlan:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._treeMissionComponet = nil
  self._treeMissionCompInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewEvaRescuePlan:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N1
end

function CCampaignReviewEvaRescuePlan:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewEvaRescuePlan:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetTreeMissionComponent()
  self:_GetPointProgressComponent()
end

function CCampaignReviewEvaRescuePlan:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewEvaRescuePlan:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewEvaRescuePlan:_GetTreeMissionComponent()
  self._treeMissionComponet = self._campaignObj:GetComponent(ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_TREE_MISSION)
  if not self._treeMissionComponet then
    return
  end
  self._treeMissionCompInfo = self._treeMissionComponet:ComponentInfo()
end

function CCampaignReviewEvaRescuePlan:GetComponent(componentID)
  if ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  if ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_TREE_MISSION == componentID then
    return self._treeMissionComponet
  end
  return nil
end

function CCampaignReviewEvaRescuePlan:GetComponentInfo(componentID)
  if ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  if ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_TREE_MISSION == componentID then
    return self._treeMissionCompInfo
  end
  return nil
end
