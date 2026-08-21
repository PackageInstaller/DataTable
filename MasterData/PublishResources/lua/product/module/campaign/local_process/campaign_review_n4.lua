_class("CCampaignReviewN4", ICampaignComponentLocalProcessBase)
CCampaignReviewN4 = CCampaignReviewN4

function CCampaignReviewN4:Constructor()
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN4:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N4
end

function CCampaignReviewN4:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN4:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetStoryComponent()
  self:_GetPointProgressComponent()
end

function CCampaignReviewN4:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignReviewN4ComponentID.ECAMPAIGN_REVIEW_ReviewN4_STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaignReviewN4:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN4ComponentID.ECAMPAIGN_REVIEW_ReviewN4_POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN4:GetComponent(componentID)
  if ECampaignReviewN4ComponentID.ECAMPAIGN_REVIEW_ReviewN4_STORY == componentID then
    return self._storyComponent
  end
  if ECampaignReviewN4ComponentID.ECAMPAIGN_REVIEW_ReviewN4_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  return nil
end

function CCampaignReviewN4:GetComponentInfo(componentID)
  if ECampaignReviewN4ComponentID.ECAMPAIGN_REVIEW_ReviewN4_STORY == componentID then
    return self._storyComponentInfo
  end
  if ECampaignReviewN4ComponentID.ECAMPAIGN_REVIEW_ReviewN4_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  return nil
end
