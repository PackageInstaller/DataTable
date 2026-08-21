_class("UIHomelandMoviePrepareItem", UICustomWidget)
UIHomelandMoviePrepareItem = UIHomelandMoviePrepareItem

function UIHomelandMoviePrepareItem:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomelandMoviePrepareItem:OnShow(uiParams)
  self:InitWidget()
  local etl = UICustomUIEventListener.Get(self._touchArea)
  self:AddUICustomEventListener(etl, UIEvent.Press, function(go)
    self:OnDown(go)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Release, function(go)
    self:OnUp(go)
  end)
end

function UIHomelandMoviePrepareItem:OnHide()
end

function UIHomelandMoviePrepareItem:InitWidget()
  self._state = self:GetGameObject("state")
  self._select = self:GetGameObject("select")
  self._stateImg = self:GetUIComponent("Image", "state")
  self._txt = self:GetUIComponent("UILocalizationText", "txt")
  self._remove = self:GetGameObject("remove")
  self._txtGo = self:GetGameObject("txt")
  self._headImg = self:GetUIComponent("RawImageLoader", "head")
  self._itemImg = self:GetUIComponent("RawImageLoader", "item")
  self._itemBg = self:GetGameObject("itemBg")
  self._headBg = self:GetGameObject("headBg")
  self._touchArea = self:GetGameObject("btn")
  self._stateSp = {
    [0] = "dy_kxyy_bq03",
    [1] = "dy_kxyy_bq01",
    [2] = "dy_kxyy_bq02"
  }
end

function UIHomelandMoviePrepareItem:SetData(index, data, prepareType, selectItemId, selectTilleId, cfgHelper, atlas)
  self._index = index
  self._prepareType = prepareType
  self._data = data
  self._atlas = atlas
  self._selectingItemId = selectItemId
  self._selectTilleId = selectTilleId
  self._cfgHelper = cfgHelper
  self:RefreshUI()
end

function UIHomelandMoviePrepareItem:RefreshUI()
  if not self._data then
    return
  end
  self._headBg:SetActive(self._prepareType == MoviePrepareType.PT_Actor)
  self._itemBg:SetActive(self._prepareType ~= MoviePrepareType.PT_Actor)
  if self._prepareType == MoviePrepareType.PT_Actor then
    local cfg = self._cfgHelper:GetSkinByPrefabId(self._data[1])
    self._headImg:LoadImage(cfg[1].Head)
  else
    local cfg = self._cfgHelper:GetArchitectureItemCfg(self._data[1])
    self._itemImg:LoadImage(cfg.Icon)
  end
  self._state:SetActive(false)
  if self._data then
    local movieId = MoviePrepareData:GetInstance():GetMovieId()
    local hadUsed = MovieDataManager:GetInstance():CheckHadUse(movieId, self._prepareType, self._data[1])
    self._state:SetActive(hadUsed)
  end
  local sp = self._stateSp[self._data[2]]
  self._stateImg.sprite = self._atlas:GetSprite(sp)
  local selecting = HomelandMoviePrepareManager:GetInstance():CheckItemUsing(self._prepareType, self._data[1])
  self._remove:SetActive(selecting)
  self._select:SetActive(selecting)
  self._txt:SetText(StringTable.Get("str_movie_using"))
end

function UIHomelandMoviePrepareItem:CheckIsSelected()
  return self._selectingItemId == self._data[1]
end

function UIHomelandMoviePrepareItem:OnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandMoviePrepareItemBtnClick, true, self._prepareType, self._selectTilleId, self._data)
end

function UIHomelandMoviePrepareItem:RemoveOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandMoviePrepareItemBtnClick, false, self._prepareType, self._selectTilleId, self._data)
end

function UIHomelandMoviePrepareItem:OnDown(go)
  self._isPress = false
  self._timerEvent = GameGlobal.Timer():AddEvent(500, function()
    self:ShowDialog("UIItemTipsHomeland", self._data[1], go)
    self._isPress = true
  end)
end

function UIHomelandMoviePrepareItem:OnUp(go)
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
  if self._isPress then
    GameGlobal.UIStateManager():CloseDialog("UIItemTipsHomeland")
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandMoviePrepareItemBtnClick, true, self._prepareType, self._selectTilleId, self._data)
  end
end
