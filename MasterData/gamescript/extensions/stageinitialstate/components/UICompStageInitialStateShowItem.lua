local UICompStageInitialStateShowItem, Super = NewViewComponent("UICompStageInitialStateShowItem", UICompStageInitialStateBtn)

function UICompStageInitialStateShowItem:ctor(uiNode, view, stageId, clickFunc)
  Super.ctor(self, uiNode, view, stageId, clickFunc)
end

function UICompStageInitialStateShowItem:_InitQuestionBtn()
  self.ui.UI_Common_Btn_Question:SetActive(false)
end

function UICompStageInitialStateShowItem:_InitName()
  self:SetText(self.ui.Text_Suppress, LT.Text(StageInitialStateModel.Instance:GetStageInitStateText(self.stageId)))
end

function UICompStageInitialStateShowItem:_OnClick()
end

return UICompStageInitialStateShowItem
