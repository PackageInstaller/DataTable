_class("UIAircraftEnterUpSortBtnPrefab", UICustomWidget)
UIAircraftEnterUpSortBtnPrefab = UIAircraftEnterUpSortBtnPrefab

function UIAircraftEnterUpSortBtnPrefab:OnShow(uiParams)
  self._arrow = self:GetUIComponent("Image", "arrow")
  self._sortText = self:GetUIComponent("UILocalizationText", "Text")
  self._bg = self:GetGameObject("bg")
  self._uiAircraftEnterBuildAtlas = self:GetAsset("UIAircraftEnterBuild.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.AircraftEnterBuildChangeSort, self.AircraftEnterBuildChangeSort)
end

function UIAircraftEnterUpSortBtnPrefab:AircraftEnterBuildChangeSort(sort_params)
  if self._sortType == sort_params._sort_type then
    self:SelectActive(sort_params._sort_order)
  else
    self:CancelActive()
  end
end

function UIAircraftEnterUpSortBtnPrefab:Constructor()
end

function UIAircraftEnterUpSortBtnPrefab:OnHide()
  self:DetachEvent(GameEventType.AircraftEnterBuildChangeSort, self.AircraftEnterBuildChangeSort)
end

function UIAircraftEnterUpSortBtnPrefab:SetData(index, sortType, sortText, sort_params, callback)
  self._index = index
  self._sortType = sortType
  self._sortText:SetText(StringTable.Get(sortText))
  self._sort_params = sort_params
  self._callback = callback
  if self._sortType == sort_params._sort_type then
    self:SelectActive(sort_params._sort_order)
  else
    self:CancelActive()
  end
end

function UIAircraftEnterUpSortBtnPrefab:CancelActive()
  self._sortText.color = Color.white
  self._bg:SetActive(false)
end

function UIAircraftEnterUpSortBtnPrefab:SelectActive(up2down)
  self._bg:SetActive(true)
  self._sortText.color = Color(0.9882352941176471, 0.9098039215686274, 0.00784313725490196, 1)
  if up2down == PetSortOrder.Descending then
    self._arrow.sprite = self._uiAircraftEnterBuildAtlas:GetSprite("spirit_jiantou_y_1_frame")
  else
    self._arrow.sprite = self._uiAircraftEnterBuildAtlas:GetSprite("spirit_jiantou_y_2_frame")
  end
end

function UIAircraftEnterUpSortBtnPrefab:bgOnClick()
  self._callback(self._index, self._sortType)
end
