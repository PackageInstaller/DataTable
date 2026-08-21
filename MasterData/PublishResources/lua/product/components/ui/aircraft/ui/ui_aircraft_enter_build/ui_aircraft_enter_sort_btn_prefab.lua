_class("UIAircraftEnterSortBtnPrefab", UICustomWidget)
UIAircraftEnterSortBtnPrefab = UIAircraftEnterSortBtnPrefab

function UIAircraftEnterSortBtnPrefab:OnShow(uiParams)
  self._arrow = self:GetUIComponent("Image", "arrow")
  self._sortText = self:GetUIComponent("UILocalizationText", "Text")
  self._uiAircraftEnterBuildAtlas = self:GetAsset("UIAircraftEnterBuild.spriteatlas", LoadType.SpriteAtlas)
  self._select = self:GetGameObject("select")
  self:AttachEvent(GameEventType.AircraftEnterBuildChangeSort, self.AircraftEnterBuildChangeSort)
end

function UIAircraftEnterSortBtnPrefab:AircraftEnterBuildChangeSort(sort_params)
  if self._sortType == sort_params._sort_type then
    self:SelectActive(sort_params._sort_order)
  else
    self:CancelActive()
  end
end

function UIAircraftEnterSortBtnPrefab:Constructor()
end

function UIAircraftEnterSortBtnPrefab:OnHide()
  self:DetachEvent(GameEventType.AircraftEnterBuildChangeSort, self.AircraftEnterBuildChangeSort)
end

function UIAircraftEnterSortBtnPrefab:SetData(index, sortType, sortText, sort_params, callback)
  self._index = index
  self._callback = callback
  self._sortType = sortType
  self._sortText:SetText(StringTable.Get(sortText))
  if self._sortType == sort_params._sort_type then
    self:SelectActive(sort_params._sort_order)
  else
    self:CancelActive()
  end
end

function UIAircraftEnterSortBtnPrefab:CancelActive()
  self._select:SetActive(false)
end

function UIAircraftEnterSortBtnPrefab:SelectActive(up2down)
  self._select:SetActive(true)
  if up2down == PetSortOrder.Descending then
    self._arrow.sprite = self._uiAircraftEnterBuildAtlas:GetSprite("spirit_jiantou_w_1_icon")
  else
    self._arrow.sprite = self._uiAircraftEnterBuildAtlas:GetSprite("spirit_jiantou_w_2_icon")
  end
end

function UIAircraftEnterSortBtnPrefab:selectOnClick()
  self._callback(self._index, self._sortType)
end
