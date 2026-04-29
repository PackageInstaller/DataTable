_class("UIActivityReturnSystemProgressArrow", UICustomWidget)
UIActivityReturnSystemProgressArrow = UIActivityReturnSystemProgressArrow

function UIActivityReturnSystemProgressArrow:SetData(text, state)
  UIWidgetHelper.SetLocalizationText(self, "_txt", text)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"_state_1"},
    {"_state_2"},
    {"_state_2"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end
