local FeatureId = CommonDefine.FeatureId
local SeasonGameplayType = CommonDefine.SeasonGameplayType
local CompGuideNotePermTrainingItemRailyWay, Super = NewViewComponent("CompGuideNotePermTrainingItemRailyWay")
CompGuideNotePermTrainingItemRailyWay.SortKey = "RailyWay"

function CompGuideNotePermTrainingItemRailyWay:ctor(gameObject, view)
  Super.ctor(self, gameObject, view)
  self._rankTitleReady = false
  self._refreshTimer = nil
  self._extraTv = nil
  self._extraComps = nil
  self._extraRewardItems = {}
  self._rankRewardTv = nil
  self._rankRewardComps = nil
  self._rankRewardItems = {}
  self.ui = view.ui
end

function CompGuideNotePermTrainingItemRailyWay:RegisterEvents()
  local btn = self.ui.Btn_Goto_RailyWay
  if btn then
    self:AddButtonClickListener(btn, function()
      self:_OnClickGoto()
    end)
  end
  if self.ui.Btn_Lock_RailyWay then
    self:AddButtonClickListener(self.ui.Btn_Lock_RailyWay, function()
      self:_OnClickLock()
    end)
  end
  self:BindEvent(EventMgr.Instance.OnRailWayDataChanged, function()
    self:Refresh()
  end)
  self:RegisterNotify(NotifyId.OnRankDataChanged, self._OnRankDataChanged, self)
end

function CompGuideNotePermTrainingItemRailyWay:_OnRankDataChanged(rankType)
  if rankType ~= RankDefine.RankType.SeasonRoRailWay then
    return
  end
  self._rankTitleReady = true
  self:Refresh()
end

function CompGuideNotePermTrainingItemRailyWay:_OnClickLock()
  local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(FeatureId.Activity, 0)
  if not string.isempty(tips) then
    Alert.ShowStr(tips)
  else
    Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
  end
end

function CompGuideNotePermTrainingItemRailyWay:_OnClickGoto()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(FeatureId.Activity, 0)
  if true ~= unlocked then
    local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(FeatureId.Activity, 0)
    if not string.isempty(tips) then
      Alert.ShowStr(tips)
    else
      Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
    end
    return
  end
  ActivityController.Instance:OpenActivityPermanentsPanel()
end

function CompGuideNotePermTrainingItemRailyWay:OnEnterComponent()
  self._rankTitleReady = false
  GuideNotePermTrainingRankUi.HideRankTitleSlots(self.view, self.ui.DivingTitle_RailyWay, self.ui.ScrollView_Rank_RailyWay, self.ui.Text_Rank_RailyWay)
  if self.ui.ScrollView_Victor_RailyWay then
    self:SetActive(self.ui.ScrollView_Victor_RailyWay, false)
  end
  if self.ui.ScrollView_Reward_RailyWay then
    self:SetActive(self.ui.ScrollView_Reward_RailyWay, false)
  end
  if RailWayController and RailWayController.Instance and RailWayController.Instance.ReqOnOpenRailWay then
    RailWayController.Instance:ReqOnOpenRailWay()
  end
  self:_RestartRefreshTimer()
  self:Refresh()
end

function CompGuideNotePermTrainingItemRailyWay:OnExitComponent()
  self:_ClearRefreshTimer()
  self:_TeardownExtraComps()
  self:_TeardownRankRewardComps()
  Super.OnExitComponent(self)
end

function CompGuideNotePermTrainingItemRailyWay:_RestartRefreshTimer()
  GuideNotePermTrainingRefreshTimer.Restart(self)
end

function CompGuideNotePermTrainingItemRailyWay:_ClearRefreshTimer()
  if self._refreshTimer then
    self:StopTimer(self._refreshTimer)
    self._refreshTimer = nil
  end
end

function CompGuideNotePermTrainingItemRailyWay:_TeardownExtraComps()
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

function CompGuideNotePermTrainingItemRailyWay:_TeardownRankRewardComps()
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

function CompGuideNotePermTrainingItemRailyWay:_RefreshRankDisplay(view, ui, seasonId)
  local rankType = RankDefine.RankType.SeasonRoRailWay
  local gameplayType = SeasonGameplayType.ConsciousnessRailway
  local divingTitleNode = ui.DivingTitle_RailyWay
  local scrollView = ui.ScrollView_Reward_RailyWay
  local textRankNode = ui.Text_Rank_RailyWay
  local groupRankReward = ui.Group_RankReward_RailyWay
  if self._rankTitleReady ~= true then
    GuideNotePermTrainingRankUi.HideRankTitleSlots(view, divingTitleNode, scrollView, textRankNode)
    GuideNotePermTrainingRankUi.ApplyRankRewardVisibility(view, scrollView, groupRankReward, false)
    self:_RefreshRankRewards(view, ui, seasonId, gameplayType, rankType, false, 0, 0)
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
  self:_RefreshRankRewards(view, ui, seasonId, gameplayType, rankType, hasData, rewardRankIndex, playersNum)
  return hasData
end

function CompGuideNotePermTrainingItemRailyWay:Refresh()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(FeatureId.Activity, 0)
  if self.ui.Group_Unlock_RailyWay then
    self.ui.Group_Unlock_RailyWay:SetActive(true == unlocked)
  end
  if self.ui.Group_Lock_RailyWay then
    self.ui.Group_Lock_RailyWay:SetActive(true ~= unlocked)
  end
  GuideNotePermTrainingUnlockTipsUi.ApplyToLockGroup(self, self.ui.Group_Lock_RailyWay, unlocked, FeatureId.Activity, 0)
  local seasonIdRailway = 0
  if SeasonRotationModel and SeasonRotationModel.Instance then
    seasonIdRailway = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway) or 0
  end
  local railwaySeasonName = SeasonRotationCfgUtils.GetName(seasonIdRailway, SeasonGameplayType.ConsciousnessRailway)
  local railwayTaskDesc = SeasonRotationCfgUtils.GetSeasonTaskDesc(seasonIdRailway, SeasonGameplayType.ConsciousnessRailway)
  if self.ui.Text_Season_RailyWay then
    self:SetText(self.ui.Text_Season_RailyWay, LT.Text(railwaySeasonName))
  end
  if self.ui.Text_WinCount_RailyWay then
    self:SetText(self.ui.Text_WinCount_RailyWay, LT.Text(railwayTaskDesc))
  end
  local railWayScore = RailWayModel.Instance:GetSeasonMaxScore()
  self:SetText(self.ui.Text_Score_RailyWay, tostring(railWayScore))
  self:_RefreshRankDisplay(self.view, self.ui, seasonIdRailway)
  self:_RefreshRailyWayExtraRewards()
end

function CompGuideNotePermTrainingItemRailyWay:RefreshTime()
  local seasonIdRailway = 0
  if SeasonRotationModel and SeasonRotationModel.Instance then
    seasonIdRailway = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway) or 0
  end
  self:SetText(self.ui.Text_Time_RailyWay, SeasonRotationCfgUtils.GetLeftTimeTextColored(seasonIdRailway, SeasonGameplayType.ConsciousnessRailway))
  self:SetImage(self.ui.Icon_Time_RailyWay, SeasonRotationCfgUtils.GetLeftTimeHourglassIcon(seasonIdRailway, SeasonGameplayType.ConsciousnessRailway))
end

function CompGuideNotePermTrainingItemRailyWay:GetSortEntry()
  local groupUnlock = self.ui.Group_Unlock_RailyWay
  local root = groupUnlock and groupUnlock.transform and groupUnlock.transform.parent or nil
  if not root then
    return nil
  end
  return {
    tf = root,
    sortKey = CompGuideNotePermTrainingItemRailyWay.SortKey,
    left = GuideNotePermTrainingSortUtil.GetSeasonLeftTime(SeasonGameplayType.ConsciousnessRailway)
  }
end

function CompGuideNotePermTrainingItemRailyWay:_RefreshRankRewards(view, ui, seasonId, gameplayType, rankType, hasData, rewardRankIndex, playersNum)
  self._rankRewardItems = {}
  if hasData and rewardRankIndex and rewardRankIndex > 0 then
    self._rankRewardItems = GuideNotePermTrainingRankUi.GetCurrentRankPrizeRewards(seasonId, gameplayType, rankType, rewardRankIndex, playersNum)
  end
  local showList = #(self._rankRewardItems or {}) > 0
  if ui.ScrollView_Reward_RailyWay then
    self:SetActive(ui.ScrollView_Reward_RailyWay, showList)
  end
  self:_EnsureRankRewardTableView()
  if self._rankRewardTv then
    self._rankRewardTv:ReloadData()
  end
end

function CompGuideNotePermTrainingItemRailyWay:_EnsureRankRewardTableView()
  if not (not self._rankRewardTv and self.ui and self.ui.ScrollView_Reward_RailyWay) or not self.ui.UI_Common_Item_WuPin_Type2 then
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
  self._rankRewardTv = self:CreateTableview(self.ui.ScrollView_Reward_RailyWay, function()
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

function CompGuideNotePermTrainingItemRailyWay:_RefreshRailyWayExtraRewards()
  self._extraRewardItems = {}
  local seasonIdRailway = 0
  if SeasonRotationModel and SeasonRotationModel.Instance then
    seasonIdRailway = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway) or 0
  end
  if not seasonIdRailway or 0 == seasonIdRailway then
    if self.ui.ScrollView_Victor_RailyWay then
      self:SetActive(self.ui.ScrollView_Victor_RailyWay, false)
    end
    return
  end
  if SeasonRotationCfgUtils and SeasonRotationCfgUtils.GetSeasonRewardList then
    self._extraRewardItems = SeasonRotationCfgUtils.GetSeasonRewardList(seasonIdRailway, SeasonGameplayType.ConsciousnessRailway) or {}
  end
  if self.ui.ScrollView_Victor_RailyWay then
    self:SetActive(self.ui.ScrollView_Victor_RailyWay, #(self._extraRewardItems or {}) > 0)
  end
  self:_EnsureExtraTableView()
  if self._extraTv then
    self._extraTv:ReloadData()
  end
end

function CompGuideNotePermTrainingItemRailyWay:_EnsureExtraTableView()
  if not (not self._extraTv and self.ui and self.ui.ScrollView_Victor_RailyWay) or not self.ui.UI_Common_Item_WuPin_Type2 then
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
  self._extraComps = {}
  local baseGameObj = self.ui.UI_Common_Item_WuPin_Type2
  local itemSelf = self
  self._extraTv = self:CreateTableview(self.ui.ScrollView_Victor_RailyWay, function()
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
        local railwayType = CommonDefine.SeasonGameplayType.ConsciousnessRailway
        local railwaySeasonId = SeasonRotationModel and SeasonRotationModel.Instance and SeasonRotationModel.Instance:GetSeasonId(railwayType) or 0
        local itemData = GuideNotePermTrainingRewardItemHelper.BuildSeasonTaskRewardItemData(self.view, gameObj, reward, railwaySeasonId, railwayType, function()
          itemSelf:Refresh()
        end)
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

return CompGuideNotePermTrainingItemRailyWay
