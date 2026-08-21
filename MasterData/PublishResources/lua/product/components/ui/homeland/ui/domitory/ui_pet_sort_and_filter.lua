_class("UIPetSortAndFilter", UICustomWidget)
UIPetSortAndFilter = UIPetSortAndFilter

function UIPetSortAndFilter:OnShow(uiParams)
  self:InitWidget()
  UIPetSortContext.CreateInstance()
  UIPetSortContext.Instance:SetViceElement(true)
end

function UIPetSortAndFilter:OnHide()
  UIPetSortContext.ClearInstance()
end

function UIPetSortAndFilter:InitWidget()
  self.sortBtns = self:GetUIComponent("UISelectObjectPath", "sortBtns")
  self.filterPanel = self:GetUIComponent("UISelectObjectPath", "filterPanel")
  self._curSortStateIcon = self:GetUIComponent("Image", "btnFiltrate")
  self._atlas = self:GetAsset("UIHomelandDomitory.spriteatlas", LoadType.SpriteAtlas)
  self._filterFavImg = self:GetUIComponent("Image", "FilterFavBtn")
  self._clearBtn = self:GetGameObject("btnClear")
end

function UIPetSortAndFilter:SetData(sortKey, defaultSortType, defaultSortOrder, btnCount, onChange)
  local sortFilterCfg = UISortFilterCfg[sortKey]
  local sortCfg = {}
  for idx, value in ipairs(sortFilterCfg.Sort) do
    sortCfg[idx] = Cfg.cfg_client_pet_sort[value]
  end
  local filterCfg = {}
  for tag, filters in pairs(sortFilterCfg.Filter) do
    local cfgs = {}
    for idx, value in ipairs(filters) do
      cfgs[idx] = Cfg.cfg_client_pet_filter[value]
    end
    filterCfg[tag] = cfgs
  end
  self._sortCfg = sortCfg
  self._filterCfg = filterCfg
  self._sortType = defaultSortType
  self._sortOrder = defaultSortOrder
  self._onChange = onChange
  self._filterParams = {}
  self._isFilterFavPet = false
  self:SetFilterFavImgActive()
  self._sortBtns = self.sortBtns:SpawnObjects("UIDomitorySortBtn", btnCount)
  for i = 1, btnCount do
    self._sortBtns[i]:SetData(i, self._sortCfg[i], self._sortType, self._sortOrder, function(idx)
      self:changeParams(idx)
    end, UIPetSortContext.Instance:CurElement())
  end
  self:ResetCleatBtn()
end

function UIPetSortAndFilter:btnFiltrateOnClick(go)
  self._curSortStateIcon.sprite = self._atlas:GetSprite("n17_dorm_list_btn2")
  if self._sortFilter == nil then
    self._sortFilter = self.filterPanel:SpawnObject("UIDomitorySortFilter")
  end
  self._sortFilter:SetData(self._sortType, self._sortOrder, self._filterParams, self._sortCfg, self._filterCfg, function(sortType, sortOrder, filterParams)
    self:OnSortFilterChanged(sortType, sortOrder, filterParams)
  end, function()
    self:OnCloseFilterPanel()
  end)
  self._sortFilter:GetGameObject():SetActive(true)
end

function UIPetSortAndFilter:changeParams(idx)
  local tp = self._sortCfg[idx].Type
  if tp == PetSortType.Element then
    local element = UIPetSortContext.Instance:CurElement()
    if element == ElementType.ElementType_Blue then
      self._sortType = PetSortType.WaterFirst
    elseif element == ElementType.ElementType_Red then
      self._sortType = PetSortType.FireFirst
    elseif element == ElementType.ElementType_Green then
      self._sortType = PetSortType.SenFirst
    elseif element == ElementType.ElementType_Yellow then
      self._sortType = PetSortType.ElectricityFirst
    elseif element == 5 then
      self._sortType = PetSortType.NoneElementFirst
    end
    self._sortOrder = PetSortOrder.Descending
  elseif self._sortType == tp then
    if self._sortOrder == PetSortOrder.Ascending then
      self._sortOrder = PetSortOrder.Descending
    elseif self._sortOrder == PetSortOrder.Descending then
      self._sortOrder = PetSortOrder.Ascending
    end
  else
    self._sortType = tp
    self._sortOrder = PetSortOrder.Descending
  end
  for i = 1, #self._sortBtns do
    self._sortBtns[i]:Flush(self._sortType, self._sortOrder, UIPetSortContext.Instance:CurElement())
  end
  self:ResetCleatBtn()
  self._onChange(self._filterParams, self._sortType, self._sortOrder)
end

function UIPetSortAndFilter:OnSortFilterChanged(sortType, sortOrder, filterParams)
  self._sortType = sortType
  self._sortOrder = sortOrder
  self._filterParams = filterParams
  for i = 1, #self._sortBtns do
    self._sortBtns[i]:Flush(self._sortType, self._sortOrder, UIPetSortContext.Instance:CurElement())
  end
  self:ResetCleatBtn()
  self._onChange(self._filterParams, self._sortType, self._sortOrder)
end

function UIPetSortAndFilter:OnCloseFilterPanel()
  self:ResetCleatBtn()
  if not next(self._filterParams) then
    self._curSortStateIcon.sprite = self._atlas:GetSprite("n17_dorm_list_btn1")
  end
end

function UIPetSortAndFilter:BtnClearOnClick()
  self._filterParams = {}
  self._isFilterFavPet = false
  UIPetSortContext.Instance:SetViceElement(true)
  self:ResetCleatBtn()
  if self._sortFilter then
    self._sortFilter:ClearFilters()
    if not self._sortFilter:IsShow() then
      self._curSortStateIcon.sprite = self._atlas:GetSprite("n17_dorm_list_btn1")
    end
  end
  self._onChange(self._filterParams, self._sortType, self._sortOrder)
  self:SetFilterFavImgActive()
end

function UIPetSortAndFilter:ResetCleatBtn()
  self._clearBtn:SetActive(next(self._filterParams) ~= nil)
end

function UIPetSortAndFilter:FilterFavBtnOnClick(go)
  self._isFilterFavPet = not self._isFilterFavPet
  if self._isFilterFavPet then
    if not self._filterParams then
      self._filterParams = {}
    end
    local filterParam = PetFilterParam:New(PetFilterType.Fav_Collect, PetFilterType.Fav_Collect)
    table.insert(self._filterParams, filterParam)
  elseif not self._filterParams then
    self._filterParams = {}
  else
    local removeIdx
    for index, value in ipairs(self._filterParams) do
      if value._filter_type == PetFilterType.Fav_Collect then
        removeIdx = index
        break
      end
    end
    if removeIdx then
      table.remove(self._filterParams, removeIdx)
    end
  end
  self:SetFilterFavImgActive()
  self._onChange(self._filterParams, self._sortType, self._sortOrder)
end

function UIPetSortAndFilter:SetFilterFavImgActive()
  if self._isFilterFavPet then
    self._filterFavImg.sprite = self._atlas:GetSprite("tjxa_icon6")
  else
    self._filterFavImg.sprite = self._atlas:GetSprite("tjxa_icon5")
  end
end
