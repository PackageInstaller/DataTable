_class("UIHomelandBreedManualInfo", UIController)
UIHomelandBreedManualInfo = UIHomelandBreedManualInfo

function UIHomelandBreedManualInfo:OnShow(uiParams)
  self._name = uiParams[1]
  self._data = uiParams[2]
  self:_GetComponents()
  self:_OnValue()
end

function UIHomelandBreedManualInfo:_GetComponents()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
end

function UIHomelandBreedManualInfo:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIHomelandBreedManualInfo:_OnValue()
  self._title:SetText(self._name)
  local count = #self._data
  self._content:SpawnObjects("UIHomelandBreedManualInfoItem", count)
  self._infoItemWidgets = self._content:GetAllSpawnList()
  for i = 1, count do
    self._infoItemWidgets[i]:SetData(self._data[i])
  end
end
