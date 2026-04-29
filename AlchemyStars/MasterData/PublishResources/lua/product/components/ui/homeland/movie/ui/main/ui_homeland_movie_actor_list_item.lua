_class("UIHomelandMovieActorListItem", UICustomWidget)
UIHomelandMovieActorListItem = UIHomelandMovieActorListItem

function UIHomelandMovieActorListItem:Constructor()
  self._data = nil
  self._movieData = nil
  self._atlas = nil
  self._type = ActorPageType.Actor
  self._actorRect = Vector2(201, 182)
  self._itemRect = Vector2(140, 140)
  self._actorPos = Vector2(-8, -3)
  self._itemPos = Vector2(0, -3)
end

function UIHomelandMovieActorListItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIHomelandMovie.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
end

function UIHomelandMovieActorListItem:Dispose()
end

function UIHomelandMovieActorListItem:InitWidget()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._bg = self:GetUIComponent("Image", "bg")
  self._mask = self:GetUIComponent("Image", "mask")
  self._gradeImg = self:GetUIComponent("Image", "gradeImg")
  self._gradeImgObj = self:GetGameObject("gradeImg")
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
end

function UIHomelandMovieActorListItem:SetData(data, movieData, isActor)
  self._data = data
  self._movieData = movieData
  self._isActor = isActor
  self:InitData(isActor)
end

function UIHomelandMovieActorListItem:InitData(isActor)
  local id = self._data[1]
  local actor = Cfg.cfg_item[id]
  if isActor then
    self._icon:LoadImage("head1_" .. id)
    self._bg.sprite = self._atlas:GetSprite("dy_kxyy_di08")
    self._mask.sprite = self._atlas:GetSprite("dy_kxyy_di08")
    self._iconRect.sizeDelta = self._actorRect
    self._iconRect.anchoredPosition = self._actorPos
  else
    self._icon:LoadImage(actor.Icon)
    self._bg.sprite = self._atlas:GetSprite("dy_kxyy_di10")
    self._mask.sprite = self._atlas:GetSprite("dy_kxyy_di10")
    self._iconRect.sizeDelta = self._itemRect
    self._iconRect.anchoredPosition = self._itemPos
  end
  if self._data[2] == 0 then
    self._gradeImg.sprite = self._atlas:GetSprite("dy_kxyy_bq03")
  elseif self._data[2] == 1 then
    self._gradeImg.sprite = self._atlas:GetSprite("dy_kxyy_bq01")
  elseif self._data[2] == 2 then
    self._gradeImg.sprite = self._atlas:GetSprite("dy_kxyy_bq02")
  end
  local used = MovieDataManager:GetInstance():GetMovieHistoryUsedByID(self._movieData.ID, id)
  self._gradeImgObj:SetActive(used)
end

function UIHomelandMovieActorListItem:BtnOnClick(go)
  if not self._isActor then
    local id = self._data[1]
    self:ShowDialog("UIItemTipsHomeland", id, go)
  end
end

function UIHomelandMovieActorListItem:GetData()
  return self._data
end
