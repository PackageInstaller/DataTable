_class("CCampaignEvaRescuePlan", ICampaignComponentLocalProcessBase)
CCampaignEvaRescuePlan = CCampaignEvaRescuePlan

function CCampaignEvaRescuePlan:Constructor()
  self._exchange1Component = nil
  self._exchange1CompInfo = nil
  self._exchange2Component = nil
  self._exchange2CompInfo = nil
  self._personProgressComponent = nil
  self._personProgressCompInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._treeMissionComponet = nil
  self._treeMissionCompInfo = nil
  self._camQuestComponet = nil
  self._camQuestComponetInfo = nil
  self._fixteamMissionComponent = nil
  self._fixteamMissionCompInfo = nil
  self._actionPointComponent = nil
  self._actionPointCompInfo = nil
  self._storyComponent = nil
  self._storyCompInfo = nil
  self._campaignObj = nil
end

function CCampaignEvaRescuePlan:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN
end

function CCampaignEvaRescuePlan:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignEvaRescuePlan:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetExchange1Component()
  self:_GetExchange2Component()
  self:_GetCumulativeLoginComponent()
  self:_GetPersonProgressComponent()
  self:_GetLineMissionComponent()
  self:_GetTreeMissionComponent()
  self:_GetCamQuestComponent()
  self:_GetFixTeamMissionComponent()
  self:_GetActionPointComponent()
  self:_GetStoryComponent()
end

function CCampaignEvaRescuePlan:_GetExchange1Component()
  self._exchange1Component = self._campaignObj:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_EXCHANGE1)
  if not self._exchange1Component then
    return
  end
  self._exchange1CompInfo = self._exchange1Component:ComponentInfo()
end

function CCampaignEvaRescuePlan:_GetExchange2Component()
  self._exchange2Component = self._campaignObj:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_EXCHANGE2)
  if not self._exchange2Component then
    return
  end
  self._exchange2CompInfo = self._exchange2Component:ComponentInfo()
end

function CCampaignEvaRescuePlan:_GetPersonProgressComponent()
  self._personProgressComponent = self._campaignObj:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_PERSON_PROGRESS)
  if not self._personProgressComponent then
    return
  end
  self._personProgressCompInfo = self._personProgressComponent:ComponentInfo()
end

function CCampaignEvaRescuePlan:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignEvaRescuePlan:_GetTreeMissionComponent()
  self._treeMissionComponet = self._campaignObj:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_TREE_MISSION)
  if not self._treeMissionComponet then
    return
  end
  self._treeMissionCompInfo = self._treeMissionComponet:ComponentInfo()
end

function CCampaignEvaRescuePlan:_GetCamQuestComponent()
  self._camQuestComponet = self._campaignObj:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_QUEST)
  if not self._camQuestComponet then
    return
  end
  self._camQuestComponetInfo = self._camQuestComponet:ComponentInfo()
end

function CCampaignEvaRescuePlan:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:GetComponentInfo()
end

function CCampaignEvaRescuePlan:_GetFixTeamMissionComponent()
  self._fixteamMissionComponent = self._campaignObj:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_MISSION_FIXTEAM)
  if not self._fixteamMissionComponent then
    return
  end
  self._fixteamMissionCompInfo = self._fixteamMissionComponent:ComponentInfo()
end

function CCampaignEvaRescuePlan:_GetActionPointComponent()
  self._actionPointComponent = self._campaignObj:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_ACTION_POINT)
  if not self._actionPointComponent then
    return
  end
  self._actionPointCompInfo = self._actionPointComponent:ComponentInfo()
end

function CCampaignEvaRescuePlan:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_STORY)
  if not self._storyComponent then
    return
  end
  self._storyCompInfo = self._storyComponent:ComponentInfo()
end

function CCampaignEvaRescuePlan:GetComponent(componentID)
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_EXCHANGE1 == componentID then
    return self._exchange1Component
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_EXCHANGE2 == componentID then
    return self._exchange2Component
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_PERSON_PROGRESS == componentID then
    return self._personProgressComponent
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_TREE_MISSION == componentID then
    return self._treeMissionComponet
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_QUEST == componentID then
    return self._camQuestComponet
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_MISSION_FIXTEAM == componentID then
    return self._fixteamMissionComponent
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_ACTION_POINT == componentID then
    return self._actionPointComponent
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_STORY == componentID then
    return self._storyComponent
  end
  return nil
end

function CCampaignEvaRescuePlan:GetComponentInfo(componentID)
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_EXCHANGE1 == componentID then
    return self._exchange1CompInfo
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_EXCHANGE2 == componentID then
    return self._exchange2CompInfo
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_PERSON_PROGRESS == componentID then
    return self._personProgressCompInfo
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_TREE_MISSION == componentID then
    return self._treeMissionCompInfo
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_QUEST == componentID then
    return self._camQuestComponetInfo
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_MISSION_FIXTEAM == componentID then
    return self._fixteamMissionCompInfo
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_ACTION_POINT == componentID then
    return self._actionPointCompInfo
  end
  if ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_STORY == componentID then
    return self._storyCompInfo
  end
  return nil
end
