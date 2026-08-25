local UIAnimationController = CS.Z1Client.UIAnimationController
local ANIM_DURATION_FRAME = 2
local SubplotGroupListItem, Super = System.NewComponent("SubplotGroupListItem")

function SubplotGroupListItem:ctor(uiNode, groupTid, index, model)
  Super.ctor(self)
  local _, isLargeSubplot = CopyDataUtils.IsSubplotGroup(groupTid)
  self.isLargeSubplot = isLargeSubplot
  self.ui = self:_GetUIResource(uiNode, isLargeSubplot)
  self.groupTid = groupTid
  self.model = model
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.index = index
end

function SubplotGroupListItem:OnBind(binder)
  if not self.ui then
    return
  end
  if self.isLargeSubplot then
    self:_BindLargeSubplotGroupListItem(binder)
  else
    self:_BindSmallSubplotGroupListItem(binder)
  end
end

function SubplotGroupListItem:_GetUIResource(uiNode, isLargeSubplot)
  if isLargeSubplot then
    do return UI_Chapter_Panel_Main2_ItemBranchResource end
    return UI_Chapter_Panel_Main2_ItemBranchResource, uiNode
  end
  do return UI_Chapter_Panel_Main2_SmallBranchResource end
  return UI_Chapter_Panel_Main2_SmallBranchResource, uiNode
end

function SubplotGroupListItem:_BindLargeSubplotGroupListItem(binder)
  binder:BindToText(self.ui.Text_Name, System.fn(self, self._GetGroupName))
  binder:SetText(self.ui.Text_Condition, self:_GetUnlockConditionDesc())
  binder:BindToText(self.ui.Text_Awaker_Name, System.fn(self, self._GetAwakerName))
  binder:BindToImage(self.ui.Image_Career, System.fn(self, self._GetAwakerSchoolIcon))
  binder:BindToImage(self.ui.Image_Portrait, System.fn(self, self._GetGroupCoverImage))
  binder:BindToImage(self.ui.Image_Quality, System.fn(self, self._GetBackgroundImage))
  binder:SetActive(self.ui.Group_Lock, self:_IsGroupLock())
  binder:SetActive(self.ui.Image_Locking, self:_IsActivityFreeLock())
  binder:BindToVisible(self.ui.Group_Over, System.fn(self, self._OnShowFinish))
  binder:BindButtonClick(self.ui.Button_Click, System.fn(self, self._OnClick))
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, System.fn(self, self._RedFunc)))
  self:_BindAwakerPortraitItem(binder, self.ui.Image_Portrait)
  binder:BindEvent(EventMgr.Instance.SubplotGroupLargeSelect, System.fn(self, self._PlayLargeItemAnim))
end

function SubplotGroupListItem:_BindSmallSubplotGroupListItem(binder)
  binder:BindToText(self.ui.Text_Name, System.fn(self, self._GetGroupName))
  binder:SetText(self.ui.Text_Condition, self:_GetUnlockConditionDesc())
  binder:BindToText(self.ui.Text_Awaker_Name, System.fn(self, self._GetAwakerName))
  binder:BindToImage(self.ui.Image_Career, System.fn(self, self._GetAwakerSchoolIcon))
  binder:BindToImage(self.ui.Image_Portrait, System.fn(self, self._GetGroupCoverImage))
  binder:SetActive(self.ui.Group_Lock, self:_IsGroupLock())
  binder:SetActive(self.ui.Image_Locking, self:_IsActivityFreeLock())
  binder:BindToVisible(self.ui.Group_Over, System.fn(self, self._OnShowFinish))
  binder:BindButtonClick(self.ui.Button_Click, System.fn(self, self._OnClick))
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, System.fn(self, self._RedFunc)))
  self:_BindAwakerPortraitItem(binder, self.ui.Image_Portrait)
  binder:BindEvent(EventMgr.Instance.SubplotGroupSmallSelect, System.fn(self, self._PlaySmallItemAnim))
end

function SubplotGroupListItem:_BindAwakerPortraitItem(binder, obj)
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(self.groupTid)
  local awakerTid = stageGroupConfig and stageGroupConfig.RelatedAwaker
  local portraitAlign = CommonDefine.PortraitAlign.Center
  binder:BindComponent(AwakerPortraitComp(obj, awakerTid, nil, nil, portraitAlign))
end

function SubplotGroupListItem:_GetAwakerName()
  local config = CopyDataUtils.GetStageGroupConfig(self.groupTid)
  if not config or not config.RelatedAwaker then
    return
  end
  do return AwakerDataUtils.GetAwakerName end
  return AwakerDataUtils.GetAwakerName, config.RelatedAwaker
end

function SubplotGroupListItem:_GetAwakerSchoolIcon()
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

function SubplotGroupListItem:_IsGroupLock()
  local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(self.groupTid)
  if isFeatureLocked then
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

function SubplotGroupListItem:_IsActivityFreeLock()
  local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(self.groupTid)
  if isFeatureLocked then
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

function SubplotGroupListItem:_OnShowFinish()
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

function SubplotGroupListItem:_OnClick()
  local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(self.groupTid)
  if isFeatureLocked then
    local feature = CopyDataUtils.GetStageGroupFeature(self.groupTid)
    if not feature then
      return
    end
    PlayerDataUtils.AlertLockedTips(feature, self.groupTid)
    return
  end
  
  local function _ReqUnlockStageGroup()
    CopyDataUtils.ReqUnlockStageGroup(self.groupTid, false, System.fn(self, self._PlaySubplotUnlockAnim))
  end
  
  if CopyDataUtils.IsStageGroupNeedUnlockItem(self.groupTid) then
    local hasUseUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(self.groupTid)
    if not hasUseUnlockItem then
      local hasOpenningSubplotActivity = ActivityManager.Instance:HasOpeningSubplotActivity(self.groupTid)
      if hasOpenningSubplotActivity then
        Alert.Show(20138, nil, _ReqUnlockStageGroup)
        return
      end
      
      local function CheckUnlock()
        if not CopyDataUtils.IsStageGroupUnlockItemEnough(self.groupTid) then
          local itemNameCostStr = CopyDataUtils.GetStageGroupUnlockItemCostStr(self.groupTid, false)
          local tipsText = LT.Textf(DT.TipsType[10646].Desc, itemNameCostStr)
          Alert.Show(10646, nil, nil, nil, tipsText)
          return
        end
        _ReqUnlockStageGroup()
      end
      
      local itemName, itemNum = CopyDataUtils.GetStageGroupFirstUnlockItemInfo(self.groupTid)
      local stageGroupName = CopyDataUtils.GetStageGroupName(self.groupTid)
      local tipsText = LT.Textf(DT.TipsType[20139].Desc, itemName, stageGroupName, itemNum)
      Alert.Show(20139, nil, CheckUnlock, nil, tipsText)
      return
    end
  end
  CopyDataUtils.OpenSubPlotGroupPanel(self.groupTid)
end

function SubplotGroupListItem:_PlaySubplotUnlockAnim(callback)
  if not self.uiAnimController then
    return
  end
  self.uiAnimController:StopPlayableGraph()
  FrameWaiter.OnNextFrame(function()
    if not IsNil(self.uiAnimController) then
      self.uiAnimController:PlayState("UI_Chapter_Panel_Main2_Branch_CommonUnlock", function()
        if callback then
          callback()
        end
      end)
    end
  end, 1)
end

function SubplotGroupListItem:_GetUnlockConditionDesc()
  if not self:_IsGroupLock() then
    return
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

function SubplotGroupListItem:_GetGroupCoverImage()
  if not self.groupTid then
    return
  end
  do return self.model.GetStageGroupCoverImage, self.model end
  return self.model.GetStageGroupCoverImage, self.model, self.groupTid
end

function SubplotGroupListItem:_GetBackgroundImage()
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

function SubplotGroupListItem:_GetGroupName()
  if not self.groupTid then
    return
  end
  do return self.model.GetStageGroupName, self.model end
  return self.model.GetStageGroupName, self.model, self.groupTid
end

function SubplotGroupListItem:_RedFunc()
  if self:_IsGroupLock() then
    return false
  end
  local red = SubplotRedUtils.GetAllDiifRedByGroupTid(self.groupTid)
  return red
end

function SubplotGroupListItem:_PlaySmallItemAnim()
  local canvasGroup = self.ui.Grope_Container:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = 0
  self.uiAnimController:StopPlayableGraph()
  FrameWaiter.OnNextFrame(function()
    if not IsNil(self.uiAnimController) then
      self.uiAnimController:PlayState("UI_Chapter_Panel_Main2_SmallBranch_Open")
    end
  end, self.index * ANIM_DURATION_FRAME)
end

function SubplotGroupListItem:_PlayLargeItemAnim()
  local canvasGroup = self.ui.Grope_Container:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = 0
  self.uiAnimController:StopPlayableGraph()
  FrameWaiter.OnNextFrame(function()
    if not IsNil(self.uiAnimController) then
      self.uiAnimController:PlayState("UI_Chapter_Panel_Main2_ItemBranch_Open")
    end
  end, self.index * ANIM_DURATION_FRAME)
end

return SubplotGroupListItem
