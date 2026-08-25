local StageInitialStateBtnItem, Super = System.NewComponent("StageInitialStateBtnItem")

function StageInitialStateBtnItem:ctor(uiNode, getStageIdFunc, onClick)
  Super.ctor(self)
  self.ui = UI_Common_Melt_DisasterResource(uiNode)
  self.getStageIdFunc = getStageIdFunc
  self.onClick = onClick
end

function StageInitialStateBtnItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Suppress, function()
    do return LT.Text, StageInitialStateModel.Instance:GetStageInitStateText(self.getStageIdFunc()) end
    return LT.Text, StageInitialStateModel.Instance:GetStageInitStateText(self.getStageIdFunc())
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, function()
    if self.onClick then
      self.onClick()
    end
  end)
  binder:BindToRaw(function(c_binder, stageId)
    if not stageId then
      return
    end
    if not StageInitialStateModel.Instance:ExistsInitialState(stageId) then
      return
    end
    local hasBuffState = StageInitialStateModel.Instance:HasPositiveInitialBuffState(stageId)
    local btnFramePath = CommonRes.StageInitialStateBtnFrame.Debuff
    local btnIconPath = CommonRes.StageInitialStateBtnIcon.Debuff
    if hasBuffState then
      btnFramePath = CommonRes.StageInitialStateBtnFrame.Buff
      btnIconPath = CommonRes.StageInitialStateBtnIcon.Buff
    end
    c_binder:SetImage(self.ui.Image_Suppress, btnFramePath)
    c_binder:SetImage(self.ui.Image_Feedback, btnIconPath)
  end, function()
    if self.getStageIdFunc then
      do return end
      return self.getStageIdFunc, nil
    end
  end)
end

function StageInitialStateBtnItem:OnTodoFunc()
end

return StageInitialStateBtnItem
