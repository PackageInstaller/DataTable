_class("CCampaignReviewN6", ICampaignComponentLocalProcessBase)
CCampaignReviewN6 = CCampaignReviewN6

function CCampaignReviewN6:Constructor()
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._buildComponent = nil
  self._buildComponentInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._pointProgressComponent = nil
  self._pointProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignReviewN6:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_REVIEW_N6
end

function CCampaignReviewN6:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignReviewN6:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetBuildComponent()
  self:_GetQuestComponent()
  self:_GetStoryComponent()
  self:_GetPointProgressComponent()
end

function CCampaignReviewN6:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignReviewN6ComponentID.LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignReviewN6:_GetBuildComponent()
  self._buildComponent = self._campaignObj:GetComponent(ECampaignReviewN6ComponentID.BUILD)
  if not self._buildComponent then
    return
  end
  self._buildComponentInfo = self._buildComponent:ComponentInfo()
end

function CCampaignReviewN6:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignReviewN6ComponentID.QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignReviewN6:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignReviewN6ComponentID.STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaignReviewN6:_GetPointProgressComponent()
  self._pointProgressComponent = self._campaignObj:GetComponent(ECampaignReviewN6ComponentID.POINT_PROGRESS)
  if not self._pointProgressComponent then
    return
  end
  self._pointProgressComponentInfo = self._pointProgressComponent:ComponentInfo()
end

function CCampaignReviewN6:GetComponent(componentID)
  if ECampaignReviewN6ComponentID.LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignReviewN6ComponentID.BUILD == componentID then
    return self._buildComponent
  end
  if ECampaignReviewN6ComponentID.QUEST == componentID then
    return self._questComponent
  end
  if ECampaignReviewN6ComponentID.STORY == componentID then
    return self._storyComponent
  end
  if ECampaignReviewN6ComponentID.POINT_PROGRESS == componentID then
    return self._pointProgressComponent
  end
  return nil
end

function CCampaignReviewN6:GetComponentInfo(componentID)
  if ECampaignReviewN6ComponentID.LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignReviewN6ComponentID.BUILD == componentID then
    return self._buildComponentInfo
  end
  if ECampaignReviewN6ComponentID.QUEST == componentID then
    return self._questComponentInfo
  end
  if ECampaignReviewN6ComponentID.STORY == componentID then
    return self._storyComponentInfo
  end
  if ECampaignReviewN6ComponentID.POINT_PROGRESS == componentID then
    return self._pointProgressComponentInfo
  end
  return nil
end
