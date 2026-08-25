local WeekBossView, Super
WeekBossView, Super = NewClass("WeekBossView", BaseView)
WeekBossView.uiResCls = UI_Dungeons_Panel_WeekBOSS_OptimizedResource

function WeekBossView:ctor(jumpStageGroupId)
  Super.ctor(self)
  self.exModel = WeekBossExtModel.Instance
  jumpStageGroupId = jumpStageGroupId or self.exModel:GetSelectedStageGroupId()
  local stageGroupIdList = CopyDataUtils.GetStageGroupIdList(CommonDefine.StageGroupType.WeekBoss, true)
  self.exModel:SetStageGroupIdList(stageGroupIdList)
  self.exModel:SetSelectedStageGroupId(jumpStageGroupId)
  self.showFadeInAnim = true
end

function WeekBossView:OnBuildView()
  Super.OnBuildView(self)
end

function WeekBossView:RefreshOnRendered()
  self:PlayTableViewFadeInAnim(self.ui.ScrollView_List)
  self.uiAnimController:PlayState("UI_Dungeons_Panel_WeekBOSS_Open")
end

function WeekBossView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_C_ActivityAchievement, LT.Text("InterludeStageRewardsTitle"))
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self.chapterTabView:ReloadData()
  self:OnWeekBossStageGroupId(self.exModel:GetSelectedStageGroupId())
  self:SetRefreshTime()
  self:_RefreshRewardNum()
  PlayerDataUtils.OpenFirstTimeIllustrate(self.__name, LT.Text("WeeklyBossTitle"), LT.Text("WeeklyBossInstructions"))
end

function WeekBossView:OnEnterViewFinished()
  self.uiAnimController:PlayState("UI_Dungeons_Panel_WeekBOSS_Open")
end

function WeekBossView:RegisterEvents()
  Super.RegisterEvents(self)
  self:_RegisterChapterTabViewEvents()
  self:_RegisterRewardTabViewEvents()
  self:AddButtonClickListener(self.ui.Btn_Enter, System.fn(self, self.OnBtnEnter))
  self:AddButtonClickListener(self.ui.Button_Info, System.fn(self, self.OnBtnInfo))
  self:AddButtonClickListener(self.ui.Btn_ActivityAchievement, System.fn(self, self.OnBtnActivityAchievement))
  self:RegisterAchievementRedDot()
  self:BindEvent(EventMgr.Instance.OnSyncWeekBossData, System.fn(self, self._OnSyncWeekBossData))
end

function WeekBossView:_OnSyncWeekBossData()
  self:_RefreshRewardNum()
end

function WeekBossView:RegisterAchievementRedDot()
  self.binder:BindComponent(RedDotComponent(self.ui.RedDot_ActivityAchievement, CommonDefine.RedDotType.Red, nil, function()
    do return RedPointDataUtils.IsTaskListRedByConstKey end
    return RedPointDataUtils.IsTaskListRedByConstKey, "WeekBossChallengePerfectRewardTaskGroup"
  end))
end

function WeekBossView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnWeekBossStageGroupId, self.OnWeekBossStageGroupId, self)
end

function WeekBossView:_RegisterChapterTabViewEvents()
  local stageGroupIdList = self.exModel:GetStageGroupIdList()
  self.chapterTabView = self:CreateTableview(self.ui.ScrollView_List, function()
    return #stageGroupIdList
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.Temp_Toggle_Item)
    self:SetChapterTabCell(cell, index, stageGroupIdList[index])
    return cell
  end)
  local needMoveStageGroupInSight = true
  
  function self.chapterTabView.reloadFinishCallback()
    if needMoveStageGroupInSight then
      needMoveStageGroupInSight = false
      local jumpStageGroupId = self.exModel:GetSelectedStageGroupId()
      for i = 1, #stageGroupIdList do
        if stageGroupIdList[i] == jumpStageGroupId then
          self.chapterTabView:MoveCellInView(i - 1)
          break
        end
      end
    end
    if self.showFadeInAnim then
      self:PlayTableViewFadeInAnim(self.ui.ScrollView_List)
      self.showFadeInAnim = false
    end
  end
end

function WeekBossView:SetChapterTabCell(cell, index, stageGroupId)
  local stageGroupIdList = self.exModel:GetStageGroupIdList()
  local stageGroupId = stageGroupIdList[index]
  local viewData = {stageGroupId = stageGroupId, index = index}
  self:AddViewComponentOnce(cell.gameObject, WeekBossToggleItem, viewData)
end

function WeekBossView:_RegisterRewardTabViewEvents()
  local sizeDelta = self.ui.IconNode.transform.sizeDelta
  local width, height = sizeDelta.x, sizeDelta.y
  self.rewardListView = self:CreateTableview(self.ui.ScrollView_Award, function()
    return #self.exModel:GetPreviewRewards()
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.IconNode)
    self:_RewardTabCellAtIndex(cell.gameObject, index)
    return cell
  end, function()
    return width, height
  end)
end

function WeekBossView:_RewardTabCellAtIndex(gameObject, index)
  local previewRewards = self.exModel:GetPreviewRewards()
  local tid = previewRewards[index]
  local itemData = {
    tid = tid,
    hideGroupDown = true,
    hideIsNew = true,
    onClick = function()
      ItemDataUtils.ShowItemDetailTips(self.binder, gameObject, nil, tid)
    end
  }
  self:SetIcon(MaterialIconType.CommonIcon, gameObject, itemData)
end

function WeekBossView:OnWeekBossStageGroupId(stageGroupId)
  local stageGroupCfg = WeekBossExtModel.Instance:GetStageGroupCfg(stageGroupId)
  if not stageGroupCfg then
    return
  end
  if stageGroupCfg.Backgrand then
    self:SetImage(self.ui.Image_Main_Bg, stageGroupCfg.Backgrand)
  end
  self.rewardListView:ReloadData()
  self:SetText(self.ui.Text_Name, stageGroupCfg.Name or "")
  self:SetText(self.ui.Text_Desc, stageGroupCfg.Desc or "")
  self.ui.UI_Awaker_Button_Addition:SetActive(false)
  self:SetButtonText(self.ui.Btn_Enter, LT.Text("DailyCopy_Start"))
end

function WeekBossView:SetRefreshTime()
  local timeDesc = self.exModel:GetWeekBossRefreshTimeDesc()
  self:SetText(self.ui.Text_CountDown, timeDesc)
end

function WeekBossView:_RefreshRewardNum()
  self:SetText(self.ui.Text_AwardNum1, self.exModel:GetWeekRewardCountTotal())
  local numLeft = self.exModel:GetWeekRewardCountLeft()
  self:SetText(self.ui.Text_AwardNum2, numLeft)
  local numLeftColor = numLeft > 0 and CommonDefine.ColorType.Normal or CommonDefine.ColorType.Dark
  self:SetTextColorType(self.ui.Text_AwardNum2, numLeftColor)
  self:SetText(self.ui.Text_AwardNumLine, "/")
end

function WeekBossView:OnBtnEnter()
  WeekBossController.Instance:EnterStageGroup()
end

function WeekBossView:OnBtnInfo()
  WeekBossController.Instance:ShowWeekBossIntroduction()
end

function WeekBossView:OnBtnActivityAchievement()
  CopyDataUtils.OpenCopyAchievePanelConstKey("WeekBossChallengePerfectRewardTaskGroup", nil, LT.Text("InterludeStageRewardsTitle"))
end

return WeekBossView
