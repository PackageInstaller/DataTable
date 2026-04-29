_class("UIDispatchSelectPetController", UIController)
UIDispatchSelectPetController = UIDispatchSelectPetController

function UIDispatchSelectPetController:Constructor()
  self._itemCountPerRow = 6
  self._listShowItemCount = 0
  self._firstIn = true
end

function UIDispatchSelectPetController:OnShow(uiParams)
  self._index = uiParams[1]
  self._dispatchDetailItem = uiParams[2]
  self._selectedPet = self._dispatchDetailItem:GetDispatchPetByIndex(self._index)
  local exculdePets = uiParams[3]
  self:GetComponents()
  local sortedPets = self._dispatchDetailItem:GetCanDispatchPetList(exculdePets, self._selectedPet)
  local count = #sortedPets
  local index = 1
  while count >= index do
    local pet = sortedPets[index]
    if self._selectedPet and pet:GetPstID() == self._selectedPet:GetPstID() then
      index = index + 1
    elseif self._dispatchDetailItem:GetWorkingSpace(pet) then
      table.remove(sortedPets, index)
      table.insert(sortedPets, pet)
      count = count - 1
    else
      index = index + 1
    end
  end
  self._pets = sortedPets
  self:_CalcPetScrollViewCount()
  self:_InitSrollView()
end

function UIDispatchSelectPetController:GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveAircraft)
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Exit, "UI")
  end)
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._emptyDataTip = self:GetGameObject("EmptyTip")
  self._emptyDataTip:SetActive(false)
end

function UIDispatchSelectPetController:_CalcPetScrollViewCount()
  self._petCount = table.count(self._pets)
  self._listShowItemCount = math.ceil(self._petCount / self._itemCountPerRow)
  self:_CheckEmptyTip()
end

function UIDispatchSelectPetController:_CheckEmptyTip()
  if self._petCount <= 0 then
    self._emptyDataTip:SetActive(true)
  else
    self._emptyDataTip:SetActive(false)
  end
end

function UIDispatchSelectPetController:_InitSrollView()
  self._scrollView:InitListView(self._listShowItemCount, function(scrollView, index)
    return self:_InitSpritListInfo(scrollView, index)
  end, self:_GetScrollViewParam())
  self._firstIn = false
end

function UIDispatchSelectPetController:_GetScrollViewParam()
  local param = UIDynamicScrollViewInitParam:New()
  param.mItemDefaultWithPaddingSize = 333
  return param
end

function UIDispatchSelectPetController:_InitSpritListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIDispatchSelectPetItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local petItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._petCount then
      petItem:GetGameObject():SetActive(false)
    else
      self:_ShowPetItem(petItem, itemIndex)
    end
  end
  return item
end

function UIDispatchSelectPetController:_ShowPetItem(petItem, index)
  local config = self._pets[index]
  petItem:GetGameObject():SetActive(true)
  if config ~= nil then
    local isSelected = self._selectedPet ~= nil and config:GetPstID() == self._selectedPet:GetPstID()
    local workingSpace
    petItem:Refresh(config, isSelected, self._dispatchDetailItem:IsSuggestPetIsElement(), workingSpace, function()
      if isSelected then
        self._dispatchDetailItem:UpdatePetInfo(self._index, nil)
      else
        self._dispatchDetailItem:UpdatePetInfo(self._index, config)
      end
      self:CloseDialog()
    end)
  end
end
