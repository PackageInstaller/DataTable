local DungeonMaterialView, Super = NewClass("DungeonMaterialView", BaseView)
DungeonMaterialView.uiResCls = UI_Dungeons_Material_ViewResource

function DungeonMaterialView:ctor()
  Super.ctor(self)
end

function DungeonMaterialView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnMaterialStageGroupChange, self._RefrshInfoDetail, self)
  self:RegisterNotify(NotifyId.OnStageDataChanged, self._OnStageDataSync, self)
  self:BindEvent(EventMgr.Instance.OnSyncStageInfoEvent, System.fn(self, self._OnStageDataSyncEvent))
  self:BindEvent(EventMgr.Instance.OnDayRefresh, System.fn(self, self._OnDayRefresh))
end

function DungeonMaterialView:_IsMyFeatureStageGroup(stageGroupId)
  if not self.featureId or not stageGroupId then
    return true
  end
  local cfg = CopyDataUtils.GetFeatureUnlockCfgByStageGroupId(stageGroupId)
  return cfg and cfg.Feature == self.featureId
end

function DungeonMaterialView:_OnStageDataSync(stageGroupId)
  if not self:_IsMyFeatureStageGroup(stageGroupId) then
    return
  end
  if not self.stageView then
    return
  end
  if not self._stageOpenAnimPlayed then
    self._pendingStageDataSync = true
    return
  end
  self:_ScheduleStageDataSyncRefresh()
end

function DungeonMaterialView:_ScheduleStageDataSyncRefresh()
  if self._stageDataSyncTimer then
    return
  end
  self._stageDataSyncTimer = self:BindTimer(0, 0, nil, function()
    self._stageDataSyncTimer = nil
    if not self.stageView then
      return
    end
    self.showFadeInAnim = false
    self.stageView:ReloadData()
    self:_RefreshUI({playOpenAnim = false})
  end)
end

function DungeonMaterialView:_OnStageDataSyncEvent()
  self:_OnStageDataSync(nil)
end

function DungeonMaterialView:_OnDayRefresh()
  if not self.featureId or not self.stageView then
    return
  end
  CopyDataUtils.RefreshFeatureCopyData(self.featureId, System.fn(self, self._RefreshUI))
end

function DungeonMaterialView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Enter, System.fn(self, self._OnClickEnter))
  self:AddButtonClickListener(self.ui.Btn_ActivityAchievement, System.fn(self, self._OnClickActivityAchievement))
  self:RegisterAchievementRedDot()
end

function DungeonMaterialView:RegisterAchievementRedDot()
  self.binder:BindComponent(RedDotComponent(self.ui.RedDot_ActivityAchievement, CommonDefine.RedDotType.Red, nil, function()
    do return RedPointDataUtils.IsTaskListRedByConstKey end
    return RedPointDataUtils.IsTaskListRedByConstKey, "DailyMaterialPerfectRewardTaskGroup"
  end))
end

function DungeonMaterialView:RefreshOnRendered()
  DungeonMaterialModel.Instance:SetStageGroupType(self.stageGroupType)
  self:_RefreshUIOnRendered()
end

function DungeonMaterialView:_RefreshUIOnRendered()
  self:_RefreshUI({playOpenAnim = false})
end

function DungeonMaterialView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_C_ActivityAchievement, LT.Text("InterludeStageRewardsTitle"))
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self.scrollView = self.ui.ScrollView_List:GetComponentInParent(typeof(CS.UnityEngine.UI.ScrollRect))
  self._stageOpenAnimPlayed = false
  self._pendingStageDataSync = false
  self:_InitData()
  self:_PrepareFeatureStageData(function(hasCached)
    self:_InitTableView()
    if hasCached then
      self._stageOpenAnimPlayed = true
      self:_ReloadStageTableView(true)
      self:_RefreshUI({playOpenAnim = true})
    else
      self.showFadeInAnim = false
      if self.stageView then
        self.stageView:ReloadData()
      end
      self:_RefreshUI({playOpenAnim = true, skipStageFade = true})
    end
  end)
end

function DungeonMaterialView:OnExitView()
  Super.OnExitView(self)
end

function DungeonMaterialView:_InitData()
  self.stageGroupType = CommonDefine.StageGroupType.MaterialCopy
  DungeonMaterialModel.Instance:SetStageGroupType(self.stageGroupType)
  self.featureId = CommonDefine.FeatureId.ResCopy
  DungeonMaterialController.Instance:SetStageGroupList()
  self.stageGroupData = DungeonMaterialModel.Instance:GetStageGroupData(self.stageGroupType)
end

function DungeonMaterialView:_PrepareFeatureStageData(openFunc)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(self.featureId, 0)
  if not unlocked then
    if openFunc then
      openFunc(true)
    end
    return
  end
  local hasCached = CopyDataUtils.IsFeatureCopyDataCached(self.featureId)
  if openFunc then
    openFunc(hasCached)
  end
  if hasCached then
    return
  end
  CopyDataUtils.ReqFeatureCopyDataIfNeeded(self.featureId, function()
    if not self.stageView or self._stageOpenAnimPlayed then
      return
    end
    self._pendingStageDataSync = false
    self._stageOpenAnimPlayed = true
    self:_ReloadStageTableView(true)
    self:_RefreshUI({playOpenAnim = false})
  end)
end

function DungeonMaterialView:_InitTableView()
  self:_InitStageTableView()
  self:_InitRewardTableView()
end

function DungeonMaterialView:_InitStageTableView()
  if self.stageView then
    return
  end
  self.stageView = self:CreateTableview(self.ui.ScrollView_List, function()
    if not self.stageGroupData then
      return 0
    end
    return #self.stageGroupData
  end, function(view, index)
    do return self._StageCellAtIndex, self, view end
    return self._StageCellAtIndex, self, view, index
  end)
end

function DungeonMaterialView:_ReloadStageTableView(playFade)
  if not self.stageView then
    return
  end
  local needMoveStageInSight = true
  self.showFadeInAnim = playFade and true or false
  
  function self.stageView.reloadFinishCallback()
    if needMoveStageInSight then
      needMoveStageInSight = false
      local curStageGroup = DungeonMaterialModel.Instance:GetStageGroupId()
      for i = 1, #self.stageGroupData do
        if self.stageGroupData[i].ID == curStageGroup then
          self.stageView:MoveCellInView(i - 1)
          break
        end
      end
    end
    if self.showFadeInAnim then
      self:PlayTableViewFadeInAnim(self.ui.ScrollView_List)
      self.showFadeInAnim = false
    end
    self.stageView.reloadFinishCallback = nil
  end
  
  self.stageView:ReloadData()
end

function DungeonMaterialView:_InitRewardTableView()
  self.rewardView = self:CreateTableview(self.ui.ScrollView_Award, function()
    if not self.rewardData then
      return 0
    end
    return #self.rewardData
  end, function(view, index)
    do return self._RewardCellAtIndex, self, view end
    return self._RewardCellAtIndex, self, view, index
  end)
end

function DungeonMaterialView:_StageCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.Temp_Toggle_Item)
  local stageData = {
    redFunc = RedPointDataUtils.IsShowResSubCopyNew,
    redType = RedPointDataUtils.RedType.ResCopyNew,
    stageData = self.stageGroupData[index],
    featureId = self.featureId
  }
  self:AddViewComponentOnce(cell.gameObject, DungeonMaterialCell, stageData)
  return cell
end

function DungeonMaterialView:_RewardCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
  local item = self.rewardData[index]
  local itemData = {
    itemTid = item.tid,
    itemCount = item.num
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, itemData)
  return cell
end

function DungeonMaterialView:_RefreshUI(options)
  options = options or {}
  if not self.ui or IsNil(self.ui.uiNode) then
    return
  end
  if options.playOpenAnim and self.uiAnimController then
    self.uiAnimController:PlayState("UI_Dungeons_Material_View_Open")
  end
  self.stageGroupId = DungeonMaterialModel.Instance:GetStageGroupId() or self.stageGroupData[1].ID
  DungeonMaterialModel.Instance:SetStageGroupId(self.stageGroupId)
  self.rewardData = DungeonMaterialController.Instance:GetStageGroupReawrds(self.stageGroupId)
  self.ui.UI_Awaker_Button_Addition:SetActive(false)
  self.ui.Image_Fall:SetActive(false)
  if options.playOpenAnim and not options.skipStageFade then
    self.showFadeInAnim = true
    self.scrollView.verticalNormalizedPosition = 1
  elseif options.playOpenAnim then
    self.scrollView.verticalNormalizedPosition = 1
  end
  self:SetButtonText(self.ui.Btn_Enter, LT.Text("DailyCopy_Start"))
  self:_RefrshInfoDetail(self.stageGroupId)
end

function DungeonMaterialView:_RefrshInfoDetail(stageGroupId)
  if self.stageGroupType ~= DungeonMaterialModel.Instance:GetStageGroupType() then
    return
  end
  self.stageGroupId = stageGroupId
  DungeonMaterialModel.Instance:SetStageGroupId(stageGroupId)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(self.featureId, stageGroupId)
  local btnState = unlocked and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
  self:SetButtonState(self.ui.Btn_Enter, btnState)
  self.rewardData = DungeonMaterialController.Instance:GetStageGroupReawrds(stageGroupId)
  if self.rewardView then
    self.rewardView:ReloadData()
  end
  local stageGroupCfg = DT.StageGroup[stageGroupId]
  if stageGroupCfg then
    self:SetImage(self.ui.Image_Main_Bg, stageGroupCfg.Backgrand)
    self:SetText(self.ui.Text_Name, stageGroupCfg.Name)
    self:SetText(self.ui.Text_Desc, stageGroupCfg.Desc)
  end
end

function DungeonMaterialView:_OnClickEnter()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(self.featureId, self.stageGroupId)
  if not unlocked then
    PlayerDataUtils.AlertLockedTips(self.featureId, self.stageGroupId)
    return
  end
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.MockCopy, RedPointDataUtils.RedAttrType.IsNew, self.stageGroupId)
  if not table.next(DungeonMaterialModel.Instance:GetStageData()) then
    local stageGroupId = DungeonMaterialModel.Instance:GetStageGroupId()
    CopyDataUtils.ReqCopyData(nil, stageGroupId, function()
      UIManager.Instance:Reopen(Urls.DungeonMaterailSubView)
    end)
  else
    UIManager.Instance:Reopen(Urls.DungeonMaterailSubView)
  end
end

function DungeonMaterialView:_OnClickActivityAchievement()
  CopyDataUtils.OpenCopyAchievePanelConstKey("DailyMaterialPerfectRewardTaskGroup", nil, LT.Text("InterludeStageRewardsTitle"))
end

return DungeonMaterialView
