local DungeonBattleTeachingView, Super = NewClass("DungeonBattleTeachingView", BaseView)
DungeonBattleTeachingView.uiResCls = UI_Dungeons_BattleTeaching_ViewResource

function DungeonBattleTeachingView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnMaterialStageChange, self._OnMaterialStageChange, self)
  self:RegisterNotify(NotifyId.OnStageDataChanged, self._OnStageDataSync, self)
  self:BindEvent(EventMgr.Instance.OnSyncStageInfoEvent, System.fn(self, self._OnStageDataSyncEvent))
  NewbieGuideManager.Instance:RegisterNewbieGo("UI_Dungeons_BattleTeaching_View.GuideRoot", self.ui.GuideRoot, Urls.DungeonBattleTeachingView)
  NewbieGuideManager.Instance:RegisterNewbieGo("UI_Dungeons_BattleTeaching_View.Btn_Enter", self.ui.Btn_Enter, Urls.DungeonBattleTeachingView)
end

function DungeonBattleTeachingView:_IsMyStageGroupType(stageGroupId)
  if not self.stageGroupType then
    return true
  end
  if not stageGroupId then
    return true
  end
  local cfg = DT.StageGroup[stageGroupId]
  return cfg and cfg.Type == self.stageGroupType
end

function DungeonBattleTeachingView:_OnStageDataSync(stageGroupId)
  if not self:_IsMyStageGroupType(stageGroupId) then
    return
  end
  if not self.stageView then
    return
  end
  self:_InitViewData()
  self:_RefreshView()
end

function DungeonBattleTeachingView:_OnStageDataSyncEvent()
  self:_OnStageDataSync(nil)
end

function DungeonBattleTeachingView:_OnMaterialStageChange(stageTid)
  self._selectStageTid = stageTid
  self:_RefrshStageInfo()
end

function DungeonBattleTeachingView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Enter, System.fn(self, self._OnClickEnter))
end

function DungeonBattleTeachingView:_OnClickEnter()
  GuideManager.Instance:ClearBattleTriggeredGuideList()
  WorldStageManager.Instance:CheckOpen(self._selectStageTid, function()
    StageExitPanelManager.Instance:PushPanel(Urls.TaskMainView, CommonDefine.TaskPage.BattleTeaching)
  end)
end

function DungeonBattleTeachingView:OnEnterView()
  Super.OnEnterView(self)
  self:_CreateTableView()
  self.stageGroupType = CommonDefine.StageGroupType.BattleTeaching
  self.featureId = CommonDefine.FeatureId.BattleTeaching
  DungeonMaterialModel.Instance:SetStageGroupType(self.stageGroupType)
  DungeonMaterialController.Instance:SetStageGroupList()
  self:SetCanvasGroup(self.ui.uiNode, 0)
  CopyController.Instance:ReqBattleTeachingStageData(System.fn(self, self._OnBattleTeachingStageDataReady))
end

function DungeonBattleTeachingView:_OnBattleTeachingStageDataReady()
  self:_InitViewData()
  self:_RefreshView()
end

function DungeonBattleTeachingView:RefreshOnRendered()
  if self.stageGroupType and self.stageGroupId then
    DungeonMaterialModel.Instance:SetStageGroupType(self.stageGroupType)
    DungeonMaterialModel.Instance:SetStageGroupId(self.stageGroupId)
  end
  CopyController.Instance:ReqBattleTeachingStageData(System.fn(self, self._RefreshView))
end

function DungeonBattleTeachingView:_InitViewData()
  self.stageGroupType = CommonDefine.StageGroupType.BattleTeaching
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self.scrollView = self.ui.ScrollView_List:GetComponentInParent(typeof(CS.UnityEngine.UI.ScrollRect))
  self.featureId = CommonDefine.FeatureId.BattleTeaching
  DungeonMaterialModel.Instance:SetStageGroupType(self.stageGroupType)
  DungeonMaterialController.Instance:SetStageGroupList()
  self.stageGroupId = self:_GetStageGroupTid()
  DungeonMaterialModel.Instance:SetStageGroupId(self.stageGroupId)
  self.stageDataList = DungeonMaterialModel.Instance:GetStageData()
  table.sort(self.stageDataList, function(a, b)
    local isDrawA = a.firstRewardDraw and 1 or 0
    local isDrawB = b.firstRewardDraw and 1 or 0
    if isDrawA ~= isDrawB then
      return isDrawA < isDrawB
    end
    local cfgA = DT.Stage[a.stageID]
    local cfgB = DT.Stage[b.stageID]
    return cfgA.BaseSortID < cfgB.BaseSortID
  end)
  self._selectStageTid = self.stageDataList and self.stageDataList[1] and self.stageDataList[1].stageID
end

function DungeonBattleTeachingView:_GetStageGroupTid()
  local rst = DungeonMaterialModel.Instance:GetStageGroupId()
  if not rst then
    local stageGroupList = DungeonMaterialModel.Instance:GetStageGroupData(self.stageGroupType)
    rst = stageGroupList and stageGroupList[1] and stageGroupList[1].ID
  end
  return rst
end

function DungeonBattleTeachingView:_RefreshView()
  self.uiAnimController:PlayState("UI_Dungeons_Material_View_Open")
  self.showFadeInAnim = true
  self.scrollView.verticalNormalizedPosition = 1
  self:_RefrshStageInfo()
end

function DungeonBattleTeachingView:_RefrshStageInfo()
  DungeonMaterialModel.Instance:SetStageId(self._selectStageTid)
  self.rewardData = CopyDataUtils.GetStageRewardPreviewList(self._selectStageTid)
  self.stageView:ReloadData()
  self.rewardView:ReloadData()
  self:SetButtonState(self.ui.Btn_Enter, CommonDefine.BtnType.High)
  local stageCfg = DT.Stage[self._selectStageTid]
  if stageCfg then
    self:SetImage(self.ui.Image_Main_Bg, stageCfg.Backgrand)
    self:SetText(self.ui.Text_Name, LT.Text(stageCfg.Name))
    self:SetText(self.ui.Text_Desc, LT.Text(stageCfg.Desc))
  end
end

function DungeonBattleTeachingView:_CreateTableView()
  self.stageView = self:CreateTableview(self.ui.ScrollView_List, function()
    if not self.stageDataList then
      return 0
    end
    return #self.stageDataList
  end, function(view, index)
    do return self._StageCellAtIndex, self, view end
    return self._StageCellAtIndex, self, view, index
  end)
  local needMoveStageInSight = true
  self.showFadeInAnim = true
  
  function self.stageView.reloadFinishCallback()
    if needMoveStageInSight then
      needMoveStageInSight = false
      local curStageGroup = DungeonMaterialModel.Instance:GetStageGroupId()
      for i = 1, #self.stageDataList do
        if self.stageDataList[i].ID == curStageGroup then
          self.stageView:MoveCellInView(i - 1)
          break
        end
      end
    end
    if self.showFadeInAnim then
      self:PlayTableViewFadeInAnim(self.ui.ScrollView_List)
      self.showFadeInAnim = false
    end
  end
  
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

function DungeonBattleTeachingView:_StageCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.Temp_Toggle_Item)
  self:AddViewComponentOnce(cell.gameObject, DungeonBattleTeachingSubCell, self.stageDataList[index])
  return cell
end

function DungeonBattleTeachingView:_RewardCellAtIndex(view, index)
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

return DungeonBattleTeachingView
