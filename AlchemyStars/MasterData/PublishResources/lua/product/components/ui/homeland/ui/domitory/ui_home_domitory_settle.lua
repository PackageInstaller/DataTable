_class("UIHomeDomitorySettle", UIController)
UIHomeDomitorySettle = UIHomeDomitorySettle

function UIHomeDomitorySettle:OnShow(uiParams)
  self:InitWidget()
  self._petModule = self:GetModule(PetModule)
  local removePetID = uiParams[1]
  if removePetID then
    self._removeOne = self._petModule:GetPet(removePetID)
    if not self._removeOne then
      Log.exception("严重错误，需要移除的星灵不在背包中:", removePetID)
    end
  end
  self._filterParams = {}
  self._sortType = PetSortType.Level
  self._sortOrder = PetSortOrder.Descending
  self._sort = self.sort:SpawnObject("UIPetSortAndFilter")
  self._sort:SetData("HomeSettle", self._sortType, self._sortOrder, 3, function(filterParams, sortType, sortOrder)
    self._filterParams = filterParams
    self._sortType = sortType
    self._sortOrder = sortOrder
    self:RefreshPets()
  end)
  self._cards = self.cards:SpawnObject("UIPetFilterCards")
  self._cards:SetData("UIHomeDomitoryPetCard", self._removeOne, function(pet, isRemove)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIPetFilterCardsOnSelect, pet, isRemove)
    self:CloseDialog()
  end)
  local guideModule = GameGlobal.GetModule(GuideModule)
  local guidePets
  if guideModule:IsGuideProcessKey("guide_dormitory_in") then
    local cfg = Cfg.cfg_guide_const.guide_dormitory_in
    guidePets = {}
    table.insert(guidePets, cfg.ArrayValue[1])
    table.insert(guidePets, cfg.ArrayValue[2])
  end
  self._guidePet = nil
  local pets = self._petModule:GetPets()
  self._allPets = {}
  for _, pet in pairs(pets) do
    local filtered = true
    if self._removeOne and self._removeOne:GetPstID() == pet:GetPstID() then
      filtered = false
    end
    local templateID = pet:GetTemplateID()
    if table.icontains(guidePets, templateID) then
      self._guidePet = pet
      filtered = false
    end
    if filtered then
      table.insert(self._allPets, pet)
    end
  end
  self:RefreshPets()
end

function UIHomeDomitorySettle:InitWidget()
  self.topBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self.sort = self:GetUIComponent("UISelectObjectPath", "sort")
  self.cards = self:GetUIComponent("UISelectObjectPath", "cards")
end

function UIHomeDomitorySettle:RefreshPets()
  local sortParams = PetDefaulSort[self._sortType][self._sortOrder]
  local tmp = {
    PetSortParam:New(PetSortType.HomeSettled, PetSortOrder.Ascending)
  }
  for _, param in ipairs(sortParams) do
    tmp[#tmp + 1] = param
  end
  sortParams = tmp
  self._pets = self._petModule:_SortPets(self._allPets, self._filterParams, sortParams, UIPetSortContext.Instance:ShowViceElement())
  if self._removeOne then
    table.insert(self._pets, 1, self._removeOne)
  end
  if self._guidePet then
    table.insert(self._pets, 1, self._guidePet)
  end
  self._cards:Refresh(self._pets)
end

function UIHomeDomitorySettle:BackOnClick()
  self:CloseDialog()
end

function UIHomeDomitorySettle:GetFirstPet()
  return self._cards:GetFirstPet()
end
