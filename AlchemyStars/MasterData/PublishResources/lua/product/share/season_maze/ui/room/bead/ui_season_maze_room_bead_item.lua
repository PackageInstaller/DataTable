_class("UISeasonMazeRoomBeadItem", UICustomWidget)
UISeasonMazeRoomBeadItem = UISeasonMazeRoomBeadItem

function UISeasonMazeRoomBeadItem:OnShow(uiParams)
  self._atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
end

function UISeasonMazeRoomBeadItem:InitWidget()
  self._RootAreaGo = self:GetGameObject("RootArea")
  self._SoldOutAreaGo = self:GetGameObject("SoldOutArea")
  self._RelicBgGo = self:GetGameObject("RelicBg")
  self._OnceItemBgGo = self:GetGameObject("OnceItemBg")
  self._PriceAreaGo = self:GetGameObject("PriceArea")
  self._OriPriceGo = self:GetGameObject("OriPrice")
  self._SelectedAreaGo = self:GetGameObject("SelectedArea")
  self._anim = self:GetGameObject():GetComponent("Animation")
  self._CostIcon = self:GetUIComponent("Image", "CostIcon")
  self._OriPriceText = self:GetUIComponent("UILocalizationText", "OriPrice")
  self._CurPriceText = self:GetUIComponent("UILocalizationText", "CurPrice")
  self._NameText = self:GetUIComponent("UILocalizationText", "NameText")
  self._type = self:GetUIComponent("Image", "Type")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._star = {}
  self._star[1] = self:GetGameObject("Star1")
  self._star[2] = self:GetGameObject("Star2")
  self._star[3] = self:GetGameObject("Star3")
  self._freeBg = self:GetGameObject("FreeBg")
  self._freeText = self:GetGameObject("FreeText")
end

function UISeasonMazeRoomBeadItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  if self._hideTimer then
    GameGlobal.Timer():CancelEvent(self._hideTimer)
  end
end

function UISeasonMazeRoomBeadItem:SetData(index, data, callback, component)
  self._index = index
  self._data = data
  self._callback = callback
  self._component = component
  self._id = self._data._slotData.item.id
  self._cfg = Cfg.cfg_component_season_maze_autobead[self._id]
  self:RefreshUI()
end

function UISeasonMazeRoomBeadItem:RefreshUI()
  local slotData = self._data._slotData
  if slotData.sellout then
    self._SoldOutAreaGo:SetActive(true)
  else
    self._SoldOutAreaGo:SetActive(false)
  end
  if slotData.ori_price > 0 and slotData.ori_price ~= slotData.price then
    self._OriPriceGo:SetActive(true)
    self._OriPriceText:SetText(tostring(slotData.ori_price))
  else
    self._OriPriceGo:SetActive(false)
  end
  self._freeBg:SetActive(0 >= slotData.price)
  self._freeText:SetActive(0 >= slotData.price)
  self._PriceAreaGo:SetActive(0 < slotData.price)
  local priceStr = tostring(slotData.price)
  local curGold = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  if curGold < slotData.price then
    priceStr = "<color=#c97d7d>" .. priceStr .. "</color>"
  end
  self._CurPriceText:SetText(priceStr)
  self._RelicBgGo:SetActive(true)
  self._OnceItemBgGo:SetActive(false)
  self._type.sprite = self._atlas:GetSprite(self:_GetTypeSprite(self._cfg))
  self._icon:LoadImage(self._cfg.Icon)
  for key, value in ipairs(self._star) do
    value:SetActive(key < self._cfg.Lv)
  end
  self._NameText:SetText(StringTable.Get(self._cfg.Name))
end

function UISeasonMazeRoomBeadItem:BgAreaOnClick()
  if self._callback then
    self._callback(self._index)
  end
end

function UISeasonMazeRoomBeadItem:OnSelect(bShow)
  self._SelectedAreaGo:SetActive(bShow)
end

function UISeasonMazeRoomBeadItem:PlayShowInAnim(delay)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._RootAreaGo:SetActive(true)
  end
  if delay and 0 < delay then
    self._RootAreaGo:SetActive(false)
    self._timer = GameGlobal.Timer():AddEvent(delay, function()
      self._RootAreaGo:SetActive(true)
      if self._anim then
        self._anim:Play("uieffanim_UISeasonMazeRoomBeadItem_in")
      end
    end)
  else
    self._RootAreaGo:SetActive(true)
    if self._anim then
      self._anim:Play("uieffanim_UISeasonMazeRoomBeadItem_in")
    end
  end
end

function UISeasonMazeRoomBeadItem:PlayShowOutAnim()
  self._RootAreaGo:SetActive(true)
  if self._anim then
    self._anim:Play("uieffanim_UISeasonMazeRoomBeadItem_out")
    if self._hideTimer then
      GameGlobal.Timer():CancelEvent(self._hideTimer)
      self._hideTimer = GameGlobal.Timer():AddEvent(300, function()
        self._RootAreaGo:SetActive(false)
      end)
    end
  end
end

function UISeasonMazeRoomBeadItem:_GetTypeSprite(cfg)
  if cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Skill then
    return "thread_junei_zdz01"
  elseif cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Strong then
    return "thread_junei_zdz02"
  elseif cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Energy then
    return "thread_junei_zdz03"
  end
  return "cn14_sjmj_xdjmk_di12"
end
