local UICompStageInitialStateBtn, Super = NewViewComponent("UICompStageInitialStateBtn")

function UICompStageInitialStateBtn:ctor(uiNode, view, stageId, clickFunc)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Melt_DisasterResource(uiNode)
  self.stageId = stageId
  self.clickFunc = clickFunc
end

function UICompStageInitialStateBtn:RegisterNotifications()
end

function UICompStageInitialStateBtn:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClick))
end

function UICompStageInitialStateBtn:OnEnterComponent()
  self:Refresh()
  self:_InitQuestionBtn()
  self:_InitName()
end

function UICompStageInitialStateBtn:_InitName()
  self:SetText(self.ui.Text_Suppress, LT.Textf("DisasterReliefKuroshioEntryNameFormat", LT.Text("DisasterReliefKuroshio"), LT.Text(StageInitialStateModel.Instance:GetStageInitStateText(self.stageId))))
end

function UICompStageInitialStateBtn:Refresh(stageId)
  self.stageId = stageId or self.stageId
  local existsInitStates = StageInitialStateModel.Instance:ExistsInitialState(self.stageId)
  local isHide = StageInitialStateModel.Instance:IsHideStageInitState(self.stageId)
  self.ui.uiNode:SetActive(not (not existsInitStates or isHide) and true or false)
  if not existsInitStates or isHide then
    return
  end
  self:_RefreshBtnFrame()
  self:_RefreshBtnIcon()
end

function UICompStageInitialStateBtn:_RefreshBtnFrame()
  local btnFramePath = CommonRes.StageInitialStateBtnFrame.Debuff
  if StageInitialStateModel.Instance:HasPositiveInitialBuffState(self.stageId) then
    btnFramePath = CommonRes.StageInitialStateBtnFrame.Buff
  end
  self:SetImage(self.ui.Image_Suppress, btnFramePath)
end

function UICompStageInitialStateBtn:_RefreshBtnIcon()
  local btnIconPath = CommonRes.StageInitialStateBtnIcon.Debuff
  if StageInitialStateModel.Instance:HasPositiveInitialBuffState(self.stageId) then
    btnIconPath = CommonRes.StageInitialStateBtnIcon.Buff
  end
  self:SetImage(self.ui.Image_Feedback, btnIconPath)
end

function UICompStageInitialStateBtn:_OnClick()
  UIManager.Instance:Reopen(Urls.StageInitialStateDetailView, self.stageId)
  if self.clickFunc then
    self.clickFunc()
  end
end

function UICompStageInitialStateBtn:_InitQuestionBtn()
  self.ui.UI_Common_Btn_Question:SetActive(true)
end

function UICompStageInitialStateBtn:OnExitComponent()
  Super.OnExitComponent(self)
end

return UICompStageInitialStateBtn
