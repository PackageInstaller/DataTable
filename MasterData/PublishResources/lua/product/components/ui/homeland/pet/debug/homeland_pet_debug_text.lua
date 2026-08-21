_class("HomelandPetDebugText", Object)
HomelandPetDebugTextText = HomelandPetDebugText

function HomelandPetDebugText:Constructor(go)
  self._uiView = go:GetComponent(typeof(UIView))
  self._text = self._uiView:GetUIComponent("UILocalizationText", "txt")
end

function HomelandPetDebugText:Refresh(position, str)
  self._uiView.transform.position = position
  self._text:SetText(str)
end
