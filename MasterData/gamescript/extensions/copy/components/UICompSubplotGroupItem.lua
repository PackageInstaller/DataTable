local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local T_CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local ANIM_DURATION_FRAME = 2
local UICompSubplotGroupItem, Super = NewViewComponent("UICompSubplotGroupItem")

function UICompSubplotGroupItem:ctor(uiNode, view, groupTid)
  Super.ctor(self, uiNode, view)
  local _, isLargeSubplot = CopyDataUtils.IsSubplotGroup(groupTid)
  self.isLargeSubplot = isLargeSubplot
  self.ui = self:_GetUIResource(uiNode, isLargeSubplot)
  self.groupTid = groupTid
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
end

function UICompSubplotGroupItem:_GetUIResource(uiNode, isLargeSubplot)
  if isLargeSubplot then
    do return UI_Chapter_Panel_Main2_ItemBranchResource end
    return UI_Chapter_Panel_Main2_ItemBranchResource, uiNode
  end
  do return UI_Chapter_Panel_Main2_SmallBranchResource end
  return UI_Chapter_Panel_Main2_SmallBranchResource, uiNode
end

function UICompSubplotGroupItem:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnCopySubplotGroupUnlocked, self._OnCopySubplotGroupUnlocked, self)
  self:RegisterNotify(NotifyId.OnResonanceDataChanged, self._OnResonanceDataChanged, self)
end

function UICompSubplotGroupItem:OnEnterComponent()
  self.canvasGroup = self.ui.Grope_Container:GetComponent(T_CanvasGroup)
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(self.groupTid)
  local awakerTid = stageGroupCfg.RelatedAwaker
  if awakerTid then
    self.ui.Image_Portrait:SetActive(true)
    self.ui.Image_Orientation:SetActive(true)
    self:SetText(self.ui.Text_Awaker_Name, self:_GetAwakerName())
    self:SetImage(self.ui.Image_Career, self:_GetAwakerSchoolIcon())
    self:SetImage(self.ui.Image_Portrait, stageGroupCfg.CoverImage)
    self:AddViewComponentOnce(self.ui.Image_Portrait, UICompAwakerPortrait, {
      awakerTid = awakerTid,
      portraitAlign = CommonDefine.PortraitAlign.Center
    })
  else
    local pic = stageGroupCfg.DailyIcon[1]
    self:SetImage(self.ui.Image_Quality, pic)
    self.ui.Image_Portrait:SetActive(false)
    self.ui.Image_Orientation:SetActive(false)
  end
  self:SetText(self.ui.Text_Name, LT.Text(stageGroupCfg.Name))
  self:AddButtonClickListener(self.ui.Button_Click, System.fn(self, self._OnClick))
  if self.isLargeSubplot and awakerTid then
    self:SetImage(self.ui.Image_Quality, self:_GetBackgroundImage())
  end
  self:_RefreshUnlockStatus()
end

function UICompSubplotGroupItem:_RefreshUnlockStatus()
  self:SetText(self.ui.Text_Condition, self:_GetUnlockConditionDesc())
  self.ui.Group_Lock:SetActive(self:_IsGroupLock())
  self.ui.Group_Over:SetActive(false)
  self.ui.Image_Locking:SetActive(self:_IsActivityFreeLock())
  self:AddRedPoint(self.ui.Com_RedDot, RedDotDefine.DynamicRedDotID.SubplotStageGroupEntryRedDot, {
    stageGroupTid = self.groupTid
  })
end

function UICompSubplotGroupItem:_OnShowFinish()
  local list = {}
  local groupTidMap = CopyDataUtils.GetSubplotDifficult2IdMap(self.groupTid)
  for _, groupTid in pairs(groupTidMap) do
    table.insert(list, groupTid)
  end
  for _, groupTid in ipairs(list) do
    local hasGotAllPrize = MainCopyDataUtils.HasGotAllSubplotPrize(groupTid)
    if not hasGotAllPrize then
      return false
    end
  end
  return true
end

function UICompSubplotGroupItem:_GetUnlockConditionDesc()
  if not self:_IsGroupLock() then
    return ""
  end
  local feature = CopyDataUtils.GetStageGroupFeature(self.groupTid)
  if not feature then
    return
  end
  local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(self.groupTid)
  if isFeatureLocked then
    do return PlayerDataUtils.GetFeatureLogicUnlockTips, feature end
    return PlayerDataUtils.GetFeatureLogicUnlockTips, feature, self.groupTid, nil, nil
  end
  local needUnlockItem = CopyDataUtils.IsStageGroupNeedUnlockItem(self.groupTid)
  if not needUnlockItem then
    return
  end
  local hasOpenningSubplotActivity = ActivityManager.Instance:HasOpeningSubplotActivity(self.groupTid)
  if hasOpenningSubplotActivity then
    do return LT.Text end
    return LT.Text, "SubplotFreeTips", nil
  end
  local hasUseUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(self.groupTid)
  if hasUseUnlockItem then
    return
  end
  do return LT.Text end
  return LT.Text, "Unlockable"
end

function UICompSubplotGroupItem:_GetAwakerName()
  local config = CopyDataUtils.GetStageGroupConfig(self.groupTid)
  if not config or not config.RelatedAwaker then
    return ""
  end
  do return AwakerDataUtils.GetAwakerName end
  return AwakerDataUtils.GetAwakerName, config.RelatedAwaker
end

function UICompSubplotGroupItem:_GetAwakerSchoolIcon()
  local config = CopyDataUtils.GetStageGroupConfig(self.groupTid)
  if not config or not config.RelatedAwaker then
    return
  end
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(config.RelatedAwaker)
  if not awakerConfig then
    return
  end
  do return AwakerDataUtils.GetSchoolIcon end
  return AwakerDataUtils.GetSchoolIcon, awakerConfig.School
end

function UICompSubplotGroupItem:_GetBackgroundImage()
  if not self.groupTid then
    return
  end
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(self.groupTid)
  local awakerTid = stageGroupCfg and stageGroupCfg.RelatedAwaker
  if not awakerTid then
    return
  end
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(awakerTid)
  local schoolTid = awakerConfig and awakerConfig.School
  if not schoolTid then
    return
  end
  do return AwakerDataUtils.GetSchoolSubplotCover end
  return AwakerDataUtils.GetSchoolSubplotCover, schoolTid
end

function UICompSubplotGroupItem:_RedFunc()
  if not SubplotRedUtils.CheckGroupRedValid(self.groupTid) then
    return false
  end
  local red = SubplotRedUtils.GetAllDiifRedByGroupTid(self.groupTid)
  if red then
    return red
  end
  local redStatus = RedPointDataUtils.IsStageGroupResonanceRedShow(self.groupTid)
  if redStatus then
    return redStatus
  end
  return false
end

function UICompSubplotGroupItem:_GetAwakerName()
  local config = CopyDataUtils.GetStageGroupConfig(self.groupTid)
  if not config or not config.RelatedAwaker then
    return
  end
  do return AwakerDataUtils.GetAwakerName end
  return AwakerDataUtils.GetAwakerName, config.RelatedAwaker
end

function UICompSubplotGroupItem:_IsGroupLock()
  local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(self.groupTid)
  if not self:_IsIgnoreFeatureLock() and isFeatureLocked then
    return true
  end
  if not CopyDataUtils.IsStageGroupNeedUnlockItem(self.groupTid) then
    return false
  end
  local hasUseUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(self.groupTid)
  if hasUseUnlockItem then
    return false
  end
  local hasOpenningSubplotActivity = ActivityManager.Instance:HasOpeningSubplotActivity(self.groupTid)
  return not hasOpenningSubplotActivity
end

function UICompSubplotGroupItem:_IsActivityFreeLock()
  local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(self.groupTid)
  if not self:_IsIgnoreFeatureLock() and isFeatureLocked then
    return false
  end
  if not CopyDataUtils.IsStageGroupNeedUnlockItem(self.groupTid) then
    return false
  end
  local hasUseUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(self.groupTid)
  if hasUseUnlockItem then
    return false
  end
  do return ActivityManager.Instance.HasOpeningSubplotActivity, ActivityManager.Instance end
  return ActivityManager.Instance.HasOpeningSubplotActivity, ActivityManager.Instance, self.groupTid
end

function UICompSubplotGroupItem:_IsIgnoreFeatureLock()
  do return StageGroupCfgUtils.IsIgnoreFeatureLock end
  return StageGroupCfgUtils.IsIgnoreFeatureLock, self.groupTid
end

function UICompSubplotGroupItem:_OnClick()
  local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(self.groupTid)
  if not self:_IsIgnoreFeatureLock() and isFeatureLocked then
    local feature = CopyDataUtils.GetStageGroupFeature(self.groupTid)
    if not feature then
      return
    end
    PlayerDataUtils.AlertLockedTips(feature, self.groupTid)
    return
  end
  
  local function _ReqUnlockStageGroup()
    CopyDataUtils.ReqUnlockStageGroup(self.groupTid)
  end
  
  if CopyDataUtils.IsStageGroupNeedUnlockItem(self.groupTid) then
    local hasUseUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(self.groupTid)
    if not hasUseUnlockItem then
      local hasOpenningSubplotActivity = ActivityManager.Instance:HasOpeningSubplotActivity(self.groupTid)
      if hasOpenningSubplotActivity then
        Alert.Show(20138, nil, _ReqUnlockStageGroup)
        return
      end
      local itemName, itemNum = CopyDataUtils.GetStageGroupFirstUnlockItemInfo(self.groupTid)
      local stageGroupName = CopyDataUtils.GetStageGroupName(self.groupTid)
      local tipsText = LT.Textf(DT.TipsType[20139].Desc, itemName, stageGroupName, itemNum)
      Alert.Show(20139, nil, function()
        if not CopyDataUtils.IsStageGroupUnlockItemEnough(self.groupTid) then
          local itemNameCostStr = CopyDataUtils.GetStageGroupUnlockItemCostStr(self.groupTid, false)
          local tempTipsText = LT.Textf(DT.TipsType[10646].Desc, itemNameCostStr)
          Alert.Show(10646, nil, nil, nil, tempTipsText)
          return
        end
        _ReqUnlockStageGroup()
      end, nil, tipsText)
      return
    end
  end
  CopyDataUtils.OpenSubPlotGroupPanel(self.groupTid)
end

function UICompSubplotGroupItem:PlaySmallItemAnim(index)
  self.canvasGroup.alpha = 0
  self.uiAnimController:StopPlayableGraph()
  FrameWaiter.OnNextFrame(function()
    if not IsNil(self.uiAnimController) then
      self.uiAnimController:PlayState("UI_Chapter_Panel_Main2_SmallBranch_Open")
    end
  end, index * ANIM_DURATION_FRAME)
end

function UICompSubplotGroupItem:PlayLargeItemAnim(index)
  self.canvasGroup.alpha = 0
  self.uiAnimController:StopPlayableGraph()
  FrameWaiter.OnNextFrame(function()
    if not IsNil(self.uiAnimController) then
      self.uiAnimController:PlayState("UI_Chapter_Panel_Main2_ItemBranch_Open")
    end
  end, index * ANIM_DURATION_FRAME)
end

function UICompSubplotGroupItem:_OnCopySubplotGroupUnlocked(groupTid)
  if groupTid == self.groupTid then
    self:_RefreshUnlockStatus()
  end
end

function UICompSubplotGroupItem:_OnResonanceDataChanged(id)
  local resonanceGroupTId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(self.groupTid)
  if id == resonanceGroupTId then
    self:_RefreshUnlockStatus()
  end
end

return UICompSubplotGroupItem
