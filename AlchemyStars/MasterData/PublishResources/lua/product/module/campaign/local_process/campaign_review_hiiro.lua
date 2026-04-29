_class("CCampaignReviewHiiro", ICampaignComponentLocalProcessBase)
CCampaignReviewHiiro = CCampaignReviewHiiro

function CCampaignReviewHiiro:Constructor()
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewHiiro:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N2
end

function CCampaignReviewHiiro:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewHiiro:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetPointProgressComponent()
  self:_GetStoryComponent()
end

function CCampaignReviewHiiro:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewHiiro:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaignReviewHiiro:GetComponent(componentID)
  if ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  if ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_STORY == componentID then
    return self._storyComponent
  end
  return nil
end

function CCampaignReviewHiiro:GetComponentInfo(componentID)
  if ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  if ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_STORY == componentID then
    return self._storyComponentInfo
  end
  return nil
end
