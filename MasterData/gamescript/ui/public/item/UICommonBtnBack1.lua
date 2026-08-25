local UICommonBtnBack1, Super = System.NewComponent("UICommonBtnBack1")

function UICommonBtnBack1:ctor(uiNode, btnFunc, btnType, btnText)
  Super.ctor(self)
  self.ui = UI_Common_Btn_Back3Resource(uiNode)
  self.btnFunc = btnFunc
  self.btnType = Vue.ref(btnType)
  self.btnText = Vue.ref(btnText)
end

function UICommonBtnBack1:OnBind(binder)
  binder:onDestroy(function()
    self.btnFunc = nil
  end)
  binder:BindButtonClick(self.ui.Image_Icon, function()
    if self.btnFunc then
      self.btnFunc()
    end
  end)
end

function UICommonBtnBack1:OnTodoFunc()
end

return UICommonBtnBack1
