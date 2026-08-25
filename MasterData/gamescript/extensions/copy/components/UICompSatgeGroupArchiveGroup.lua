local UICompSatgeGroupArchiveGroup, Super = NewViewComponent("UICompSatgeGroupArchiveGroup")

function UICompSatgeGroupArchiveGroup:ctor(uiNode, view, stageGroupId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Btn_Level3Resource(uiNode)
  self.stageGroupId = stageGroupId
end

function UICompSatgeGroupArchiveGroup:RegisterEvents()
  local function onClickBtnArchivement()
    MainCopyDataUtils.OpenMainCopyAchievementTips(self.stageGroupId)
  end
  
  if self.view.AddButtonClickListener then
    self:AddButtonClickListener(self.ui.Btn_Progress, onClickBtnArchivement)
  else
    self.binder:BindButtonClick(self.ui.Btn_Progress, onClickBtnArchivement)
  end
end

function UICompSatgeGroupArchiveGroup:OnEnterComponent()
  local curProgress, limitProgress = MainCopyDataUtils.GetAchievementProgress(self.stageGroupId)
  local isActived = 0 ~= limitProgress
  self.ui.uiNode:SetActive(isActived)
  if isActived then
    local SetText = self.view.SetText
    local obj = self
    if not SetText then
      SetText = self.binder.SetText
      obj = self.binder
    end
    SetText(obj, self.ui.Text_Progress_Cur, LT.Text(curProgress))
    SetText(obj, self.ui.Text_Progress_Limit, LT.Text(limitProgress))
    SetText(obj, self.ui.Text_Name, LT.Text("CopyAchievementBtnGroupName"))
    self:AddRedPoint(self.ui.RedDot, RedDotDefine.DynamicRedDotID.StageGroupArchivementRedDot, {
      stageGroupTid = self.stageGroupId
    })
  end
end

return UICompSatgeGroupArchiveGroup
