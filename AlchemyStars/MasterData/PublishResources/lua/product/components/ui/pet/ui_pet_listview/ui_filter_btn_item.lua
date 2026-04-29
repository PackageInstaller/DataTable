_class("UIFilterBtnItem", UICustomWidget)
UIFilterBtnItem = UIFilterBtnItem

function UIFilterBtnItem:Constructor()
end

function UIFilterBtnItem:OnShow(uiParams)
end

function UIFilterBtnItem:GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._selectGo = self:GetGameObject("select")
end

function UIFilterBtnItem:SetData(cfg, currentFilterParams, Callback)
  self:GetComponents()
  self._cfg = cfg
  self._currentFilterParams = currentFilterParams
  self._callback = Callback
  self:OnValue()
end

function UIFilterBtnItem:OnValue()
  self._name:SetText(StringTable.Get(self._cfg.Name))
  self._selectGo:SetActive(false)
  local c = table.count(self._currentFilterParams)
  if c <= 0 then
    return
  else
    for i = 1, c do
      if self._cfg.Type == self._currentFilterParams[i]._filter_type then
        self._selectGo:SetActive(true)
        break
      end
    end
  end
end

function UIFilterBtnItem:Flush(currFilterParams)
  for i = 1, table.count(currFilterParams) do
    if currFilterParams[i]._filter_type == self._cfg.Type then
      self._selectGo:SetActive(true)
      return
    end
  end
  self._selectGo:SetActive(false)
end

function UIFilterBtnItem:bgOnClick()
  if self._callback then
    self._callback(self._cfg.Type, self._cfg.Tag)
  end
end
