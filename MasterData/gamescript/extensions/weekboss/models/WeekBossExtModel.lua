local WeekBossExtModel = NewClass("WeekBossExtModel", BaseModel)

function WeekBossExtModel:OnReset()
  self.featureId = CommonDefine.FeatureId.WeekBossChallenge
  self.stageGroupType = CommonDefine.StageGroupType.WeekBoss
  self.stageGroupIdList = {}
  self.selectedStageGroupId = 0
  self.previewRewards = {}
end

function WeekBossExtModel:OnInit()
  self:OnReset()
end

function WeekBossExtModel:GetFeartureId()
  return self.featureId
end

function WeekBossExtModel:SetStageGroupIdList(stageGroupIdList)
  self.stageGroupIdList = stageGroupIdList
end

function WeekBossExtModel:GetStageGroupIdList()
  return self.stageGroupIdList
end

function WeekBossExtModel:GetFirstStageGroupId()
  return self.stageGroupIdList[1]
end

function WeekBossExtModel:SetSelectedStageGroupId(stageGroupId)
  self.selectedStageGroupId = stageGroupId or 0
  if 0 == self.selectedStageGroupId then
    self.selectedStageGroupId = self:GetFirstStageGroupId()
  end
  local stageGroupCfg = self:GetStageGroupCfg(self.selectedStageGroupId)
  self.previewRewards = table.clone(stageGroupCfg and stageGroupCfg.StageGroupDropPreview or {})
  self:LocalNotify(NotifyId.OnWeekBossStageGroupId, self.selectedStageGroupId)
end

function WeekBossExtModel:GetSelectedStageGroupId()
  return self.selectedStageGroupId
end

function WeekBossExtModel:GetPreviewRewards()
  return self.previewRewards
end

function WeekBossExtModel:GetWeekBossRefreshTimeDesc()
  do return end
  return DungeonUtils.GetWeekBossRefreshTimeDesc
end

function WeekBossExtModel:GetWeekRewardCountTotal()
  do return DT.GetConstant, "WeeklyBossStageRewardCount" end
  return DT.GetConstant, "WeeklyBossStageRewardCount", 0
end

function WeekBossExtModel:GetWeekRewardCountLeft()
  do return end
  return CopyDataUtils.GetWeekBossRewardCnt
end

function WeekBossExtModel:IsSelected(stageGroupId)
  return stageGroupId == self.selectedStageGroupId
end

function WeekBossExtModel:IsShowRed(stageGroupId)
  do return RedPointDataUtils.IsShowWeekBossNew end
  return RedPointDataUtils.IsShowWeekBossNew, stageGroupId
end

function WeekBossExtModel:GetStageGroupCfg(stageGroupId)
  return DT.StageGroup[stageGroupId]
end

function WeekBossExtModel:IsUnlocked(stageGroupId)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(self.featureId, stageGroupId)
  return unlocked
end

function WeekBossExtModel:GetUnlockTips(stageGroupId)
  do return PlayerDataUtils.GetFeatureLogicUnlockTips, self.featureId end
  return PlayerDataUtils.GetFeatureLogicUnlockTips, self.featureId, stageGroupId
end

function WeekBossExtModel:IsInDoubleAct(stageGroupId)
  do return ActivityManager.Instance.CheckDoubleOutputEffect, ActivityManager.Instance end
  return ActivityManager.Instance.CheckDoubleOutputEffect, ActivityManager.Instance, stageGroupId
end

return WeekBossExtModel
