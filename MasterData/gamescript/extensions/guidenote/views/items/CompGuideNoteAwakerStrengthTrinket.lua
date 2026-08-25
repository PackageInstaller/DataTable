local CompGuideNoteAwakerStrengthTrinket, Super = NewViewComponent("CompGuideNoteAwakerStrengthTrinket")
local AwakerTrinketDataUtils = require("Data.AwakerTrinketDataUtils")
local LT = require("System.LangTable")

local function _IsWeeklyStageGroupType(stageGroupType)
  return stageGroupType == CommonDefine.StageGroupType.WeekBoss or stageGroupType == CommonDefine.StageGroupType.WeeklyCopy or stageGroupType == CommonDefine.StageGroupType.WeeklyCopy2
end

function CompGuideNoteAwakerStrengthTrinket:ctor(uiNode, view, groupData)
  Super.ctor(self, uiNode, view)
  self.ui = UIBaseResource(uiNode)
  self._groupData = groupData
  self._firstItem = nil
  self._copyJumpRequesting = false
end

function CompGuideNoteAwakerStrengthTrinket:RegisterEvents()
  if self.ui and self.ui.Btn_Source then
    self:AddButtonClickListener(self.ui.Btn_Source, System.fn(self, self._OnClickSource))
  end
  if self.ui and self.ui.Btn_Goto then
    self:AddButtonClickListener(self.ui.Btn_Goto, System.fn(self, self._OnClickGoto))
  end
  if self.ui and self.ui.Btn_Sweep then
    self:AddButtonClickListener(self.ui.Btn_Sweep, System.fn(self, self._OnClickSweep))
  end
end

function CompGuideNoteAwakerStrengthTrinket:OnEnterComponent()
  self:_RefreshByGroup(self._groupData)
end

function CompGuideNoteAwakerStrengthTrinket:OnRefreshComponent(groupData)
  self._groupData = groupData
  self:_RefreshByGroup(groupData)
end

function CompGuideNoteAwakerStrengthTrinket:_RefreshByGroup(groupData)
  local group = groupData
  local itemList = group and group.itemList or {}
  self._firstItem = itemList and itemList[1] or nil
  local item = self._firstItem
  local suitIcon = item and item.icon or nil
  local suitName = item and item.suitName or ""
  if (not suitName or "" == suitName) and item and item.suitTid then
    suitName = AwakerTrinketDataUtils.GetSuitName(item.suitTid) or ""
  end
  if self.ui and self.ui.Icon_Trinket then
    local showIcon = suitIcon and "" ~= suitIcon
    self:SetActive(self.ui.Icon_Trinket, true == showIcon)
    if true == showIcon then
      self:SetImageSync(self.ui.Icon_Trinket, suitIcon)
    end
  end
  if self.ui and self.ui.Text_Trinket_Name then
    self:SetText(self.ui.Text_Trinket_Name, suitName)
  end
  local showDouble = false
  if group and true ~= group.noBattle and group.groupId and 0 ~= group.groupId and ActivityManager and ActivityManager.Instance and ActivityManager.Instance.CheckDoubleOutputEffect and ActivityManager.Instance:CheckDoubleOutputEffect(group.groupId) then
    showDouble = true
  end
  if self.ui and self.ui.Tag then
    self:SetActive(self.ui.Tag, true == showDouble)
  end
  local isCopySource = group and true ~= group.noBattle and group.groupId and 0 ~= group.groupId
  self:_RefreshButtonsVisibility(true == isCopySource, group)
end

function CompGuideNoteAwakerStrengthTrinket:_RefreshButtonsVisibility(isCopySource, group)
  if self.ui and self.ui.Btn_Source then
    self:SetActive(self.ui.Btn_Source, true ~= isCopySource)
    if true ~= isCopySource then
      local item = self._firstItem
      local tid = item and item.tid or 0
      local canClick = nil ~= tid and 0 ~= tid
      local btnState = true == canClick and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
      self:SetButtonState(self.ui.Btn_Source, btnState)
    end
  end
  if self.ui and self.ui.Btn_Goto then
    self:SetActive(self.ui.Btn_Goto, true == isCopySource)
    if true == isCopySource then
      local canGoto = self:_CheckCanGoto(group)
      local btnState = true == canGoto and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
      self:SetButtonState(self.ui.Btn_Goto, btnState)
    end
  end
  if self.ui and self.ui.Btn_Sweep then
    self:SetActive(self.ui.Btn_Sweep, true == isCopySource)
    if true == isCopySource then
      local canSweep = self:_CheckCanSweep(group)
      local btnState = true == canSweep and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
      self:SetButtonState(self.ui.Btn_Sweep, btnState)
    end
  end
end

function CompGuideNoteAwakerStrengthTrinket:_CheckCanGoto(group)
  if not self:_IsFeatureTrinketOpen() then
    return false
  end
  if not (group and group.groupId) or 0 == group.groupId then
    return false
  end
  if self:_CheckWeeklyStageGroupUnlocked(group) ~= true then
    return false
  end
  if CopyDataUtils and CopyDataUtils.IsStageGroupFeatureLocked and CopyDataUtils.IsStageGroupFeatureLocked(group.groupId) then
    return false
  end
  local stageId = self:_GetTargetStageId(group)
  if 0 == stageId then
    return false
  end
  if CopyDataUtils and CopyDataUtils.CheckStageIsUnlocked then
    local isUnlocked = CopyDataUtils.CheckStageIsUnlocked(stageId)
    if true ~= isUnlocked then
      return false
    end
  end
  if CopyDataUtils and CopyDataUtils.CheckLevelReach and true ~= CopyDataUtils.CheckLevelReach(stageId) then
    return false
  end
  return true
end

function CompGuideNoteAwakerStrengthTrinket:_GetTargetStageId(group)
  if not group then
    return 0
  end
  return group.gotoStageId or 0
end

function CompGuideNoteAwakerStrengthTrinket:_IsFeatureTrinketOpen()
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketCopy, 0)
  return unlock
end

function CompGuideNoteAwakerStrengthTrinket:_CheckWeeklyStageGroupUnlocked(group)
  if not (group and group.groupId) or 0 == group.groupId then
    return true
  end
  local groupCfg = CopyDataUtils.GetStageGroupConfig(group.groupId)
  local stageGroupType = groupCfg and groupCfg.Type or nil
  if not _IsWeeklyStageGroupType(stageGroupType) then
    return true
  end
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.WeekBossChallenge, group.groupId)
  return true == unlocked
end

function CompGuideNoteAwakerStrengthTrinket:_ShowWeekBossFeatureLockTips(group)
  local groupId = group and group.groupId or 0
  local featureId = CommonDefine.FeatureId.WeekBossChallenge
  local data = PlayerDataUtils.GetFeatureUnlockData(featureId, groupId)
  local tipText
  if data and data.cfg and data.cfg.LockTip then
    tipText = LT.Text(data.cfg.LockTip)
  else
    tipText = PlayerDataUtils.GetFeatureLogicUnlockTips(featureId, 0)
  end
  if tipText then
    Alert.ShowStr(tipText)
  end
end

function CompGuideNoteAwakerStrengthTrinket:_ShowFeatureTrinketLockTips()
  local tipText = PlayerDataUtils.GetFeatureLogicUnlockTips(CommonDefine.FeatureId.TrinketCopy, 0)
  if not tipText then
    return
  end
  Alert.ShowStr(tipText)
end

function CompGuideNoteAwakerStrengthTrinket:_CheckCanSweep(group)
  if not self:_IsFeatureTrinketOpen() then
    return false
  end
  if not (group and group.stageId) or 0 == group.stageId then
    return false
  end
  if self:_CheckWeeklyStageGroupUnlocked(group) ~= true then
    return false
  end
  local sweepStageId = CompGuideNoteAwakerStrengthMaterial._ResolveSweepStageId(group)
  if not sweepStageId or 0 == sweepStageId then
    return false
  end
  if CopyDataUtils and CopyDataUtils.IsCanSweepInCondition then
    local canSweep = CopyDataUtils.IsCanSweepInCondition(sweepStageId)
    if true == canSweep and group.groupId and 0 ~= group.groupId then
      local groupCfg = CopyDataUtils.GetStageGroupConfig(group.groupId)
      local stageGroupType = groupCfg and groupCfg.Type or nil
      if _IsWeeklyStageGroupType(stageGroupType) and (CopyDataUtils.GetWeekBossRewardCnt() or 0) <= 0 then
        return false
      end
    end
    return true == canSweep
  end
  return false
end

function CompGuideNoteAwakerStrengthTrinket:_OnClickSource()
  local item = self._firstItem
  local boxTid = item and item.tid or 0
  if boxTid and 0 ~= boxTid then
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Source, nil, boxTid, true)
  end
end

function CompGuideNoteAwakerStrengthTrinket:_IsComponentAlive()
  return self.view ~= nil and nil ~= self.ui
end

function CompGuideNoteAwakerStrengthTrinket:_EnsureStageDataThen(groupId, stageId, onReady)
  if self._copyJumpRequesting then
    return
  end
  if CopyDataUtils.GetStageData(groupId, stageId) then
    onReady()
    return
  end
  self._copyJumpRequesting = true
  CopyDataUtils.ReqCopyData(nil, groupId, function()
    self._copyJumpRequesting = false
    if not self:_IsComponentAlive() then
      return
    end
    if not CopyDataUtils.GetStageData(groupId, stageId) then
      return
    end
    onReady()
  end)
end

function CompGuideNoteAwakerStrengthTrinket:_ShowStageLockTips(stageId, lockReason)
  if not Alert or not Alert.ShowStr then
    return
  end
  if lockReason and "" ~= lockReason then
    Alert.ShowStr(lockReason)
    return
  end
  local lockTip
  if CopyDataUtils and CopyDataUtils.GetStageUnlockTip then
    lockTip = CopyDataUtils.GetStageUnlockTip(stageId)
  end
  Alert.ShowStr(lockTip or LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
end

function CompGuideNoteAwakerStrengthTrinket:_OnClickGoto()
  if not self:_IsFeatureTrinketOpen() then
    self:_ShowFeatureTrinketLockTips()
    return
  end
  local group = self._groupData
  if not (group and group.groupId) or 0 == group.groupId then
    return
  end
  if self:_CheckWeeklyStageGroupUnlocked(group) ~= true then
    self:_ShowWeekBossFeatureLockTips(group)
    return
  end
  if CopyDataUtils and CopyDataUtils.CheckStageGroupIsFeatrueLock and CopyDataUtils.CheckStageGroupIsFeatrueLock(group.groupId) then
    return
  end
  local groupCfg = CopyDataUtils.GetStageGroupConfig(group.groupId)
  local stageGroupType = groupCfg and groupCfg.Type or nil
  local stageId = self:_GetTargetStageId(group)
  print(string.format("[GuideNoteAwakerStrengthDebug] ClickGoto groupId=%s stageId=%s rawStageId=%s rawGotoStageId=%s", tostring(group.groupId), tostring(stageId), tostring(group.stageId), tostring(group.gotoStageId)))
  if 0 == stageId then
    if Alert and Alert.ShowStr then
      Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
    end
    return
  end
  local isUnlocked, lockReason = CopyDataUtils.CheckStageIsUnlocked(stageId)
  if true ~= isUnlocked then
    self:_ShowStageLockTips(stageId, lockReason)
    return
  end
  if CopyDataUtils.CheckLevelReach and true ~= CopyDataUtils.CheckLevelReach(stageId) then
    if Alert and Alert.ShowStr then
      Alert.ShowStr(LT.Text("SchoolTowerChallengeNotReachLevelTips"))
    end
    return
  end
  self:_EnsureStageDataThen(group.groupId, stageId, function()
    self:_OpenGotoPanel(group, stageGroupType, stageId)
  end)
end

function CompGuideNoteAwakerStrengthTrinket:_OpenGotoPanel(group, stageGroupType, stageId)
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

function CompGuideNoteAwakerStrengthTrinket:_OnClickSweep()
  if not self:_IsFeatureTrinketOpen() then
    self:_ShowFeatureTrinketLockTips()
    return
  end
  local group = self._groupData
  local sweepStageId = CompGuideNoteAwakerStrengthMaterial._ResolveSweepStageId(group)
  if not (group and sweepStageId) or 0 == sweepStageId then
    return
  end
  if self:_CheckWeeklyStageGroupUnlocked(group) ~= true then
    self:_ShowWeekBossFeatureLockTips(group)
    return
  end
  if CopyDataUtils and CopyDataUtils.CheckStageGroupIsFeatrueLock and CopyDataUtils.CheckStageGroupIsFeatrueLock(group.groupId) then
    return
  end
  local isUnlocked, lockReason = CopyDataUtils.CheckStageIsUnlocked(sweepStageId)
  if true ~= isUnlocked then
    self:_ShowStageLockTips(sweepStageId, lockReason)
    return
  end
  if CopyDataUtils.CheckLevelReach and true ~= CopyDataUtils.CheckLevelReach(sweepStageId) then
    if Alert and Alert.ShowStr then
      Alert.ShowStr(LT.Text("SchoolTowerChallengeNotReachLevelTips"))
    end
    return
  end
  self:_EnsureStageDataThen(group.groupId, sweepStageId, function()
    self:_OpenSweepPanel(group, sweepStageId)
  end)
end

function CompGuideNoteAwakerStrengthTrinket:_OpenSweepPanel(group, sweepStageId)
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
    if tip and "" ~= tip and Alert and Alert.ShowStr then
      Alert.ShowStr(tip)
    end
    return
  end
  CopyDataUtils.OpenSweepPanel(sweepStageId, nil, sweepLimitTimes)
end

return CompGuideNoteAwakerStrengthTrinket
