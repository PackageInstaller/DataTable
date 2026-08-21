_class("CCampaingN6", ICampaignComponentLocalProcessBase)
CCampaingN6 = CCampaingN6

function CCampaingN6:Constructor()
  self._buildComponent = nil
  self._buildComponentInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._lineMissionComponet1 = nil
  self._lineMissionCompInfo1 = nil
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._campaignObj = nil
end

function CCampaingN6:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_HALLOWEEN
end

function CCampaingN6:CampaignObjInfo()
  return self._campaignObj
end

function CCampaingN6:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetBuildComponent()
  self:_GetQuestComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetFixTeamLineMissionComponent()
  self:_GetStoryComponent()
end

function CCampaingN6:_GetBuildComponent()
  self._buildComponent = self._campaignObj:GetComponent(ECampaignN6ComponentID.ECAMPAIGN_N6_BUILD)
  if not self._buildComponent then
    return
  end
  self._buildComponentInfo = self._buildComponent:ComponentInfo()
end

function CCampaingN6:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignN6ComponentID.ECAMPAIGN_N6_QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaingN6:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaingN6:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaingN6:_GetFixTeamLineMissionComponent()
  self._lineMissionComponet1 = self._campaignObj:GetComponent(ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION_FIXTEAM)
  if not self._lineMissionComponet1 then
    return
  end
  self._lineMissionCompInfo1 = self._lineMissionComponet1:ComponentInfo()
end

function CCampaingN6:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignN6ComponentID.ECAMPAIGN_N6_STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaingN6:GetComponent(componentID)
  if ECampaignN6ComponentID.ECAMPAIGN_N6_BUILD == componentID then
    return self._buildComponent
  end
  if ECampaignN6ComponentID.ECAMPAIGN_N6_QUEST == componentID then
    return self._questComponent
  end
  if ECampaignN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION_FIXTEAM == componentID then
    return self._lineMissionComponet1
  end
  if ECampaignN6ComponentID.ECAMPAIGN_N6_STORY == componentID then
    return self._storyComponent
  end
  return nil
end

function CCampaingN6:GetComponentInfo(componentID)
  if ECampaignN6ComponentID.ECAMPAIGN_N6_BUILD == componentID then
    return self._buildComponentInfo
  end
  if ECampaignN6ComponentID.ECAMPAIGN_N6_QUEST == componentID then
    return self._questComponentInfo
  end
  if ECampaignN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION_FIXTEAM == componentID then
    return self._lineMissionCompInfo1
  end
  if ECampaignN6ComponentID.ECAMPAIGN_N6_STORY == componentID then
    return self._storyComponentInfo
  end
  return nil
end
