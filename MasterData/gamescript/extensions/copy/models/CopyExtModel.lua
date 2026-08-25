local StageGroupType = CommonDefine.StageGroupType
local CopyExtModel = NewClass("CopyExtModel", BaseModel)
local PageResources = {}

function CopyExtModel:OnReset()
  self.curCopyPage = CommonDefine.MainCopyPanelPage.MainChapter
end

function CopyExtModel:OnInit()
  self:OnReset()
end

function CopyExtModel:SetCurCopyPage(curCopyPage)
  if self.curCopyPage == curCopyPage then
    return
  end
  self.curCopyPage = curCopyPage
  self:LocalNotify(NotifyId.OnCopyPagedChanged, curCopyPage)
end

function CopyExtModel:GetCurCopyPage()
  return self.curCopyPage
end

function CopyExtModel:GetCopyPageResUrl(page)
  if PageResources[page] then
    return PageResources[page]
  end
  local uiRes
  if page == CommonDefine.MainCopyPanelPage.MainChapter then
    uiRes = UI_Copy_MainChapter_ViewResource()
  elseif page == CommonDefine.MainCopyPanelPage.LargeSubplot then
    uiRes = UI_Copy_BranchLarge_ViewResource()
  elseif page == CommonDefine.MainCopyPanelPage.SmallSubplot then
    uiRes = UI_Copy_BranchSmall_ViewResource()
  end
  if uiRes then
    PageResources[page] = uiRes.assetPath
  end
  return PageResources[page]
end

function CopyExtModel:GetSublplotLargeGroupList()
  local groupList = CopyDataUtils.GetSubplotList(true)
  local list = {}
  local notOpenActivityMap = ActivityManager.Instance:GetNotOpenSubplotActivities()
  for _, groupTid in ipairs(groupList) do
    local isNormal = CopyDataUtils.IsNormalSubplotGroup(groupTid)
    if isNormal and not notOpenActivityMap[groupTid] then
      table.insert(list, groupTid)
    end
  end
  return list
end

function CopyExtModel:GetSpecialGroupList()
  local now = TimeUtils.GetServerTime()
  local rst = {}
  for _, stageGroupCfg in pairs(DT.StageGroup) do
    if stageGroupCfg.Type == StageGroupType.SpecialSubplotNormal and stageGroupCfg.DailyIcon and (not stageGroupCfg.StageDisplayDate or now >= stageGroupCfg.StageDisplayDate) then
      table.insert(rst, stageGroupCfg.ID)
    end
  end
  return rst
end

function CopyExtModel:GetSubplotGroupList()
  local groupList = CopyDataUtils.GetSubplotList(false)
  local list = {}
  local notOpenActivityMap = ActivityManager.Instance:GetNotOpenSubplotActivities()
  for _, groupTid in ipairs(groupList) do
    local isNormal = CopyDataUtils.IsNormalSubplotGroup(groupTid)
    if isNormal and not notOpenActivityMap[groupTid] then
      table.insert(list, groupTid)
    end
  end
  return list
end

function CopyExtModel:GetLinkageActivityGroupListFromCfg()
  local rst = {}
  for _, stageGroupCfg in pairs(DT.StageGroup) do
    if self:CheckIsLinkageActivity(stageGroupCfg.Type) then
      table.insert(rst, stageGroupCfg.ID)
    end
  end
  return rst
end

function CopyExtModel:GetLinkageActivityGroupList(withoutSorted)
  local now = TimeUtils.GetServerTime()
  local rst = {}
  for _, stageGroupTid in ipairs(self:GetLinkageActivityGroupListFromCfg()) do
    local stageGroupCfg = DT.StageGroup[stageGroupTid]
    if not stageGroupCfg.StageDisplayDate or now >= stageGroupCfg.StageDisplayDate then
      table.insert(rst, stageGroupCfg.ID)
    end
  end
  if not withoutSorted then
    table.sort(rst, function(aTid, bTid)
      local isLockedA = CopyDataUtils.IsStageGroupFeatureLocked(aTid) and 1 or 0
      local isLockedB = CopyDataUtils.IsStageGroupFeatureLocked(bTid) and 1 or 0
      if isLockedA == isLockedB then
        local configA = CopyDataUtils.GetStageGroupConfig(aTid)
        local configB = CopyDataUtils.GetStageGroupConfig(bTid)
        return configA.Sequence < configB.Sequence
      end
      return isLockedA < isLockedB
    end)
  end
  return rst
end

function CopyExtModel:GetLinkageActivityNormalGroupList(withoutSorted)
  local groupList = self:GetLinkageActivityGroupList(withoutSorted)
  local normalGroupList = {}
  for _, groupTid in ipairs(groupList) do
    local stageGroupCfg = DT.StageGroup[groupTid]
    if stageGroupCfg.Type == StageGroupType.LinkageActivityNormal then
      table.insert(normalGroupList, groupTid)
    end
  end
  return normalGroupList
end

function CopyExtModel:GetSpecialSubplotGroupListFromCfg()
  local rst = {}
  for _, stageGroupCfg in pairs(DT.StageGroup) do
    if self:CheckIsSpecialSubPlot(stageGroupCfg.Type) then
      table.insert(rst, stageGroupCfg.ID)
    end
  end
  return rst
end

function CopyExtModel:GetSpecialSubplotGroupList()
  local now = TimeUtils.GetServerTime()
  local rst = {}
  for _, stageGroupID in pairs(self:GetSpecialSubplotGroupListFromCfg()) do
    local stageGroupCfg = DT.StageGroup[stageGroupID]
    if not stageGroupCfg.StageDisplayDate or now >= stageGroupCfg.StageDisplayDate then
      table.insert(rst, stageGroupCfg.ID)
    end
  end
  table.sort(rst, function(aTid, bTid)
    local isLockedA = CopyDataUtils.IsStageGroupFeatureLocked(aTid) and 1 or 0
    local isLockedB = CopyDataUtils.IsStageGroupFeatureLocked(bTid) and 1 or 0
    if isLockedA == isLockedB then
      local configA = CopyDataUtils.GetStageGroupConfig(aTid)
      local configB = CopyDataUtils.GetStageGroupConfig(bTid)
      return configA.Sequence < configB.Sequence
    end
    return isLockedA < isLockedB
  end)
  return rst
end

local specialSubPlotGroup = {
  StageGroupType.SpecialSubplotNormal,
  StageGroupType.SpecialSubplotHard,
  StageGroupType.SpecialSubplotCrazy
}

function CopyExtModel:CheckIsSpecialSubPlot(stageGroupType)
  if not stageGroupType then
    return false
  end
  do return table.contains, specialSubPlotGroup end
  return table.contains, specialSubPlotGroup, stageGroupType
end

local linkageActivityGroup = {
  StageGroupType.LinkageActivityNormal,
  StageGroupType.LinkageActivityHard,
  StageGroupType.LinkageActivityCrazy
}

function CopyExtModel:CheckIsLinkageActivity(stageGroupType)
  if not stageGroupType then
    return false
  end
  do return table.contains, linkageActivityGroup end
  return table.contains, linkageActivityGroup, stageGroupType
end

function CopyExtModel:CalcOverflowConvertItems(rewardItemList)
  if not rewardItemList or table.next(rewardItemList) == nil then
    return {}
  end
  local convertResultList = {}
  for _, itemInfo in ipairs(rewardItemList) do
    local tid = itemInfo.tid
    local num = itemInfo.num
    if tid and num then
      local convertItems, overflowNum = self:CalcOverflowItem(tid, num)
      if convertItems then
        table.insert(convertResultList, {
          sourceItemTid = tid,
          convertItems = convertItems,
          overflowNum = overflowNum
        })
      end
    end
  end
  return convertResultList
end

function CopyExtModel:CalcOverflowItem(itemTid, num)
  local itemConfig = ItemDataUtils.GetItemConfig(itemTid)
  if itemConfig.Overflow then
    local ownItemNum = ItemDataUtils.GetItemNum(itemTid) or 0
    local overflowConfig = ItemDataUtils.GetItemOverflowConfig(itemConfig.Overflow)
    local total = overflowConfig.ItemNum
    if overflowConfig.ResonanceGroup then
      local _, totalNeedNum = ResonanceDataUtils.GetUpgradeGroupToMaxCost(overflowConfig.ResonanceGroup)
      total = totalNeedNum
    end
    local overflowNum = ownItemNum + num - total
    if overflowNum > 0 then
      local result = {}
      for convertItemTid, convertNumUnit in table.iteraDouble(overflowConfig.ConverseItem) do
        if convertItemTid and convertNumUnit then
          local convertItemNum = convertNumUnit * overflowNum
          table.insert(result, {tid = convertItemTid, num = convertItemNum})
        end
      end
      return result, total
    end
  end
end

function CopyExtModel:CalcOverflowList(rewardItemList)
  if not rewardItemList or table.next(rewardItemList) == nil then
    return {}
  end
  local overflowList = {}
  local overflow
  for _, itemInfo in pairs(rewardItemList) do
    overflow = itemInfo.overflow or {}
    if overflow.tid and overflow.num and overflow.num > 0 then
      local isFind = false
      for _, info in ipairs(overflowList) do
        if info.tid == overflow.tid and info.num == overflow.num then
          isFind = true
          break
        end
      end
      if not isFind then
        table.insert(overflowList, {
          tid = overflow.tid,
          num = overflow.num
        })
      end
    end
  end
  return overflowList
end

function CopyExtModel:IsShowUnlockCompensate(stageGroupTid)
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  Logger.Debug("[ac] IsShowUnlockCompensate 1 stageGroupTid=%s, unlockParams=%s, stageGroupConfig=%s", stageGroupTid, table.tostring(stageGroupConfig.UnlockCompensation), table.tostring(stageGroupConfig))
  if not stageGroupConfig or not stageGroupConfig.UnlockCompensation then
    return
  end
  local activityType = stageGroupConfig.UnlockCompensation[1]
  if not activityType then
    return
  end
  local isActivityOpen = ActivityManager.Instance:IsActivityOpenByType(activityType)
  Logger.Debug("[ac] IsShowUnlockCompensate 2 activityType=%s, isActivityOpen=%s", activityType, isActivityOpen)
  if not isActivityOpen then
    return
  end
  local needUnlockItem = CopyDataUtils.IsStageGroupNeedUnlockItem(stageGroupTid)
  local hasUsedUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(stageGroupTid)
  Logger.Debug("[ac] IsShowUnlockCompensate 3 needUnlockItem=%s, hasUsedUnlockItem=%s", needUnlockItem, hasUsedUnlockItem)
  if not needUnlockItem or not hasUsedUnlockItem then
    return false
  end
  local isGotCompensate = ActivityManager.Instance:IsGotCompensate(activityType)
  Logger.Debug("[ac] isGotCompensate 4 hasGotCompensate=%s", isGotCompensate)
  return not isGotCompensate
end

return CopyExtModel
