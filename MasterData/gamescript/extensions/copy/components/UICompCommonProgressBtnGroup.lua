local UICompCommonProgressBtnGroup, Super = NewViewComponent("UICompCommonProgressBtnGroup")

function UICompCommonProgressBtnGroup:ctor(uiNode, view, stageGroupId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Btn_Level3Resource(uiNode)
  self.stageGroupId = stageGroupId
end

function UICompCommonProgressBtnGroup:OnEnterComponent()
  local curProgress, limitProgress = MainCopyDataUtils.GetAchievementProgress(self.stageGroupId)
  local isActived = 0 ~= limitProgress
  self.ui.uiNode:SetActive(isActived)
  if not isActived then
    return
  end
  self:SetText(self.ui.Text_Name, LT.Text("CopyAchievementBtnGroupName"))
  self:SetText(self.ui.Text_Progress_Cur, curProgress)
  self:SetText(self.ui.Text_Progress_Limit, limitProgress)
  self:AddButtonClickListener(self.ui.Btn_Progress, function()
    if self.clickFunc then
      self.clickFunc()
      return
    end
    MainCopyDataUtils.OpenMainCopyAchievementTips(self.stageGroupId)
  end)
  self:AddViewComponentOnce(self.ui.RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, function()
    do return RedPointDataUtils.IsShowStageGroupAchievementReward end
    return RedPointDataUtils.IsShowStageGroupAchievementReward, self.stageGroupId
  end)
end

return UICompCommonProgressBtnGroup
