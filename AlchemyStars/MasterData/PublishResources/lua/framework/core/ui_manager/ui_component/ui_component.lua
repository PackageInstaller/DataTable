_class("UIComponent", Object)

function UIComponent:Constructor()
  self.uiController = nil
  self.registerInfo = nil
end

function UIComponent:Init(uiController, registerInfo)
  self.uiController = uiController
  self.registerInfo = registerInfo
end

function UIComponent:Show(uiParams)
end

function UIComponent:AfterShow(TT)
end

function UIComponent:BeforeHide(TT)
end

function UIComponent:Hide()
end
