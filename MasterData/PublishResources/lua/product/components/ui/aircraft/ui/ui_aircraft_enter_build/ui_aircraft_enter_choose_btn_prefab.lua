_class("UIAircraftEnterChooseBtnPrefab", UICustomWidget)
UIAircraftEnterChooseBtnPrefab = UIAircraftEnterChooseBtnPrefab

function UIAircraftEnterChooseBtnPrefab:OnShow(uiParams)
  self._select = self:GetGameObject("select")
  self._chooseText = self:GetUIComponent("UILocalizationText", "Text")
  self._show = false
  self:AttachEvent(GameEventType.AircraftEnterBuildChangeFilter, self.AircraftEnterBuildChangeFilter)
end

function UIAircraftEnterChooseBtnPrefab:AircraftEnterBuildChangeFilter(filter_params)
  for i = 1, #filter_params do
    if filter_params[i]._filter_type == self._chooseType then
      self._show = true
      self._select:SetActive(true)
      return
    end
  end
  self._select:SetActive(false)
end

function UIAircraftEnterChooseBtnPrefab:OnHide()
  self:DetachEvent(GameEventType.AircraftEnterBuildChangeFilter, self.AircraftEnterBuildChangeFilter)
end

function UIAircraftEnterChooseBtnPrefab:itemBtnOnClick()
  self._callback(self._index, self._chooseType)
end

function UIAircraftEnterChooseBtnPrefab:SetData(index, chooseType, chooseText, filter_params, callback)
  self._callback = callback
  self._index = index
  self._chooseType = chooseType
  self._chooseText:SetText(StringTable.Get(chooseText))
  for i = 1, #filter_params do
    if filter_params[i]._filter_type == self._chooseType then
      self._show = true
      self._select:SetActive(true)
      return
    end
  end
  self._select:SetActive(false)
end
