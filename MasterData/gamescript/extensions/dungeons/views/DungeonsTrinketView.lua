local DungeonsTrinketView, Super = NewClass("DungeonsTrinketView", DungeonMaterialView)
DungeonsTrinketView.uiResCls = UI_Dungeons_Trinket_ViewResource

function DungeonsTrinketView:_InitData()
  self.stageGroupType = CommonDefine.StageGroupType.TrinketCopy
  DungeonMaterialModel.Instance:SetStageGroupType(self.stageGroupType)
  DungeonMaterialController.Instance:SetStageGroupList()
  self.featureId = CommonDefine.FeatureId.TrinketCopy
  self.stageGroupData = DungeonMaterialModel.Instance:GetStageGroupData(self.stageGroupType)
end

function DungeonsTrinketView:_StageCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_Common_Element)
  local stageData = {
    redFunc = RedPointDataUtils.IsShowTrinketSubCopyNew,
    redType = RedPointDataUtils.RedType.TrinketCopyNew,
    stageData = self.stageGroupData[index],
    featureId = self.featureId
  }
  self:AddViewComponentOnce(cell.gameObject, DungeonMaterialCell, stageData)
  return cell
end

function DungeonsTrinketView:_RefreshUI(options)
  options = options or {}
  if not self.ui or IsNil(self.ui.uiNode) then
    return
  end
  if options.playOpenAnim and self.uiAnimController then
    self.uiAnimController:PlayState("UI_Dungeons_Trinket_View_Open")
  end
  self.stageGroupId = DungeonMaterialModel.Instance:GetStageGroupId() or self.stageGroupData[1].ID
  DungeonMaterialModel.Instance:SetStageGroupId(self.stageGroupId)
  self.rewardData = DungeonMaterialController.Instance:GetStageGroupReawrds(self.stageGroupId)
  if options.playOpenAnim and not options.skipStageFade then
    self.showFadeInAnim = true
    self.scrollView.verticalNormalizedPosition = 1
  elseif options.playOpenAnim then
    self.scrollView.verticalNormalizedPosition = 1
  end
  self:SetButtonText(self.ui.Btn_Enter, LT.Text("DailyCopy_Start"))
  self:_RefrshInfoDetail(self.stageGroupId)
end

function DungeonsTrinketView:_OnClickActivityAchievement()
  CopyDataUtils.OpenCopyAchievePanelConstKey("TrinketCopyPerfectRewardTaskGroup", nil, LT.Text("InterludeStageRewardsTitle"))
end

function DungeonsTrinketView:RegisterAchievementRedDot()
  self.binder:BindComponent(RedDotComponent(self.ui.RedDot_ActivityAchievement, CommonDefine.RedDotType.Red, nil, function()
    do return RedPointDataUtils.IsTaskListRedByConstKey end
    return RedPointDataUtils.IsTaskListRedByConstKey, "TrinketCopyPerfectRewardTaskGroup"
  end))
end

return DungeonsTrinketView
