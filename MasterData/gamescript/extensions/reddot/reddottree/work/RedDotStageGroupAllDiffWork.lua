local RedDotStageGroupAllDiffWork, Super = System.NewPoolClass("RedDotStageGroupAllDiffWork", RedDotSingleFlow)

function RedDotStageGroupAllDiffWork:ctor(stageGroupTidList)
  Super.ctor(self, "关卡组所有难度红点")
  self.stageGroupTidList = stageGroupTidList or {}
end

function RedDotStageGroupAllDiffWork:_IsFreeToUnlock(stageGroupTid)
  if not CopyDataUtils.IsStageGroupNeedUnlockItem(stageGroupTid) then
    return true
  end
  do return ActivityManager.Instance.HasOpeningSubplotActivity, ActivityManager.Instance end
  return ActivityManager.Instance.HasOpeningSubplotActivity, ActivityManager.Instance, stageGroupTid
end

function RedDotStageGroupAllDiffWork:_IsSubplotDataEmpty(stageGroupTid)
  local plotData = DataCenter.MainCopyData.allPlots[stageGroupTid]
  if not (plotData and plotData.stageList) or 0 == #plotData.stageList then
    return true
  end
  return false
end

function RedDotStageGroupAllDiffWork:_HasLocalSubplotProgress(stageGroupTid)
  local diffMap = CopyDataUtils.GetSubplotDifficult2IdMap(stageGroupTid)
  if diffMap then
    for _, tid in pairs(diffMap) do
      if MainCopyDataUtils.HasGotAllSubplotPrize(tid) then
        return true
      end
      local plotData = DataCenter.MainCopyData.allPlots[tid]
      if plotData and plotData.stageList then
        for _, stageData in ipairs(plotData.stageList) do
          if stageData.unlocked or stageData.firstRewardDraw then
            return true
          end
        end
      end
    end
    return false
  end
  if MainCopyDataUtils.HasGotAllSubplotPrize(stageGroupTid) then
    return true
  end
  local plotData = DataCenter.MainCopyData.allPlots[stageGroupTid]
  if plotData and plotData.stageList then
    for _, stageData in ipairs(plotData.stageList) do
      if stageData.unlocked or stageData.firstRewardDraw then
        return true
      end
    end
  end
  return false
end

function RedDotStageGroupAllDiffWork:Execute()
  for _, stageGroupTid in ipairs(self.stageGroupTidList) do
    if not CopyDataUtils.IsValidSubplotStageGroupForRedDot(stageGroupTid) then
    else
      local isLocked = CopyDataUtils.IsStageGroupFeatureLocked(stageGroupTid)
      if not isLocked then
        if self:_IsFreeToUnlock(stageGroupTid) and (not CopySubplotGroupModel.Instance:IsHaveServerStageData(stageGroupTid) or self:_IsSubplotDataEmpty(stageGroupTid)) and not self:_HasLocalSubplotProgress(stageGroupTid) and not CopyDataUtils.IsStageGroupUseUnlockItem(stageGroupTid) then
          return RedDotDefine.RedDotType.New
        end
        local isNew = SubplotRedUtils.GetAllDiifRedByGroupTid(stageGroupTid)
        if isNew then
          return RedDotDefine.RedDotType.New
        end
      end
    end
  end
  return false
end

return RedDotStageGroupAllDiffWork
