_class("CCampaignReviewN12", ICampaignComponentLocalProcessBase)
CCampaignReviewN12 = CCampaignReviewN12

function CCampaignReviewN12:Constructor()
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN12:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N12
end

function CCampaignReviewN12:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN12:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetStoryComponent()
  self:_GetPointProgressComponent()
end

function CCampaignReviewN12:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignReviewN12ComponentID.ECAMPAIGN_REVIEW_ReviewN12_STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaignReviewN12:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN12ComponentID.ECAMPAIGN_REVIEW_ReviewN12_POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN12:GetComponent(componentID)
  if ECampaignReviewN12ComponentID.ECAMPAIGN_REVIEW_ReviewN12_STORY == componentID then
    return self._storyComponent
  end
  if ECampaignReviewN12ComponentID.ECAMPAIGN_REVIEW_ReviewN12_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  return nil
end

function CCampaignReviewN12:GetComponentInfo(componentID)
  if ECampaignReviewN12ComponentID.ECAMPAIGN_REVIEW_ReviewN12_STORY == componentID then
    return self._storyComponentInfo
  end
  if ECampaignReviewN12ComponentID.ECAMPAIGN_REVIEW_ReviewN12_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  return nil
end
