_class("UIHomelandMoviePlaybackItem", UICustomWidget)
UIHomelandMoviePlaybackItem = UIHomelandMoviePlaybackItem

function UIHomelandMoviePlaybackItem:Constructor()
  self._actorId = nil
  self._movieData = nil
  self._callBack = nil
  self._altas = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomelandMoviePlaybackItem:OnShow(uiParams)
  self:InitWidget()
end

function UIHomelandMoviePlaybackItem:InitWidget()
  self._actorHead = self:GetUIComponent("RawImageLoader", "actorHead")
  self._actorName = self:GetUIComponent("UILocalizationText", "actorName")
  self._actorType = self:GetUIComponent("UILocalizationText", "actorType")
end

function UIHomelandMoviePlaybackItem:SetData(data, movieData)
  self._actorId = data
  self._movieData = movieData
  self:InitData()
end

function UIHomelandMoviePlaybackItem:GetData()
  return self._actorId
end

function UIHomelandMoviePlaybackItem:InitData()
  local typeText = MovieDataManager:GetInstance():GetMoviePointByID(self._movieData.ID, self._actorId)
  self._actorType:SetText(StringTable.Get(typeText))
  self._actorHead:LoadImage("head1_" .. self._actorId)
  self._actorName:SetText(StringTable.Get(Cfg.cfg_item[self._actorId].Name))
end
