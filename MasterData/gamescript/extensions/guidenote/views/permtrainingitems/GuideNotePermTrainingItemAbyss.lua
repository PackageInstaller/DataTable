local FeatureId = CommonDefine.FeatureId
local CompGuideNotePermTrainingItemAbyss, Super = NewViewComponent("CompGuideNotePermTrainingItemAbyss")
CompGuideNotePermTrainingItemAbyss.SortKey = "Abyss"

function CompGuideNotePermTrainingItemAbyss:ctor(gameObject, view)
  Super.ctor(self, gameObject, view)
  self._rankTitleReady = false
  self._refreshTimer = nil
  self._extraTv = nil
  self._extraComps = nil
  self._extraRewardItems = {}
  self.ui = view.ui
end

function CompGuideNotePermTrainingItemAbyss:RegisterEvents()
  local btn = self.ui.Btn_Goto_Abyss
  if btn then
    self:AddButtonClickListener(btn, function()
      self:_OnClickGoto()
    end)
  end
  if self.ui.Btn_Lock_Abyss then
    self:AddButtonClickListener(self.ui.Btn_Lock_Abyss, function()
      self:_OnClickLock()
    end)
  end
  self:RegisterNotify(NotifyId.OnRankDataChanged, self.OnRankDataChanged, self)
end

function CompGuideNotePermTrainingItemAbyss:_OnClickLock()
  local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(FeatureId.AbyssChallenge, 0)
  if not string.isempty(tips) then
    Alert.ShowStr(tips)
  else
    Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
  end
end

function CompGuideNotePermTrainingItemAbyss:_OnClickGoto()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(FeatureId.AbyssChallenge, 0)
  if true ~= unlocked then
    local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(FeatureId.AbyssChallenge, 0)
    if not string.isempty(tips) then
      Alert.ShowStr(tips)
    else
      Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
    end
    return
  end
  UIManager.Instance:Reopen(Urls.AbyssView)
end

function CompGuideNotePermTrainingItemAbyss:OnEnterComponent()
  self._rankTitleReady = false
  self:Refresh()
  self:_RestartRefreshTimer()
end

function CompGuideNotePermTrainingItemAbyss:OnRankDataChanged(rankType)
  if rankType ~= RankDefine.RankType.AbyssChallenge then
    return
  end
  self._rankTitleReady = true
  self:Refresh()
  self:_RestartRefreshTimer()
end

function CompGuideNotePermTrainingItemAbyss:OnExitComponent()
  self:_ClearRefreshTimer()
  self:_TeardownExtraComps()
  Super.OnExitComponent(self)
end

function CompGuideNotePermTrainingItemAbyss:_RestartRefreshTimer()
  GuideNotePermTrainingRefreshTimer.Restart(self)
end

function CompGuideNotePermTrainingItemAbyss:_ClearRefreshTimer()
  if self._refreshTimer then
    self:StopTimer(self._refreshTimer)
    self._refreshTimer = nil
  end
end

function CompGuideNotePermTrainingItemAbyss:_TeardownExtraComps()
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

function CompGuideNotePermTrainingItemAbyss:_SetCombinedProgressTextCompat(ui, progressText, scoreText, rewardProgressText)
  if nil == progressText or nil == scoreText or nil == rewardProgressText then
    return
  end
  local progressLabel = LT.PanelText("UI_Summon_Popup_Presented_Tip_Text_C_Plan")
  local scoreLabel = LT.PanelText("UI_Dungeons_Popup_AbyssRank_Text_C_Value")
  local rewardLabel = LT.PanelText("UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Weekly")
  local textValue = progressLabel .. "<space=0.3em>" .. progressText .. "<space=1em>" .. scoreLabel .. "<space=0.3em>" .. scoreText .. "<space=1em>" .. rewardLabel .. "<space=0.3em>" .. rewardProgressText
  if ui.Text_Progress_Abyss then
    self:SetText(ui.Text_Progress_Abyss, textValue)
  end
  if ui.Text_Progrress_Abyss then
    self:SetText(ui.Text_Progrress_Abyss, textValue)
  end
end

function CompGuideNotePermTrainingItemAbyss:Refresh()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(FeatureId.AbyssChallenge, 0)
  if self.ui.Group_Unlock_Abyss then
    self.ui.Group_Unlock_Abyss:SetActive(true == unlocked)
  end
  if self.ui.Group_Lock_Abyss then
    self.ui.Group_Lock_Abyss:SetActive(true ~= unlocked)
  end
  GuideNotePermTrainingUnlockTipsUi.ApplyToLockGroup(self, self.ui.Group_Lock_Abyss, unlocked, FeatureId.AbyssChallenge, 0)
  local abyssGotAwardNum, abyssMaxAwardNum, abyssScore = 0, 0, 0
  local abyssPassedCount, abyssTotalGroupCount = 0, 0
  local abyssModel = AbyssExtModel and AbyssExtModel.Instance or nil
  if abyssModel then
    abyssGotAwardNum = abyssModel.GetGotAwardNum and (abyssModel:GetGotAwardNum() or 0) or 0
    abyssMaxAwardNum = abyssModel.GetMaxAwardNum and (abyssModel:GetMaxAwardNum() or 0) or 0
    abyssScore = abyssModel.GetScore and (abyssModel:GetScore() or 0) or 0
    local stageGroupTidList = abyssModel.GetStageGroupTidList and abyssModel:GetStageGroupTidList() or {}
    for _, tid in ipairs(stageGroupTidList) do
      abyssTotalGroupCount = abyssTotalGroupCount + 1
      if abyssModel:HasStageGroupPassed(tid) then
        abyssPassedCount = abyssPassedCount + 1
      end
      local hasExtraChallenge = false
      if AbyssExtChallengeModel and AbyssExtChallengeModel.Instance and AbyssExtChallengeModel.Instance.IsStageGroupHaveExtraChallenge then
        hasExtraChallenge = AbyssExtChallengeModel.Instance:IsStageGroupHaveExtraChallenge(tid)
      end
      if hasExtraChallenge then
        abyssTotalGroupCount = abyssTotalGroupCount + 1
        local stageGroupData = abyssModel:GetStageGroupData(tid) or {}
        if stageGroupData.extraPass then
          abyssPassedCount = abyssPassedCount + 1
        end
      end
    end
  end
  local abyssProgressText = tostring(abyssPassedCount) .. "/" .. tostring(abyssTotalGroupCount)
  local abyssScoreText = tostring(abyssScore)
  local abyssRewardProgressText = tostring(abyssGotAwardNum) .. "/" .. tostring(abyssMaxAwardNum)
  self:_SetCombinedProgressTextCompat(self.ui, abyssProgressText, abyssScoreText, abyssRewardProgressText)
  local abyssRankText = LT.Text("AbyssChallengeRankNotOnTheList")
  if true == self._rankTitleReady and abyssModel and abyssModel.GetCurrActivityTid then
    local activityTid = abyssModel:GetCurrActivityTid()
    if activityTid and activityTid > 0 then
      local selfRankData = RankModel.Instance:GetSelfRankData(RankDefine.RankType.AbyssChallenge, activityTid)
      local rewardRankIndex = selfRankData and selfRankData:GetRewardRankIndex() or 0
      local rankIndex = selfRankData and selfRankData:GetRank() or 0
      local rank = rewardRankIndex > 0 and rewardRankIndex or rankIndex
      if rank and rank > 0 then
        abyssRankText = tostring(rank)
      end
    end
  end
  self:SetText(self.ui.Text_Rank_Abyss, abyssRankText)
  self:_RefreshAbyssExtraRewards()
end

function CompGuideNotePermTrainingItemAbyss:RefreshTime()
  self:SetText(self.view.ui.Text_Time_Abyss, self:_GetAbyssTimeText())
end

function CompGuideNotePermTrainingItemAbyss:_GetAbyssTimeText()
  local abyssModel = AbyssExtModel and AbyssExtModel.Instance or nil
  local endTime = abyssModel and abyssModel.GetEndTime and abyssModel:GetEndTime() or 0
  local now = TimeUtils.GetServerTime()
  local left = (endTime or 0) - now
  if left <= 0 then
    do return LT.Text end
    return LT.Text, "AbyssChallengeEndTips", nil, nil, nil, nil, nil
  end
  local d, h, m = TimeUtils.ConvertTime(left)
  if d > 0 then
    do return LT.Textf, "AbyssChallengeResetTipsDateHour", d end
    return LT.Textf, "AbyssChallengeResetTipsDateHour", d, h
  end
  do return LT.Textf, "AbyssChallengeResetTipsHourMinute", h end
  return LT.Textf, "AbyssChallengeResetTipsHourMinute", h, m
end

function CompGuideNotePermTrainingItemAbyss:GetSortEntry()
  local ui = self.view.ui
  local groupUnlock = ui.Group_Unlock_Abyss
  local root = groupUnlock and groupUnlock.transform and groupUnlock.transform.parent or nil
  if not root then
    return nil
  end
  return {
    tf = root,
    sortKey = CompGuideNotePermTrainingItemAbyss.SortKey,
    left = GuideNotePermTrainingSortUtil.GetAbyssLeftTime()
  }
end

function CompGuideNotePermTrainingItemAbyss:_RefreshAbyssExtraRewards()
  local v = self.view
  local ui = v.ui
  self._extraRewardItems = {}
  local rawRewards = {}
  local abyssModel = AbyssExtModel and AbyssExtModel.Instance or nil
  if abyssModel and abyssModel.GetProgressRewardDatas then
    local progressRewardDatas = abyssModel:GetProgressRewardDatas() or {}
    for _, progressData in ipairs(progressRewardDatas) do
      if progressData and progressData.isGet ~= true then
        local rewards = progressData.rewards or {}
        for _, r in ipairs(rewards) do
          if r and r.tid and r.num then
            table.insert(rawRewards, {
              tid = r.tid,
              num = r.num
            })
          end
        end
      end
    end
  end
  self._extraRewardItems = GuideNotePermTrainingRewardMerge.MergeRewardsByTid(rawRewards)
  if ui.ScrollView_Reward_Abyss then
    self:SetActive(ui.ScrollView_Reward_Abyss, #(self._extraRewardItems or {}) > 0)
  end
  self:_EnsureExtraTableView()
  if self._extraTv then
    self._extraTv:ReloadData()
  end
end

function CompGuideNotePermTrainingItemAbyss:_EnsureExtraTableView()
  local v = self.view
  local ui = v.ui
  if not (not self._extraTv and ui and ui.ScrollView_Reward_Abyss) or not ui.UI_Common_Item_WuPin_Type2 then
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
  self._extraTv = self:CreateTableview(ui.ScrollView_Reward_Abyss, function()
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

return CompGuideNotePermTrainingItemAbyss
