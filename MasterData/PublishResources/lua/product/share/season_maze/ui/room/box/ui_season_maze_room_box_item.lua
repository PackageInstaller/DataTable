_class("UISeasonMazeRoomBoxItem", UICustomWidget)
UISeasonMazeRoomBoxItem = UISeasonMazeRoomBoxItem

function UISeasonMazeRoomBoxItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeRoomBoxItem:InitWidget()
  self._item = self:GetUIComponent("UISelectObjectPath", "Item")
  self._bead = self:GetUIComponent("UISelectObjectPath", "Bead")
  self._markGO = self:GetGameObject("Mark")
  self._markGO:SetActive(false)
end

function UISeasonMazeRoomBoxItem:SetData(index, data, onClickCallBack, onShowTipsCallBack)
  self._index = index
  self._data = data
  self._onClickCallBack = onClickCallBack
  self._onShowTipsCallBack = onShowTipsCallBack
  if self._data.type == SeasonMazeEffectType.SMET_Bead_LV then
    local beadItem = self._bead:SpawnObject("UISeasonMazeBeadItem")
    beadItem:ShowUnknown(self._data.id, function(go)
      self:ShowTips(go)
    end)
  else
    local itemWidget = self._item:SpawnObject("UIItem")
    itemWidget:SetForm(UIItemForm.Base)
    itemWidget:SetClickCallBack(function(go)
      self:ShowTips(go)
    end)
    local icon, quality, count = self:GetItemInfo()
    itemWidget:SetData({
      icon = icon,
      quality = quality,
      text1 = count
    })
  end
end

function UISeasonMazeRoomBoxItem:BgOnClick(go)
  if self._onClickCallBack then
    self._onClickCallBack(self._index)
  end
end

function UISeasonMazeRoomBoxItem:ShowTips(go)
  if self._onShowTipsCallBack then
    self._onShowTipsCallBack(self._index, go.transform.position)
  end
end

function UISeasonMazeRoomBoxItem:GetItemInfo()
  local icon, quality, count
  if self._data.type == SeasonMazeEffectType.SMET_Pro then
    local cfg = Cfg.cfg_season_maze_attribute[self._data.id]
    if cfg then
      icon = cfg.ItemIcon
      quality = cfg.Quality
      count = self._data.value_min
    end
  else
    local cfg = Cfg.cfg_item[self._data.id]
    if cfg then
      icon = cfg.Icon
      quality = cfg.Color
      count = self._data.value_min
    end
  end
  return icon, quality, count
end

function UISeasonMazeRoomBoxItem:OnSelected(isSelected)
  self._markGO:SetActive(isSelected)
end
