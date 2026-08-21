_class("UIChooseSpiritSortItem", UICustomWidget)
UIChooseSpiritSortItem = UIChooseSpiritSortItem

function UIChooseSpiritSortItem:Constructor()
  self._itemCountPerRow = 6
  self._listShowItemCount = 0
  self._AsyncLoadFlagMap = {}
  self._TaskList = {}
  self._btnCount = 3
  self._firstIn = true
  self._uiHeartAtlas = self:GetAsset("UIChangeAssistant.spriteatlas", LoadType.SpriteAtlas)
  self._items = {}
  self._elementSortTypeOrder = {
    [1] = PetSortType.WaterFirst,
    [2] = PetSortType.FireFirst,
    [3] = PetSortType.SenFirst,
    [4] = PetSortType.ElectricityFirst,
    [5] = PetSortType.NoneElementFirst
  }
  self._currentElementSortTypeOrder = 0
  self._sortFilterActiveStatus = false
  self._petHeartItemList = {}
end

function UIChooseSpiritSortItem:GetComponents()
  self._sortBtns = self:GetUIComponent("UISelectObjectPath", "sortBtns")
  self._curSortStateIcon = self:GetUIComponent("Image", "btnFiltrate")
  self._curSortObj = self:GetGameObject("btnFiltrate")
  self._curSortObj:SetActive(true)
  self._sortFilterLoader = self:GetUIComponent("UISelectObjectPath", "sortFilter")
  self._clearFilterBtn = self:GetGameObject("clearFilterBtn")
  self._clearFilterBtn:SetActive(false)
  self._clearFilterBtnTrans = self:GetUIComponent("RectTransform", "clearFilterBtn")
  self._topRightTrans = self:GetUIComponent("RectTransform", "TopRightAnchor")
end

function UIChooseSpiritSortItem:OnValue()
  self:SetClearBtnStatus()
  self:InitTopBtns()
end

function UIChooseSpiritSortItem:OnShow(uiParams)
  self:GetComponents()
  self._petModule = GameGlobal.GetModule(PetModule)
  local sortFilterCfg = UISortFilterCfg.ChooseSortItem
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
  self._sortType = PetSortType.Star
  self._sortOrder = PetSortOrder.Descending
  self._filterParams = {}
  self:AttacEvents()
  local sortParams = PetDefaulSort[self._sortType][self._sortOrder]
  self._pets = self._petModule:_SortPets(self._petModule:GetPets(), self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  self:OnValue()
end

function UIChooseSpiritSortItem:InitTopBtns()
  self._curSortStateIcon.sprite = self._uiHeartAtlas:GetSprite("ghzl_main_di14")
  if self._petModule.PetSortElementIndex ~= 0 then
    self._currentElementSortTypeOrder = self._petModule.PetSortElementIndex
  end
  self._sortBtns:SpawnObjects("UIChooseSortBtnItem", self._btnCount)
  self._sortBtnsPool = self._sortBtns:GetAllSpawnList()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:SetData(i, self._sortCfg[i], self._sortType, self._sortOrder, function(idx)
      self:ChangeSortParams(idx)
    end, self._currentElementSortTypeOrder)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._topRightTrans)
  local topBtnsWidth = self._topRightTrans.rect.width
  local sub = 145
  local targetPos = Vector2(-topBtnsWidth + sub, self._clearFilterBtn.transform.localPosition.y)
  self._clearFilterBtn.transform.localPosition = targetPos
end

function UIChooseSpiritSortItem:ChangeSortParams(idx)
  local tp = self._sortCfg[idx].Type
  GameGlobal.UAReportForceGuideEvent("UIPetViewClick", {
    self._sortCfg[idx].Name
  }, true)
  if self._sortType == tp then
    if self._sortOrder == PetSortOrder.Ascending then
      self._sortOrder = PetSortOrder.Descending
    elseif self._sortOrder == PetSortOrder.Descending then
      self._sortOrder = PetSortOrder.Ascending
    end
  else
    self._sortType = tp
  end
  self:FlushTopBtnState()
  self:RefrenshPetList()
end

function UIChooseSpiritSortItem:FlushTopBtnState()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:Flush(self._sortType, self._sortOrder, self._petModule.PetSortElementIndex)
  end
end

function UIChooseSpiritSortItem:AttacEvents()
end

function UIChooseSpiritSortItem:DetachEvents()
end

function UIChooseSpiritSortItem:CheckCardAwakeRedPoint()
  self:RefrenshPetList(0, true)
end

function UIChooseSpiritSortItem:OnHide()
  for _, v in pairs(self._TaskList) do
    if v then
      GameGlobal.TaskManager():KillTask(v)
      v = nil
    end
  end
  self:DetachEvents()
  self._petModule:ClearAllPetSortInfo()
end

function UIChooseSpiritSortItem:RefrenshPetList(pstid, stay)
  self._items = {}
  local sortParams
  if self._sortType == PetSortType.Element then
    self._currentElementSortTypeOrder = self._petModule.PetSortElementIndex
    sortParams = PetDefaulSort[self._elementSortTypeOrder[self._currentElementSortTypeOrder]][PetSortOrder.Descending]
  else
    sortParams = PetDefaulSort[self._sortType][self._sortOrder]
  end
  self._pets = self._petModule:_SortPets(self._petModule:GetPets(), self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  self._petModule:SavePetSortInfo(self._filterParams, self._sortOrder, self._sortType)
  self.uiOwner:_OnValue()
end

function UIChooseSpiritSortItem:OnSortFilterChanged(sortType, sortOrder, filterParams)
  self._sortType = sortType
  self._sortOrder = sortOrder
  self._filterParams = filterParams
  self:FlushTopBtnState()
  self:RefrenshPetList()
end

function UIChooseSpiritSortItem:btnFiltrateOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIPetViewClick", {
    "shaixuankai"
  }, true)
  self._curSortStateIcon.sprite = self._uiHeartAtlas:GetSprite("ghzl_main_di15")
  self._sortFilterActiveStatus = true
  if self._sortFilter == nil then
    self._sortFilter = self._sortFilterLoader:SpawnObject("UIChooseSortFilterItem")
  end
  self._sortFilter:SetData(self._sortType, self._sortOrder, self._filterParams, self._sortCfg, self._filterCfg, function(sortType, sortOrder, filterParams)
    self:OnSortFilterChanged(sortType, sortOrder, filterParams)
  end, function()
    self:CloseFiterCallBack()
  end)
  self._clearFilterBtn:SetActive(true)
  self._sortFilter:GetGameObject():SetActive(true)
  self._curSortObj:SetActive(false)
  self.uiOwner:SetSaveAndCancelObj(false)
end

function UIChooseSpiritSortItem:ClearFilterBtnOnClick()
  if self._sortFilterActiveStatus == false then
    self._clearFilterBtn:SetActive(false)
    self._curSortObj:SetActive(true)
    self.uiOwner:SetSaveAndCancelObj(true)
    self._curSortStateIcon.sprite = self._uiHeartAtlas:GetSprite("ghzl_main_di14")
  end
  self._petModule:ClearPetSortFilterInfo()
  self._filterParams = {}
  self:FlushTopBtnState()
  self:RefrenshPetList()
  if self._sortFilter then
    self._sortFilter:ClearFilters()
  end
end

function UIChooseSpiritSortItem:CloseFiterCallBack()
  GameGlobal.UAReportForceGuideEvent("UIPetViewClick", {
    "shaixuanguan"
  }, true)
  self._sortFilterActiveStatus = false
  self:SetClearBtnStatus()
end

function UIChooseSpiritSortItem:SetClearBtnStatus()
  if not self._petModule:CheckHasCachePetSortInfo() then
    self._curSortStateIcon.sprite = self._uiHeartAtlas:GetSprite("ghzl_main_di14")
    self._clearFilterBtn:SetActive(false)
    self._curSortObj:SetActive(true)
    self.uiOwner:SetSaveAndCancelObj(true)
  else
    self._curSortStateIcon.sprite = self._uiHeartAtlas:GetSprite("ghzl_main_di15")
    self._clearFilterBtn:SetActive(true)
    self._curSortObj:SetActive(false)
    self.uiOwner:SetSaveAndCancelObj(false)
  end
end
