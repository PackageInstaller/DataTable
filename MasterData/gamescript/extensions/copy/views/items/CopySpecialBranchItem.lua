local TYPE_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local CopySpecialBranchItem, Super = NewViewComponent("CopySpecialBranchItem")

function CopySpecialBranchItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = data.resource(uiNode)
  self.prefabName = data.prefabName
  self.stageGroupId = data.stageGroupId
  self.stageGroupCfg = DT.StageGroup[self.stageGroupId]
end

function CopySpecialBranchItem:OnEnterComponent()
  self:RegisterNotify(NotifyId.OnCopySubplotGroupUnlocked, self._OnCopySubplotGroupUnlocked, self)
  self:RegisterNotify(NotifyId.OnStageDataChanged, self._OnStageDataChanged, self)
  self:AddButtonClickListener(self.ui.Image_Awaker_Click, System.fn(self, self._OnClick))
  self:SetText(self.ui.Text_Name, LT.Text(self.stageGroupCfg.Name))
  self:RefreshDisplay()
  self:AddRedPoint(self.ui.Com_RedDot, RedDotDefine.DynamicRedDotID.SubplotStageGroupEntryRedDot, {
    stageGroupTid = self.stageGroupId
  })
  if self.stageGroupCfg and self.stageGroupCfg.DailyIcon and self.stageGroupCfg.DailyIcon[2] and type(self.stageGroupCfg.DailyIcon[2]) == "string" then
    self:SetActive(self.ui.Image_Awaker, true)
    self:SetActive(self.ui.AwakerCon, false)
    self:SetImage(self.ui.Image_Awaker, self.stageGroupCfg.DailyIcon[2])
  else
    self:SetActive(self.ui.Image_Awaker, false)
    self:SetActive(self.ui.AwakerCon, true)
    self:RefreshPortraitComp()
  end
end

function CopySpecialBranchItem:RefreshDisplay()
  if not self.ui or IsNil(self.ui.uiNode) then
    return
  end
  local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(self.stageGroupId)
  local feature = CopyDataUtils.GetStageGroupFeature(self.stageGroupId)
  if CopySubplotGroupModel.Instance:IsHaveServerStageData(self.stageGroupId) then
    self:SetText(self.ui.Text_Condition, self:_GetUnlockConditionDesc())
  else
    self:SetText(self.ui.Text_Condition, isFeatureLocked and PlayerDataUtils.GetFeatureLogicUnlockTips(feature, self.stageGroupId) or LT.Text("Unlockable"))
  end
  self:RefreshState()
end

function CopySpecialBranchItem:_GetUnlockConditionDesc()
  if not self:_CheckIsLockState() then
    return
  end
  local feature = CopyDataUtils.GetStageGroupFeature(self.stageGroupId)
  if not feature then
    return
  end
  local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(self.stageGroupId)
  if isFeatureLocked then
    do return PlayerDataUtils.GetFeatureLogicUnlockTips, feature end
    return PlayerDataUtils.GetFeatureLogicUnlockTips, feature, self.stageGroupId
  end
  if not CopyDataUtils.IsStageGroupNeedUnlockItem(self.stageGroupId) then
    return
  end
  if ActivityManager.Instance:HasOpeningSubplotActivity(self.stageGroupId) then
    do return LT.Text end
    return LT.Text, "SubplotFreeTips", self.stageGroupId
  end
  if CopyDataUtils.IsStageGroupUseUnlockItem(self.stageGroupId) then
    return
  end
  do return LT.Text end
  return LT.Text, "Unlockable", self.stageGroupId
end

function CopySpecialBranchItem:_OnStageDataChanged(stageGroupId)
  if stageGroupId ~= self.stageGroupId then
    return
  end
  self:RefreshDisplay()
end

function CopySpecialBranchItem:RefreshPortraitComp()
  local awakerTid = self.stageGroupCfg.RelatedAwaker
  if not awakerTid then
    return
  end
  if not DT.AwakerConfig[awakerTid] then
    local awakerSkinTid = awakerTid
    local clothersResNu = DT.AwakerSkin[awakerSkinTid].ClothersResNum
    if clothersResNu then
      self:AddViewComponentOnce(self.ui.AwakerCon, UICompAwakerPortrait, {
        awakerTid = awakerTid,
        portraitAlign = CommonDefine.PortraitAlign.Center,
        portraitNo = clothersResNu
      })
    end
  else
    self:AddViewComponentOnce(self.ui.AwakerCon, UICompAwakerPortrait, {
      awakerTid = awakerTid,
      portraitAlign = CommonDefine.PortraitAlign.Center
    })
  end
end

function CopySpecialBranchItem:RefreshState()
  if not self:_CheckIsLockState() then
    self:_SetFreeLockActive(false)
    self:_SetNormalLockActive(false)
    return
  end
  local hasOpenningSubplotActivity = ActivityManager.Instance:HasOpeningSubplotActivity(self.stageGroupId)
  self:_SetFreeLockActive(hasOpenningSubplotActivity)
  self:_SetNormalLockActive(not hasOpenningSubplotActivity)
end

function CopySpecialBranchItem:_OnCopySubplotGroupUnlocked()
  self:RefreshDisplay()
  self:PlayLoopAnim()
end

function CopySpecialBranchItem:_SetFreeLockActive(boolVal)
  if self.ui.Image_Locking then
    self.ui.Image_Locking:SetActive(boolVal)
  end
end

function CopySpecialBranchItem:_SetNormalLockActive(boolVal)
  if self.ui.Group_Lock then
    self.ui.Group_Lock:SetActive(boolVal)
  end
end

function CopySpecialBranchItem:_OnClick()
  local isStageLocked = CopyDataUtils.IsStageGroupFeatureLocked(self.stageGroupId)
  if isStageLocked then
    local feature = CopyDataUtils.GetStageGroupFeature(self.stageGroupId)
    if feature then
      PlayerDataUtils.AlertLockedTips(feature, self.stageGroupId)
      return
    end
  end
  if not CopySubplotGroupModel.Instance:IsHaveServerStageData(self.stageGroupId) then
    CopyDataUtils.OnClickSubPlotEntry(self.stageGroupId)
    return
  end
  
  local function _ReqUnlockStageGroup()
    CopyDataUtils.ReqUnlockStageGroup(self.stageGroupId)
  end
  
  if CopyDataUtils.IsStageGroupNeedUnlockItem(self.stageGroupId) then
    local hasUseUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(self.stageGroupId)
    if not hasUseUnlockItem then
      local hasOpenningSubplotActivity = ActivityManager.Instance:HasOpeningSubplotActivity(self.stageGroupId)
      if hasOpenningSubplotActivity then
        Alert.Show(20138, nil, _ReqUnlockStageGroup)
        return
      end
      local itemName, itemNum = CopyDataUtils.GetStageGroupFirstUnlockItemInfo(self.stageGroupId)
      local stageGroupName = CopyDataUtils.GetStageGroupName(self.stageGroupId)
      local tipsText = LT.Textf(DT.TipsType[20139].Desc, itemName, stageGroupName, itemNum)
      Alert.Show(20139, nil, function()
        if not CopyDataUtils.IsStageGroupUnlockItemEnough(self.stageGroupId) then
          local itemNameCostStr = CopyDataUtils.GetStageGroupUnlockItemCostStr(self.stageGroupId, false)
          local tipsText2 = LT.Textf(DT.TipsType[10646].Desc, itemNameCostStr)
          Alert.Show(10646, nil, nil, nil, tipsText2)
          return
        end
        _ReqUnlockStageGroup()
      end, nil, tipsText)
      return
    end
  end
  self:OnOpenSubPlotGroupPanel()
end

function CopySpecialBranchItem:OnOpenSubPlotGroupPanel()
  if self:_CheckIsLockState() then
    CopyDataUtils.OnClickSubPlotEntry(self.stageGroupId)
    return
  end
  CopySubplotGroupModel.Instance:SetStageGroupID(self.stageGroupId)
  local extraParam = {showUIEffect = true}
  CopyDataUtils.OpenSubPlotGroupPanel(self.stageGroupId, nil, extraParam)
end

function CopySpecialBranchItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CopySpecialBranchItem:_CheckIsLockState()
  do return CopyDataUtils.CheckSubplotIsLockState end
  return CopyDataUtils.CheckSubplotIsLockState, self.stageGroupId
end

function CopySpecialBranchItem:Hide()
  local canvasGroup = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = 0
end

function CopySpecialBranchItem:PlayEnterAnim()
  self:StopPlayableGraph()
  local canvasGroup = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = 1
  self:_GetAnimCtr():PlayState(self:_GetEnterAnimClipName(), function()
    if not self:_CheckIsLockState() then
      self:PlayLoopAnim()
    end
  end)
end

function CopySpecialBranchItem:PlayLoopAnim()
  self:StopPlayableGraph()
  self:_GetAnimCtr():LoopPlayState(self:_GetAnimName("Loop"))
end

function CopySpecialBranchItem:StopPlayableGraph()
  self:_GetAnimCtr():StopPlayableGraph()
end

function CopySpecialBranchItem:_GetEnterAnimClipName()
  if self:_CheckIsLockState() then
    do return self._GetAnimName, self end
    return self._GetAnimName, self, "Lock_Open"
  end
  do return self._GetAnimName, self end
  return self._GetAnimName, self, "Open"
end

function CopySpecialBranchItem:_GetAnimCtr()
  if not self.uiAnimCtr then
    self.uiAnimCtr = self.ui.uiNode:GetComponent(TYPE_UIAnimationController)
  end
  return self.uiAnimCtr
end

function CopySpecialBranchItem:_GetAnimName(state)
  local animationInfoList = self.uiAnimCtr.animationInfoList
  if 0 == animationInfoList.Count then
    return
  end
  return self.ui.uiNode.gameObject.name .. "_" .. state
end

return CopySpecialBranchItem
