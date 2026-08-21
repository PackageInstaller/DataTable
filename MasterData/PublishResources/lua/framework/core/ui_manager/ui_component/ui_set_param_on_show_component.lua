_class("UISetParamOnShowComponent", UIComponent)

function UISetParamOnShowComponent:Show()
  if self.registerInfo then
    for key, value in pairs(self.registerInfo) do
      self.uiController:SetComponentSharedParam(key, value)
    end
  end
end
