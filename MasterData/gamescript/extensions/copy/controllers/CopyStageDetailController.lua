local CopyStageDetailController, Super = NewClass("CopyStageDetailController", BaseController)

function CopyStageDetailController:OnInit()
  self:OnReset()
end

function CopyStageDetailController:OnReset()
end

function CopyStageDetailController:ReqUnlockStageByItem(stageId, forceUnlock)
  if not forceUnlock and self:IsEnoughUnlockItem(stageId) then
    return
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("StageRequest", "UnlockStageByItem", function()
    Alert.Show(10755)
  end, function()
  end, stageId)
end

function CopyStageDetailController:GetAchiveCount(stageId)
  local totalCount = 0
  local stageCfg = CopyStageDetailModel.Instance:GetStageCfg(stageId)
  totalCount = #(stageCfg.LevelAchieve or {})
  local count = 0
  local stageData = CopyStageDetailModel.Instance:GetStageData(stageId)
  for _, isFinish in pairs(stageData.achivement or {}) do
    if isFinish >= 1 then
      count = count + 1
    end
  end
  return totalCount, count
end

function CopyStageDetailController:GainStageGroupAchievementRw(stageGroupTid, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "GainStageGroupAchievementRw", function(data)
    Logger.Proto("CopyStageDetailController:GainStageGroupAchievementRw:%s", table.tostring(data))
    EventMgr.Instance.CloseReqMask:Dispatch()
    self:MarkAchievementGot(stageGroupTid)
    if callback then
      callback()
    end
  end, nil, stageGroupTid)
end

function CopyStageDetailController:MarkAchievementGot(stageGroupTid)
  local groupData = MainCopyData.allPlots[stageGroupTid]
  if groupData then
    for _, stageData in ipairs(groupData.stageList) do
      local stageCfg = DT.Stage[stageData.stageID] or {}
      for _, taskId in pairs(stageCfg.LevelAchieve or {}) do
        local state = stageData.achivement[taskId]
        if state == CommonDefine.MainCopyAchieveState.IsFinish then
          stageData.achivement[taskId] = CommonDefine.MainCopyAchieveState.IsGot
        end
      end
    end
  end
end

function CopyStageDetailController:GetHideNode(stageId)
  if not stageId then
    return 0, 0
  end
  local hideNodeCount = #MainCopyDataUtils.GetHideAwardNodeList(stageId) or 0
  local stageData = CopyStageDetailModel.Instance:GetStageData(stageId)
  local curHideNodeCount = stageData and 1 == stageData.hiddenAward and 1 or 0
  return hideNodeCount, curHideNodeCount
end

function CopyStageDetailController:IsShowReward(stageId)
  if not stageId then
    return
  end
  local isStoryReviewMode = StoryReviewModel.Instance:IsReviewingStory()
  if isStoryReviewMode then
    return false
  end
  local hideNodeCount, curHideNodeCount = self:GetHideNode(stageId)
  if curHideNodeCount <= 0 then
    return false
  end
  return hideNodeCount > 0
end

function CopyStageDetailController:IsStageValid(stageIndex)
  local stageGroupList = CopyStageDetailModel.Instance:GetStageGroupList()
  if not (stageIndex and stageGroupList) or #stageGroupList < 0 then
    return false
  end
  local stageData = stageGroupList[stageIndex]
  if not stageData or table.next(stageData) == nil then
    return false
  end
  if not CopyDataUtils.CheckStageIsUnlocked(stageData.stageID) then
    return false
  end
  return stageData.unlocked and (stageData.openTime or 0) < TimeUtils.GetServerTime()
end

function CopyStageDetailController:IsMonsterValid(monsterTid)
  if type(monsterTid) == "number" then
    return monsterTid and monsterTid > 0
  end
  if type(monsterTid) == "string" then
    return monsterTid and "" ~= monsterTid
  end
end

function CopyStageDetailController:GetCostInfo(stageId)
  local costItemTid, oriCostCount = self:GetOriCostInfo(stageId)
  if CopyStageDetailModel.Instance:IsSubplotInActivity(self.stageGroupId) then
    return costItemTid, 0, oriCostCount
  end
  return costItemTid, oriCostCount, oriCostCount
end

function CopyStageDetailController:GetOriCostInfo(stageId)
  if not self.withoutOpenItem and not self:HasUseUnlockItem(stageId) then
    do return CopyStageDetailModel.Instance.GetOpenItem, CopyStageDetailModel.Instance end
    return CopyStageDetailModel.Instance.GetOpenItem, CopyStageDetailModel.Instance, stageId
  end
  if not CopyStageDetailModel.Instance:IsEnergyEnough(stageId) then
    return CommonDefine.CurrencyType.Energy, 0
  end
  local stageCfg = CopyStageDetailModel.Instance:GetStageCfg(stageId)
  return CommonDefine.CurrencyType.Energy, stageCfg.Cost
end

function CopyStageDetailController:HasUseUnlockItem(stageId)
  if not stageId then
    return true
  end
  local stageCfg = CopyStageDetailModel.Instance:GetStageCfg(stageId)
  local stageData = CopyStageDetailModel.Instance:GetStageData(stageId)
  if not stageCfg or not stageData then
    return true
  end
  if not stageCfg.OpenItem then
    return true
  end
  return stageData.unlockItem ~= false
end

function CopyStageDetailController:IsEnoughUnlockItem(stageId)
  local stageCfg = CopyStageDetailModel.Instance:GetStageCfg(stageId)
  if not stageCfg then
    return false
  end
  if not stageCfg.OpenItem then
    return true
  end
  local openItem = stageCfg.OpenItem
  for tid, num in pairs(openItem) do
    if num and num > 0 then
      return num <= ItemDataUtils.GetItemNum(tid)
    end
  end
  return false
end

function CopyStageDetailController:GetRewardList(stageId, starLevel, isPlot)
  if self.isStoryReviewMode then
    return {}
  end
  local difficultyId = MainCopyDataUtils.GetDymicDifficultyId(stageId) or stageId
  local oriCfg = CopyStageDetailModel.Instance:GetStageCfg(stageId)
  local cfg = CopyStageDetailModel.Instance:GetStageCfg(difficultyId)
  local stageData = MainCopyDataUtils.GetStageData(stageId)
  local rewardList = {}
  local firstTimeReward = cfg.FirstTimeReward or oriCfg.FirstTimeReward
  for tid, num, index in table.iteraDouble(firstTimeReward or {}) do
    table.insert(rewardList, {
      tid = tid,
      num = num,
      type = CommonDefine.ItemAwardType.First,
      isGot = stageData.firstRewardDraw,
      index = index
    })
  end
  local perfectReward = cfg.PerfectReward or oriCfg.PerfectReward
  for tid, num, index in table.iteraDouble(perfectReward or {}) do
    table.insert(rewardList, {
      tid = tid,
      num = num,
      type = CommonDefine.ItemAwardType.First3Star,
      isGot = starLevel >= 3,
      index = index
    })
  end
  local normalReward = cfg.NormalReward or oriCfg.NormalReward
  local firstTimeNormalRewardMultiple = cfg.FirstTimeNormalRewardMultiple or oriCfg.FirstTimeNormalRewardMultiple
  for tid, num, index in table.iteraDouble(normalReward or {}) do
    local normalType = CommonDefine.ItemAwardType.Normal
    local isFirst = not stageData.firstRewardDraw
    local isGot = false
    if isFirst and (firstTimeNormalRewardMultiple or 0) > 1 then
      isGot = stageData.firstRewardDraw
      normalType = CommonDefine.ItemAwardType.FirstMult
    end
    table.insert(rewardList, {
      tid = tid,
      num = num,
      index = index,
      type = normalType,
      isFirst = isFirst,
      isGot = isGot,
      multipleNum = firstTimeNormalRewardMultiple
    })
  end
  rewardList = ItemDataUtils.KickoutAwakerFavorItem(rewardList)
  table.sort(rewardList, function(a, b)
    local sortWeightA = self:GetItemSortWeight(a)
    local sortWeightB = self:GetItemSortWeight(b)
    if sortWeightA == sortWeightB then
      local itemA = DT.Item[a.tid]
      local itemB = DT.Item[b.tid]
      return itemA.BaseSortID < itemB.BaseSortID
    end
    return sortWeightA > sortWeightB
  end)
  return rewardList
end

function CopyStageDetailController:GetItemSortWeight(item)
  local weight = 9999
  local gap = 100
  local isGot = item.isGot
  local type = item.type
  if not isGot and type == CommonDefine.ItemAwardType.First3Star then
    return weight - item.index
  end
  weight = weight - gap
  if not isGot and type == CommonDefine.ItemAwardType.First then
    return weight - item.index
  end
  weight = weight - gap
  if not isGot and type == CommonDefine.ItemAwardType.FirstMult then
    return weight - item.index
  end
  weight = weight - gap
  if type == CommonDefine.ItemAwardType.Normal then
    return weight - item.index
  end
  weight = weight - gap
  if type == CommonDefine.ItemAwardType.First3Star then
    return weight - item.index
  end
  weight = weight - gap
  if type == CommonDefine.ItemAwardType.First then
    return weight - item.index
  end
  return weight
end

return CopyStageDetailController
