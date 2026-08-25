local CompGuideNoteAwakerStrengthMaterial, Super = NewViewComponent("CompGuideNoteAwakerStrengthMaterial")
local AwakerTrinketDataUtils = require("Data.AwakerTrinketDataUtils")
local LT = require("System.LangTable")
local ITEM_SUBTYPE_ORDER = {
  TopBarItem = 600,
  ExpMaterial = 500,
  SkillMaterial = 400,
  WeeklyMaterial = 300,
  SpecialMaterial = 200
}

local function _IsWeeklyStageGroupType(stageGroupType)
  return stageGroupType == CommonDefine.StageGroupType.WeekBoss or stageGroupType == CommonDefine.StageGroupType.WeeklyCopy or stageGroupType == CommonDefine.StageGroupType.WeeklyCopy2
end

local function _IsWeekBossFeatureUnlocked(stageGroupId)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.WeekBossChallenge, stageGroupId or 0)
  return true == unlocked
end

local function _GetWeekBossFeatureUnlockTips(stageGroupId)
  local featureId = CommonDefine.FeatureId.WeekBossChallenge
  local data = stageGroupId and PlayerDataUtils.GetFeatureUnlockData(featureId, stageGroupId) or nil
  if data and data.cfg and data.cfg.LockTip then
    do return LT.Text end
    return LT.Text, data.cfg.LockTip, nil
  end
  do return PlayerDataUtils.GetFeatureLogicUnlockTips, featureId end
  return PlayerDataUtils.GetFeatureLogicUnlockTips, featureId, 0
end

function CompGuideNoteAwakerStrengthMaterial:ctor(uiNode, view, groupData)
  Super.ctor(self, uiNode, view)
  self.ui = UIBaseResource(uiNode)
  self._groupData = groupData
  self._materialIconComps = {}
end

function CompGuideNoteAwakerStrengthMaterial:OnEnterComponent()
  self:AddButtonClickListener(self.ui.Btn_Goto, System.fn(self, self._OnClickMaterialGoto))
  self:AddButtonClickListener(self.ui.Btn_Sweep, System.fn(self, self._OnClickMaterialSweep))
  self:_RefreshByGroup(self._groupData)
end

function CompGuideNoteAwakerStrengthMaterial:OnRefreshComponent(groupData)
  self._groupData = groupData
  self:_RefreshByGroup(groupData)
end

function CompGuideNoteAwakerStrengthMaterial:_SetFullState(isFullState)
  local isFull = true == isFullState
  self:SetActive(self.ui.Group_Full, isFull)
  self:SetActive(self.ui.Text_Tip, false)
  self:SetActive(self.ui.Group_Btns, not isFull)
  self:SetActive(self.ui.Material_1, not isFull)
  self:SetActive(self.ui.Material_2, not isFull)
  self:SetActive(self.ui.Material_3, not isFull)
end

function CompGuideNoteAwakerStrengthMaterial:_RefreshByGroup(groupData)
  if not groupData then
    self:_SetFullState(false)
    self:_RefreshMaterialSlots(nil)
    self:_SetMaterialButtonsState(false, false)
    return
  end
  local itemList = groupData.itemList or {}
  local isFullState = groupData.groupType ~= "TrinketRecommend" and #itemList <= 0
  self:_SetFullState(isFullState)
  self:_RefreshWeeklyRemainTip(groupData)
  if isFullState then
    self:_RefreshMaterialSlots(nil)
    self:_SetMaterialButtonsState(false, false)
    return
  end
  self:_RefreshMaterialSlots(itemList)
  local canGoto, canSweep = CompGuideNoteAwakerStrengthMaterial._CalcMaterialButtonState(groupData)
  self:_SetMaterialButtonsState(canGoto, canSweep)
end

function CompGuideNoteAwakerStrengthMaterial:_RefreshWeeklyRemainTip(group)
  if not self.ui or not self.ui.Text_Tip then
    return
  end
  local show = false
  local tipText = ""
  if group and group.noBattle ~= true and group.groupId and 0 ~= group.groupId then
    local groupCfg = CopyDataUtils.GetStageGroupConfig(group.groupId)
    local stageGroupType = groupCfg and groupCfg.Type or nil
    if _IsWeeklyStageGroupType(stageGroupType) then
      local leftTime = CopyDataUtils.GetWeekBossRewardCnt() or 0
      local totalTime = DT.GetConstant("WeeklyBossStageRewardCount") or 0
      local colorVal = 0 == leftTime and "#B7544A" or "#2B8BA0"
      tipText = LT.Textf("WeeklyBossRemainTimes", colorVal, leftTime, totalTime)
      show = true
    end
  end
  self:SetActive(self.ui.Text_Tip, show)
  if show then
    self:SetText(self.ui.Text_Tip, tipText)
  end
end

function CompGuideNoteAwakerStrengthMaterial:_OnClickMaterialGoto()
  local group = self._groupData
  if not group then
    return
  end
  local sourceTid = CompGuideNoteAwakerStrengthMaterial._GetSourceItemTid(group)
  local gotoStageId = group.gotoStageId or group.stageId or 0
  if not (group.noBattle ~= true and group.groupId) or 0 == group.groupId then
    if sourceTid and 0 ~= sourceTid then
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Goto, nil, sourceTid, true)
    end
    return
  end
  local groupCfg = CopyDataUtils.GetStageGroupConfig(group.groupId)
  local stageGroupType = groupCfg and groupCfg.Type or nil
  local stageId = gotoStageId
  if _IsWeeklyStageGroupType(stageGroupType) and not _IsWeekBossFeatureUnlocked(group.groupId) then
    local unlockTips = _GetWeekBossFeatureUnlockTips(group.groupId)
    Alert.ShowStr(unlockTips)
    return
  end
  if CopyDataUtils and CopyDataUtils.CheckStageGroupIsFeatrueLock and CopyDataUtils.CheckStageGroupIsFeatrueLock(group.groupId) then
    return
  end
  local canGoto, lockReason = CompGuideNoteAwakerStrengthMaterial._CheckGotoStageAvailable(group.groupId, stageId)
  if true ~= canGoto then
    if lockReason and "" ~= lockReason and Alert and Alert.ShowStr then
      Alert.ShowStr(lockReason)
    end
    return
  end
  if stageGroupType == CommonDefine.StageGroupType.DisposableSchoolTower or stageGroupType == CommonDefine.StageGroupType.AlternationSchoolTower then
    UIManager.Instance:Reopen(Urls.SchoolTowerDetailView, group.groupId, stageId)
    return
  end
  if stageGroupType == CommonDefine.StageGroupType.WeekBoss or stageGroupType == CommonDefine.StageGroupType.WeeklyCopy or stageGroupType == CommonDefine.StageGroupType.WeeklyCopy2 then
    local exModel = WeekBossExtModel and WeekBossExtModel.Instance or nil
    if exModel then
      local stageGroupIdList = CopyDataUtils.GetStageGroupIdList(CommonDefine.StageGroupType.WeekBoss, true) or {}
      exModel:SetStageGroupIdList(stageGroupIdList)
      exModel:SetSelectedStageGroupId(group.groupId)
      UIManager.Instance:Reopen(Urls.DungeonWeekBossSubPanel, group.groupId, exModel.featureId, exModel.stageGroupType, CommonDefine.DBGEntryPage.WeekBossPanel, stageId)
      return
    end
  end
  if stageGroupType then
    DungeonMaterialModel.Instance:SetStageGroupType(stageGroupType)
  end
  DungeonMaterialModel.Instance:SetStageGroupId(group.groupId)
  UIManager.Instance:Reopen(Urls.DungeonMaterailSubView, stageId)
end

function CompGuideNoteAwakerStrengthMaterial:_OnClickMaterialSweep()
  local group = self._groupData
  local sweepStageId = CompGuideNoteAwakerStrengthMaterial._ResolveSweepStageId(group)
  if not (group and sweepStageId) or 0 == sweepStageId then
    return
  end
  local sweepGroupCfg = CopyDataUtils.GetStageGroupConfig(group.groupId)
  local sweepGroupType = sweepGroupCfg and sweepGroupCfg.Type or nil
  if _IsWeeklyStageGroupType(sweepGroupType) and not _IsWeekBossFeatureUnlocked(group.groupId) then
    local unlockTips = _GetWeekBossFeatureUnlockTips(group.groupId)
    Alert.ShowStr(unlockTips)
    return
  end
  if CopyDataUtils and CopyDataUtils.CheckStageGroupIsFeatrueLock and CopyDataUtils.CheckStageGroupIsFeatrueLock(group.groupId) then
    return
  end
  if CopyDataUtils and CopyDataUtils.CheckStageIsUnlocked then
    local isUnlocked, lockReason = CopyDataUtils.CheckStageIsUnlocked(sweepStageId)
    if true ~= isUnlocked then
      if lockReason and "" ~= lockReason and Alert and Alert.ShowStr then
        Alert.ShowStr(lockReason)
      end
      return
    end
  end
  if CopyDataUtils and CopyDataUtils.CheckLevelReach and true ~= CopyDataUtils.CheckLevelReach(sweepStageId) then
    if Alert and Alert.ShowStr then
      Alert.ShowStr(LT.Text("SchoolTowerChallengeNotReachLevelTips"))
    end
    return
  end
  local sweepLimitTimes
  if group and group.groupId and 0 ~= group.groupId then
    local groupCfg = CopyDataUtils.GetStageGroupConfig(group.groupId)
    local stageGroupType = groupCfg and groupCfg.Type or nil
    local isWeeklyStageGroup = _IsWeeklyStageGroupType(stageGroupType)
    if isWeeklyStageGroup then
      sweepLimitTimes = CopyDataUtils.GetWeekBossRewardCnt() or 0
    end
    if isWeeklyStageGroup and sweepLimitTimes <= 0 then
      local tipsCfg = DT.TipsType and DT.TipsType.WeekChallengeSweepTips
      Alert.ShowStr(tipsCfg and tipsCfg.Desc and LT.Text(tipsCfg.Desc) or LT.Text("SweepTipsUnopenTxt"))
      return
    end
  end
  local canSweep, _, tip = CopyDataUtils.IsCanSweepInCondition(sweepStageId)
  if true ~= canSweep then
    if type(tip) == "string" and string.find(tip, "No StageData", 1, true) then
      local isUnlocked, lockReason = CopyDataUtils.CheckStageIsUnlocked(sweepStageId)
      if true ~= isUnlocked and lockReason and "" ~= lockReason and Alert and Alert.ShowStr then
        Alert.ShowStr(lockReason)
      elseif Alert and Alert.ShowStr then
        Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
      end
      return
    end
    if tip and "" ~= tip and Alert and Alert.ShowStr then
      Alert.ShowStr(tip)
    end
    return
  end
  CopyDataUtils.OpenSweepPanel(sweepStageId, nil, sweepLimitTimes)
end

function CompGuideNoteAwakerStrengthMaterial:_SetMaterialButtonsState(canGoto, canSweep)
  local group = self._groupData
  local isCopySource = group and group.noBattle ~= true and group.groupId and 0 ~= group.groupId
  if self.ui and self.ui.Btn_Goto and self:GetButton(self.ui.Btn_Goto) then
    local btnState = true == canGoto and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
    self:SetButtonState(self.ui.Btn_Goto, btnState)
  end
  if self.ui and self.ui.Btn_Sweep then
    self:SetActive(self.ui.Btn_Sweep, true == isCopySource)
    if true == isCopySource and self:GetButton(self.ui.Btn_Sweep) then
      local btnState = true == canSweep and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
      self:SetButtonState(self.ui.Btn_Sweep, btnState)
    end
  end
  self:_RefreshGotoButtonText()
end

function CompGuideNoteAwakerStrengthMaterial._GetSourceItemTid(group)
  local itemList = group and group.itemList or nil
  if type(itemList) ~= "table" then
    return 0
  end
  for _, item in ipairs(itemList) do
    local tid = item and item.tid or 0
    if tid and 0 ~= tid then
      return tid
    end
  end
  return 0
end

function CompGuideNoteAwakerStrengthMaterial:_RefreshGotoButtonText()
  if not self.ui or not self.ui.Btn_Goto then
    return
  end
  local group = self._groupData
  local isSourceMode = group and (group.noBattle == true or not group.groupId or 0 == group.groupId)
  local btnText = isSourceMode and LT.PanelText("UI_Bag_Item_Detail_Text_C_Source") or LT.PanelText("UI_Recharge_Instructions_Text_Name")
  self:SetButtonText(self.ui.Btn_Goto, btnText)
end

function CompGuideNoteAwakerStrengthMaterial:_ClearMaterialIcons()
  for _, comp in ipairs(self._materialIconComps or {}) do
    if comp and comp.binder then
      comp.binder:teardown()
    end
  end
  self._materialIconComps = {}
end

function CompGuideNoteAwakerStrengthMaterial:_RefreshMaterialSlots(itemList)
  self:_ClearMaterialIcons()
  local slots = {
    self.ui and self.ui.Material_1 or nil,
    self.ui and self.ui.Material_2 or nil,
    self.ui and self.ui.Material_3 or nil
  }
  for idx, slotGo in ipairs(slots) do
    if slotGo then
      local info = itemList and itemList[idx] or nil
      local hasIcon = info and info.icon and info.icon ~= ""
      local canShow = info and info.lackNum and info.lackNum > 0 and (info.tid and 0 ~= info.tid or hasIcon)
      slotGo:SetActive(true == canShow)
      if canShow then
        local itemTid = info.tid or 0
        local lackNum = info.lackNum or 0
        local icon = info and info.icon or nil
        local isPreview = info and info.isPreview or nil
        local itemCount = info and (info.itemCount or lackNum) or lackNum
        local itemData = {
          itemTid = itemTid,
          itemCount = itemCount,
          icon = icon,
          isPreview = isPreview
        }
        table.insert(self._materialIconComps, self.binder:BindComponent(CommonIconItemType2(slotGo, itemData)))
      end
    end
  end
end

function CompGuideNoteAwakerStrengthMaterial._CalcMaterialButtonState(group)
  local canGoto = false
  if group then
    if group.noBattle ~= true and group.groupId and 0 ~= group.groupId then
      local groupCfg = CopyDataUtils.GetStageGroupConfig(group.groupId)
      local stageGroupType = groupCfg and groupCfg.Type or nil
      if _IsWeeklyStageGroupType(stageGroupType) and not _IsWeekBossFeatureUnlocked(group.groupId) then
        return false, false
      end
      local gotoStageId = group.gotoStageId or group.stageId or 0
      canGoto = true == CompGuideNoteAwakerStrengthMaterial._CheckGotoStageAvailable(group.groupId, gotoStageId)
    elseif 0 ~= CompGuideNoteAwakerStrengthMaterial._GetSourceItemTid(group) then
      canGoto = true
    end
  end
  local canSweep = false
  local sweepStageId = CompGuideNoteAwakerStrengthMaterial._ResolveSweepStageId(group)
  if canGoto and group and group.noBattle ~= true and sweepStageId and 0 ~= sweepStageId then
    canSweep = CopyDataUtils.IsCanSweepInCondition(sweepStageId)
    if true == canSweep and group.groupId and 0 ~= group.groupId then
      local groupCfg = CopyDataUtils.GetStageGroupConfig(group.groupId)
      local stageGroupType = groupCfg and groupCfg.Type or nil
      if _IsWeeklyStageGroupType(stageGroupType) and (CopyDataUtils.GetWeekBossRewardCnt() or 0) <= 0 then
        canSweep = false
      end
    end
  end
  return true == canGoto, true == canSweep
end

function CompGuideNoteAwakerStrengthMaterial._CheckGotoStageAvailable(stageGroupId, stageId)
  if not stageGroupId or 0 == stageGroupId then
    return false, LT.Text("MainShopSingleBuyConfirmPanel_Lock")
  end
  if CopyDataUtils and CopyDataUtils.IsStageGroupFeatureLocked and CopyDataUtils.IsStageGroupFeatureLocked(stageGroupId) then
    return false, nil
  end
  if not stageId or 0 == stageId then
    return false, LT.Text("MainShopSingleBuyConfirmPanel_Lock")
  end
  if CopyDataUtils and CopyDataUtils.CheckStageIsUnlocked then
    local isUnlocked, lockReason = CopyDataUtils.CheckStageIsUnlocked(stageId)
    if true ~= isUnlocked then
      return false, lockReason
    end
  end
  if CopyDataUtils and CopyDataUtils.CheckLevelReach and true ~= CopyDataUtils.CheckLevelReach(stageId) then
    return false, LT.Text("SchoolTowerChallengeNotReachLevelTips")
  end
  return true
end

function CompGuideNoteAwakerStrengthMaterial._AddNeedItem(needMap, tid, num)
  if tid and 0 ~= tid and num and num > 0 then
    needMap[tid] = (needMap[tid] or 0) + num
  end
end

function CompGuideNoteAwakerStrengthMaterial._CountBreakthroughBoundaries(awakerTid, curLevel, targetLevel)
  local cfg = DT.AwakerBreakThrough and DT.AwakerBreakThrough[math.abs(awakerTid)]
  if not cfg or not cfg.data_list then
    return 0
  end
  local count = 0
  for _, starCfg in ipairs(cfg.data_list) do
    local maxLv = starCfg and starCfg.MaxLevel or 0
    if curLevel < maxLv and targetLevel > maxLv then
      count = count + 1
    end
  end
  return count
end

function CompGuideNoteAwakerStrengthMaterial._CalcOwnedExpBottleAvailableExp(needMap)
end

function CompGuideNoteAwakerStrengthMaterial._AppendLevelNeed(awakerTid, compareData, needMap)
  if compareData.targetLevel <= compareData.curLevel then
    return
  end
  local curAwakerExp = compareData.awaker and compareData.awaker.exp or 0
  local needExp = AwakerDataUtils.GetExpUpgradeEx(awakerTid, compareData.curLevel, compareData.targetLevel) - curAwakerExp
  if needExp <= 0 then
    return
  end
  local ratio = DT.GetConstant("AwakerExpCoinRatio") or 0
  local coinTid = DT.GetConstant("GeneralCultivationNeedCurreny") or 0
  local candidates = CompGuideNoteAwakerStrengthMaterial._GetAvailableExpBottleCandidates()
  if #candidates <= 0 then
    return
  end
  if 0 ~= coinTid and ratio > 0 then
    local billableExp = AwakerDataUtils.CalcLevelUpBillableExp(needExp)
    CompGuideNoteAwakerStrengthMaterial._AddNeedItem(needMap, coinTid, math.floor(billableExp * ratio))
  end
  local remain = needExp
  local allCandidates = CompGuideNoteAwakerStrengthMaterial._BuildAllExpBottleCandidates()
  for _, c in ipairs(allCandidates) do
    local ownNum = ItemDataUtils.GetItemNum(c.tid) or 0
    local reservedNum = needMap[c.tid] or 0
    local availableNum = math.max(0, ownNum - reservedNum)
    local needNum = math.ceil(remain / c.exp)
    if availableNum > 0 and needNum > 0 then
      local useNum = math.min(availableNum, needNum)
      CompGuideNoteAwakerStrengthMaterial._AddNeedItem(needMap, c.tid, useNum)
      remain = remain - useNum * c.exp
    end
  end
  for idx, c in ipairs(candidates) do
    if remain <= 0 then
      break
    end
    local isLast = idx == #candidates
    local cnt = 0
    if isLast then
      cnt = math.ceil(remain / c.exp)
    else
      cnt = math.floor(remain / c.exp)
    end
    if cnt > 0 then
      CompGuideNoteAwakerStrengthMaterial._AddNeedItem(needMap, c.tid, cnt)
      remain = remain - cnt * c.exp
    end
  end
end

function CompGuideNoteAwakerStrengthMaterial._BuildAllExpBottleCandidates()
  local expItemList = DT.GetOriginalConstant("AwakerExpItem") or {}
  local candidates = {}
  for i = 1, #expItemList, 2 do
    local tid = expItemList[i]
    local expValue = expItemList[i + 1] or 0
    if tid and 0 ~= tid and expValue > 0 then
      table.insert(candidates, {tid = tid, exp = expValue})
    end
  end
  table.sort(candidates, function(a, b)
    return (a.exp or 0) > (b.exp or 0)
  end)
  return candidates
end

function CompGuideNoteAwakerStrengthMaterial._IsAnyStageSweepableInGroup(stageGroupId)
  if not stageGroupId or 0 == stageGroupId then
    return false
  end
  for stageTid, stageCfg in pairs(DT.Stage or {}) do
    if stageCfg and stageCfg.BelongGroup == stageGroupId and stageCfg.StageSweep and 0 ~= stageCfg.StageSweep then
      local canSweep = CopyDataUtils.IsCanSweepInCondition(tonumber(stageTid) or 0)
      if true == canSweep then
        return true
      end
    end
  end
  return false
end

function CompGuideNoteAwakerStrengthMaterial._IsStageSweepable(stageTid, stageCfg)
  if not stageTid or 0 == stageTid or not stageCfg then
    return false
  end
  if not stageCfg.StageSweep or 0 == stageCfg.StageSweep then
    return false
  end
  return CopyDataUtils.IsCanSweepInCondition(stageTid) == true
end

function CompGuideNoteAwakerStrengthMaterial._GetBestSweepStageIdInGroup(stageGroupId, preferStageId)
  if preferStageId and 0 ~= preferStageId and CopyDataUtils.IsCanSweepInCondition(preferStageId) == true then
    return preferStageId
  end
  if not stageGroupId or 0 == stageGroupId then
    return preferStageId or 0
  end
  local bestStageId = 0
  local bestSequence = -1
  local bestTid = -1
  for stageTid, stageCfg in pairs(DT.Stage or {}) do
    if stageCfg and stageCfg.BelongGroup == stageGroupId and stageCfg.StageSweep and 0 ~= stageCfg.StageSweep then
      local tid = tonumber(stageTid) or 0
      if CompGuideNoteAwakerStrengthMaterial._IsStageSweepable(tid, stageCfg) then
        local seq = stageCfg.Sequence or 0
        if bestSequence < seq or seq == bestSequence and bestTid < tid then
          bestSequence = seq
          bestTid = tid
          bestStageId = tid
        end
      end
    end
  end
  if 0 ~= bestStageId then
    return bestStageId
  end
  return preferStageId or 0
end

function CompGuideNoteAwakerStrengthMaterial._ResolveSweepStageId(group)
  if not group then
    return 0
  end
  return group.stageId or group.gotoStageId or 0
end

function CompGuideNoteAwakerStrengthMaterial._StageDropsItem(stageCfg, itemTid)
  if not (stageCfg and itemTid) or 0 == itemTid then
    return false
  end
  local dropIds = {}
  CompGuideNoteAwakerStrengthMaterial._CollectDropIds(stageCfg, dropIds)
  for dropId, _ in pairs(dropIds) do
    local itemList = ItemDataUtils.GetDropItemList(dropId) or {}
    for _, dropItemTid in ipairs(itemList) do
      if dropItemTid == itemTid then
        return true
      end
    end
  end
  return false
end

function CompGuideNoteAwakerStrengthMaterial._IsExpBottleCurrentlySweepable(itemTid)
  if not itemTid or 0 == itemTid then
    return false
  end
  local stageGroups = CompGuideNoteAwakerStrengthMaterial._TryBuildItemStageGroups(itemTid)
  if type(stageGroups) ~= "table" or #stageGroups <= 0 then
    return false
  end
  for _, group in ipairs(stageGroups) do
    local groupId = group and group.groupId or 0
    if 0 ~= groupId then
      for stageTid, stageCfg in pairs(DT.Stage or {}) do
        local numStageTid = tonumber(stageTid) or 0
        if stageCfg and stageCfg.BelongGroup == groupId and CompGuideNoteAwakerStrengthMaterial._IsStageSweepable(numStageTid, stageCfg) and CompGuideNoteAwakerStrengthMaterial._StageDropsItem(stageCfg, itemTid) then
          return true
        end
      end
    end
  end
  return false
end

function CompGuideNoteAwakerStrengthMaterial._GetAvailableExpBottleCandidates()
  local allCandidates = CompGuideNoteAwakerStrengthMaterial._BuildAllExpBottleCandidates()
  if #allCandidates <= 0 then
    return {}
  end
  local maxSweepableExp = 0
  for _, c in ipairs(allCandidates) do
    if CompGuideNoteAwakerStrengthMaterial._IsExpBottleCurrentlySweepable(c.tid) then
      maxSweepableExp = math.max(maxSweepableExp, c.exp or 0)
    end
  end
  if maxSweepableExp <= 0 then
    local lowest = allCandidates[#allCandidates]
    if lowest then
      return {lowest}
    end
    return {}
  end
  local availableCandidates = {}
  for _, c in ipairs(allCandidates) do
    if maxSweepableExp >= (c.exp or 0) then
      table.insert(availableCandidates, c)
    end
  end
  return availableCandidates
end

function CompGuideNoteAwakerStrengthMaterial._AppendSkillNeed(awakerTid, compareData, needMap)
  local skills = compareData.skillEntries or {}
  local targetSkillLevels = compareData.targetSkillLevels or {}
  local targetSkillLv = compareData.targetSkill or compareData.targetLevel or 0
  for idx, skill in ipairs(skills) do
    local skillTid = skill and skill.tid or 0
    local level = skill and skill.level or 0
    local oneTargetLv = targetSkillLv
    if type(targetSkillLevels) == "table" and nil ~= targetSkillLevels[idx] then
      oneTargetLv = targetSkillLevels[idx]
    end
    oneTargetLv = oneTargetLv or 0
    if 0 ~= skillTid and level < oneTargetLv and oneTargetLv > 0 then
      local startLv = level
      if startLv <= 0 then
        startLv = 1
      end
      for lv = startLv, oneTargetLv - 1 do
        local itemCost = AwakerDataUtils.GetSkillUpgradeCostItem(awakerTid, skillTid, lv) or {}
        for _, cost in ipairs(itemCost) do
          CompGuideNoteAwakerStrengthMaterial._AddNeedItem(needMap, cost.tid, cost.num)
        end
        local coinCost = AwakerDataUtils.GetSkillUpgradeCoinCost(awakerTid, skillTid, lv) or {}
        CompGuideNoteAwakerStrengthMaterial._AddNeedItem(needMap, coinCost.tid, coinCost.num)
      end
    end
  end
end

function CompGuideNoteAwakerStrengthMaterial._AppendLimitIncreaseNeed(awakerTid, needMap)
  local costItems = AwakerDataUtils.GetCostItemsWithoutGold(awakerTid) or {}
  for _, cost in ipairs(costItems) do
    CompGuideNoteAwakerStrengthMaterial._AddNeedItem(needMap, cost.tid, cost.num)
  end
  CompGuideNoteAwakerStrengthMaterial._AddNeedItem(needMap, DT.GetConstant("GoldItemTid") or 0, AwakerDataUtils.GetGoldCostNum(awakerTid) or 0)
end

function CompGuideNoteAwakerStrengthMaterial._GetAwakerTalentCfgList(awakerTid)
  if not awakerTid or 0 == awakerTid or not DT.AwakerTalent then
    return {}
  end
  local list = {}
  for _, cfg in pairs(DT.AwakerTalent) do
    local firstCfg = cfg and cfg.data_list and cfg.data_list[1]
    if firstCfg and firstCfg.AwakerID == awakerTid then
      table.insert(list, cfg)
    end
  end
  table.sort(list, function(a, b)
    local aSort = tonumber(a and a.BaseSortID) or 0
    local bSort = tonumber(b and b.BaseSortID) or 0
    if aSort ~= bSort then
      return aSort < bSort
    end
    return (tonumber(a and a.ID) or 0) < (tonumber(b and b.ID) or 0)
  end)
  return list
end

function CompGuideNoteAwakerStrengthMaterial._CheckTaskListDone(taskList)
  if type(taskList) ~= "table" or #taskList <= 0 then
    return true
  end
  if TaskDataUtils and TaskDataUtils.CheckTaskListIsAllDone then
    return TaskDataUtils.CheckTaskListIsAllDone(taskList) == true
  end
  return false
end

function CompGuideNoteAwakerStrengthMaterial._AppendNeedFromRequireItem(requireItem, needMap)
  if type(requireItem) ~= "table" then
    return
  end
  if #requireItem > 0 then
    for i = 1, #requireItem, 2 do
      local tid = tonumber(requireItem[i]) or 0
      local num = tonumber(requireItem[i + 1]) or 0
      CompGuideNoteAwakerStrengthMaterial._AddNeedItem(needMap, tid, num)
    end
    return
  end
  for tid, num in pairs(requireItem) do
    CompGuideNoteAwakerStrengthMaterial._AddNeedItem(needMap, tonumber(tid) or 0, tonumber(num) or 0)
  end
end

function CompGuideNoteAwakerStrengthMaterial._AppendAllAwakerTalentNeed(awakerTid, needMap)
  local talentCfgList = CompGuideNoteAwakerStrengthMaterial._GetAwakerTalentCfgList(awakerTid)
  if #talentCfgList <= 0 then
    return
  end
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awaker then
    return
  end
  for _, talentCfg in ipairs(talentCfgList) do
    local talentTid = talentCfg and talentCfg.ID or 0
    if 0 ~= talentTid then
      local curLv = 0
      if awaker.talents and awaker.talents[talentTid] and awaker.talents[talentTid].lv then
        curLv = tonumber(awaker.talents[talentTid].lv) or 0
      end
      local maxLv = #(talentCfg.data_list or {})
      for lv = curLv + 1, maxLv do
        local cfg = talentCfg.data_list[lv]
        if not cfg then
          break
        end
        local isTaskDone = CompGuideNoteAwakerStrengthMaterial._CheckTaskListDone(cfg.TaskCondition) == true
        if true ~= isTaskDone then
          break
        end
        CompGuideNoteAwakerStrengthMaterial._AppendNeedFromRequireItem(cfg.RequireItem, needMap)
      end
    end
  end
end

function CompGuideNoteAwakerStrengthMaterial._SortNeedList(needList)
  table.sort(needList, function(a, b)
    local aCfg = ItemDataUtils.GetItemConfig(a.tid)
    local bCfg = ItemDataUtils.GetItemConfig(b.tid)
    local aSubType = aCfg and aCfg.SubType or ""
    local bSubType = bCfg and bCfg.SubType or ""
    local aOrder = ITEM_SUBTYPE_ORDER[aSubType] or 0
    local bOrder = ITEM_SUBTYPE_ORDER[bSubType] or 0
    if aOrder ~= bOrder then
      return aOrder > bOrder
    end
    local aQuality = ItemDataUtils.GetQualitySortValue(a.tid) or 0
    local bQuality = ItemDataUtils.GetQualitySortValue(b.tid) or 0
    if aQuality ~= bQuality then
      return aQuality > bQuality
    end
    return (a.tid or 0) < (b.tid or 0)
  end)
end

function CompGuideNoteAwakerStrengthMaterial.BuildNeedList(awakerTid, compareData, excludeTalent, includeLimitIncreaseNeed)
  local needMap = {}
  local breakthroughNeedMap = compareData.breakthroughNeedMap
  if type(breakthroughNeedMap) == "table" then
    for tid, lackNum in pairs(breakthroughNeedMap) do
      CompGuideNoteAwakerStrengthMaterial._AddNeedItem(needMap, tid, lackNum)
    end
  end
  CompGuideNoteAwakerStrengthMaterial._AppendSkillNeed(awakerTid, compareData, needMap)
  if true ~= excludeTalent then
    CompGuideNoteAwakerStrengthMaterial._AppendAllAwakerTalentNeed(awakerTid, needMap)
  end
  CompGuideNoteAwakerStrengthMaterial._AppendLevelNeed(awakerTid, compareData, needMap)
  local needMapSize = 0
  for _ in pairs(needMap) do
    needMapSize = needMapSize + 1
  end
  local parts = {}
  for tid, needNum in pairs(needMap) do
    table.insert(parts, string.format("%s:%s", tostring(tid), tostring(needNum)))
  end
  local needList = {}
  local lackDebugParts = {}
  for tid, needNum in pairs(needMap) do
    local ownNum = ItemDataUtils.GetItemNum(tid) or 0
    local lackNum = math.max(0, needNum - ownNum)
    table.insert(lackDebugParts, string.format("tid=%s need=%s own=%s lack=%s", tostring(tid), tostring(needNum), tostring(ownNum), tostring(lackNum)))
    if lackNum > 0 then
      table.insert(needList, {
        tid = tid,
        needNum = needNum,
        ownNum = ownNum,
        lackNum = lackNum
      })
    end
  end
  CompGuideNoteAwakerStrengthMaterial._SortNeedList(needList)
  return needList
end

function CompGuideNoteAwakerStrengthMaterial._CollectDropIds(v, dropIds)
  if type(v) == "number" then
    if DT.Drop[v] then
      dropIds[v] = true
    end
    return
  end
  if type(v) ~= "table" then
    return
  end
  for k, sub in pairs(v) do
    local key = tostring(k or "")
    if string.find(key, "Drop") then
      CompGuideNoteAwakerStrengthMaterial._CollectDropIds(sub, dropIds)
    elseif type(sub) == "table" or type(sub) == "number" then
      CompGuideNoteAwakerStrengthMaterial._CollectDropIds(sub, dropIds)
    end
  end
end

function CompGuideNoteAwakerStrengthMaterial._TryBuildItemStageGroups(itemTid)
  local itemCfg = ItemDataUtils.GetItemConfig(itemTid)
  if not itemCfg then
    return {}
  end
  local farmableStageGroup = itemCfg.FarmableStageGroup
  if not farmableStageGroup or 0 == farmableStageGroup then
    return {}
  end
  local groups = {}
  if type(farmableStageGroup) == "number" then
    local groupId = tonumber(farmableStageGroup) or 0
    if 0 ~= groupId then
      local gotoStageId = CompGuideNoteAwakerStrengthMaterial._GetBestStageIdsByStageGroupId(groupId)
      table.insert(groups, {
        groupId = groupId,
        bestStageId = gotoStageId or 0,
        stageId = gotoStageId or 0,
        gotoStageId = gotoStageId or 0
      })
    end
  elseif type(farmableStageGroup) == "table" then
    for _, groupId in ipairs(farmableStageGroup) do
      groupId = tonumber(groupId) or 0
      if 0 ~= groupId then
        local gotoStageId = CompGuideNoteAwakerStrengthMaterial._GetBestStageIdsByStageGroupId(groupId)
        table.insert(groups, {
          groupId = groupId,
          bestStageId = gotoStageId or 0,
          stageId = gotoStageId or 0,
          gotoStageId = gotoStageId or 0
        })
      end
    end
  end
  return groups
end

function CompGuideNoteAwakerStrengthMaterial._GetBestStageIdsByStageGroupId(stageGroupId)
  if not stageGroupId or 0 == stageGroupId then
    return 0
  end
  local bestGotoStageId = 0
  local bestGotoStageLv = -1
  local bestGotoSequence = -1
  local bestGotoTid = -1
  local fallbackStageId = 0
  local fallbackStageLv = -1
  local fallbackSequence = -1
  local fallbackTid = -1
  
  local function IsCandidateBetter(stageLvA, seqA, tidA, stageLvB, seqB, tidB)
    if stageLvA ~= stageLvB then
      return stageLvB < stageLvA
    end
    if seqA ~= seqB then
      return seqB < seqA
    end
    return tidB < tidA
  end
  
  for stageTid, stageCfg in pairs(DT.Stage or {}) do
    if stageCfg and stageCfg.BelongGroup and stageCfg.BelongGroup == stageGroupId and stageCfg.StageSweep and 0 ~= stageCfg.StageSweep then
      local tid = tonumber(stageTid) or 0
      local stageLv = stageCfg.PlayerLevel or stageCfg.StageLevel or 0
      local seq = stageCfg.Sequence or 0
      if IsCandidateBetter(stageLv, seq, tid, fallbackStageLv, fallbackSequence, fallbackTid) then
        fallbackStageLv = stageLv
        fallbackSequence = seq
        fallbackTid = tid
        fallbackStageId = tid
      end
      local isUnlocked = CopyDataUtils.CheckStageIsUnlocked(tid) == true and true == CopyDataUtils.CheckLevelReach(tid)
      if true == isUnlocked and IsCandidateBetter(stageLv, seq, tid, bestGotoStageLv, bestGotoSequence, bestGotoTid) then
        bestGotoStageLv = stageLv
        bestGotoSequence = seq
        bestGotoTid = tid
        bestGotoStageId = tid
      end
    end
  end
  if 0 == bestGotoStageId then
    bestGotoStageId = fallbackStageId
  end
  return bestGotoStageId
end

function CompGuideNoteAwakerStrengthMaterial._GetBestStageIdByStageGroupId(stageGroupId)
  local gotoStageId = CompGuideNoteAwakerStrengthMaterial._GetBestStageIdsByStageGroupId(stageGroupId)
  return gotoStageId or 0
end

function CompGuideNoteAwakerStrengthMaterial._ParseFarmableStageGroupIds(rawVal)
  local ids = {}
  if type(rawVal) == "number" then
    local id = tonumber(rawVal) or 0
    if 0 ~= id then
      table.insert(ids, id)
    end
    return ids
  end
  if type(rawVal) == "table" then
    for _, v in ipairs(rawVal) do
      local id = tonumber(v) or 0
      if 0 ~= id then
        table.insert(ids, id)
      end
    end
    return ids
  end
  if type(rawVal) == "string" and "" ~= rawVal then
    for num in string.gmatch(rawVal, "%d+") do
      local id = tonumber(num) or 0
      if 0 ~= id then
        table.insert(ids, id)
      end
    end
  end
  return ids
end

function CompGuideNoteAwakerStrengthMaterial.BuildRecommendTrinketAcquireGroups(awakerTid)
  if not awakerTid or 0 == awakerTid then
    return {}
  end
  local awakerCfg = DT.AwakerConfig and DT.AwakerConfig[awakerTid] or nil
  if not awakerCfg or not awakerCfg.RecommendTrinket then
    return {}
  end
  local suitTids = awakerCfg.RecommendTrinket
  if not suitTids or #suitTids <= 0 then
    return {}
  end
  local groupMap = {}
  local groups = {}
  local fallbackKeyPrefix = "TrinketRecommendFallback"
  for _, suitTid in ipairs(suitTids) do
    local suitCfg = DT.TrinketSuitEffect and DT.TrinketSuitEffect[suitTid] or nil
    if suitCfg then
      local boxTid = suitCfg.TrinketSuitBox or 0
      local suitIcon = suitCfg.Icon or AwakerTrinketDataUtils.GetSuitIcon(suitTid)
      local suitName = AwakerTrinketDataUtils.GetSuitName(suitTid)
      local item = {
        tid = boxTid,
        itemCount = 0,
        lackNum = 1,
        isPreview = true,
        icon = suitIcon,
        suitTid = suitTid,
        suitName = suitName
      }
      local stageGroupIds = CompGuideNoteAwakerStrengthMaterial._ParseFarmableStageGroupIds(suitCfg.FarmableStageGroup)
      if #stageGroupIds <= 0 and boxTid and 0 ~= boxTid then
        local boxStageGroups = CompGuideNoteAwakerStrengthMaterial._TryBuildItemStageGroups(boxTid)
        for _, g in ipairs(boxStageGroups) do
          local gid = g and g.groupId or 0
          if 0 ~= gid then
            table.insert(stageGroupIds, gid)
          end
        end
      end
      if #stageGroupIds > 0 then
        local uniqueStageGroupIds = {}
        local uniqueStageGroupIdMap = {}
        for _, gid in ipairs(stageGroupIds) do
          gid = tonumber(gid) or 0
          if 0 ~= gid and true ~= uniqueStageGroupIdMap[gid] then
            uniqueStageGroupIdMap[gid] = true
            table.insert(uniqueStageGroupIds, gid)
          end
        end
        for _, farmableStageGroupId in ipairs(uniqueStageGroupIds) do
          local key = tostring(farmableStageGroupId)
          if not groupMap[key] then
            local gotoStageId = CompGuideNoteAwakerStrengthMaterial._GetBestStageIdsByStageGroupId(farmableStageGroupId)
            groupMap[key] = {
              groupId = farmableStageGroupId,
              stageId = gotoStageId or 0,
              gotoStageId = gotoStageId or 0,
              itemList = {},
              noBattle = false,
              groupType = "TrinketRecommend"
            }
            table.insert(groups, groupMap[key])
          end
          local group = groupMap[key]
          table.insert(group.itemList, item)
        end
      else
        local fallbackKey = fallbackKeyPrefix .. "_" .. suitTid
        if not groupMap[fallbackKey] then
          groupMap[fallbackKey] = {
            groupId = 0,
            stageId = 0,
            itemList = {},
            noBattle = true,
            groupType = "TrinketRecommend"
          }
          table.insert(groups, groupMap[fallbackKey])
        end
        local group = groupMap[fallbackKey]
        table.insert(group.itemList, item)
      end
    end
  end
  return groups
end

function CompGuideNoteAwakerStrengthMaterial._AddPrefetchStageGroupId(ids, added, stageGroupId)
  local id = tonumber(stageGroupId) or 0
  if not (0 ~= id and ids and added) or added[id] then
    return
  end
  added[id] = true
  table.insert(ids, id)
end

function CompGuideNoteAwakerStrengthMaterial.CollectPrefetchStageGroupIds(acquireGroups)
  local ids = {}
  local added = {}
  for _, group in ipairs(acquireGroups or {}) do
    CompGuideNoteAwakerStrengthMaterial._AddPrefetchStageGroupId(ids, added, group and group.groupId)
  end
  local bottles = CompGuideNoteAwakerStrengthMaterial._BuildAllExpBottleCandidates()
  for _, candidate in ipairs(bottles) do
    local stageGroups = CompGuideNoteAwakerStrengthMaterial._TryBuildItemStageGroups(candidate and candidate.tid)
    for _, stageGroup in ipairs(stageGroups or {}) do
      CompGuideNoteAwakerStrengthMaterial._AddPrefetchStageGroupId(ids, added, stageGroup and stageGroup.groupId)
    end
  end
  return ids
end

function CompGuideNoteAwakerStrengthMaterial.BuildAcquireGroups(needList)
  if type(needList) ~= "table" or #needList <= 0 then
    return {
      {
        groupId = 0,
        stageId = 0,
        itemList = {},
        noBattle = true
      }
    }
  end
  local groupMap = {}
  for _, item in ipairs(needList or {}) do
    local stageGroups = CompGuideNoteAwakerStrengthMaterial._TryBuildItemStageGroups(item.tid)
    if 0 == #stageGroups then
      local gid = -item.tid
      groupMap[gid] = groupMap[gid] or {
        groupId = 0,
        stageId = 0,
        itemList = {},
        noBattle = true
      }
      table.insert(groupMap[gid].itemList, item)
    else
      for _, g in ipairs(stageGroups) do
        local gid = g.groupId
        groupMap[gid] = groupMap[gid] or {
          groupId = gid,
          stageId = g.gotoStageId or g.bestStageId or 0,
          gotoStageId = g.gotoStageId or g.bestStageId or 0,
          itemList = {},
          noBattle = false
        }
        table.insert(groupMap[gid].itemList, item)
      end
    end
  end
  local groups = {}
  for _, group in pairs(groupMap) do
    local groupSubTypeOrderMax = 0
    
    local function getSubTypeOrder(tid)
      local cfg = ItemDataUtils.GetItemConfig(tid)
      local subType = cfg and cfg.SubType or ""
      return ITEM_SUBTYPE_ORDER[subType] or 0
    end
    
    table.sort(group.itemList, function(a, b)
      local aOrder = getSubTypeOrder(a.tid)
      local bOrder = getSubTypeOrder(b.tid)
      if aOrder ~= bOrder then
        return aOrder > bOrder
      end
      local qa = ItemDataUtils.GetQualitySortValue(a.tid) or 0
      local qb = ItemDataUtils.GetQualitySortValue(b.tid) or 0
      if qa ~= qb then
        return qa > qb
      end
      return (a.tid or 0) < (b.tid or 0)
    end)
    for _, it in ipairs(group.itemList) do
      local o = getSubTypeOrder(it.tid)
      if groupSubTypeOrderMax < o then
        groupSubTypeOrderMax = o
      end
    end
    group._sortSubTypeOrder = groupSubTypeOrderMax
    table.insert(groups, group)
  end
  table.sort(groups, function(a, b)
    local ao = a._sortSubTypeOrder or 0
    local bo = b._sortSubTypeOrder or 0
    if ao ~= bo then
      return ao > bo
    end
    return (a.groupId or 0) < (b.groupId or 0)
  end)
  return groups
end

return CompGuideNoteAwakerStrengthMaterial
