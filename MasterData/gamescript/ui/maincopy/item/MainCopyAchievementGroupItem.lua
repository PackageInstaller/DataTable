local MainCopyAchievementGroupItem, Super = System.NewComponent("MainCopyAchievementGroupItem")

function MainCopyAchievementGroupItem:ctor(uiNode, stageData)
  Super.ctor(self)
  self.ui = UI_Chapter_Item_Level_SuccessResource(uiNode)
  self.stageData = stageData
  self.stageCfg = DT.Stage[stageData.stageID]
end

function MainCopyAchievementGroupItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Overview, function()
    local stageNumber = CopyDataUtils.GetStageNameNumber(self.stageCfg.ID)
    local stageName = LT.Text(self.stageCfg.Name)
    if not CopyDataUtils.CheckStageIsInOpenTime(self.stageData.stageID) then
      stageName = StrUtils.GetConfuseText(self.ui.Text_Overview, stageName)
    end
    do return string.format, "%s %s", stageNumber end
    return string.format, "%s %s", stageNumber, stageName
  end)
  self:_BindAchievementGroup(binder)
end

function MainCopyAchievementGroupItem:_BindAchievementGroup(binder)
  for idx, taskId in pairs(self.stageCfg.LevelAchieve) do
    binder:BindNewComponent(self.ui.Content, MainCopyAchievementItem, UI_Chapter_Item_Success_ListResource, taskId, self.stageData)
  end
end

return MainCopyAchievementGroupItem
