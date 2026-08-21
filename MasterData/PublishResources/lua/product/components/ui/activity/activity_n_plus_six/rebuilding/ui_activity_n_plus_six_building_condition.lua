_class("UIActivityNPlusSixBuildingCondition", Object)
UIActivityNPlusSixBuildingCondition = UIActivityNPlusSixBuildingCondition

function UIActivityNPlusSixBuildingCondition:Constructor(cfg, localProcess)
  self._localProcess = localProcess
  self._lineMissionComponet = self._localProcess:GetComponent(ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION)
  self._lineMissionCompInfo = self._localProcess:GetComponentInfo(ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION)
  self._preBuildingIdList = {}
  self._preBuildingStatusList = {}
  if not cfg then
    return
  end
  if cfg.NeedItemId > 0 then
    self._preBuildingIdList[#self._preBuildingIdList + 1] = cfg.NeedItemId
    self._preBuildingStatusList[#self._preBuildingStatusList + 1] = cfg.NeedItemStatus
  end
  self._needMissionList = cfg.NeedMissionList
end

function UIActivityNPlusSixBuildingCondition:IsUnLock(buildingDatas)
  for i = 1, #self._preBuildingIdList do
    local buildingData = buildingDatas:GetBuilding(self._preBuildingIdList[i])
    local statusType = self._preBuildingStatusList[i]
    if 0 <= statusType and buildingData:IsUnLockStatus(self._preBuildingStatusList[i]) == false then
      return false
    end
  end
  if self._needMissionList then
    local passMissionInfos = self._lineMissionCompInfo.m_pass_mission_info
    for i = 1, #self._needMissionList do
      if self._lineMissionComponet:IsPassCamMissionID(self._needMissionList[i]) == false then
        return false
      end
    end
  end
  return true
end
