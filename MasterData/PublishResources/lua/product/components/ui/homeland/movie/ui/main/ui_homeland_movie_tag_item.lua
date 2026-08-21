_class("UIHomelandMovieTagItem", UICustomWidget)
UIHomelandMovieTagItem = UIHomelandMovieTagItem

function UIHomelandMovieTagItem:Constructor()
  self._data = nil
  self._callBack = nil
  self._isLocked = true
  self._select = false
  self._redState = false
  self._pstid = nil
  self._isLeave = false
  self._isBeSelected = false
  self._atlas = self:GetAsset("UIMovieSecond.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomelandMovieTagItem:OnShow(uiParams)
  self:InitWidget()
end

function UIHomelandMovieTagItem:OnHide()
end

function UIHomelandMovieTagItem:InitWidget()
  self._text = self:GetUIComponent("UILocalizationText", "Text")
  self._tag = self:GetUIComponent("Image", "Tag")
  self._redPoint = self:GetGameObject("redPoint")
end

function UIHomelandMovieTagItem:Dispose()
end

function UIHomelandMovieTagItem:SetData(data, index, callback)
  self._data = data
  self.index = index
  self._callBack = callback
  self:SetInfo()
  self:SetRed()
end

function UIHomelandMovieTagItem:SetInfo()
  self._tag.sprite = self._atlas:GetSprite("dy_xzjb_di17")
  if self._data.Title then
    self._text:SetText(StringTable.Get(self._data.Title))
  else
    Log.fatal("未配置标签")
  end
end

function UIHomelandMovieTagItem:SetRed()
  local cfg = Cfg.cfg_homeland_movice({})
  local id = self._data.MovieId
  for _, v in ipairs(id) do
    if self:CheckRed(cfg[v]) then
      self._redPoint:SetActive(true)
      break
    else
      self._redPoint:SetActive(false)
    end
  end
end

function UIHomelandMovieTagItem:TagOnClick()
  if self._callBack then
    self._callBack(self)
  end
  local cfg = Cfg.cfg_homeland_movice({})
  local a = self.index
  Log.fatal("点击" .. a)
  local id = self._data.MovieId
  local controller = GameGlobal.UIStateManager():GetController("UIHomelandMovieMainController")
  controller:InitDramaList(id)
  for _, v in ipairs(id) do
    if self:CheckRed(cfg[v]) then
      self._redPoint:SetActive(true)
      break
    else
      self._redPoint:SetActive(false)
    end
  end
end

function UIHomelandMovieTagItem:SetSelected(isSelected)
  if isSelected then
    self._tag.sprite = self._atlas:GetSprite("dy_xzjb_di16")
    self._text.color = Color(1.0, 1.0, 1.0)
  else
    self._tag.sprite = self._atlas:GetSprite("dy_xzjb_di17")
    self._text.color = Color(0.4196078431372549, 0.4196078431372549, 0.4196078431372549)
  end
end

function UIHomelandMovieTagItem:CheckRed(data)
  self._redState = MovieDataManager:GetInstance():CheckMovieNew(data)
  return self._redState
end
