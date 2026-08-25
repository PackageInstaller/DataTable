local RedType = RedTypeDefine.RedType
local SubplotRedUtils = {}

function SubplotRedUtils.Init()
  DataCenter.redPointData[RedType.SubplotStar] = {}
  local allPlots = DataCenter.MainCopyData.allPlots
  for _, groupData in pairs(allPlots) do
    if groupData then
      SubplotRedUtils.UpdateRed(groupData)
    end
  end
end

function SubplotRedUtils.RemoveStageNew(stageTid)
  if not stageTid then
    return
  end
  RedPointDataUtils.ReqRemoveData(RedType.NewStageUnlock, RedPointDataUtils.RedAttrType.IsNew, stageTid)
end

function SubplotRedUtils.UpdateRed(groupData)
  if not groupData then
    return
  end
  if not CopyDataUtils.IsSubplotGroup(groupData.stageGroupID) then
    return
  end
  local redData = DataCenter.redPointData[RedType.SubplotStar]
  if not redData[groupData.stageGroupID] then
    redData[groupData.stageGroupID] = {}
  end
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(groupData.stageGroupID)
  if not stageGroupCfg or not stageGroupCfg.StageGroupDrop then
    return
  end
  local groupRedData = redData[groupData.stageGroupID]
  for i = 1, #stageGroupCfg.StageGroupDrop, 2 do
    local star = stageGroupCfg.StageGroupDrop[i]
    local hasGained = groupData and groupData.starGainInfo and groupData.starGainInfo[star]
    local isRed = not (not (star <= groupData.totalStar) or hasGained) and 1 or 0
    local starRed = groupRedData[star]
    if not starRed then
      starRed = {}
      groupRedData[star] = starRed
    end
    starRed.red = isRed
  end
end

function SubplotRedUtils.GetSmallSubplotRed()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.SmallSubplotTab, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local groupList = CopyDataUtils.GetSubplotList(false)
  for _, groupTid in ipairs(groupList) do
    local ret = SubplotRedUtils.GetAllDiifRedByGroupTid(groupTid)
    if ret then
      return ret
    end
  end
  return false
end

function SubplotRedUtils.GetLargeSubplotRed()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.LargeSubplotTab, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local groupList = CopyDataUtils.GetSubplotList(true)
  for _, groupTid in ipairs(groupList) do
    local _, groupLocked = PlayerDataUtils.IsFeatureUnlock(CopyDataUtils.GetStageGroupFeature(groupTid), groupTid)
    local notOpenActivityMap = ActivityManager.Instance:GetNotOpenSubplotActivities()
    if groupLocked and not notOpenActivityMap[groupTid] then
      local ret = SubplotRedUtils.GetAllDiifRedByGroupTid(groupTid)
      if ret then
        return ret
      end
    end
  end
  do return end
  return RedPointDataUtils.IsLargeSubplotGroupResonanceRedShow, ipairs(groupList)
end

function SubplotRedUtils.GetLinkageActivityRed()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.SpecialSubplotTab, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local groupList = CopyExtModel.Instance:GetLinkageActivityGroupList()
  for _, groupTid in ipairs(groupList) do
    local ret = SubplotRedUtils.GetRedByGroupTid(groupTid)
    if ret then
      return ret
    end
    if CopyDataUtils.IsStageGroupNeedUnlockItem(groupTid) and ActivityManager.Instance:HasOpeningSubplotActivity(groupTid) and not CopyDataUtils.IsStageGroupUseUnlockItem(groupTid) then
      return RedPointDataUtils.RedAttrType.IsNew
    end
  end
  return false
end

function SubplotRedUtils.GetSpecialSubplotRed()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.SpecialSubplotTab, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local groupList = CopyExtModel.Instance:GetSpecialGroupList()
  for _, groupTid in ipairs(groupList) do
    local ret = SubplotRedUtils.GetAllDiifRedByGroupTid(groupTid)
    if ret then
      return ret
    end
  end
  return false
end

function SubplotRedUtils.GetRedByGroupType(groupType)
  if not groupType then
    return
  end
  local redData = DataCenter.redPointData[RedType.SubplotStar]
  for groupTid, _ in pairs(redData) do
    local _groupType = CopyDataUtils.GetStageGroupType(groupTid)
    if _groupType == groupType then
      local red = SubplotRedUtils.GetRedByGroupTid(groupTid)
      if red then
        return red
      end
    end
  end
  return
end

function SubplotRedUtils.CheckGroupRedValid(groupTid)
  if not groupTid then
    return false
  end
  local feature = CopyDataUtils.GetStageGroupFeature(groupTid)
  local _, isUnlocked = PlayerDataUtils.IsFeatureUnlock(feature, groupTid)
  if not isUnlocked then
    return false
  end
  if not CopyDataUtils.IsStageGroupNeedUnlockItem(groupTid) then
    return true
  end
  if CopyDataUtils.IsStageGroupUseUnlockItem(groupTid) then
    return true
  end
  if ActivityManager.Instance:HasOpeningSubplotActivity(groupTid) then
    return true
  end
  return false
end

function SubplotRedUtils.GetAllDiifRedByGroupTid(groupTid)
  if CopyDataUtils.IsStageGroupNeedUnlockItem(groupTid) and ActivityManager.Instance:HasOpeningSubplotActivity(groupTid) and not CopyDataUtils.IsStageGroupUseUnlockItem(groupTid) then
    return RedPointDataUtils.RedAttrType.IsNew
  end
  if CopyDataUtils.CheckSubplotIsLockState(groupTid) and not ActivityManager.Instance:HasOpeningSubplotActivity(groupTid) then
    return false
  end
  local groupTidMap = CopyDataUtils.GetSubplotDifficult2IdMap(groupTid)
  if not groupTidMap then
    do return SubplotRedUtils.GetRedByGroupTid end
    return SubplotRedUtils.GetRedByGroupTid, groupTid, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  for _, tid in pairs(groupTidMap) do
    if SubplotRedUtils.CheckGroupRedValid(tid) then
      local groupData = DataCenter.MainCopyData.allPlots[tid]
      if groupData and groupData.stageList then
        for _, stageData in ipairs(groupData.stageList) do
          local stageRed = SubplotRedUtils.GetNewByStageTid(stageData.stageID)
          if stageRed then
            return stageRed
          end
        end
      end
    end
  end
  for _, tid in pairs(groupTidMap) do
    local ret = SubplotRedUtils.GetRedByGroupTid(tid)
    if ret then
      return ret
    end
  end
  return false
end

function SubplotRedUtils.GetRedByGroupTid(groupTid)
  if not SubplotRedUtils.CheckGroupRedValid(groupTid) then
    return false
  end
  local groupData = DataCenter.MainCopyData.allPlots[groupTid]
  if groupData and groupData.stageList then
    for _, stageData in ipairs(groupData.stageList) do
      local stageRed = SubplotRedUtils.GetRedByStageTid(stageData.stageID)
      if stageRed then
        return stageRed
      end
    end
  end
  local achiveRed = RedPointDataUtils.IsShowStageGroupAchievementReward(groupTid)
  if achiveRed then
    return achiveRed
  end
  do return SubplotRedUtils.GetSubplotGroupStarRed end
  return SubplotRedUtils.GetSubplotGroupStarRed, {groupTid}, groupTid, nil, nil, SubplotRedUtils.GetRedByStageTid(stageData.stageID), stageData.stageID
end

function SubplotRedUtils.GetSubplotGroupStarRed(args)
  local redData = RedPointDataUtils.GetRedPointState(RedType.SubplotStar, args)
  return redData
end

function SubplotRedUtils.GetRedByStageTid(stageTid)
  if not stageTid then
    return false
  end
  local stageData = MainCopyDataUtils.GetStageData(stageTid)
  if stageData then
    if stageData.openTime and stageData.openTime > TimeUtils.GetServerTime() then
      return false
    end
    if not stageData.unlocked then
      return false
    end
  end
  local stageConfig = CopyDataUtils.GetStageConfig(stageTid)
  if not stageConfig then
    return false
  end
  local groupTid = stageConfig.BelongGroup
  local feature = CopyDataUtils.GetStageGroupFeature(groupTid)
  local _, isUnlocked = PlayerDataUtils.IsFeatureUnlock(feature, groupTid)
  if not isUnlocked then
    return false
  end
  if not CopyDataUtils.CheckStageIsUnlocked(stageTid) then
    return false
  end
  local red = RedPointDataUtils.GetRedPointState(RedTypeDefine.RedType.NewStageUnlock, {stageTid})
  return red
end

function SubplotRedUtils.GetNewByStageTid(stageTid)
  if not stageTid then
    return false
  end
  local stageConfig = CopyDataUtils.GetStageConfig(stageTid)
  if not stageConfig then
    return false
  end
  local groupTid = stageConfig.BelongGroup
  local feature = CopyDataUtils.GetStageGroupFeature(groupTid)
  local _, isUnlocked = PlayerDataUtils.IsFeatureUnlock(feature, groupTid)
  if not isUnlocked then
    return false
  end
  local stageData = MainCopyDataUtils.GetStageData(stageTid)
  if stageData then
    if stageData.openTime and stageData.openTime > TimeUtils.GetServerTime() then
      return false
    end
    if not stageData.unlocked then
      return false
    end
  end
  if not CopyDataUtils.CheckStageIsUnlocked(stageTid) then
    return false
  end
  local red = RedPointDataUtils.GetRedPointState(RedTypeDefine.RedType.NewStageUnlock, {stageTid})
  return red
end

return SubplotRedUtils
