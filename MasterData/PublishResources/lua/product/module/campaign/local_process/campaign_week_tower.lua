_class("CCampaignWeekTower", ICampaignComponentLocalProcessBase)
CCampaignWeekTower = CCampaignWeekTower

function CCampaignWeekTower:Constructor()
  self._weekTowerMissionComponent = nil
  self._weekTowerMissionComponentInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignWeekTower:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetWeekTowerMissionComponent()
  self:_GetQuestComponent()
end

function CCampaignWeekTower:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_WEEK_TOWER
end

function CCampaignWeekTower:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignWeekTower:_GetWeekTowerMissionComponent()
  self._weekTowerMissionComponent = self._campaignObj:GetComponent(ECampaignWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_MISSION)
  if not self._weekTowerMissionComponent then
    return
  end
  self._weekTowerMissionComponentInfo = self._weekTowerMissionComponent:ComponentInfo()
end

function CCampaignWeekTower:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_TASK)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignWeekTower:GetComponent(componentID)
  if ECampaignWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_MISSION == componentID then
    return self._weekTowerMissionComponent
  end
  if ECampaignWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_TASK == componentID then
    return self._questComponent
  end
  return nil
end

function CCampaignWeekTower:GetComponentInfo(componentID)
  if ECampaignWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_MISSION == componentID then
    return self._weekTowerMissionComponentInfo
  end
  if ECampaignWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_TASK == componentID then
    return self._questComponentInfo
  end
  return nil
end

function CCampaignWeekTower:GetWeekTowerMissionList()
  local missionList = {
    [1] = 1001,
    [2] = 1002
  }
  return missionList
end

function CCampaignWeekTower:GetWeekTowerMissionInfo()
  local missionInfoMap = {}
  local info = {}
  info.missionid = 1001
  info.passtime = 1
  local info2 = {}
  info.missionid = 1002
  info.passtime = 0
  missionInfoMap[info.missionid] = info
  missionInfoMap[info2.missionid] = info2
  return missionInfoMap
end
