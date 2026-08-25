local FeatureId = CommonDefine.FeatureId
local SeasonGameplayType = CommonDefine.SeasonGameplayType
local CompGuideNotePermTrainingItemPvp, Super = NewViewComponent("CompGuideNotePermTrainingItemPvp")
CompGuideNotePermTrainingItemPvp.SortKey = "Pvp"

function CompGuideNotePermTrainingItemPvp:ctor(gameObject, view)
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

function CompGuideNotePermTrainingItemPvp:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Goto_Pvp, function()
    self:_OnClickGoto()
  end)
  self:AddButtonClickListener(self.ui.Btn_Lock_Pvp, function()
    self:_OnClickLock()
  end)
  self:RegisterNotify(NotifyId.OnRankDataChanged, self._OnRankDataChanged, self)
end

function CompGuideNotePermTrainingItemPvp:_OnRankDataChanged(rankType)
  if rankType ~= RankDefine.RankType.SeasonRoPvpPrebuilt then
    return
  end
  self._rankTitleReady = true
  self:Refresh()
end

function CompGuideNotePermTrainingItemPvp:_OnClickLock()
  local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(FeatureId.PVP, 0)
  if not string.isempty(tips) then
    Alert.ShowStr(tips)
  else
    Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
  end
end

function CompGuideNotePermTrainingItemPvp:_OnClickGoto()
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

function CompGuideNotePermTrainingItemPvp:OnEnterComponent()
  self._rankTitleReady = false
  GuideNotePermTrainingRankUi.HideRankTitleSlots(self.view, self.ui.DivingTitle_Pvp, self.ui.ScrollView_Rank_Pvp, self.ui.Text_Rank_Pvp)
  if self.ui.Text_C_Reward_Pvp then
    self:SetActive(self.ui.Text_C_Reward_Pvp, false)
  end
  self:_RestartRefreshTimer()
  self:Refresh()
end

function CompGuideNotePermTrainingItemPvp:OnExitComponent()
  self:_ClearRefreshTimer()
  self:_TeardownRankRewardComps()
  self:_TeardownVictorComps()
  Super.OnExitComponent(self)
end

function CompGuideNotePermTrainingItemPvp:_RestartRefreshTimer()
  GuideNotePermTrainingRefreshTimer.Restart(self)
end

function CompGuideNotePermTrainingItemPvp:_ClearRefreshTimer()
  if self._refreshTimer then
    self:StopTimer(self._refreshTimer)
    self._refreshTimer = nil
  end
end

function CompGuideNotePermTrainingItemPvp:_TeardownVictorComps()
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

function CompGuideNotePermTrainingItemPvp:_TeardownRankRewardComps()
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

function CompGuideNotePermTrainingItemPvp:_RefreshRankDisplay(seasonId)
  local rankType = RankDefine.RankType.SeasonRoPvpPrebuilt
  local gameplayType = SeasonGameplayType.PvpPreBuilt
  local divingTitleNode = self.ui.DivingTitle_Pvp
  local scrollView = self.ui.ScrollView_Rank_Pvp
  local textRankNode = self.ui.Text_Rank_Pvp
  local groupRankReward = self.ui.Group_RankReward_Pvp
  if self._rankTitleReady ~= true then
    GuideNotePermTrainingRankUi.HideRankTitleSlots(self.view, divingTitleNode, scrollView, textRankNode)
    GuideNotePermTrainingRankUi.ApplyRankRewardVisibility(self.view, scrollView, groupRankReward, false)
    self:_RefreshRankRewards(seasonId, gameplayType, rankType, false, 0, 0)
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
  GuideNotePermTrainingRankUi.ApplyRankTitle(self.view, divingTitleNode, rankData)
  GuideNotePermTrainingRankUi.ApplyRankRewardVisibility(self.view, scrollView, groupRankReward, hasData)
  if not divingTitleNode then
    GuideNotePermTrainingRankUi.ApplyRankTextFallback(self.view, scrollView, textRankNode, rankData)
  end
  self:_RefreshRankRewards(seasonId, gameplayType, rankType, hasData, rewardRankIndex, playersNum)
  return hasData
end

function CompGuideNotePermTrainingItemPvp:_RefreshRankRewards(seasonId, gameplayType, rankType, hasData, rewardRankIndex, playersNum)
  self._rankRewardItems = {}
  if hasData and rewardRankIndex and rewardRankIndex > 0 then
    self._rankRewardItems = GuideNotePermTrainingRankUi.GetCurrentRankPrizeRewards(seasonId, gameplayType, rankType, rewardRankIndex, playersNum)
  end
  local showList = #(self._rankRewardItems or {}) > 0
  if self.ui.ScrollView_Rank_Pvp then
    self:SetActive(self.ui.ScrollView_Rank_Pvp, showList)
  end
  self:_EnsureRankRewardTableView()
  if self._rankRewardTv then
    self._rankRewardTv:ReloadData()
  end
end

function CompGuideNotePermTrainingItemPvp:_EnsureRankRewardTableView()
  if not (not self._rankRewardTv and self.ui and self.ui.ScrollView_Rank_Pvp) or not self.ui.UI_Common_Item_WuPin_Type2 then
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
  self._rankRewardTv = self:CreateTableview(self.ui.ScrollView_Rank_Pvp, function()
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

function CompGuideNotePermTrainingItemPvp:Refresh()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(FeatureId.PVP, 0)
  if self.ui.Group_Unlock_Pvp then
    self.ui.Group_Unlock_Pvp:SetActive(true == unlocked)
  end
  if self.ui.Group_Lock_Pvp then
    self.ui.Group_Lock_Pvp:SetActive(true ~= unlocked)
  end
  GuideNotePermTrainingUnlockTipsUi.ApplyToLockGroup(self, self.ui.Group_Lock_Pvp, unlocked, FeatureId.PVP, 0)
  local preBuiltSeasonData = {}
  if SeasonRotationModel and SeasonRotationModel.Instance then
    preBuiltSeasonData = SeasonRotationModel.Instance:GetPvpPrebuildSeasonData() or {}
  end
  self:SetText(self.ui.Text_Score_Pvp, tostring(preBuiltSeasonData.score or 0))
  local preBuiltSeasonId = 0
  if SeasonRotationModel and SeasonRotationModel.Instance then
    preBuiltSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpPreBuilt) or 0
  end
  local pvpTaskDesc = SeasonRotationCfgUtils.GetSeasonTaskDesc(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt)
  self:SetText(self.ui.Text_WinCount_Pvp, LT.Text(pvpTaskDesc))
  local showRankRewardCaption = self:_RefreshRankDisplay(preBuiltSeasonId)
  if self.ui.Text_C_Reward_Pvp then
    self:SetActive(self.ui.Text_C_Reward_Pvp, showRankRewardCaption)
  end
  self:_RefreshVictorRewards()
end

function CompGuideNotePermTrainingItemPvp:RefreshTime()
  local preBuiltSeasonId = 0
  if SeasonRotationModel and SeasonRotationModel.Instance then
    preBuiltSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpPreBuilt) or 0
  end
  self:SetText(self.ui.Text_Time_Pvp, SeasonRotationCfgUtils.GetLeftTimeTextColored(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt))
  self:SetImage(self.ui.Icon_Time_Pvp, SeasonRotationCfgUtils.GetLeftTimeHourglassIcon(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt))
end

function CompGuideNotePermTrainingItemPvp:GetSortEntry()
  local groupUnlock = self.ui.Group_Unlock_Pvp
  local root = groupUnlock and groupUnlock.transform and groupUnlock.transform.parent or nil
  if not root then
    return nil
  end
  return {
    tf = root,
    sortKey = CompGuideNotePermTrainingItemPvp.SortKey,
    left = GuideNotePermTrainingSortUtil.GetSeasonLeftTime(SeasonGameplayType.PvpPreBuilt)
  }
end

function CompGuideNotePermTrainingItemPvp:_RefreshVictorRewards()
  local preBuiltSeasonId = 0
  if SeasonRotationModel and SeasonRotationModel.Instance then
    preBuiltSeasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.PvpPreBuilt) or 0
  end
  self._victorRewards = {}
  if SeasonRotationCfgUtils then
    self._victorRewards = SeasonRotationCfgUtils.GetSeasonRewardList(preBuiltSeasonId, SeasonGameplayType.PvpPreBuilt) or {}
  end
  if self.ui.ScrollView_Victor_Pvp then
    self:SetActive(self.ui.ScrollView_Victor_Pvp, #(self._victorRewards or {}) > 0)
  end
  self:_EnsureVictorTableView()
  if self._victorTv then
    self._victorTv:ReloadData()
  end
end

function CompGuideNotePermTrainingItemPvp:_EnsureVictorTableView()
  if not (not self._victorTv and self.ui and self.ui.UI_Common_Item_WuPin_Type2) or not self.ui.ScrollView_Victor_Pvp then
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
  self._victorTv = self:CreateTableview(self.ui.ScrollView_Victor_Pvp, function()
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
        local seasonId = SeasonRotationModel and SeasonRotationModel.Instance and SeasonRotationModel.Instance:GetSeasonId(CommonDefine.SeasonGameplayType.PvpPreBuilt) or 0
        local itemData = GuideNotePermTrainingRewardItemHelper.BuildSeasonTaskRewardItemData(self.view, gameObj, reward, seasonId, CommonDefine.SeasonGameplayType.PvpPreBuilt, function()
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

return CompGuideNotePermTrainingItemPvp
