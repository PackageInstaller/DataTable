_class("UIChooseAssistantCutItem", UICustomWidget)
UIChooseAssistantCutItem = UIChooseAssistantCutItem

function UIChooseAssistantCutItem:OnShow()
  self:_GetComponents()
end

function UIChooseAssistantCutItem:SetData(idx, data)
  self._idx = idx
  self._data = data
  self:_OnValue()
end

function UIChooseAssistantCutItem:_GetComponents()
end

function UIChooseAssistantCutItem:_OnValue()
end
