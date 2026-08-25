local CommonProgressBtnGroup, Super = System.NewComponent("CommonProgressBtnGroup")

function CommonProgressBtnGroup:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Common_Btn_Level3Resource(uiNode)
  self.curProgressTextFunc = data.curProgressTextFunc
  self.limitProgressTextFunc = data.limitProgressTextFunc
  self.activeFunc = data.activeFunc
  self.clickFunc = data.clickFunc
  self.nameTextFunc = data.nameTextFunc
end

function CommonProgressBtnGroup:OnBind(binder)
  binder:BindToVisible(self.ui.uiNode, self.activeFunc)
  binder:BindToText(self.ui.Text_Progress_Cur, self.curProgressTextFunc)
  binder:BindToText(self.ui.Text_Progress_Limit, self.limitProgressTextFunc)
  binder:BindToText(self.ui.Text_Name, self.nameTextFunc)
  binder:BindButtonClick(self.ui.Btn_Progress, self.clickFunc)
end

return CommonProgressBtnGroup
