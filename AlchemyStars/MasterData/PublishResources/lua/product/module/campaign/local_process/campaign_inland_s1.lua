_class("CCampaignInlandS1", ICampaignComponentLocalProcessBase)
CCampaignInlandS1 = CCampaignInlandS1

function CCampaignInlandS1:Constructor()
  self._levelCommonComponet = nil
  self._levelCommonCompInfo = nil
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignInlandS1:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_S1
end

function CCampaignInlandS1:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignInlandS1:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLevelCommonComponent()
  self:_GetStoryComponent()
end

function CCampaignInlandS1:_GetLevelCommonComponent()
  self._levelCommonComponet = self._campaignObj:GetComponent(ECCampaignInlandS1ComponentID.Line_MISSION)
  if not self._levelCommonComponet then
    return
  end
  self._levelCommonCompInfo = self._levelCommonComponet:ComponentInfo()
end

function CCampaignInlandS1:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECCampaignInlandS1ComponentID.STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaignInlandS1:GetComponent(componentID)
  if ECCampaignInlandS1ComponentID.Line_MISSION == componentID then
    return self._levelCommonComponet
  end
  if ECCampaignInlandS1ComponentID.STORY == componentID then
    return self._storyComponent
  end
  return nil
end

function CCampaignInlandS1:GetComponentInfo(componentID)
  if ECCampaignInlandS1ComponentID.Line_MISSION == componentID then
    return self._levelCommonCompInfo
  end
  if ECCampaignInlandS1ComponentID.STORY == componentID then
    return self._storyComponentInfo
  end
  return nil
end
