local FeatureId = CommonDefine.FeatureId
local SeasonGameplayType = CommonDefine.SeasonGameplayType
local CompGuideNotePermTrainingItemRotationMode, Super = NewViewComponent("CompGuideNotePermTrainingItemRotationMode")
CompGuideNotePermTrainingItemRotationMode.SortKey = "RotationMode"

function CompGuideNotePermTrainingItemRotationMode:ctor(gameObject, view)
  Super.ctor(self, gameObject, view)
  self._rankTitleReady = false
  self._refreshTimer = nil
  self._rankRewardTv = nil
  self._rankRewardComps = nil
  self._rankRewardItems = {}
  self._victorTv = nil
  self._victorComps = nil
  self._victorRewards = {}
  self.ui = view.ui
end

function CompGuideNotePermTrainingItemRotationMode:RegisterEvents()
  local btn = self.ui.Btn_Goto_RotationMode
  if btn then
    self:AddButtonClickListener(btn, function()
      self:_OnClickGoto()
    end)
  end
  if self.ui.Btn_Lock_RotationMode then
    self:AddButtonClickListener(self.ui.Btn_Lock_RotationMode, function()
      self:_OnClickLock()
    end)
  end
  self:RegisterNotify(NotifyId.OnRankDataChanged, self._OnRankDataChanged, self)
end

function CompGuideNotePermTrainingItemRotationMode:_OnRankDataChanged(rankType)
  if rankType ~= RankDefine.RankType.SeasonRoPvpDraft then
    return
  end
  self._rankTitleReady = true
  self:Refresh()
end

function CompGuideNotePermTrainingItemRotationMode:_OnClickLock()
  local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(FeatureId.PVP, 0)
  if not string.isempty(tips) then
    Alert.ShowStr(tips)
  else
    Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
  end
end

function CompGuideNotePermTrainingItemRotationMode:_OnClickGoto()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(FeatureId.PVP, 0)
  if true ~= unlocked then
    local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(FeatureId.PVP, 0)
    if not string.isempty(tips) then
      Alert.ShowStr(tips)
    else
      Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
    end
    return
  end
  UIManager.Instance:Reopen(Urls.MainPanelPVP)
end

function CompGuideNotePermTrainingItemRotationMode:OnEnterComponent()
  self._rankTitleReady = false
  GuideNotePermTrainingRankUi.HideRankTitleSlots(self.view, self.ui.DivingTitle_RotationMode, self.ui.ScrollView_Rank_RotationMode, self.ui.Text_Rank_RotationMode)
  if self.ui.Text_C_Reward_RotationMode then
    self:SetActive(self.ui.Text_C_Reward_RotationMode, false)
  end
  self:_RestartRefreshTimer()
  self:Refresh()
end

function CompGuideNotePermTrainingItemRotationMode:OnExitComponent()
  self:_ClearRefreshTimer()
  self:_TeardownRankRewardComps()
  self:_TeardownVictorComps()
  Super.OnExitComponent(self)
end

function CompGuideNotePermTrainingItemRotationMode:_RestartRefreshTimer()
  GuideNotePermTrainingRefreshTimer.Restart(self)
end

function CompGuideNotePermTrainingItemRotationMode:_ClearRefreshTimer()
  if self._refreshTimer then
    self:StopTimer(self._refreshTimer)
    self._refreshTimer = nil
  end
end

function CompGuideNotePermTrainingItemRotationMode:_TeardownRankRewardComps()
  if self._rankRewardComps then
    for _, comp in pairs(self._rankRewardComps) do
      if comp and comp.binder then
        comp.binder:teardown()
      end
    end
  end
  self._rankRewardComps = nil
  self._rankRewardTv = nil
end

function CompGuideNotePermTrainingItemRotationMode:_TeardownVictorComps()
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

function CompGuideNotePermTrainingItemRotationMode:_RefreshRankDisplay(view, ui, seasonId)
  local rankType = RankDefine.RankType.SeasonRoPvpDraft
  local gameplayType = SeasonGameplayType.PvpDraft
  local divingTitleNode = ui.DivingTitle_RotationMode
  local scrollView = ui.ScrollView_Rank_RotationMode
  local textRankNode = ui.Text_Rank_RotationMode
  local groupRankReward = ui.Group_RankReward_RotationMode
  if self._rankTitleReady ~= true then
    GuideNotePermTrainingRankUi.HideRankTitleSlots(view, divingTitleNode, scrollView, textRankNode)
    GuideNotePermTrainingRankUi.ApplyRankRewardVisibility(view, scrollView, groupRankReward, false)
    self:_RefreshRankRewards(ui, seasonId, gameplayType, rankType, false, 0, 0)
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
  self:_RefreshRankRewards(ui, seasonId, gameplayType, rankType, hasData, rewardRankIndex, playersNum)
  return hasData
end

function CompGuideNotePermTrainingItemRotationMode:_RefreshRankRewards(ui, seasonId, gameplayType, rankType, hasData, rewardRankIndex, playersNum)
  self._rankRewardItems = {}
  if hasData and rewardRankIndex and rewardRankIndex > 0 then
    self._rankRewardItems = GuideNotePermTrainingRankUi.GetCurrentRankPrizeRewards(seasonId, gameplayType, rankType, rewardRankIndex, playersNum)
  end
  local showList = #(self._rankRewardItems or {}) > 0
  if ui.ScrollView_Rank_RotationMode then
    self:SetActive(ui.ScrollView_Rank_RotationMode, showList)
  end
  self:_EnsureRankRewardTableView()
  if self._rankRewardTv then
    self._rankRewardTv:ReloadData()
  end
end

function CompGuideNotePermTrainingItemRotationMode:_EnsureRankRewardTableView()
  if not (not self._rankRewardTv and self.ui and self.ui.ScrollView_Rank_RotationMode) or not self.ui.UI_Common_Item_WuPin_Type2 then
    return
  end
  if not self.ui.UI_Common_Item_WuPin_Type2.transform then
    return
  end
  local sizeDelta = self.ui.UI_Common_Item_WuPin_Type2.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local templateGo = self.ui.UI_Common_Item_WuPin_Type2.gameObject or self.ui.UI_Common_Item_WuPin_Type2
  if templateGo and templateGo.SetActive then
    templateGo:SetActive(false)
  end
  self._rankRewardComps = {}
  local baseGameObj = self.ui.UI_Common_Item_WuPin_Type2
  local itemSelf = self
  self._rankRewardTv = self:CreateTableview(self.ui.ScrollView_Rank_RotationMode, function()
    return #(itemSelf._rankRewardItems or {})
  end, function(tblView, idx)
    local cell = tblView:DequeueCell()
    cell = cell or tblView:AddChild(baseGameObj)
    local gameObj = cell and cell.gameObject
    if gameObj then
      if itemSelf._rankRewardComps[gameObj] then
        itemSelf._rankRewardComps[gameObj].binder:teardown()
        itemSelf._rankRewardComps[gameObj] = nil
      end
      local reward = itemSelf._rankRewardItems and itemSelf._rankRewardItems[idx] or nil
      if reward and reward.tid then
        local itemData = GuideNotePermTrainingRewardItemHelper.BuildAbyssRewardItemData(reward)
        itemSelf._rankRewardComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
      end
    end
    if cell and cell.gameObject then
      cell.gameObject:SetActive(true)
    end
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemSelf._rankRewardComps = nil
  end)
end

function CompGuideNotePermTrainingItemRotationMode:Refresh()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(FeatureId.PVP, 0)
  if self.ui.Group_Unlock_RotationMode then
    self.ui.Group_Unlock_RotationMode:SetActive(true == unlocked)
  end
  if self.ui.Group_Lock_RotationMode then
    self.ui.Group_Lock_RotationMode:SetActive(true ~= unlocked)
  end
  GuideNotePermTrainingUnlockTipsUi.ApplyToLockGroup(self, self.ui.Group_Lock_RotationMode, unlocked, FeatureId.PVP, 0)
  local draftSeasonData = {}
  if SeasonRotationModel and SeasonRotationModel.Instance then
    draftSeasonData = SeasonRotationModel.Instance:GetPvpDraftSeasonData() or {}
  end
  self:SetText(self.ui.Text_Score_RotationMode, tostring(draftSeasonData.score or 0))
  local draftSeasonId = 0
  if SeasonRotationModel and SeasonRotationModel.Instance then
    draftSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpDraft) or 0
  end
  local draftTaskDesc = SeasonRotationCfgUtils.GetSeasonTaskDesc(draftSeasonId, SeasonGameplayType.PvpDraft)
  self:SetText(self.ui.Text_WinCount_RotationMode, LT.Text(draftTaskDesc))
  local showRankRewardCaption = self:_RefreshRankDisplay(self.view, self.ui, draftSeasonId)
  if self.ui.Text_C_Reward_RotationMode then
    self:SetActive(self.ui.Text_C_Reward_RotationMode, showRankRewardCaption)
  end
  self:_RefreshVictorRewards()
end

function CompGuideNotePermTrainingItemRotationMode:RefreshTime()
  local draftSeasonId = 0
  if SeasonRotationModel and SeasonRotationModel.Instance then
    draftSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpDraft) or 0
  end
  self:SetText(self.ui.Text_Time_RotationMode, SeasonRotationCfgUtils.GetLeftTimeTextColored(draftSeasonId, SeasonGameplayType.PvpDraft))
  self:SetImage(self.ui.Icon_Time_RotationMode, SeasonRotationCfgUtils.GetLeftTimeHourglassIcon(draftSeasonId, SeasonGameplayType.PvpDraft))
end

function CompGuideNotePermTrainingItemRotationMode:GetSortEntry()
  local groupUnlock = self.ui.Group_Unlock_RotationMode
  local root = groupUnlock and groupUnlock.transform and groupUnlock.transform.parent or nil
  if not root then
    return nil
  end
  return {
    tf = root,
    sortKey = CompGuideNotePermTrainingItemRotationMode.SortKey,
    left = GuideNotePermTrainingSortUtil.GetSeasonLeftTime(SeasonGameplayType.PvpDraft)
  }
end

function CompGuideNotePermTrainingItemRotationMode:_RefreshVictorRewards()
  local draftSeasonId = 0
  if SeasonRotationModel and SeasonRotationModel.Instance then
    draftSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpDraft) or 0
  end
  self._victorRewards = {}
  if SeasonRotationCfgUtils then
    self._victorRewards = SeasonRotationCfgUtils.GetSeasonRewardList(draftSeasonId, SeasonGameplayType.PvpDraft) or {}
  end
  if self.ui.ScrollView_Victor_RotationMode then
    self:SetActive(self.ui.ScrollView_Victor_RotationMode, #(self._victorRewards or {}) > 0)
  end
  self:_EnsureVictorTableView()
  if self._victorTv then
    self._victorTv:ReloadData()
  end
end

function CompGuideNotePermTrainingItemRotationMode:_EnsureVictorTableView()
  if not (not self._victorTv and self.ui and self.ui.UI_Common_Item_WuPin_Type2) or not self.ui.ScrollView_Victor_RotationMode then
    return
  end
  if not self.ui.UI_Common_Item_WuPin_Type2.transform then
    return
  end
  local sizeDelta = self.ui.UI_Common_Item_WuPin_Type2.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  self._victorComps = {}
  local templateGo = self.ui.UI_Common_Item_WuPin_Type2.gameObject or self.ui.UI_Common_Item_WuPin_Type2
  if templateGo and templateGo.SetActive then
    templateGo:SetActive(false)
  end
  local itemSelf = self
  self._victorTv = self:CreateTableview(self.ui.ScrollView_Victor_RotationMode, function()
    return #(itemSelf._victorRewards or {})
  end, function(tblView, idx)
    local cell = tblView:DequeueCell()
    cell = cell or tblView:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
    if cell and cell.gameObject then
      cell.gameObject:SetActive(true)
    end
    if itemSelf._victorComps and cell and cell.gameObject then
      local gameObj = cell.gameObject
      if itemSelf._victorComps[gameObj] then
        itemSelf._victorComps[gameObj].binder:teardown()
        itemSelf._victorComps[gameObj] = nil
      end
      local reward = itemSelf._victorRewards and itemSelf._victorRewards[idx] or nil
      if reward and reward.tid then
        local seasonId = SeasonRotationModel and SeasonRotationModel.Instance and SeasonRotationModel.Instance:GetSeasonId(CommonDefine.SeasonGameplayType.PvpDraft) or 0
        local itemData = GuideNotePermTrainingRewardItemHelper.BuildSeasonTaskRewardItemData(self.view, gameObj, reward, seasonId, CommonDefine.SeasonGameplayType.PvpDraft, function()
          itemSelf:Refresh()
        end)
        itemSelf._victorComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
      end
    end
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemSelf._victorComps = nil
  end)
end

return CompGuideNotePermTrainingItemRotationMode
