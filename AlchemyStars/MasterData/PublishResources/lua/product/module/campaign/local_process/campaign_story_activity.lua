_class("CCampaignStoryActivity", ICampaignComponentLocalProcessBase)
CCampaignStoryActivity = CCampaignStoryActivity

function CCampaignStoryActivity:Constructor()
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._storySharedComponent = nil
  self._storySharedComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignStoryActivity:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
  self:_GetQuestComponent()
  self:_GetSharedStoryComponent()
end

function CCampaignStoryActivity:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_STORY_ACTIVITY
end

function CCampaignStoryActivity:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignStoryActivity:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignStoryActivity:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_TASK)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignStoryActivity:_GetSharedStoryComponent()
  self._storySharedComponent = self._campaignObj:GetComponent(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_SHARED)
  if not self._storySharedComponent then
    return
  end
  self._storySharedComponentInfo = self._storySharedComponent:ComponentInfo()
end

function CCampaignStoryActivity:GetComponent(componentID)
  if ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_TASK == componentID then
    return self._questComponent
  end
  if ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_SHARED == componentID then
    return self._storySharedComponent
  end
  return nil
end

function CCampaignStoryActivity:GetComponentInfo(componentID)
  if ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_TASK == componentID then
    return self._questComponentInfo
  end
  if ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_SHARED == componentID then
    return self._storySharedComponentInfo
  end
  return nil
end

function CCampaignStoryActivity:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_STORY_ACTIVITY)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignStoryActivity:GetEntryRedDot()
  return self:HardLineMissionRedDot() or self:CampQuestReddot()
end

function CCampaignStoryActivity:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignStoryActivity:CampQuestReddot()
  return self._questComponent and self._questComponent:HaveRedPoint()
end
