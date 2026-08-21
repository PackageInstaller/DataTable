_class("UIHomelandMovieExplainItem", UICustomWidget)
UIHomelandMovieExplainItem = UIHomelandMovieExplainItem

function UIHomelandMovieExplainItem:Constructor()
  self._data = nil
end

function UIHomelandMovieExplainItem:OnShow(uiParams)
  self:InitWidget()
end

function UIHomelandMovieExplainItem:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._info = self:GetUIComponent("UILocalizationText", "info")
end

function UIHomelandMovieExplainItem:SetData(data)
  self._data = data
  self:InitData()
end

function UIHomelandMovieExplainItem:InitData()
  self._title:SetText(StringTable.Get(self._data.Title))
  self._info:SetText(StringTable.Get(self._data.Content))
end
