_class("CCampaignInlandStory", ICampaignComponentLocalProcessBase)
CCampaignInlandStory = CCampaignInlandStory

function CCampaignInlandStory:Constructor()
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignInlandStory:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_STORY
end

function CCampaignInlandStory:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignInlandStory:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetStoryComponent()
end

function CCampaignInlandStory:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECCampaignInlandStoryComponentID.STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaignInlandStory:GetComponent(componentID)
  if ECCampaignInlandStoryComponentID.STORY == componentID then
    return self._storyComponent
  end
  return nil
end

function CCampaignInlandStory:GetComponentInfo(componentID)
  if ECCampaignInlandStoryComponentID.STORY == componentID then
    return self._storyComponentInfo
  end
  return nil
end
