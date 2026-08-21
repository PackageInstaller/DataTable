_class("UIDomitorySortBtn2", UICustomWidget)
UIDomitorySortBtn2 = UIDomitorySortBtn2

function UIDomitorySortBtn2:Constructor()
  self.ElementSpriteName = {
    [1] = "bing_color",
    [2] = "huo_color",
    [3] = "sen_color",
    [4] = "lei_color",
    [5] = "wu_color"
  }
end

function UIDomitorySortBtn2:OnShow(uiParams)
  self._uiHeartAtlas = self:GetAsset("UIHomelandDomitory.spriteatlas", LoadType.SpriteAtlas)
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UIDomitorySortBtn2:GetComponents()
  self._arrow = self:GetUIComponent("Image", "arrow")
  self._arrowGo = self:GetGameObject("arrow")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._selectImgGo = self:GetGameObject("selectImg")
  self._elementTypeImg = self:GetUIComponent("Image", "eleImage")
  self._root = self:GetGameObject("root")
  self._rootRect = self:GetUIComponent("RectTransform", "root")
end

function UIDomitorySortBtn2:SetData(index, cfg, currentSortParams, currentSortOrder, callback, eleType)
  self:GetComponents()
  self._index = index
  self._cfg = cfg
  if not next(cfg) then
    self._root:SetActive(false)
    return
  elseif cfg.Type == PetSortType.Element then
    self._rootRect.sizeDelta = Vector2(339, 71)
  else
    self._rootRect.sizeDelta = Vector2(166, 71)
  end
  self._root:SetActive(true)
  self._currSortParams = currentSortParams
  self._currentSortOrder = currentSortOrder
  self._callback = callback
  self._eleType = eleType
  self:OnValue()
end

function UIDomitorySortBtn2:OnValue()
  self._name:SetText(StringTable.Get(self._cfg.Name))
  self._elementTypeImg.gameObject:SetActive(false)
  self:Flush(self._currSortParams, self._currentSortOrder, self._eleType)
end

function UIDomitorySortBtn2:BgOnClick()
  if self._cfg.Type == PetSortType.Element then
    local currentElementSortTypeOrder = UIPetSortContext.Instance:CurElement()
    UIPetSortContext.Instance:SetElement(currentElementSortTypeOrder % 5 + 1)
  end
  if self._callback then
    self._callback(self._index)
  end
end

function UIDomitorySortBtn2:Flush(params, order, eleType)
  if params == self._cfg.Type then
    self._arrowGo:SetActive(true)
    self._selectImgGo:SetActive(true)
    if order == PetSortOrder.Ascending then
      self._arrow.sprite = self._uiHeartAtlas:GetSprite("n17_dorm_list_icon1")
    else
      self._arrow.sprite = self._uiHeartAtlas:GetSprite("n17_dorm_list_icon2")
    end
  else
    self._arrowGo:SetActive(false)
    self._selectImgGo:SetActive(false)
  end
  self._eleType = eleType
  if self:_IsElement(self._cfg.ID) then
    self._arrowGo:SetActive(false)
    self._elementTypeImg.gameObject:SetActive(true)
    if self._eleType ~= 0 then
      self._elementTypeImg.sprite = self.atlasProperty:GetSprite(self.ElementSpriteName[self._eleType])
    end
  else
    self._elementTypeImg.gameObject:SetActive(false)
  end
end

function UIDomitorySortBtn2:_IsElement(type)
  return type == PetSortType.Element or type == PetSortType.WaterFirst or type == PetSortType.FireFirst or type == PetSortType.SenFirst or type == PetSortType.ElectricityFirst or type == PetSortType.NoneElementFirst
end
