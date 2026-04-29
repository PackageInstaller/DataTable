_class("CCampaignDifficultyWeekTower", ICampaignComponentLocalProcessBase)
CCampaignDifficultyWeekTower = CCampaignDifficultyWeekTower

function CCampaignDifficultyWeekTower:Constructor()
  self._weekTowerMissionComponent = nil
  self._weekTowerMissionComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignDifficultyWeekTower:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetWeekTowerMissionComponent()
end

function CCampaignDifficultyWeekTower:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_DIFFICULTY_WEEK_TOWER
end

function CCampaignDifficultyWeekTower:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignDifficultyWeekTower:_GetWeekTowerMissionComponent()
  self._weekTowerMissionComponent = self._campaignObj:GetComponent(ECampaignDiffcultyWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_DIFFICULT_MISSION)
  if not self._weekTowerMissionComponent then
    return
  end
  self._weekTowerMissionComponentInfo = self._weekTowerMissionComponent:ComponentInfo()
end

function CCampaignDifficultyWeekTower:GetComponent(componentID)
  if ECampaignDiffcultyWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_DIFFICULT_MISSION == componentID then
    return self._weekTowerMissionComponent
  end
  return nil
end

function CCampaignDifficultyWeekTower:GetComponentInfo(componentID)
  if ECampaignDiffcultyWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_DIFFICULT_MISSION == componentID then
    return self._weekTowerMissionComponentInfo
  end
  return nil
end

function CCampaignDifficultyWeekTower:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_DIFFICULTY_WEEK_TOWER)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignDifficultyWeekTower:GetEntryRedDot()
  return self:HardLineMissionRedDot()
end

function CCampaignDifficultyWeekTower:HardLineMissionRedDot()
  if not self._weekTowerMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._weekTowerMissionComponent:HaveRedPoint()
end
