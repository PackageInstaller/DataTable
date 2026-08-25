local FeatureId = CommonDefine.FeatureId
local SeasonGameplayType = CommonDefine.SeasonGameplayType
local DivingGameplayType = SeasonGameplayType.ConsciousnessDiving
local CompGuideNotePermTrainingItemDailyChallenge, Super = NewViewComponent("CompGuideNotePermTrainingItemDailyChallenge")
CompGuideNotePermTrainingItemDailyChallenge.SortKey = "DailyChallenge"

function CompGuideNotePermTrainingItemDailyChallenge:ctor(gameObject, view)
  Super.ctor(self, gameObject, view)
  self._rankTitleReady = false
  self._refreshTimer = nil
  self._victorTv = nil
  self._victorComps = nil
  self._victorRewards = {}
  self._extraTv = nil
  self._extraComps = nil
  self._extraRewardItems = {}
  self.ui = view.ui
end

function CompGuideNotePermTrainingItemDailyChallenge:RegisterEvents()
  local btn = self.ui.Btn_Goto_DailyChallenge
  if btn then
    self:AddButtonClickListener(btn, function()
      self:_OnClickGoto()
    end)
  end
  if self.ui.Btn_Lock_DailyChallenge then
    self:AddButtonClickListener(self.ui.Btn_Lock_DailyChallenge, function()
      self:_OnClickLock()
    end)
  end
  self:RegisterNotify(NotifyId.OnRankDataChanged, self._OnRankDataChanged, self)
end

function CompGuideNotePermTrainingItemDailyChallenge:_OnRankDataChanged(rankType)
  if rankType ~= RankDefine.RankType.SeasonRoDailyChallenge then
    return
  end
  self._rankTitleReady = true
  self:Refresh()
end

function CompGuideNotePermTrainingItemDailyChallenge:_OnClickLock()
  local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(FeatureId.DailyChallenge, 0)
  if not string.isempty(tips) then
    Alert.ShowStr(tips)
  else
    Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
  end
end

function CompGuideNotePermTrainingItemDailyChallenge:_OnClickGoto()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(FeatureId.DailyChallenge, 0)
  if true ~= unlocked then
    local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(FeatureId.DailyChallenge, 0)
    if not string.isempty(tips) then
      Alert.ShowStr(tips)
    else
      Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
    end
    return
  end
  UIManager.Instance:Reopen(Urls.DailyChallengeView)
end

function CompGuideNotePermTrainingItemDailyChallenge:OnEnterComponent()
  self._rankTitleReady = false
  GuideNotePermTrainingRankUi.HideRankTitleSlots(self.view, self.ui.DivingTitle_DailyChallenge, self.ui.ScrollView_Rank_DailyChallenge, self.ui.Text_Rank_DailyChallenge)
  if self.ui.Text_C_Reward_DailyChallenge then
    self:SetActive(self.ui.Text_C_Reward_DailyChallenge, false)
  end
  if self.ui.ScrollView_Reward_DailyChallenge then
    self:SetActive(self.ui.ScrollView_Reward_DailyChallenge, false)
  end
  self:_RestartRefreshTimer()
  self:Refresh()
end

function CompGuideNotePermTrainingItemDailyChallenge:OnExitComponent()
  self:_ClearRefreshTimer()
  self:_TeardownVictorComps()
  self:_TeardownExtraComps()
  Super.OnExitComponent(self)
end

function CompGuideNotePermTrainingItemDailyChallenge:_RestartRefreshTimer()
  GuideNotePermTrainingRefreshTimer.Restart(self)
end

function CompGuideNotePermTrainingItemDailyChallenge:_ClearRefreshTimer()
  if self._refreshTimer then
    self:StopTimer(self._refreshTimer)
    self._refreshTimer = nil
  end
end

function CompGuideNotePermTrainingItemDailyChallenge:_TeardownVictorComps()
  if self._victorComps then
    for _, comp in pairs(self._victorComps) do
      if comp and comp.binder then
        comp.binder:teardown()
      end
    end
  end
  self._victorComps = nil
  self._victorTv = nil
end

function CompGuideNotePermTrainingItemDailyChallenge:_TeardownExtraComps()
  if self._extraComps then
    for _, comp in pairs(self._extraComps) do
      if comp and comp.binder then
        comp.binder:teardown()
      end
    end
  end
  self._extraComps = nil
  self._extraTv = nil
end

function CompGuideNotePermTrainingItemDailyChallenge:_RefreshRankDisplay(view, ui, seasonId)
  local rankType = RankDefine.RankType.SeasonRoDailyChallenge
  local gameplayType = SeasonGameplayType.ConsciousnessDiving
  local divingTitleNode = ui.DivingTitle_DailyChallenge
  local scrollView = ui.ScrollView_Rank_DailyChallenge
  local textRankNode = ui.Text_Rank_DailyChallenge
  local groupRankReward = ui.Group_RankReward_DailyChallenge
  if self._rankTitleReady ~= true then
    GuideNotePermTrainingRankUi.HideRankTitleSlots(view, divingTitleNode, scrollView, textRankNode)
    GuideNotePermTrainingRankUi.ApplyRankRewardVisibility(view, scrollView, groupRankReward, false)
    return false
  end
  local rewardRankIndex, playersNum = GuideNotePermTrainingRankUi.GetRewardRankDisplayParams(rankType, seasonId)
  local rankData = GuideNotePermTrainingRankUi.GetRankTierDisplayData({
    rewardRankIndex = rewardRankIndex,
    seasonId = seasonId,
    gameplayType = gameplayType,
    playersNum = playersNum,
    rankType = rankType,
    rankSubTid = seasonId
  })
  local hasData = rankData and true == rankData.hasData
  GuideNotePermTrainingRankUi.ApplyRankTitle(view, divingTitleNode, rankData)
  GuideNotePermTrainingRankUi.ApplyRankRewardVisibility(view, scrollView, groupRankReward, hasData)
  if not divingTitleNode then
    GuideNotePermTrainingRankUi.ApplyRankTextFallback(view, scrollView, textRankNode, rankData)
  end
  return hasData
end

function CompGuideNotePermTrainingItemDailyChallenge:Refresh()
  local v = self.view
  local ui = v.ui
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(FeatureId.DailyChallenge, 0)
  if ui.Group_Unlock_DailyChallenge then
    ui.Group_Unlock_DailyChallenge:SetActive(true == unlocked)
  end
  if ui.Group_Lock_DailyChallenge then
    ui.Group_Lock_DailyChallenge:SetActive(true ~= unlocked)
  end
  GuideNotePermTrainingUnlockTipsUi.ApplyToLockGroup(self, ui.Group_Lock_DailyChallenge, unlocked, FeatureId.DailyChallenge, 0)
  local dailyChallengeScore = 0
  if DailyChallengeController and DailyChallengeController.Instance and DailyChallengeController.Instance.GetWeekHighestScore then
    dailyChallengeScore = DailyChallengeController.Instance:GetWeekHighestScore() or 0
  end
  self:SetText(ui.Text_Score_DailyChallenge, tostring(dailyChallengeScore))
  local seasonIdDiving = 0
  if DailyChallengeModel and DailyChallengeModel.Instance and DailyChallengeModel.Instance.GetSeasonId then
    seasonIdDiving = DailyChallengeModel.Instance:GetSeasonId() or 0
  end
  if 0 == seasonIdDiving and SeasonRotationModel and SeasonRotationModel.Instance then
    seasonIdDiving = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessDiving) or 0
  end
  local seasonNameDiving = SeasonRotationCfgUtils.GetName(seasonIdDiving, SeasonGameplayType.ConsciousnessDiving)
  local divingTaskDesc = SeasonRotationCfgUtils.GetSeasonTaskDesc(seasonIdDiving, SeasonGameplayType.ConsciousnessDiving)
  if ui.Text_Season_DailyChallenge then
    self:SetText(ui.Text_Season_DailyChallenge, LT.Text(seasonNameDiving))
  end
  if ui.Text_WinCount_DailyChallenge then
    self:SetText(ui.Text_WinCount_DailyChallenge, LT.Text(divingTaskDesc))
  end
  local showRankRewardCaption = self:_RefreshRankDisplay(v, ui, seasonIdDiving)
  if ui.Text_C_Reward_DailyChallenge then
    self:SetActive(ui.Text_C_Reward_DailyChallenge, showRankRewardCaption)
  end
  self:_RefreshVictorRewards()
  self:_RefreshDailyExtraRewards()
end

function CompGuideNotePermTrainingItemDailyChallenge:RefreshTime()
  local ui = self.view.ui
  local seasonIdDiving = 0
  if SeasonRotationModel and SeasonRotationModel.Instance then
    seasonIdDiving = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessDiving) or 0
  end
  if 0 == seasonIdDiving and DailyChallengeModel and DailyChallengeModel.Instance and DailyChallengeModel.Instance.GetSeasonId then
    seasonIdDiving = DailyChallengeModel.Instance:GetSeasonId() or 0
  end
  if ui.Text_Time_DailyChallenge then
    self:SetText(ui.Text_Time_DailyChallenge, SeasonRotationCfgUtils.GetLeftTimeTextColored(seasonIdDiving, SeasonGameplayType.ConsciousnessDiving))
  end
  if ui.Icon_Time_DailyChallenge then
    self:SetImage(ui.Icon_Time_DailyChallenge, SeasonRotationCfgUtils.GetLeftTimeHourglassIcon(seasonIdDiving, SeasonGameplayType.ConsciousnessDiving))
  end
end

function CompGuideNotePermTrainingItemDailyChallenge:GetSortEntry()
  local ui = self.view.ui
  local groupUnlock = ui.Group_Unlock_DailyChallenge
  local root = groupUnlock and groupUnlock.transform and groupUnlock.transform.parent or nil
  if not root then
    return nil
  end
  return {
    tf = root,
    sortKey = CompGuideNotePermTrainingItemDailyChallenge.SortKey,
    left = GuideNotePermTrainingSortUtil.GetSeasonLeftTime(SeasonGameplayType.ConsciousnessDiving)
  }
end

function CompGuideNotePermTrainingItemDailyChallenge:_DivingSeasonId()
  local seasonTid = 0
  if DailyChallengeModel and DailyChallengeModel.Instance and DailyChallengeModel.Instance.GetSeasonId then
    seasonTid = DailyChallengeModel.Instance:GetSeasonId() or 0
  end
  if (not seasonTid or 0 == seasonTid) and SeasonRotationModel and SeasonRotationModel.Instance and SeasonRotationModel.Instance.GetSeasonId then
    seasonTid = SeasonRotationModel.Instance:GetSeasonId(DivingGameplayType) or 0
  end
  return seasonTid
end

function CompGuideNotePermTrainingItemDailyChallenge:_DailyHasRankTierDisplayData(seasonIdDiving, divingRewardRankIndex, divingPlayersNum, rankTypeDaily)
  if not (divingRewardRankIndex and not (divingRewardRankIndex <= 0) and seasonIdDiving) or seasonIdDiving <= 0 then
    return false
  end
  if SeasonRotationModel and SeasonRotationModel.Instance then
    local row = SeasonRotationModel.Instance:GetSeasonRankRewardRowByRewardIndex(seasonIdDiving, DivingGameplayType, divingRewardRankIndex, divingPlayersNum)
    if row and row.Name then
      return true
    end
  end
  if rankTypeDaily then
    local rankCfg = RankModel.Instance:GetRankCfgByRewardIndex(rankTypeDaily, seasonIdDiving, divingRewardRankIndex)
    if rankCfg and rankCfg.Name then
      return true
    end
  end
  return false
end

function CompGuideNotePermTrainingItemDailyChallenge:_BuildDailyRankPrizeRewardList(seasonIdDiving, rewardRankIndex, playersNum, rankTypeDaily)
  local raw = {}
  if not (rewardRankIndex and not (rewardRankIndex <= 0) and seasonIdDiving) or seasonIdDiving <= 0 then
    return {}
  end
  if SeasonRotationModel and SeasonRotationModel.Instance then
    local row = SeasonRotationModel.Instance:GetSeasonRankRewardRowByRewardIndex(seasonIdDiving, DivingGameplayType, rewardRankIndex, playersNum)
    if row and row.Name then
      raw = RankingBoardDataUtils.GetSeasonRankRowRewards(row)
    end
  end
  if (not raw or 0 == #raw) and rankTypeDaily then
    local rankCfg = RankModel.Instance:GetRankCfgByRewardIndex(rankTypeDaily, seasonIdDiving, rewardRankIndex)
    if rankCfg and rankCfg.Name then
      local fakeRow = {
        NewRankReward = {}
      }
      for tid, count in pairs(rankCfg.CoinReward or {}) do
        fakeRow.NewRankReward[tid] = count
      end
      for tid, count in pairs(rankCfg.GoldReward or {}) do
        fakeRow.NewRankReward[tid] = count
      end
      raw = RankingBoardDataUtils.GetSeasonRankRowRewards(fakeRow)
    end
  end
  do return GuideNotePermTrainingRewardMerge.MergeRewardsByTid end
  return GuideNotePermTrainingRewardMerge.MergeRewardsByTid, raw or {}, RankingBoardDataUtils.GetSeasonRankRowRewards(fakeRow), fakeRow, pairs(rankCfg.GoldReward or {})
end

function CompGuideNotePermTrainingItemDailyChallenge:_RefreshVictorRewards()
  local v = self.view
  local ui = v.ui
  self._victorRewards = {}
  local seasonTid = self:_DivingSeasonId()
  if seasonTid and 0 ~= seasonTid and SeasonRotationCfgUtils and SeasonRotationCfgUtils.GetSeasonRewardList then
    self._victorRewards = SeasonRotationCfgUtils.GetSeasonRewardList(seasonTid, DivingGameplayType) or {}
  end
  if ui.ScrollView_Victor_DailyChallenge then
    self:SetActive(ui.ScrollView_Victor_DailyChallenge, #(self._victorRewards or {}) > 0)
  end
  self:_EnsureVictorTableView()
  if self._victorTv then
    self._victorTv:ReloadData()
  end
end

function CompGuideNotePermTrainingItemDailyChallenge:_EnsureVictorTableView()
  local v = self.view
  local ui = v.ui
  if not (not self._victorTv and ui and ui.ScrollView_Victor_DailyChallenge) or not ui.UI_Common_Item_WuPin_Type2 then
    return
  end
  if not ui.UI_Common_Item_WuPin_Type2.transform then
    return
  end
  local sizeDelta = ui.UI_Common_Item_WuPin_Type2.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local templateGo = ui.UI_Common_Item_WuPin_Type2.gameObject or ui.UI_Common_Item_WuPin_Type2
  if templateGo and templateGo.SetActive then
    templateGo:SetActive(false)
  end
  self._victorComps = {}
  local baseGameObj = ui.UI_Common_Item_WuPin_Type2
  local itemSelf = self
  self._victorTv = self:CreateTableview(ui.ScrollView_Victor_DailyChallenge, function()
    return #(itemSelf._victorRewards or {})
  end, function(tblView, idx)
    local cell = tblView:DequeueCell()
    cell = cell or tblView:AddChild(baseGameObj)
    local gameObj = cell and cell.gameObject
    if gameObj then
      if itemSelf._victorComps[gameObj] then
        itemSelf._victorComps[gameObj].binder:teardown()
        itemSelf._victorComps[gameObj] = nil
      end
      local reward = itemSelf._victorRewards and itemSelf._victorRewards[idx] or nil
      if reward and reward.tid then
        local divingType = CommonDefine.SeasonGameplayType.ConsciousnessDiving
        local divingSeasonId = itemSelf:_DivingSeasonId()
        local itemData = GuideNotePermTrainingRewardItemHelper.BuildSeasonTaskRewardItemData(v, gameObj, reward, divingSeasonId, divingType, function()
          itemSelf:Refresh()
        end)
        itemSelf._victorComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
      end
    end
    if cell and cell.gameObject then
      cell.gameObject:SetActive(true)
    end
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemSelf._victorComps = nil
  end)
end

function CompGuideNotePermTrainingItemDailyChallenge:_RefreshDailyExtraRewards()
  local ui = self.view.ui
  self._extraRewardItems = {}
  local seasonIdDiving = self:_DivingSeasonId()
  if not seasonIdDiving or 0 == seasonIdDiving then
    if ui.ScrollView_Reward_DailyChallenge then
      self:SetActive(ui.ScrollView_Reward_DailyChallenge, false)
    end
    return
  end
  local rankTypeDaily = RankDefine.RankType.SeasonRoDailyChallenge
  local divingRewardRankIndex, divingPlayersNum = GuideNotePermTrainingRankUi.GetRewardRankDisplayParams(rankTypeDaily, seasonIdDiving)
  local showList = false
  if self._rankTitleReady == true and self:_DailyHasRankTierDisplayData(seasonIdDiving, divingRewardRankIndex, divingPlayersNum, rankTypeDaily) then
    self._extraRewardItems = self:_BuildDailyRankPrizeRewardList(seasonIdDiving, divingRewardRankIndex, divingPlayersNum, rankTypeDaily)
    showList = #(self._extraRewardItems or {}) > 0
  end
  if ui.ScrollView_Reward_DailyChallenge then
    self:SetActive(ui.ScrollView_Reward_DailyChallenge, showList)
  end
  self:_EnsureExtraTableView()
  if self._extraTv then
    self._extraTv:ReloadData()
  end
end

function CompGuideNotePermTrainingItemDailyChallenge:_EnsureExtraTableView()
  local v = self.view
  local ui = v.ui
  if not (not self._extraTv and ui and ui.ScrollView_Reward_DailyChallenge) or not ui.UI_Common_Item_WuPin_Type2 then
    return
  end
  if not ui.UI_Common_Item_WuPin_Type2.transform then
    return
  end
  local sizeDelta = ui.UI_Common_Item_WuPin_Type2.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local templateGo = ui.UI_Common_Item_WuPin_Type2.gameObject or ui.UI_Common_Item_WuPin_Type2
  if templateGo and templateGo.SetActive then
    templateGo:SetActive(false)
  end
  self._extraComps = {}
  local baseGameObj = ui.UI_Common_Item_WuPin_Type2
  local itemSelf = self
  self._extraTv = self:CreateTableview(ui.ScrollView_Reward_DailyChallenge, function()
    return #(itemSelf._extraRewardItems or {})
  end, function(tblView, idx)
    local cell = tblView:DequeueCell()
    cell = cell or tblView:AddChild(baseGameObj)
    local gameObj = cell and cell.gameObject
    if gameObj then
      if itemSelf._extraComps[gameObj] then
        itemSelf._extraComps[gameObj].binder:teardown()
        itemSelf._extraComps[gameObj] = nil
      end
      local reward = itemSelf._extraRewardItems and itemSelf._extraRewardItems[idx] or nil
      if reward and reward.tid then
        local itemData = GuideNotePermTrainingRewardItemHelper.BuildAbyssRewardItemData(reward)
        itemSelf._extraComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
      end
    end
    if cell and cell.gameObject then
      cell.gameObject:SetActive(true)
    end
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemSelf._extraComps = nil
  end)
end

return CompGuideNotePermTrainingItemDailyChallenge
