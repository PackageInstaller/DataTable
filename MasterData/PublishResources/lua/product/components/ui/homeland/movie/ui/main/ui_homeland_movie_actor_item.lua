_class("UIHomelandMovieActorItem", UICustomWidget)
UIHomelandMovieActorItem = UIHomelandMovieActorItem

function UIHomelandMovieActorItem:Constructor()
  self._data = nil
  self._movieData = nil
  self._widgets = nil
  self._singleHeight = 252
  self._doubleHeight = 421
  self._cfg = Cfg.cfg_homeland_movice_item({})
end

function UIHomelandMovieActorItem:OnShow(uiParams)
  self._widgets = {}
  self:InitWidget()
end

function UIHomelandMovieActorItem:InitWidget()
  self._typeTitle = self:GetUIComponent("UILocalizationText", "typeTitle")
  self._actorItemParent = self:GetUIComponent("UISelectObjectPath", "actorItemParent")
  self.layout = self:GetUIComponent("LayoutElement", "layout")
end

function UIHomelandMovieActorItem:SetData(data, movieData, isActor)
  self._data = data
  self._movieData = movieData
  self:InitData(isActor)
end

function UIHomelandMovieActorItem:GetData()
  return self._data
end

function UIHomelandMovieActorItem:InitData(isActor)
  local movie = self._cfg[self._data]
  self._typeTitle:SetText(StringTable.Get(movie.Name))
  if #movie.SelectList > 5 then
    self.layout.minHeight = self._doubleHeight
  else
    self.layout.minHeight = self._singleHeight
  end
  self._widgets = self._actorItemParent:SpawnObjects("UIHomelandMovieActorListItem", #movie.SelectList)
  local index = 1
  for i, v in pairs(movie.SelectList) do
    self._widgets[index]:SetData(v, self._movieData, isActor)
    index = index + 1
  end
end
