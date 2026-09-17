local module = class("cellPetBox", G_UIModuleBase)
local FILTER_LIST_ROW_COUNT = 6
local FILTER_LIST_LINE_COUNT = 5

local function onClickChoose(cell)
  local parent = cell.parent
  if parent and parent.isBind then
    parent:onClickChoose(cell)
  end
end

function module.bind()
  return {
    list_pet = {
      moduleName = "pages/pet/cellPixelPet"
    }
  }
end

function module.methods()
  return {}
end

function module:open()
  self.bindComponents.scrollView.enabled = false
end

function module:show()
  L_PetStore:listenCallFunc(L_PetStore.event.refreshNewPet, self.refreshInfo, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.refreshSinglePet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetBox, self.onEvent_refreshPetBox, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setSelectReleasePet, self.onEvent_setSelectReleasePet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setPetReleaseMode, self.onEvent_setPetReleaseMode, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetGeneMutation, self.onEvent_refreshPetGeneMutation, self)
end

function module:hide()
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshNewPet, self.refreshInfo, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.refreshSinglePet, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetBox, self.onEvent_refreshPetBox, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.setSelectReleasePet, self.onEvent_setSelectReleasePet, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.setPetReleaseMode, self.onEvent_setPetReleaseMode, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetGeneMutation, self.onEvent_refreshPetGeneMutation, self)
end

function module:refresh()
  if not self.isBind then
    return
  end
  local boxList = self.bindComponents.boxList
  if L_CommonUtil.isValid(boxList) then
  end
  self._isFilterListMode = false
  self.bindComponents.scrollView.enabled = false
  self.bind.petList = L_PetStore:getPetBoxList(self.bind.boxIndex) or {}
  self:refreshInfo()
end

function module:refreshSinglePet(pet)
  if not self.isBind then
    return
  end
  local petGuid = pet and pet.guid
  if not math.isEmpty(petGuid) then
    for _, cell in pairs(self.modules.list_pet or {}) do
      if cell.bind and cell.bind.guid == petGuid and cell.refreshView then
        cell:refreshView()
      end
    end
  end
  self:refreshBoxList(L_PetStore:getCurSelectPetId())
end

function module:onEvent_setCurPetId(guid)
  self:refreshBoxList(guid)
end

function module:onEvent_setSelectReleasePet(guid)
  self:refreshBoxList(guid)
end

function module:onEvent_setPetReleaseMode()
  self:refreshBoxList()
end

function module:onEvent_refreshPetBox(boxMap)
  if boxMap[self.bind.boxIndex] then
    if not self._isFilterListMode then
      self.bind.petList = L_PetStore:getPetBoxList(self.bind.boxIndex) or {}
    end
    self:refreshInfo()
    self:refreshBoxList()
  end
end

function module:onEvent_refreshPetGeneMutation(guid)
  self:refreshBoxList()
end

function module:getPetCellByGuid(guid)
  if math.isEmpty(guid) then
    return
  end
  for _, cell in pairs(self.modules.list_pet or {}) do
    if cell and cell.bind and cell.bind.guid == guid then
      return cell
    end
  end
end

function module:refreshBoxList(guid)
  guid = guid or L_PetStore:getCurSelectPetId()
  CS.UnityEngine.Profiling.Profiler.BeginSample("cellPetBox refreshBoxList 1")
  local releaseMode = L_PetReleaseManager:getIsReleaseMode()
  if releaseMode then
    for _, v in pairs(self.modules.list_pet) do
      if not math.isEmpty(v.bind.guid) then
        v:setGifPlay(L_PetReleaseManager:isPetSelected(v.bind.guid))
      end
    end
    self._lastReleaseMode = true
  else
    if self._lastSelectGuid == nil or self._lastReleaseMode then
      for _, v in pairs(self.modules.list_pet) do
        if not math.isEmpty(v.bind.guid) then
          v:setGifPlay(false)
        end
      end
    end
    local lastSelectGuid = self._lastSelectGuid
    if not math.isEmpty(lastSelectGuid) and lastSelectGuid ~= guid then
      local lastCell = self:getPetCellByGuid(lastSelectGuid)
      if lastCell then
        lastCell:setGifPlay(false)
      end
    end
    local selectCell = self:getPetCellByGuid(guid)
    if selectCell then
      selectCell:setGifPlay(true)
      L_ReddotManager:clearNew(L_ReddotManager.DotDef.PetNew, guid)
    end
    self._lastSelectGuid = guid
    self._lastReleaseMode = false
  end
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function module:padFilterListRow(lst)
  local count = #lst
  local padCount = 0
  local num = FILTER_LIST_ROW_COUNT * FILTER_LIST_LINE_COUNT - count
  if num <= 0 then
    padCount = (FILTER_LIST_ROW_COUNT - count % FILTER_LIST_ROW_COUNT) % FILTER_LIST_ROW_COUNT
  else
    padCount = num
  end
  for _ = 1, padCount do
    table.insert(lst, {filterEmpty = true})
  end
  return lst
end

function module:refreshFilterList(filteredPets, filterType, resetScroll)
  if not self.isBind or not self.bindComponents then
    self._isFilterListMode = true
    self.bind.petList = filteredPets or {}
    return
  end
  self.bindComponents.scrollView.enabled = true
  self._isFilterListMode = true
  self.bind.petList = filteredPets or {}
  self:refreshInfo(filterType)
  self:trimFilterListLayoutOverflow()
  if resetScroll and self.bindComponents.scrollView then
    self.bindComponents.scrollView.verticalNormalizedPosition = 1
  end
end

function module:trimFilterListLayoutOverflow()
  local boxList = self.bindComponents and self.bindComponents.boxList
  if not boxList or not boxList.transform then
    return
  end
  local totalCount = boxList.totalCount or 0
  local trans = boxList.transform
  local childCount = trans.childCount
  for i = totalCount, childCount - 1 do
    local child = trans:GetChild(i)
    if child and child.gameObject.activeSelf then
      child.gameObject:SetActive(false)
    end
  end
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(trans)
  local scrollView = self.bindComponents.scrollView
  if scrollView and scrollView.SetLayoutVertical then
    scrollView:SetLayoutVertical()
  end
end

function module:getWorkStatusIcon(petItem)
  if petItem.work_status == L_Const.PetStationedWorkStatusType.PSWST_RANCH_WORK then
    return "UI/Page/PetBox/tex_pet_frame_homeranch.png"
  elseif petItem.work_status ~= L_Const.PetStationedWorkStatusType.PSWST_NONE then
    return "UI/Page/PetBox/tex_pet_frame_homework.png"
  elseif petItem.roulette_pos > 0 then
    return "UI/Page/PetBox/tex_pet_frame_zuoji.png"
  else
    local index = L_QuickRouletteStore:checkInRoulette(L_Const.quickRouletteType.petPuzzle, petItem.guid)
    if 0 <= index then
      return "UI/Page/PetBox/tex_pet_frame_jiemi.png"
    end
  end
end

function module:onClickChoose(cell)
  if L_PetReleaseManager:getIsReleaseMode() then
    local petId = cell.bind.guid
    L_PetReleaseManager:dealSelectPet(petId)
    return
  end
  if self.isDragging then
    return
  end
  local petId = cell.bind.guid
  if L_PetStore:getCurSelectPetId() == petId then
    return
  end
  local lastPetId = L_PetStore:getCurSelectPetId()
  local lastPetItem = L_PetStore:getPetItem(lastPetId)
  if math.isEmpty(lastPetId) or lastPetItem then
  end
  if lastPetItem and lastPetItem.gene_infos and #lastPetItem.gene_infos > 0 then
    for i, v in ipairs(lastPetItem.gene_infos) do
      local keyString = L_PetStore:getPetGeneMutationNewSaveKeyByPos(lastPetId, v.pos)
      C_PlayerPrefsUtility.SetInt(keyString, 0)
    end
  end
  L_PetStore:setCurSelectPetId(petId)
  self.petId = petId
  self:refreshBoxList(petId)
end

function module:refreshInfo(filterType)
  if not self.isBind then
    return
  end
  if self.isBinded == nil then
    self.isBinded = true
  else
    self.bindComponents.boxList.IsRefreshType = true
  end
  local petStore = L_PetStore
  local countList = self.bind.petList or {}
  local lst = {}
  for i = 1, #countList do
    local cell = {filterEmpty = false}
    local src = countList[i]
    local guid, originBoxIndex, originSlot, petName, rarities
    if type(src) == "table" then
      guid = src.guid
      originBoxIndex = src.originBoxIndex
      originSlot = src.originSlot
      petName = src.petName
      rarities = src.rarities
    else
      guid = src
    end
    local pet = petStore:getPetItem(guid)
    if not table.isEmpty(pet) and not math.isEmpty(guid) then
      cell.choice = petStore:getCurSelectPetId() == guid
      if filterType then
        cell.filterType = filterType
        cell.workStatusIcon = self:getWorkStatusIcon(pet)
      end
      cell.guid = guid
      cell.itemType = L_Const.resType.pet
      cell.reddotName = string.format(L_ReddotManager.DotDef.PetNew, guid)
      cell.reddotGeneName = string.format(L_ReddotManager.DotDef.PetGeneMutation, guid)
      cell.pageType = self.bind.pageType
      cell.callback = onClickChoose
      if self._isFilterListMode then
        cell.originBoxIndex = originBoxIndex
        cell.originSlot = originSlot
        cell.petName = petName
        cell.rarities = rarities
        cell.isFilterItem = true
        cell.slotIndex = i
      else
        cell.originBoxIndex = self.bind.boxIndex
        cell.originSlot = i
        cell.isFilterItem = false
        cell.slotIndex = i
      end
    end
    table.insert(lst, cell)
  end
  if self._isFilterListMode then
    lst = self:padFilterListRow(lst)
  end
  local guidCheckResult = self:isGuidListSame(lst)
  if guidCheckResult == "skip" then
    return
  end
  if guidCheckResult == true and not self._isFilterListMode and filterType == nil then
    self:refreshBoxList(petStore:getCurSelectPetId())
    return
  end
  if not self._isFilterListMode and math.isEmpty(petStore:getCurSelectPetId()) then
    local petGuid = petStore:getFirstOrderPet()
    petStore:setCurSelectPetId(petGuid)
  end
  if #self.bind.list_pet ~= #lst then
    self.bind.list_pet:clear()
    self.bind.list_pet:insert_array(lst)
  else
    for i = 1, #lst do
      if lst[i].guid then
        local cellModule = self.modules.list_pet[i]
        local cellBind = cellModule and cellModule.bind
        local isSameCell = cellBind and cellBind.guid == lst[i].guid and cellBind.filterEmpty == (lst[i].filterEmpty or false) and cellBind.originBoxIndex == lst[i].originBoxIndex and cellBind.originSlot == lst[i].originSlot
        if isSameCell and not self._isFilterListMode and filterType == nil then
          cellBind.choice = lst[i].choice
        else
          self.bind.list_pet:change(i, lst[i])
        end
      else
        local cellModule = self.modules.list_pet[i]
        if cellModule then
          local cellBind = cellModule.bind
          local needRefreshEmpty = cellBind and (not math.isEmpty(cellBind.guid) or cellBind.filterEmpty ~= (lst[i].filterEmpty or false))
          if needRefreshEmpty then
            cellBind.guid = nil
            cellBind.choice = nil
            cellBind.originBoxIndex = lst[i].originBoxIndex
            cellBind.originSlot = lst[i].originSlot
            cellBind.isFilterItem = lst[i].isFilterItem
            cellBind.slotIndex = lst[i].slotIndex
            cellBind.filterEmpty = lst[i].filterEmpty or false
            cellModule:refreshView()
          end
        end
      end
    end
  end
  if self._isFilterListMode then
    self:refreshFilterPetCells()
  end
end

function module:refreshFilterPetCells()
  for _, cell in pairs(self.modules.list_pet or {}) do
    if cell and cell.refreshView and cell.bind and (not math.isEmpty(cell.bind.guid) or cell.bind.filterEmpty) then
      cell:refreshView()
    end
  end
end

function module:close()
  self:closeCell()
end

function module:closeCell()
end

function module:setIsDragging(bool)
  self.isDragging = bool
end

function module:isGuidListSame(newLst)
  local currentModules = self.modules.list_pet or {}
  if #currentModules ~= #newLst then
    return false
  end
  local hasSatietyChange = false
  for i = 1, #newLst do
    local currentCell = currentModules[i]
    local newCell = newLst[i]
    local currentGuid = ""
    if currentCell and currentCell.bind then
      currentGuid = currentCell.bind.guid or ""
    end
    local newGuid = newCell.guid or ""
    if currentGuid ~= newGuid then
      return false
    end
    local currentFilterEmpty = currentCell and currentCell.bind and currentCell.bind.filterEmpty or false
    local newFilterEmpty = newCell.filterEmpty or false
    if currentFilterEmpty ~= newFilterEmpty then
      return false
    end
    local currentOriginBoxIndex = currentCell and currentCell.bind and currentCell.bind.originBoxIndex or nil
    local currentOriginSlot = currentCell and currentCell.bind and currentCell.bind.originSlot or nil
    local newOriginBoxIndex = newCell.originBoxIndex
    local newOriginSlot = newCell.originSlot
    if currentOriginBoxIndex ~= newOriginBoxIndex or currentOriginSlot ~= newOriginSlot then
      return false
    end
    if not math.isEmpty(newGuid) then
      local currentPetEntity = L_PetStore:getPetItem(currentGuid)
      if currentCell.bind.lastSatietyVal == nil then
        currentCell.bind.lastSatietyVal = currentPetEntity and currentPetEntity.satiety_val or 0
      else
        local currentSatiety = currentPetEntity and currentPetEntity.satiety_val or 0
        if currentCell.bind.lastSatietyVal ~= currentSatiety then
          hasSatietyChange = true
          currentCell.bind.lastSatietyVal = currentSatiety
        end
      end
    end
  end
  if hasSatietyChange then
    return "skip"
  end
  return true
end

function module:refreshExistingCells(newLst)
  local currentModules = self.modules.list_pet or {}
  for i = 1, #newLst do
    local currentCell = currentModules[i]
    if currentCell and currentCell.bind then
      currentCell.bind.choice = newLst[i].choice
      currentCell.bind.originBoxIndex = newLst[i].originBoxIndex
      currentCell.bind.originSlot = newLst[i].originSlot
      currentCell.bind.isFilterItem = newLst[i].isFilterItem
      currentCell.bind.slotIndex = newLst[i].slotIndex
      currentCell.bind.filterEmpty = newLst[i].filterEmpty or false
      if currentCell.refresh then
        currentCell:refresh()
      end
    end
  end
end

return module
