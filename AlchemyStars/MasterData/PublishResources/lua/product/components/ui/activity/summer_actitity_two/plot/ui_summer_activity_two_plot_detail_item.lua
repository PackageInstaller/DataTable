_class("UISummerActivityTwoPlotDetailItem", UICustomWidget)
UISummerActivityTwoPlotDetailItem = UISummerActivityTwoPlotDetailItem

function UISummerActivityTwoPlotDetailItem:OnShow(uiParams)
  self._state2img = {
    [1] = "summer_zhangjie_btn2",
    [2] = "summer_zhangjie_btn3"
  }
  self:_GetComponents()
  self:AttachEvent(GameEventType.OnSummerActivityPlotSelect, self.Select)
end

function UISummerActivityTwoPlotDetailItem:_GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._conditionTex = self:GetUIComponent("UILocalizationText", "conditionTex")
  self._btn_normal = self:GetUIComponent("RawImageLoader", "btn_normal")
  self._btn_click = self:GetGameObject("btn_click")
  self._red = self:GetGameObject("red")
end

function UISummerActivityTwoPlotDetailItem:SetData(index, currIdx, data, callback)
  self._idx = index
  self._data = data
  self._callback = callback
  self:_OnValue()
  self:Select(currIdx)
end

function UISummerActivityTwoPlotDetailItem:_OnValue()
  local nameStr = self._data.name
  self._name:SetText(StringTable.Get(nameStr))
  local unlock = self._data.unlock
  self._conditionTex.gameObject:SetActive(not unlock)
  if not unlock then
    self._conditionTex:SetText(self._data.condition)
    self._btn_normal:LoadImage(self._state2img[2])
  else
    self._btn_normal:LoadImage(self._state2img[1])
  end
  self._red:SetActive(self._data.red)
end

function UISummerActivityTwoPlotDetailItem:bgOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end

function UISummerActivityTwoPlotDetailItem:Select(idx)
  local select = idx == self._idx
  self._btn_click:SetActive(select)
end
