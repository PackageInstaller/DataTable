_class("UIAircraftDecorateTabItem", UICustomWidget)
UIAircraftDecorateTabItem = UIAircraftDecorateTabItem

function UIAircraftDecorateTabItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIAircraftDecorate.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.UIAircraftDecorateBigTabClick, self._OnBigTypeBtnClick)
end

function UIAircraftDecorateTabItem:SetData(index, data, callback, changeLayout)
  self:_GetComponents()
  self._index = index
  self._data = data
  self._callback = callback
  self._changeLayout = changeLayout
  self._isOpen = false
  self._tweenTime = 0.2
  local tableId = self._data.ID
  local cfg_aircraft_furniture_tab2 = Cfg.cfg_aircraft_furniture_tab2({})
  self._tabChildList = {}
  for k, value in pairs(cfg_aircraft_furniture_tab2) do
    if value.Tab1 == tableId then
      table.insert(self._tabChildList, value)
    end
  end
  self:_OnValue()
end

function UIAircraftDecorateTabItem:ItemRectTransform()
  return self._rect
end

function UIAircraftDecorateTabItem:ItemMoveRectTransform()
  return self._moveRect
end

function UIAircraftDecorateTabItem:OnGetMaskSizeDeltaHeight()
  return self._mask.sizeDelta.y
end

function UIAircraftDecorateTabItem:_GetComponents()
  self._rect = self:GetUIComponent("RectTransform", "Rect")
  self._text = self:GetUIComponent("UILocalizationText", "Text")
  self._image = self:GetUIComponent("Image", "Image")
  self._smallBtnPool = self:GetUIComponent("UISelectObjectPath", "smallBtnPool")
  self._grid = self:GetUIComponent("GridLayoutGroup", "smallBtnPool")
  self._moveRect = self:GetUIComponent("RectTransform", "smallBtnPool")
  self._mask = self:GetUIComponent("RectTransform", "mask")
  self._bg = self:GetUIComponent("Image", "Bg")
  self._select = self:GetGameObject("Select")
end

function UIAircraftDecorateTabItem:_OnValue()
  self._image.sprite = self._atlas:GetSprite(self._data.Icon)
  self._text:SetText(StringTable.Get(self._data.Name))
  if #self._tabChildList > 0 then
    self._hasSmallType = true
    self._smallBtnPool:SpawnObjects("UIAircraftDecorateTabChildItem", #self._tabChildList)
    self._items = self._smallBtnPool:GetAllSpawnList()
    for i = 1, #self._tabChildList do
      local sprite = self._atlas:GetSprite(self._tabChildList[i].Icon)
      self._items[i]:SetData(i, self._tabChildList[i].ID, self._tabChildList[i].Name, sprite, function(idx)
        self:_OnClickChildTab(idx)
      end)
    end
  else
    self._hasSmallType = false
  end
  self._mask.gameObject:SetActive(self._hasSmallType)
  local left = self._grid.padding.left
  local right = self._grid.padding.right
  local Top = self._grid.padding.top
  local Bottom = self._grid.padding.bottom
  self._mask.sizeDelta = Vector2(left + self._grid.cellSize.x + right, Top + Bottom + self._grid.cellSize.y * #self._tabChildList + self._grid.spacing.y * (#self._tabChildList - 1))
end

function UIAircraftDecorateTabItem:BgOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  self:_OnSelectCurTab()
end

function UIAircraftDecorateTabItem:_OnSelectCurTab()
  if not self._hasSmallType then
    return
  end
  if self._changeLayout then
    self._changeLayout(self._index, self:OnGetMaskSizeDeltaHeight(), true)
  end
end

function UIAircraftDecorateTabItem:_OnBigTypeBtnClick(tabIndex, isOpenTab)
  if tabIndex == self._index then
  else
  end
end

function UIAircraftDecorateTabItem:_OnClickChildTab(tabChild)
  if self._callback then
    self._callback(tabChild)
  end
end

function UIAircraftDecorateTabItem:CloseMovePos(doTween)
  if not self._hasSmallType then
    return
  end
  self._isOpen = false
  local moveToPos = Vector2(0, 0)
  if doTween then
    self._moveRect:DOAnchorPos(moveToPos, self._tweenTime)
  else
    self._moveRect.anchoredPosition = moveToPos
  end
  self._select:SetActive(false)
end

function UIAircraftDecorateTabItem:OpenMovePos(doTween)
  if not self._hasSmallType then
    return
  end
  self._isOpen = true
  local moveToPos = Vector2(0, -self._moveRect.sizeDelta.y)
  if doTween then
    self._moveRect:DOAnchorPos(moveToPos, self._tweenTime)
  else
    self._moveRect.anchoredPosition = moveToPos
  end
  self._select:SetActive(true)
end

function UIAircraftDecorateTabItem:OnHide()
end

function UIAircraftDecorateTabItem:GetChildItem(index)
  return self._items[index]
end
