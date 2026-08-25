local CopySubplotGroupModel, Super = NewClass("CopySubplotGroupModel", CopyStagesModel)
local StageGroupType = CommonDefine.StageGroupType
local StageGroupHardModeIndex = CommonDefine.StageGroupHardModeIndex
local SMALL_GROUP_TYPE = 1
local LARGE_GROUP_TYPE = 2

function CopySubplotGroupModel:OnReset()
  Super.OnReset(self)
end

function CopySubplotGroupModel:ResetStageData()
  Super.ResetStageData(self)
  self.jumpActivityTid = nil
end

function CopySubplotGroupModel:SetJumpActivityTid(activityTid)
  if self.jumpActivityTid == activityTid then
    return
  end
  self.jumpActivityTid = activityTid
end

function CopySubplotGroupModel:GetJumpActivityTid()
  return self.jumpActivityTid
end

function CopySubplotGroupModel:OnInit()
  self.hardIndex2Difficult = {
    [StageGroupHardModeIndex.Normal] = {
      StageGroupType.SmallSubplotNormal,
      StageGroupType.LargeSubplotNormal
    },
    [StageGroupHardModeIndex.Hard] = {
      StageGroupType.SmallSubplotHard,
      StageGroupType.LargeSubplotHard
    },
    [StageGroupHardModeIndex.Crazy] = {
      StageGroupType.SmallSubplotCrazy,
      StageGroupType.LargeSubplotCrazy
    }
  }
  self.activitySubplotGroupsMap = nil
  self:OnReset()
end

function CopySubplotGroupModel:SetStageGroupID(stageGroupId)
  if self.stageGroupId ~= stageGroupId then
    self.stageGroupId = stageGroupId
    CopyController.Instance:ReqSubplotBranchStageData({stageGroupId})
  end
  self:LocalNotify(NotifyId.OnCopySubplotStageGroupIdChanged, stageGroupId)
end

function CopySubplotGroupModel:GetCurStageGroupHardModeIndex()
  local difficult2TidMap = CopyDataUtils.GetSubplotDifficult2IdMap(self.stageGroupId) or {}
  local NormalModeIndex = CommonDefine.StageGroupHardModeIndex.Normal
  if self.stageGroupId == difficult2TidMap[NormalModeIndex] then
    return NormalModeIndex
  end
  local HardModeIndex = CommonDefine.StageGroupHardModeIndex.Hard
  if self.stageGroupId == difficult2TidMap[HardModeIndex] then
    return HardModeIndex
  end
  local CrazyModeIndex = CommonDefine.StageGroupHardModeIndex.Crazy
  if self.stageGroupId == difficult2TidMap[CrazyModeIndex] then
    return CrazyModeIndex
  end
  return NormalModeIndex
end

function CopySubplotGroupModel:StageGroupHardModeIndex2Id(hardModeIndex, stageGroupId)
  local difficult2TidMap = CopyDataUtils.GetSubplotDifficult2IdMap(stageGroupId or self.stageGroupId) or {}
  local NormalModeIndex = CommonDefine.StageGroupHardModeIndex.Normal
  if hardModeIndex == NormalModeIndex then
    return difficult2TidMap[NormalModeIndex]
  end
  local HardModeIndex = CommonDefine.StageGroupHardModeIndex.Hard
  if hardModeIndex == HardModeIndex then
    return difficult2TidMap[HardModeIndex]
  end
  local CrazyModeIndex = CommonDefine.StageGroupHardModeIndex.Crazy
  if hardModeIndex == CrazyModeIndex then
    return difficult2TidMap[CrazyModeIndex]
  end
  return 0
end

function CopySubplotGroupModel:GetCurDifficulty()
  local curDiffIndex = self:GetCurStageGroupHardModeIndex()
  local hardGroupTypeArr = self.hardIndex2Difficult[curDiffIndex]
  if not hardGroupTypeArr then
    return
  end
  local isSubplot, isLarge = CopyDataUtils.IsSubplotGroup(self.stageGroupId)
  local isLargeSubplot = isSubplot and isLarge
  local difficulty = hardGroupTypeArr[SMALL_GROUP_TYPE]
  if isLargeSubplot then
    difficulty = hardGroupTypeArr[LARGE_GROUP_TYPE]
  end
  return difficulty
end

function CopySubplotGroupModel:GetStageGroupName()
  if not self:CheckStageGroupIdValid(self.stageGroupId) then
    return
  end
  local config = CopyDataUtils.GetStageGroupConfig(self.stageGroupId)
  return config and LT.Text(config.Name)
end

function CopySubplotGroupModel:GetCurrStageGroupTotalStar()
  do return MainCopyDataUtils.GetTotalStar end
  return MainCopyDataUtils.GetTotalStar, self.stageGroupId
end

function CopySubplotGroupModel:GetCurrStageGroupStar()
  local curGroupData = self:GetGroupData()
  if not curGroupData then
    return 0
  end
  return curGroupData.totalStar or 0
end

function CopySubplotGroupModel:CheckStageGroupIdValid(numValue)
  if not numValue or type(numValue) ~= "number" or 0 == numValue then
    return false
  end
  return true
end

function CopySubplotGroupModel:GetStageGroupDesc()
  if not self:CheckStageGroupIdValid(self.stageGroupId) then
    return
  end
  local config = CopyDataUtils.GetStageGroupConfig(self.stageGroupId)
  return config and LT.Text(config.Desc)
end

function CopySubplotGroupModel:GetBackgroundImage()
  if not self:CheckStageGroupIdValid(self.stageGroupId) then
    return
  end
  local config = CopyDataUtils.GetStageGroupConfig(self.stageGroupId)
  return config and config.Backgrand
end

function CopySubplotGroupModel:IsActivitySubplot(stageGroupTid)
  if not stageGroupTid then
    return false
  end
  if self.activitySubplotGroupsMap and self.activitySubplotGroupsMap[stageGroupTid] then
    return true
  end
  local groupData = DT.StageGroup[stageGroupTid]
  if not groupData then
    return false
  end
  local isSubplot = false
  for _, v in pairs(self.hardIndex2Difficult) do
    for _, groupType in pairs(v) do
      if groupType == groupData.Type then
        isSubplot = true
        break
      end
    end
    if isSubplot then
      break
    end
  end
  if not isSubplot then
    return false
  end
  for k, v in pairs(DT.Activity) do
    local activityType = ActivityDataUtils.GetType(k)
    if activityType ~= ActivityDefine.ActivityType.SubPlot then
    elseif not v.ActivityPara1 then
    else
      for _, groupTid in ipairs(config.ActivityPara1) do
        if stageGroupTid == groupTid then
          self.activitySubplotGroupsMap = self.activitySubplotGroupsMap or {}
          self.activitySubplotGroupsMap[stageGroupTid] = k
          return true
        end
      end
    end
  end
end

function CopySubplotGroupModel:IsSubplotInActivity()
  do return ActivityManager.Instance.HasOpeningSubplotActivity, ActivityManager.Instance end
  return ActivityManager.Instance.HasOpeningSubplotActivity, ActivityManager.Instance, self.stageGroupId
end

function CopySubplotGroupModel:HasStarPrize()
  if not self:CheckStageGroupIdValid(self.stageGroupId) then
    return false
  end
  local totalStar = MainCopyDataUtils.GetTotalStar(self.stageGroupId)
  return totalStar and totalStar > 0
end

function CopySubplotGroupModel:IsStageGroupFeatureUnlock(stageGroupTid)
  local feature = CopyDataUtils.GetStageGroupFeature(stageGroupTid)
  if not feature then
    return true
  end
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(feature, stageGroupTid)
  return unlocked
end

return CopySubplotGroupModel
