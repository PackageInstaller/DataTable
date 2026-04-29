_class("UIChooseSortBtnItem1", UICustomWidget)
UIChooseSortBtnItem1 = UIChooseSortBtnItem1

function UIChooseSortBtnItem1:Constructor()
  self.ElementSpriteName = {
    [1] = "bing_color",
    [2] = "huo_color",
    [3] = "sen_color",
    [4] = "lei_color",
    [5] = "wu_color"
  }
end

function UIChooseSortBtnItem1:OnShow(uiParams)
  self._uiHeartAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UIChooseSortBtnItem1:GetComponents()
  self._arrow = self:GetUIComponent("Image", "arrow")
  self._arrowGo = self:GetGameObject("arrow")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._selectImgGo = self:GetGameObject("select")
  self._elementTypeImg = self:GetUIComponent("Image", "eleImage")
  self._eleRoot = self:GetGameObject("ele")
  self._norRoot = self:GetGameObject("bg")
  self._eleName = self:GetUIComponent("UILocalizationText", "eleText")
  self._eleSelectGo = self:GetGameObject("eleSelct")
end

function UIChooseSortBtnItem1:SetData(index, cfg, currentSortParams, currentSortOrder, callback, eleType)
  self:GetComponents()
  self._index = index
  self._cfg = cfg
  self._currSortParams = currentSortParams
  self._currentSortOrder = currentSortOrder
  self._callback = callback
  self._eleType = eleType
  self:OnValue()
end

function UIChooseSortBtnItem1:OnValue()
  if self._cfg.Type == PetSortType.Element then
    self._eleName:SetText(StringTable.Get(self._cfg.Name))
    self._eleRoot:SetActive(true)
    self._norRoot:SetActive(false)
  else
    self._name:SetText(StringTable.Get(self._cfg.Name))
    self._eleRoot:SetActive(false)
    self._norRoot:SetActive(true)
  end
  if self._eleType ~= 0 then
    self._elementTypeImg.sprite = self.atlasProperty:GetSprite(self.ElementSpriteName[self._eleType])
  end
  self:Flush(self._currSortParams, self._currentSortOrder, self._eleType)
end

function UIChooseSortBtnItem1:BgOnClick()
  if self._callback then
    self._callback(self._index)
  end
end

function UIChooseSortBtnItem1:EleOnClick()
  local petModule = self:GetModule(PetModule)
  local currentElementSortTypeOrder = petModule.PetSortElementIndex
  petModule:SavePetSortElementIndex(currentElementSortTypeOrder % 4 + 1)
  if self._callback then
    self._callback(self._index)
  end
end

function UIChooseSortBtnItem1:Flush(params, order, eleType)
  if params == self._cfg.Type then
    if self._cfg.Type == PetSortType.Element then
      self._eleSelectGo:SetActive(true)
      self._elementTypeImg.gameObject:SetActive(true)
      if eleType ~= 0 then
        self._elementTypeImg.sprite = self.atlasProperty:GetSprite(self.ElementSpriteName[eleType])
      end
    else
      self._arrowGo:SetActive(true)
      self._selectImgGo:SetActive(true)
      if order == PetSortOrder.Ascending then
        self._arrow.sprite = self._uiHeartAtlas:GetSprite("spirit_jiantou_w_2_icon")
      else
        self._arrow.sprite = self._uiHeartAtlas:GetSprite("spirit_jiantou_w_1_icon")
      end
    end
  else
    self._arrowGo:SetActive(false)
    self._selectImgGo:SetActive(false)
    self._eleSelectGo:SetActive(false)
  end
end
