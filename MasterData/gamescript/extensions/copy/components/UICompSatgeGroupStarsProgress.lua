local UICompSatgeGroupStarsProgress, Super = NewViewComponent("UICompSatgeGroupStarsProgress")

function UICompSatgeGroupStarsProgress:ctor(uiNode, view, stageGroupId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Btn_Level3Resource(uiNode)
  self.stageGroupId = stageGroupId
end

function UICompSatgeGroupStarsProgress:RegisterEvents()
  local function onClickBtnProgress()
    local stageGroupCfg = DT.StageGroup[self.stageGroupId]
    
    local star = MainCopyDataUtils.GetStageGroupCurStar(self.stageGroupId)
    local curGroupData = CopyMainModel.Instance:GetGroupData(self.stageGroupId)
    UIManager.Instance:Reopen(Urls.MainCopyProgressRewardPanel, stageGroupCfg.StageGroupDrop, star, self.stageGroupId, curGroupData.starGainInfo)
  end
  
  if self.view.AddButtonClickListener then
    self:AddButtonClickListener(self.ui.Btn_Progress, onClickBtnProgress)
  else
    self.binder:BindButtonClick(self.ui.Btn_Progress, onClickBtnProgress)
  end
end

function UICompSatgeGroupStarsProgress:OnEnterComponent()
  local SetText = self.view.SetText
  local obj = self
  if not SetText then
    SetText = self.binder.SetText
    obj = self.binder
  end
  local curStar = MainCopyDataUtils.GetStageGroupCurStar(self.stageGroupId)
  local totalStar = MainCopyDataUtils.GetTotalStar(self.stageGroupId)
  SetText(obj, self.ui.Text_Progress_Cur, curStar)
  SetText(obj, self.ui.Text_Progress_Limit, totalStar)
  SetText(obj, self.ui.Text_Name, LT.Text("CopyCollectBtnGroupName"))
  self:AddRedPoint(self.ui.RedDot, RedDotDefine.DynamicRedDotID.StageGroupStarsProgRedDot, {
    stageGroupTid = self.stageGroupId
  })
end

return UICompSatgeGroupStarsProgress
