local UIAnimationController = CS.Z1Client.UIAnimationController
local StageGroupType = CommonDefine.StageGroupType
local StageGroupHardModeIndex = CommonDefine.StageGroupHardModeIndex
local SMALL_GROUP_TYPE = 1
local LARGE_GROUP_TYPE = 2
local SubplotGroupPanel, Super = System.NewClass("SubplotGroupPanel", UIBasePanel)
SubplotGroupPanel.uiResCls = UI_Chapter_Panel_SpurResource

function SubplotGroupPanel:ctor(stageGroupTid)
  Super.ctor(self)
  self.stageGroupTid = stageGroupTid
  self.stageList = {}
  self.activityTimer = nil
  self.hardIndex2Difficult = {
    [StageGroupHardModeIndex.Normal] = {
      StageGroupType.SmallSubplotNormal,
      StageGroupType.LargeSubplotNormal
    },
    [StageGroupHardModeIndex.Hard] = {
      StageGroupType.SmallSubplotHard,
      StageGroupType.LargeSubplotHard
    },
    [StageGroupHardModeIndex.Crazy] = {
      StageGroupType.SmallSubplotCrazy,
      StageGroupType.LargeSubplotCrazy
    }
  }
end

function SubplotGroupPanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(SubplotGroupModel, self.stageGroupTid)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.uiAnimControllerDiffcult = self.ui.Bg:GetComponent(typeof(UIAnimationController))
  binder:BindToText(self.ui.Text_Gamecopy_Name, System.fn(self, self._GetGroupName))
  binder:BindToText(self.ui.Text_Extent, System.fn(self, self._GetCurrStageGroupStar))
  binder:BindToText(self.ui.Text_Originally, System.fn(self, self._GetCurrStageGroupTotalStar))
  binder:BindToText(self.ui.Text_Description, System.fn(self, self._GetStageGroupDesc))
  binder:BindToImage(self.ui.Image_SScene_BG, System.fn(self, self._GetBackgroundImage))
  binder:BindToVisible(self.ui.Group_Tab_Special, System.fn(self, self._HasOpeningActivity))
  binder:BindToVisible(self.ui.Image_Progress, System.fn(self, self._HasStarPrize))
  binder:BindButtonClick(self.ui.Btn_Progress_1, System.fn(self, self._OnClickStarPrize))
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GetStageList), System.fn(self, self._UpdateStageItem))
  self:_BindActivityTimer(binder)
  self:_BindAchievementGroup(binder)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, System.fn(self, self._RedFunc)))
  self:_BindToggles(binder)
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, System.fn(self, self.Close)))
  binder:BindToRaw(function(childBinder, nVal)
    if not nVal then
      return
    end
    childBinder:SetActive(self.ui.ScrollView, false)
    childBinder:BindTimer(0.01, 0, nil, function()
      childBinder:SetActive(self.ui.ScrollView, true)
      childBinder:CircularScrollTo(self.ui.ScrollView, #self.stageList)
    end)
  end, function()
    return self.model.curGroupTid
  end)
  self:_BindPortraitComp(binder)
  self.uiAnimController:PlayState("UI_Chapter_Panel_Spur_Open")
end

function SubplotGroupPanel:_BindPortraitComp(binder)
  if not self.model or not self.model.curGroupTid then
    return
  end
  local stageGroupTid = self.model.curGroupTid
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if not stageGroupConfig then
    return
  end
  local awakerTid = stageGroupConfig.RelatedAwaker
  if not self.awakerPortraitComp then
    local portraitAlign = CommonDefine.PortraitAlign.Center
    self.awakerPortraitComp = binder:BindComponent(AwakerPortraitComp(self.ui.Image_Awaker, awakerTid, nil, nil, portraitAlign))
  else
    self.awakerPortraitComp:ChangeAwakerTid(awakerTid)
  end
end

function SubplotGroupPanel:_BindToggles(binder)
  binder:BindToZ1Toggle(self.ui.Toggle_Simple, nil, function(isOn)
    local groupType = self:_GetGroupTypeByHardIndex(StageGroupHardModeIndex.Normal)
    self:_SetStageGroupTidByToggle(isOn, groupType)
  end, function()
    local groupType = StageGroupType.SmallSubplotNormal
    if self.model.isLarge then
      groupType = StageGroupType.LargeSubplotNormal
    end
    return self.model.difficult == groupType
  end, nil, function()
    local groupType = self:_GetGroupTypeByHardIndex(StageGroupHardModeIndex.Normal)
    local groupTid = self.model.difficult2Group[groupType]
    local isLocked = self:_IsGroupLock(groupTid)
    return isLocked
  end, function()
    self:_OnClickLockedToggle(StageGroupHardModeIndex.Normal)
  end)
  binder:BindToVisible(self.ui.Background_1, function()
    local groupType = self:_GetGroupTypeByHardIndex(StageGroupHardModeIndex.Normal)
    local groupTid = self.model.difficult2Group[groupType]
    local isLocked = self:_IsGroupLock(groupTid)
    return not isLocked
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Hard, nil, nil, System.bind(self._ToggleRedFunc, self, StageGroupHardModeIndex.Normal)))
  binder:BindToZ1Toggle(self.ui.Toggle_Difficulty, nil, function(isOn)
    if isOn then
    else
    end
    local groupType = self:_GetGroupTypeByHardIndex(StageGroupHardModeIndex.Hard)
    self:_SetStageGroupTidByToggle(isOn, groupType)
  end, function()
    local groupType = StageGroupType.SmallSubplotHard
    if self.model.isLarge then
      groupType = StageGroupType.LargeSubplotHard
    end
    return self.model.difficult == groupType
  end, nil, function()
    local groupType = self:_GetGroupTypeByHardIndex(StageGroupHardModeIndex.Hard)
    local groupTid = self.model.difficult2Group[groupType]
    local isLocked = self:_IsGroupLock(groupTid)
    return isLocked
  end, function()
    self:_OnClickLockedToggle(StageGroupHardModeIndex.Hard)
  end)
  binder:BindToVisible(self.ui.Background_2, function()
    local groupType = self:_GetGroupTypeByHardIndex(StageGroupHardModeIndex.Hard)
    local groupTid = self.model.difficult2Group[groupType]
    local isLocked = self:_IsGroupLock(groupTid)
    return not isLocked
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Hard_1, nil, nil, System.bind(self._ToggleRedFunc, self, StageGroupHardModeIndex.Hard)))
  binder:BindToZ1Toggle(self.ui.Toggle_Nightmare, nil, function(isOn)
    if isOn then
    else
    end
    local groupType = self:_GetGroupTypeByHardIndex(StageGroupHardModeIndex.Crazy)
    self:_SetStageGroupTidByToggle(isOn, groupType)
  end, function()
    local groupType = StageGroupType.SmallSubplotCrazy
    if self.model.isLarge then
      groupType = StageGroupType.LargeSubplotCrazy
    end
    return self.model.difficult == groupType
  end, nil, function()
    local groupType = self:_GetGroupTypeByHardIndex(StageGroupHardModeIndex.Crazy)
    local groupTid = self.model.difficult2Group[groupType]
    local isLocked = self:_IsGroupLock(groupTid)
    return isLocked
  end, function()
    self:_OnClickLockedToggle(StageGroupHardModeIndex.Crazy)
  end)
  binder:BindToVisible(self.ui.Background_3, function()
    local groupType = self:_GetGroupTypeByHardIndex(StageGroupHardModeIndex.Crazy)
    local groupTid = self.model.difficult2Group[groupType]
    local isLocked = self:_IsGroupLock(groupTid)
    return not isLocked
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Hard_2, nil, nil, System.bind(self._ToggleRedFunc, self, StageGroupHardModeIndex.Crazy)))
  binder:BindToRaw(function(_, curGroupTid)
    if not curGroupTid or 0 == curGroupTid then
      return
    end
    if self.model:IsHardGroup(curGroupTid) then
      self.ui.bg_Easy:SetActive(false)
      self.ui.bg_Difficulty:SetActive(true)
      self.ui.bg_Nightmare:SetActive(false)
    elseif self.model:IsCrazyGroup(curGroupTid) then
      self.ui.bg_Easy:SetActive(false)
      self.ui.bg_Difficulty:SetActive(false)
      self.ui.bg_Nightmare:SetActive(true)
    else
      self.ui.bg_Easy:SetActive(true)
      self.ui.bg_Difficulty:SetActive(false)
      self.ui.bg_Nightmare:SetActive(false)
    end
  end, function()
    return self.model.curGroupTid
  end)
  binder:SetImageAlpha(self.ui.bg_Easy, 1)
  binder:SetImageAlpha(self.ui.bg_Difficulty, 1)
  binder:SetImageAlpha(self.ui.bg_Nightmare, 1)
end

function SubplotGroupPanel:_IsHardDifficult()
  if not self.model then
    return false
  end
  do return self.model.IsHardGroup, self.model end
  return self.model.IsHardGroup, self.model, self.model.curGroupTid
end

function SubplotGroupPanel:_IsCrazyDifficult()
  if not self.model then
    return false
  end
  do return self.model.IsCrazyGroup, self.model end
  return self.model.IsCrazyGroup, self.model, self.model.curGroupTid
end

function SubplotGroupPanel:_SetStageGroupTidByToggle(isOn, groupType)
  if not isOn or not groupType then
    return
  end
  local groupTid = self.model.difficult2Group[groupType]
  if groupTid then
    self.model:SetCurGroupTid(groupTid)
  end
end

function SubplotGroupPanel:_IsGroupLock(stageGroupTid)
  local feature = CopyDataUtils.GetStageGroupFeature(stageGroupTid)
  if not feature then
    return true
  end
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(feature, stageGroupTid)
  return not unlocked
end

function SubplotGroupPanel:_GetGroupTypeByHardIndex(hardIndex)
  local hardGroupTypeArr = self.hardIndex2Difficult[hardIndex]
  if not hardGroupTypeArr then
    return
  end
  local groupType = hardGroupTypeArr[SMALL_GROUP_TYPE]
  if self.model.isLarge then
    groupType = hardGroupTypeArr[LARGE_GROUP_TYPE]
  end
  return groupType
end

function SubplotGroupPanel:_OnClickLockedToggle(hardIndex)
  local groupType = self:_GetGroupTypeByHardIndex(hardIndex)
  if not groupType then
    return
  end
  local groupTid = self.model.difficult2Group[groupType]
  if not groupTid then
    return
  end
  if self:_IsGroupLock(groupTid) then
    local feature = CopyDataUtils.GetStageGroupFeature(groupTid)
    if not feature then
      return true
    end
    PlayerDataUtils.AlertLockedTips(feature, groupTid)
  end
end

function SubplotGroupPanel:_GetStageList()
  if self.model and self.model.curGroupData and self.model.curGroupData.stageList then
    local temp = {}
    for _, stageData in ipairs(self.model.curGroupData.stageList) do
      if stageData and stageData.unlocked then
        table.insert(temp, stageData.stageID)
      end
    end
    self.stageList = temp
  end
  return self.stageList
end

function SubplotGroupPanel:_UpdateStageItem(childBinder, go, index)
  local stageTid = self.stageList[index]
  childBinder:BindComponent(SubplotStageListItem(go, self.model, stageTid, index))
end

function SubplotGroupPanel:_GetBackgroundImage()
  if not self.model or not self.model.curGroupTid then
    return
  end
  do return self.model.GetStageGroupBgImage, self.model end
  return self.model.GetStageGroupBgImage, self.model, self.model.curGroupTid
end

function SubplotGroupPanel:_GetCurrStageGroupTotalStar()
  if not self.model then
    return 0
  end
  do return self.model.GetCurrStageGroupTotalStar end
  return self.model.GetCurrStageGroupTotalStar, self.model
end

function SubplotGroupPanel:_GetCurrStageGroupStar()
  if not self.model or not self.model.curGroupData then
    return 0
  end
  return self.model.curGroupData.totalStar or 0
end

function SubplotGroupPanel:_GetGroupName()
  if not self.model then
    return
  end
  do return self.model.GetStageGroupName, self.model end
  return self.model.GetStageGroupName, self.model, self.model.curGroupTid
end

function SubplotGroupPanel:_GetStageGroupDesc()
  if not self.model then
    return
  end
  do return self.model.GetStageGroupDesc, self.model end
  return self.model.GetStageGroupDesc, self.model, self.model.curGroupTid
end

function SubplotGroupPanel:_HasStarPrize()
  if not self.model then
    return false
  end
  do return self.model.HasStarPrize, self.model end
  return self.model.HasStarPrize, self.model, self.model.curGroupTid
end

function SubplotGroupPanel:_ToggleRedFunc(hardIndex)
  local groupType = self:_GetGroupTypeByHardIndex(hardIndex)
  if not groupType then
    return
  end
  local groupTid = self.model.difficult2Group[groupType]
  if not groupTid then
    return
  end
  do return SubplotRedUtils.GetRedByGroupTid end
  return SubplotRedUtils.GetRedByGroupTid, groupTid
end

function SubplotGroupPanel:_RedFunc()
  local red = SubplotRedUtils.GetSubplotGroupStarRed({
    self.model.curGroupTid
  })
  return red
end

function SubplotGroupPanel:_HasOpeningActivity()
  return self.model.hasSubplotActivity
end

function SubplotGroupPanel:_BindActivityTimer(binder)
  if not self.model.curGroupTid then
    return
  end
  local activityData = ActivityManager.Instance:GetOpeningSubplotActivity(self.model.curGroupTid)
  if not activityData then
    return
  end
  local timeType = ActivityDataUtils.GetTimeType(activityData.activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    binder:SetText(self.ui.Text_Time, "")
    return
  end
  local leftTime = ActivityDataUtils.GetLeftTime(activityData) or 0
  if leftTime <= 0 then
    if activityData.endTime > 0 and activityData.endTime < TimeUtils.GetServerTime() then
      binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimeExpired"))
    end
    return
  end
  binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
  self.activityTimer = binder:BindTimer(1, -1, function()
    leftTime = leftTime - 1
    if leftTime <= 0 then
      self:_ClearTimer()
      return
    end
    binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
  end, function()
    binder:SetText(self.ui.Text_Time, "")
    self:_ClearTimer()
  end)
end

function SubplotGroupPanel:_ClearTimer()
  if self.activityTimer then
    TimerManager.Instance:StopTimer(self.activityTimer)
    self.activityTimer = nil
  end
end

function SubplotGroupPanel:_BindAchievementGroup(binder)
  local function activeFunc()
    local _, limitProgress = MainCopyDataUtils.GetAchievementProgress(self.model.curGroupTid)
    
    return 0 ~= limitProgress
  end
  
  local function curProgressTextFunc()
    local curProgress, _ = MainCopyDataUtils.GetAchievementProgress(self.model.curGroupTid)
    do return LT.Text end
    return LT.Text, curProgress
  end
  
  local function limitProgressTextFunc()
    local _, limitProgress = MainCopyDataUtils.GetAchievementProgress(self.model.curGroupTid)
    do return LT.Text end
    return LT.Text, limitProgress
  end
  
  local function nameTextFunc()
    do return LT.Text end
    return LT.Text, "CopyAchievementBtnGroupName"
  end
  
  local function clickFunc()
    MainCopyDataUtils.OpenMainCopyAchievementTips(self.model.curGroupTid)
  end
  
  local function redFunc()
    do return RedPointDataUtils.IsShowStageGroupAchievementReward end
    return RedPointDataUtils.IsShowStageGroupAchievementReward, self.model.curGroupTid
  end
  
  local itemData = {
    activeFunc = activeFunc,
    curProgressTextFunc = curProgressTextFunc,
    limitProgressTextFunc = limitProgressTextFunc,
    clickFunc = clickFunc,
    redFunc = redFunc,
    nameTextFunc = nameTextFunc
  }
  binder:BindComponent(CommonProgressBtnGroup(self.ui.Group_Success, itemData))
end

function SubplotGroupPanel:_OnClickStarPrize()
  if not (self.model.curGroupTid and self.model) or not self.model.curGroupData then
    return
  end
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(self.model.curGroupTid)
  if not stageGroupCfg then
    return
  end
  local stageGroupDrop = stageGroupCfg.StageGroupDrop
  local star = self:_GetCurrStageGroupStar()
  local stageGroupTid = self.model.curGroupTid
  local data = self.model.curGroupData.starGainInfo
  UIManager.Instance:Reopen(Urls.MainCopyProgressRewardPanel, stageGroupDrop, star, stageGroupTid, data)
end

function SubplotGroupPanel:Close()
  UIManager.Instance:ReShowBehindPanel(self)
  self.uiAnimController:StopPlayableGraph()
  self.uiAnimController:PlayState("UI_Chapter_Panel_Spur_Close", function()
    Super.Close(self)
  end)
end

return SubplotGroupPanel
