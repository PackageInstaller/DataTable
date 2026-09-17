local this = class("pagePetChangeBoxTip", G_UIPageBase)

function this.bind()
  return {
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip,
    txt_moveDesc = "",
    list_pet = {
      moduleName = "pages/pet/cellPixelPet"
    }
  }
end

function this.methods()
  return {
    moduleCommonTipMedium = {
      onClick_confirm = function(self)
        self:onClick_confirm()
      end,
      onClick_cancel = function(self)
        self:onClick_cancel()
      end,
      onClick_close = function(self)
        self:onClick_cancel()
      end,
      onClick_bg = function(self)
        self:onClick_cancel()
      end
    },
    list_pet = {
      onClick_select = function(self, bind)
        self:selectPet(bind.guid)
      end
    }
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.exchangeList = {}
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.options = options or {}
  self.dragPetGuid = self.options.dragPetGuid or self.options.petGuid or self.options.fromGuid
  self.targetBoxIndex = self.options.targetBoxIndex or self.options.boxIndex
  self.targetBoxName = self.options.targetBoxName or L_PetStore:getPetBoxName(self.targetBoxIndex)
  self.exchangeList = self:getExchangeList()
  self.selectedGuid = not self.options.defaultSelectGuid and self.exchangeList[1] and self.exchangeList[1].guid
  self:initCommonTip()
  self:refreshContent()
end

function this:close()
  this.super.close(self)
end

function this:refreshContent()
  local dragPet = L_PetStore:getPetItem(self.dragPetGuid)
  local dragPetName = self:getPetName(dragPet)
  local targetBoxName = self.targetBoxName or ""
  self.bind.txt_moveDesc = L_WordsTpl:getValue("ui_kibo_box_position_change_tips", {
    [0] = L_GameUtil.fillColor(dragPetName, "#d94b4b"),
    [1] = L_GameUtil.fillColor(targetBoxName, "#d94b4b")
  })
  self:refreshPetList()
end

function this:initCommonTip()
  local moduleTip = self.modules and self.modules.moduleCommonTipMedium
  if moduleTip == nil then
    return
  end
  local param = {
    txtTitle = L_WordsTpl:getValue("ui_kibo_box_position_change_title"),
    txtContent = "",
    txtCancel = L_WordsTpl:getValue("common_window_2"),
    txtConfirm = L_WordsTpl:getValue("common_window_1")
  }
  moduleTip:initModule(param)
end

function this:getExchangeList()
  if not table.isEmpty(self.options.exchangeList) then
    return self.options.exchangeList
  end
  local list = {}
  local targetBoxPets = L_PetStore:getPetBoxList(self.targetBoxIndex) or {}
  for slot, guid in ipairs(targetBoxPets) do
    if not math.isEmpty(guid) then
      local pet = L_PetStore:getPetItem(guid)
      if pet then
        table.insert(list, {
          guid = guid,
          name = self:getPetName(pet),
          slot = slot,
          boxIndex = self.targetBoxIndex,
          configId = pet.id
        })
      end
    end
  end
  return list
end

function this:getPetName(pet)
  if not pet then
    return ""
  end
  if pet.getPetName then
    return pet:getPetName()
  end
  return pet.pet_name or pet.name or ""
end

function this:refreshPetList()
  local tmp = {}
  self.exchangeIndexByGuid = {}
  for i, petData in ipairs(self.exchangeList or {}) do
    self.exchangeIndexByGuid[petData.guid] = i
    table.insert(tmp, self:getPetCellData(petData, i))
  end
  self.bind.list_pet:clear()
  self.bind.list_pet:insert_array(tmp)
end

function this:getPetCellData(petData, index)
  local isSelected = petData.guid == self.selectedGuid
  return {
    guid = petData.guid,
    itemType = L_Const.resType.pet,
    choice = isSelected,
    selected = isSelected,
    isSelected = isSelected,
    pointEnter = isSelected,
    outlineShow = isSelected,
    slot = petData.slot,
    slotIndex = petData.slot or index,
    boxIndex = petData.boxIndex or self.targetBoxIndex,
    originBoxIndex = petData.boxIndex or self.targetBoxIndex,
    originSlot = petData.slot,
    configId = petData.configId,
    name = petData.name,
    petName = petData.name,
    callback = function(cell)
      self:selectPet(cell.bind.guid, true)
    end
  }
end

function this:selectPet(guid, delayUpdate)
  if math.isEmpty(guid) or self.selectedGuid == guid then
    return
  end
  local lastGuid = self.selectedGuid
  self.selectedGuid = guid
  if delayUpdate then
    FrameScheduler.add(function()
      if self.isBind then
        self:refreshSelectedPet(lastGuid, guid)
      end
    end, 1, self.gameObject)
    return
  end
  self:refreshSelectedPet(lastGuid, guid)
end

function this:refreshSelectedPet(...)
  for _, guid in ipairs({
    ...
  }) do
    local index = self.exchangeIndexByGuid and self.exchangeIndexByGuid[guid]
    local petData = index and self.exchangeList[index]
    if index and petData then
      local cellData = self:getPetCellData(petData, index)
      self.bind.list_pet:change(index, cellData)
      local cell = self.modules and self.modules.list_pet and self.modules.list_pet[index]
      self:refreshPetCellSelectState(cell, cellData)
    end
  end
end

function this:refreshPetCellSelectState(cell, cellData)
  if not cell or not cell.isBind then
    return
  end
  local isSelected = cellData.selected == true
  cell.bind.choice = isSelected
  cell.bind.pointEnter = isSelected
  cell.bind.outlineShow = isSelected
  cell.bind.selected = not isSelected
  if cell.setGifPlay then
    cell:setGifPlay(isSelected)
  end
  if cell.setOutLineShow then
    cell:setOutLineShow(isSelected)
  end
end

function this:onClick_confirm()
  if math.isEmpty(self.selectedGuid) then
    return
  end
  local selectedData = self:getSelectedData()
  if self.options.confirmCallback then
    self.options.confirmCallback(self.selectedGuid, selectedData)
  else
    L_PetStore:req_CSExchangePetBoxId(self.dragPetGuid, self.selectedGuid)
  end
  L_UI:close(self.pageName)
end

function this:onClick_cancel()
  if self.options and self.options.cancelCallback then
    self.options.cancelCallback()
  end
  L_UI:close(self.pageName)
end

function this:getSelectedData()
  for _, petData in ipairs(self.exchangeList or {}) do
    if petData.guid == self.selectedGuid then
      return petData
    end
  end
end

return this
