local DEFAULT_RATE = 1

local function createCommonStageModelState(stageGroupId, featureId)
  local state = {}
  state.stageGroupId = stageGroupId
  state.featureId = featureId
  state.stageInfoVer = 0
  state.selectedStageId = nil
  state.selectedRewards = nil
  state.currMonsterTid = 0
  
  function state.sortedSelectedRewards()
    local rewards = table.clone(state.selectedRewards or {})
    return rewards
  end
  
  function state.stageDataList()
    return CopyDataUtils.GetStageList(state.stageGroupId) or {}
  end
  
  function state.bgImage()
    if not state.selectedStageId then
      return ""
    end
    local cfg = DT.Stage[state.selectedStageId]
    assert(nil ~= cfg, string.format("Stage没有找到该配置，配置id为: %s", state.selectedStageId))
    return cfg.Backgrand
  end
  
  return state
end

local function createCommonStageModelViews(data)
  local views = {}
  
  function views:GetLastUnlockIndex()
    local index = 1
    for i = #self.stageDataList, 1, -1 do
      local stageData = self.stageDataList[i]
      if stageData.unlocked == true then
        index = i
        break
      end
    end
    return index
  end
  
  function views:GetMaxPassedStageIndex()
    local maxPassedIndex = 0
    for i = 1, #self.stageDataList do
      local stageData = self.stageDataList[i]
      if stageData and stageData.firstRewardDraw and i > maxPassedIndex then
        maxPassedIndex = i
      end
    end
    return maxPassedIndex
  end
  
  function views:GetLastUnlockStageIndex()
    local index = 0
    for i = 1, #self.stageDataList do
      local stageData = self:GetStageDataByIndex(i)
      local stageId = stageData.stageID
      local stageCfg = self:GetStageCfg(stageId)
      if 1 == stageCfg.DailyChallengeMadnessDifficulty or data:ImageMaskVisible(i) then
        break
      end
      index = index + 1
    end
    return 0 == index and 1 or index
  end
  
  function views:GetUniqDesignIcon()
    local DailyIconInfo = DT.StageGroup[self.stageGroupId].DailyIcon
    return DailyIconInfo and DailyIconInfo[1]
  end
  
  function views:GetUniqDesignStr()
    local DailyIconInfo = DT.StageGroup[self.stageGroupId].DailyIcon
    return DailyIconInfo and DailyIconInfo[2]
  end
  
  function views:GetTalentGroup()
    local BattleBuff = DT.StageGroup[self.stageGroupId].BattleBuff
    if BattleBuff and 1 == BattleBuff[1] then
      return BattleBuff[2]
    end
  end
  
  function views:GetTitle()
    return DT.StageGroup[self.stageGroupId].Name
  end
  
  function views:GetType()
    return DT.StageGroup[self.stageGroupId].Type
  end
  
  function views:GetInitCreationEmptyTips()
    do return LT.Text end
    return LT.Text, "StageRelicEmpty"
  end
  
  function views:GetStageCfg(stageId)
    local cfg = DT.Stage[stageId]
    if not cfg then
      Logger.Error("没有找到副本,ID = " .. stageId)
    end
    return cfg
  end
  
  function views:GetStageData(stageId)
    for _, stageData in ipairs(self.stageDataList) do
      if stageData.stageID == stageId then
        return stageData
      end
    end
  end
  
  function views:GetStageDataByIndex(index)
    local stateList = self.stageDataList
    local stageData = stateList[index]
    return stageData
  end
  
  function views:GetIsLocked(stageId)
    for _, stageData in ipairs(self.stageDataList) do
      if stageData.stageID == stageId then
        return stageData and not stageData.unlocked
      end
    end
  end
  
  function views:IsIndexLocked(index)
    local stageData = self:GetStageDataByIndex(index)
    return not stageData.unlocked
  end
  
  function views:GetStageUnlockTips(index)
    local preStageData = self.stageDataList[index - 1]
    local preStageId = preStageData.stageID
    local preStageName = self:GetStageName(preStageId)
    local tipsId = 20016
    local tipsDesc = DT.TipsType[tipsId] and DT.TipsType[tipsId].Desc or ""
    local desc = LT.Textf(tipsDesc, preStageName)
    return desc
  end
  
  function views:GetStageUnlockTipsByStageId(stageId)
    for index, stageData in ipairs(self.stageDataList) do
      if stageData.stageID == stageId then
        return self:GetStageUnlockTips(index)
      end
    end
  end
  
  function views:GetStageName(stageId)
    local cfg = DT.Stage[stageId]
    do return LT.Text end
    return LT.Text, cfg.Name
  end
  
  function views:GetSelectedStageCfg()
    do return self.GetStageCfg, self end
    return self.GetStageCfg, self, self.selectedStageId
  end
  
  function views:GetSelectedStageName()
    do return self.GetStageName, self end
    return self.GetStageName, self, self.selectedStageId
  end
  
  function views:GetSelectedStageDesc()
    return self:GetSelectedStageCfg().Desc
  end
  
  function views:GetItemSortWeight(item)
    local weight = 9999
    local gap = 100
    local type = item.awardType or item.type
    local isGot = item.isGot
    if type == CommonDefine.ItemAwardType.First3Star and not isGot then
      return weight - (item.index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.First and not isGot then
      return weight - (item.index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.FirstMult and not isGot then
      return weight - (item.index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.Normal then
      return weight - (item.index or 0)
    end
    if type == CommonDefine.ItemAwardType.First3Star then
      return weight - (item.index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.First then
      return weight - (item.index or 0)
    end
    return weight
  end
  
  function views:GetSelectedRewards()
    local cfg = self:GetSelectedStageCfg()
    local curStar = self:GetCurStar()
    local rewards = {}
    for tid, num, index in table.iteraDouble(cfg.FirstTimeReward or {}) do
      table.insert(rewards, {
        tid = tid,
        num = num,
        type = CommonDefine.ItemAwardType.First,
        isGot = self:GetIsPassed(self.selectedStageId),
        index = index
      })
    end
    for tid, num, index in table.iteraDouble(cfg.PerfectReward or {}) do
      table.insert(rewards, {
        tid = tid,
        num = num,
        type = CommonDefine.ItemAwardType.First3Star,
        isGot = curStar >= 3,
        index = index
      })
    end
    for tid, num, index in table.iteraDouble(cfg.NormalReward or {}) do
      table.insert(rewards, {
        tid = tid,
        num = num,
        type = CommonDefine.ItemAwardType.Normal,
        index = index
      })
    end
    if cfg.TaskCondition and TaskDataUtils.CheckTaskListIsAllDone(cfg.TaskCondition) then
      for tid, num, index in table.iteraDouble(cfg.TaskNormalReward or {}) do
        table.insert(rewards, {
          tid = tid,
          num = num,
          type = CommonDefine.ItemAwardType.Normal,
          index = index
        })
      end
    end
    rewards = ItemDataUtils.KickoutAwakerFavorItem(rewards)
    table.sort(rewards, function(a, b)
      local weightA = self:GetItemSortWeight(a)
      local weightB = self:GetItemSortWeight(b)
      if weightA == weightB then
        local itemA = DT.Item[a.tid]
        local itemB = DT.Item[b.tid]
        return itemA.BaseSortID < itemB.BaseSortID
      end
      return weightA > weightB
    end)
    return rewards
  end
  
  function views:GetSelectedMonsterList()
    do return CopyDataUtils.GetStageMonsterWithAffixList, self.selectedStageId end
    return CopyDataUtils.GetStageMonsterWithAffixList, self.selectedStageId, true
  end
  
  function views:GetSelectedCost()
    return StageCfgUtils.GetExtraCostItemNum(self.selectedStageId) or self:GetSelectedStageCfg().Cost
  end
  
  function views:GetSelectedSecondModeCost()
    local cost = StageCfgUtils.GetExtraCostItemNum(self.selectedStageId) or self:GetSelectedStageCfg().Cost
    local rate = self:GetSelectedStageCfg().SecondMode or DEFAULT_RATE
    return cost * rate
  end
  
  function views:GetTalents()
    return {}
  end
  
  function views:GetRecommendFight(stageId)
    return self:GetStageCfg(stageId).RecScore
  end
  
  function views:GetSelectedRecommendFight()
    return self:GetSelectedStageCfg().RecScore
  end
  
  function views:GetCostIcon()
    local itemId = CommonDefine.CurrencyType.Energy
    if StageCfgUtils.GetExtraCostItemTid(self.selectedStageId) then
      itemId = StageCfgUtils.GetExtraCostItemTid(self.selectedStageId)
    end
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, itemId
  end
  
  function views:GetTicketHaveItemNum()
    local itemTid = self:GetCostItemTid()
    if itemTid == CommonDefine.CurrencyType.Energy then
      do return end
      return PlayerDataUtils.GetEnergy, nil
    end
    do return ItemDataUtils.GetItemNum end
    return ItemDataUtils.GetItemNum, itemTid
  end
  
  function views:GetCostItemTid()
    if StageCfgUtils.GetExtraCostItemTid(self.selectedStageId) then
      do return StageCfgUtils.GetExtraCostItemTid end
      return StageCfgUtils.GetExtraCostItemTid, self.selectedStageId
    end
    return CommonDefine.CurrencyType.Energy
  end
  
  function views:GetIsDoubleFight()
    do return CopyDataUtils.IsDoubleFight end
    return CopyDataUtils.IsDoubleFight, self.selectedStageId
  end
  
  function views:GetIsShowSweep()
    do return CopyDataUtils.IsCanSweepInCfg, self.selectedStageId end
    return CopyDataUtils.IsCanSweepInCfg, self.selectedStageId, self.stageGroupId
  end
  
  function views:GetIsCanSweep(activityTid)
    local isCan = CopyDataUtils.IsSweepTypeOK(self.selectedStageId, activityTid)
    return isCan
  end
  
  function views:GetStar(stageId)
    for _, stageData in ipairs(self.stageDataList) do
      if stageData.stageID == stageId then
        return stageData.star
      end
    end
    return 0
  end
  
  function views:GetCurStar()
    do return self.GetStar, self end
    return self.GetStar, self, self.selectedStageId
  end
  
  function views:GetIsPassed(stageId)
    for _, stageData in ipairs(self.stageDataList) do
      if stageData.stageID == stageId then
        return stageData.firstRewardDraw
      end
    end
  end
  
  function views:GetUnlockTips()
  end
  
  function views:GetResonanceGroup()
  end
  
  function views:LevelReach(stageId)
    local playerLv = DataCenter.playerData.DRole.level
    local stageCfg = self:GetStageCfg(stageId)
    local limitLv = stageCfg.PlayerLevel or 0
    local lvMatch = limitLv and playerLv >= limitLv
    return lvMatch
  end
  
  function views:GetChallengeBtnState()
    local btnState = CommonDefine.BtnType.High
    local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self:GetType())
    if showLevelLimit then
      if not self:LevelReach(self.selectedStageId) then
        btnState = CommonDefine.BtnType.Unclickable
      end
    elseif self:GetIsLocked(self.selectedStageId) then
      btnState = CommonDefine.BtnType.Unclickable
    end
    return btnState
  end
  
  function views:CheckTicketCostItemEnough(costNum)
    local costItemTid = self:GetCostItemTid()
    local haveItemNum = self:GetTicketHaveItemNum()
    if costNum <= haveItemNum then
      return true
    end
    if costItemTid == CommonDefine.CurrencyType.Energy then
      FrameWaiter.OnNextFrame(function()
        PlayerDataUtils.ShowEnergyRestorePanel()
      end)
    elseif costItemTid == CommonDefine.CurrencyType.SummerChapter1Ticket then
      FrameWaiter.OnNextFrame(function()
        MainShopViewUtils.OpenActivityTicketBuyPanel(costItemTid)
      end)
    end
    return false
  end
  
  function views:CheckCanChallengeAndShowTips()
    local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self:GetType())
    if showLevelLimit then
      if not self:LevelReach(self.selectedStageId) then
        local stageCfg = self:GetStageCfg(self.selectedStageId)
        local limitLv = stageCfg.PlayerLevel
        Alert.ShowStr(LT.Textf("WeeklyBoss_LvLimit", limitLv))
        return false
      end
    elseif self:GetIsLocked(self.selectedStageId) then
      Alert.ShowStr(self:GetStageUnlockTipsByStageId(self.selectedStageId))
      return false
    end
    return true
  end
  
  function views:ShowUnlockTips(index)
    local stageData = self:GetStageDataByIndex(index)
    local stageId = stageData.stageID
    local stageCfg = self:GetStageCfg(stageId)
    local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self:GetType())
    if showLevelLimit then
      if not self:LevelReach(stageId) then
        local limitLv = stageCfg.PlayerLevel
        do return LT.Textf, "WeeklyBoss_LvLimit" end
        return LT.Textf, "WeeklyBoss_LvLimit", limitLv
      else
        do return self.RecommendLvCall, self end
        return self.RecommendLvCall, self, stageCfg.StageLevel, limitLv
      end
    elseif stageData.unlocked then
      do return self.RecommendLvCall, self end
      return self.RecommendLvCall, self, stageCfg.StageLevel, limitLv
    else
      do return self.GetStageUnlockTips, self end
      return self.GetStageUnlockTips, self, index, limitLv
    end
  end
  
  function views:RecommendLvCall(lv)
    do return string.format, "%s%s", (LT.Text("Copy_Recommend_Level")) end
    return string.format, "%s%s", LT.Text("Copy_Recommend_Level"), lv
  end
  
  function views:ImageMaskVisible(index)
    local stageData = self:GetStageDataByIndex(index)
    local stageId = stageData.stageID
    local playerLv = DataCenter.playerData.DRole.level
    local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self:GetType())
    if showLevelLimit then
      local stageCfg = self:GetStageCfg(stageId)
      local limitLv = stageCfg and stageCfg.PlayerLevel or stageCfg.StageLevel or 0
      return playerLv < limitLv
    else
      return not stageData.unlocked
    end
  end
  
  function views:GetWeekBossRefreshTimeDesc()
    do return end
    return DungeonUtils.GetWeekBossRefreshTimeDesc
  end
  
  function views:GetRewardNumLeft()
    do return end
    return CopyDataUtils.GetWeekBossRewardCnt
  end
  
  function views:IsHaveMap(stageId)
    local stageCfg = self:GetStageCfg(stageId)
    return stageCfg.Map
  end
  
  return views
end

local function createCommonStageModelActions(data)
  local actions = {}
  
  function actions:SetSelectedIndex(index)
    if self.stageDataList[index] then
      self.selectedStageId = self.stageDataList[index].stageID
      self.selectedRewards = self:GetSelectedRewards()
    end
  end
  
  function actions:UpdateSelectedRewards()
    self.selectedRewards = self:GetSelectedRewards()
  end
  
  function actions:SetSelectedStageId(stageID)
    for index, stageData in ipairs(self.stageDataList) do
      if stageData.stageID == stageID then
        self:SetSelectedIndex(index)
      end
    end
  end
  
  function actions:SetIsAutoBattle(boolVal)
    if nil == boolVal then
      Logger.Error("Error boolVal:", boolVal)
    end
    data.isAutoBattle = boolVal
  end
  
  function actions:GotoIntroduction()
    local title = LT.Text("WeeklyBossTitle")
    local content = LT.Text("WeeklyBossInstructions")
    UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
  end
  
  function actions:SetMonsterTid(tid)
    data.currMonsterTid = tid
  end
  
  return actions
end

local function onSetup(binder, model)
  local function refreshStageSelection()
    if not model.selectedStageId then
      local maxPassedIndex = model:GetMaxPassedStageIndex()
      
      if maxPassedIndex and maxPassedIndex > 0 then
        model:SetSelectedIndex(maxPassedIndex)
      else
        model:SetSelectedIndex(model:GetLastUnlockStageIndex())
      end
    else
      model:UpdateSelectedRewards()
    end
  end
  
  if model.featureId ~= CommonDefine.FeatureId.WeekBossChallenge then
    local stageGroupId = model.stageGroupId
    if model.featureId ~= nil and model.featureId ~= "" then
      stageGroupId = 0
    end
    CopyDataUtils.ReqCopyData(model.featureId, stageGroupId, refreshStageSelection)
    if stageGroupId and stageGroupId > 0 then
      local function onStageDataChangedHandler(changedGroupId)
        if changedGroupId == stageGroupId then
          model.stageInfoVer = (model.stageInfoVer or 0) + 1
          
          refreshStageSelection()
        end
      end
      
      GlobalDispatcher:AddListener(NotifyId.OnStageDataChanged, onStageDataChangedHandler)
      binder:onDestroy(function()
        GlobalDispatcher:RemoveListener(NotifyId.OnStageDataChanged, onStageDataChangedHandler)
      end)
    end
  end
  if not model.selectedStageId then
    model:SetSelectedIndex(model:GetLastUnlockStageIndex())
  end
  binder:BindToRaw(function(_, _)
  end, function()
    do return model.GetTalentGroup end
    return model.GetTalentGroup, model
  end)
end

local CommonStageModel = Vue.model("CommonStageModel", createCommonStageModelState):views(createCommonStageModelViews):actions(createCommonStageModelActions):setup(onSetup)
return CommonStageModel
