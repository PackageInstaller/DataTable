_class("CCampaignSeasonTaskMission", ICampaignComponentLocalProcessBase)
CCampaignSeasonTaskMission = CCampaignSeasonTaskMission

function CCampaignSeasonTaskMission:Constructor()
  self._seasonTaskMissionComponent = nil
  self._seasonTaskMissionComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignSeasonTaskMission:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetSeasonTaskMissionComponent()
end

function CCampaignSeasonTaskMission:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_SEASON_TASK_MISSION
end

function CCampaignSeasonTaskMission:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignSeasonTaskMission:_GetSeasonTaskMissionComponent()
  self._seasonTaskMissionComponent = self._campaignObj:GetComponent(ECampaignSeasonTaskMissionComponentID.ECAMPAIGN_SEASON_TASK_MISSION)
  if not self._seasonTaskMissionComponent then
    return
  end
  self._seasonTaskMissionComponentInfo = self._seasonTaskMissionComponent:ComponentInfo()
end

function CCampaignSeasonTaskMission:GetComponent(componentID)
  if ECampaignSeasonTaskMissionComponentID.ECAMPAIGN_SEASON_TASK_MISSION == componentID then
    return self._seasonTaskMissionComponent
  end
  return nil
end

function CCampaignSeasonTaskMission:GetComponentInfo(componentID)
  if ECampaignSeasonTaskMissionComponentID.ECAMPAIGN_SEASON_TASK_MISSION == componentID then
    return self._seasonTaskMissionComponentInfo
  end
  return nil
end
