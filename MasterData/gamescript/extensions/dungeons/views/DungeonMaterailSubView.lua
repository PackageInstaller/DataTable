local DungeonMaterailSubView, Super = NewClass("DungeonMaterailSubView", BaseView)
DungeonMaterailSubView.uiResCls = UI_Dungeous_SecEntrance_ViewResource

function DungeonMaterailSubView:ctor(stageId)
  Super.ctor(self)
  self.stageId = stageId
end

function DungeonMaterailSubView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnMaterialStageChange, self._RefrshInfoDetail, self)
  self:RegisterNotify(NotifyId.OnStageDataChanged, self._OnStageDataChanged, self)
end

function DungeonMaterailSubView:_OnStageDataChanged(stageGroupId)
  if stageGroupId and self.stageGroupId and stageGroupId ~= self.stageGroupId then
    return
  end
  self.stageData = DungeonMaterialModel.Instance:GetStageData()
  if not self.stageView then
    return
  end
  self.stageView:ReloadData()
end

function DungeonMaterailSubView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Challenge, System.fn(self, self._OnClickChallenge))
  self:AddButtonClickListener(self.ui.Btn_Sweep, System.fn(self, self._OnClickSweep))
  self:AddButtonClickListener(self.ui.Btn_Replay, System.fn(self, self._OnClickReplay))
end

function DungeonMaterailSubView:OnEnterView()
  Super.OnEnterView(self)
  self.stageData = DungeonMaterialModel.Instance:GetStageData()
  self.stageId = self.stageId or self:GetDefaultStageId(self.stageData)
  self.stageGroupType = DungeonMaterialController.Instance:GetStageGroupType()
  self.stageGroupId = DungeonMaterialModel.Instance:GetStageGroupId()
  self.InitRelicData = DungeonMaterialController.Instance:GetStageInitRelic()
  self.showFadeInAnim = true
  self:_InitUI()
  self:_RefrshInfoDetail(self.stageId)
end

function DungeonMaterailSubView:OnExitView()
  Super.OnExitView(self)
end

function DungeonMaterailSubView:AfterSetRenderTrue()
  Super.AfterSetRenderTrue(self)
  if self.stageGroupType == nil or nil == self.stageGroupId then
    return
  end
  DungeonMaterialModel.Instance:SetStageGroupType(self.stageGroupType)
  DungeonMaterialModel.Instance:SetStageGroupId(self.stageGroupId)
end

function DungeonMaterailSubView:_InitUI()
  local stageGroupId = DungeonMaterialModel.Instance:GetStageGroupId()
  local stageGroupCfg = DT.StageGroup[stageGroupId]
  local coinList = DungeonMaterialModel.Instance:GetCoinList()
  self:SetText(self.ui.Text_Title, stageGroupCfg.Name or "")
  self:SetText(self.ui.Text_Special_Desc, stageGroupCfg.DailyIcon[2] or "")
  self:SetButtonText(self.ui.Btn_Challenge, LT.Text("DailyCopy_Start"))
  self:_InitTableView()
  self.ui.Group_Award:SetActive(false)
  self:AddViewComponent(self.ui.UI_Common_Btn_Back2, UICompBtnCloseItem, System.fn(self, self._OnClickClose))
  self:AddViewComponentOnce(self.ui.Group_Icon, UICompCommonCurrencyGroupItem, coinList)
  self:AddViewComponentOnce(self.ui.UI_Common_Btn_StageChapter, CopyChapterMvcItem, self.stageId)
end

function DungeonMaterailSubView:_InitTableView()
  self.stageView = self:CreateTableview(self.ui.ScrollView_Difficulty, function()
    if not self.stageData then
      return 0
    end
    return #self.stageData
  end, function(view, index)
    do return self._StageCellAtIndex, self, view end
    return self._StageCellAtIndex, self, view, index
  end)
  
  function self.stageView.reloadFinishCallback()
    if self.showFadeInAnim then
      self:PlayTableViewFadeInAnim(self.ui.ScrollView_Difficulty)
      self.showFadeInAnim = false
    end
  end
  
  self.InitRelicView = self:CreateTableview(self.ui.ScrollView_Initial, function()
    if not self.InitRelicData then
      return 0
    end
    return #self.InitRelicData
  end, function(view, index)
    do return self._RelicCellAtIndex, self, view end
    return self._RelicCellAtIndex, self, view, index
  end)
  self.rewardView = self:CreateTableview(self.ui.ScrollView_Article, function()
    if not self.rewardData then
      return 0
    end
    return #self.rewardData
  end, function(view, index)
    do return self._RewardCellAtIndex, self, view end
    return self._RewardCellAtIndex, self, view, index
  end)
end

function DungeonMaterailSubView:_StageCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_Common_Tier)
  local stageData = self.stageData[index]
  self:AddViewComponentOnce(cell.gameObject, DungeonMaterialSubCell, stageData)
  return cell
end

function DungeonMaterailSubView:_RelicCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_Award_Creation)
  local relicData = {
    relicTid = self.InitRelicData[index],
    hideName = false
  }
  self:AddViewComponentOnce(cell.gameObject, UICompRelicIconItem, relicData)
  return cell
end

function DungeonMaterailSubView:_RewardCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
  local item = self.rewardData[index]
  local itemCfg = DT.Item[item.tid]
  local itemCount = itemCfg.Type == "DropItem" and "" or item.num
  local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
  local hasTag = item.type and item.type ~= CommonDefine.ItemAwardType.Normal
  local itemData = {
    itemTid = item.tid,
    itemCount = itemCount,
    extraDesc = hasTag and itemAwardTypeDescMap[item.type] or nil,
    extraDescBgType = hasTag and CommonDefine.CommonIconExtraDescBgType.Blue or nil,
    isGot = item.isGot == true
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, itemData)
  return cell
end

function DungeonMaterailSubView:GetDefaultStageId(stageDataList)
  do return CopyDataUtils.GetDefaultStageTid end
  return CopyDataUtils.GetDefaultStageTid, stageDataList
end

function DungeonMaterailSubView:_RefrshInfoDetail(stageId)
  DungeonMaterialModel.Instance:SetStageId(stageId)
  self.stageId = stageId
  self.InitRelicData = DungeonMaterialController.Instance:GetStageInitRelic()
  self.rewardData = DungeonMaterialController.Instance:GetStageRewars()
  self.stageView:ReloadData()
  local stageCfg = DT.Stage[stageId]
  if stageCfg then
    self.ui.Text_Empty_Creation:SetActive(not self.InitRelicData)
    self:SetImage(self.ui.Image_D_Bg, stageCfg.Backgrand)
    self:SetImage(self.ui.Image_Coin_Icon, ItemDataUtils.GetItemIcon(CommonDefine.CurrencyType.Energy))
    self:SetText(self.ui.Text_Name, stageCfg.Name)
    self:SetText(self.ui.Text_Introduce, stageCfg.Desc)
    self:SetText(self.ui.Text_Coin_Count, stageCfg.Cost)
    self:SetText(self.ui.Text_Empty_Creation, LT.Text("StageRelicEmpty"))
    self.InitRelicView:ReloadData()
    self.rewardView:ReloadData()
  end
  local starLevel = DungeonMaterialController.Instance:GetStarLevel(stageId)
  local starData = {
    stageTid = stageId,
    star = starLevel,
    clickFunc = function()
      if stageId then
        UIManager.Instance:Reopen(Urls.StageStarDetailPanel, {stageTid = stageId, star = starLevel})
      else
        Logger.Warn("没有传入stageTid")
      end
    end
  }
  self:AddViewComponentOnce(self.ui.Group_Star, CompStageStar, starData)
  local isCanSweep = DungeonMaterialController.Instance:IsStageCanSweep()
  self.ui.Btn_Sweep:SetActive(isCanSweep)
  if StageModel.Instance:IsStageCanSweepBySweepType(stageId) then
    self.ui.Btn_Sweep.transform:SetAsLastSibling()
  else
    self.ui.Btn_Challenge.transform:SetAsLastSibling()
  end
  local challengeBtnState = DungeonMaterialController.Instance:GetChallengeBtnState()
  self:SetButtonState(self.ui.Btn_Challenge, challengeBtnState)
  local sweepBtnState = DungeonMaterialController.Instance:GetSweepBtnState()
  self:SetButtonState(self.ui.Btn_Sweep, sweepBtnState)
  self:SetActive(self.ui.Btn_Replay, true)
  self:SetText(self.ui.Text_C_Replay, LT.PanelText("UI_Event_Panel_Challenge_Text_C_Replay"))
end

function DungeonMaterailSubView:_OnClickClose()
  self:Close()
end

function DungeonMaterailSubView:_OnClickChallenge()
  if not DungeonMaterialController.Instance:CheckCanChallengeAndShowTips() then
    return
  end
  local stageCfg = DT.Stage[self.stageId]
  if PlayerDataUtils.GetEnergy() < stageCfg.Cost then
    PlayerDataUtils.ShowEnergyRestorePanel()
    return
  end
  if DungeonMaterialController.Instance:CheckTrinketCntIsMax() then
    return
  end
  WorldStageManager.Instance:CheckOpen(self.stageId, function()
    StageExitPanelManager.Instance:PushWhenMaterialCopyExit(self.stageId)
  end, {})
end

function DungeonMaterailSubView:_OnClickSweep()
  if not DungeonMaterialController.Instance:CheckCanChallengeAndShowTips() then
    return
  end
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(self.stageGroupType)
  local isLock = DungeonMaterialModel.Instance:IsLockedStage(self.stageId)
  if not showLevelLimit and isLock then
    Alert.ShowStr(DungeonMaterialController.Instance:GetStageUnlockTips(self.stageId))
    return
  end
  if DungeonMaterialController.Instance:CheckTrinketCntIsMax() then
    return
  end
  CopyDataUtils.OpenSweepPanel(self.stageId)
end

function DungeonMaterailSubView:_OnClickReplay()
  CopyRecordsController.Instance:OpenCopyRecordsView(self.stageId)
end

return DungeonMaterailSubView
