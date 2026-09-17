local this = class("moduleSituationEdit_pet", require("ui.pages.situation.group.moduleSituationEditBase"))
local _situationTabTpl = L_GameTpl:getSituationTabTpl()
local MAX_TOGGLE_COUNT = 14

function this.bind()
  return {
    active_blur = true,
    activePetList = true,
    list = {
      moduleName = "pages/situation/cell/cellSituationPetItem"
    },
    size_list_pet = L_DeviceTpl:getIsPc() and C_Vector2(367, 768) or C_Vector2(367, 611),
    txt_listIndex = "",
    txt_petName = "",
    txt_curNum = "",
    txt_maxNum = "",
    list_toggle = {
      moduleName = "pages/photo/cell/cellPhotoListToggle"
    },
    dragHandler = {
      moduleName = "pages/situation/module/moduleSituationDragHandler"
    },
    activeDragHandler = nil,
    actionPanel = {
      moduleName = "pages/situation/module/moduleSituationActionPanel"
    },
    panelBg = false,
    menuTabList = {
      moduleName = "pages/photo/modulePhotoMenuTabList"
    },
    active_tabList = false,
    title = true,
    instruection = false
  }
end

function this.methods()
  return {
    onClickPre = function(self)
      self:moveBox(-1)
    end,
    onClickNext = function(self)
      self:moveBox(1)
    end,
    list = {
      onClickAdd = function(self, guid, darkenSafeHelper)
        local curNum = L_SituationManager:getCount(L_Const.situationGroup.pet)
        local tpl_situationTab = _situationTabTpl:getTplById(L_Const.situationGroup.pet)
        local maxNum = _situationTabTpl:getNumber(tpl_situationTab)
        self:onClickAdd(guid)
        if curNum == maxNum then
          return
        end
        if curNum <= maxNum then
          darkenSafeHelper:SetGray()
        end
        self:refreshShowNum()
      end,
      onClickRemove = function(self, guid, darkenSafeHelper)
        self:onClickRemove(guid)
        darkenSafeHelper:ResetColors()
        self:refreshShowNum()
      end
    },
    onClickCloseList = function(self)
      self.bind.activePetList = false
      self.bind.title = false
      self.bind.active_blur = false
      self.parent.bind.editTabId = -1
    end,
    dragHandler = {
      onClickCancel = function(self)
        self:onClickRemove(self.selectPetGuid)
      end,
      onClickConfirm = function(self)
        self:deSelectPet()
      end,
      onRotChanged = function(self, startY, endY)
        self:onRotChanged(startY, endY)
      end,
      onPosChanged = function(self, startPos, endPos)
        self:onPosChanged(startPos, endPos)
      end
    }
  }
end

function this:open()
  self:initModule()
end

function this:initModule()
  self.bind.activePetList = true
  self.bind.active_blur = true
  self.bind.title = true
  self.modules.actionPanel:init(L_Const.situationGroup.pet)
  self:initPetList()
  self:refreshShowNum()
end

function this:show()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.refreshItemBtns, self)
  L_SituationStore:listenCallFunc(L_SituationStore.event.undoCountChanged, self.refreshItemBtns, self)
  self:initTab()
  self:deSelectPet()
  self:refreshItemBtns()
end

function this:hide()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.refreshItemBtns, self)
  self:deSelectPet()
  self:refreshItemBtns()
end

function this:close()
end

function this:initPetList()
  self.curBoxIndex = 1
  self:initPetBoxData()
  self:refreshBoxInfo(self.curBoxIndex)
  self.toggleCount = math.min(self.maxBoxIndex, MAX_TOGGLE_COUNT)
  self.windowStart = 1
  local toggleInitDatas = {}
  for i = 1, self.toggleCount do
    table.insert(toggleInitDatas, {})
  end
  self.bind.list_toggle:clear()
  self.bind.list_toggle:insert_array(toggleInitDatas)
  self:setPointListActive(self.curBoxIndex)
end

function this:refreshWindow(boxIndex)
  if boxIndex < self.windowStart then
    self.windowStart = boxIndex
  elseif boxIndex > self.windowStart + self.toggleCount - 1 then
    self.windowStart = boxIndex - self.toggleCount + 1
  end
  local maxStart = math.max(1, self.maxBoxIndex - self.toggleCount + 1)
  self.windowStart = math.clamp(self.windowStart, 1, maxStart)
end

function this:refreshShowNum()
  self.bind.txt_curNum = string.format("%d", L_SituationManager:getCount(L_Const.situationGroup.pet))
  local tpl_situationTab = _situationTabTpl:getTplById(L_Const.situationGroup.pet)
  self.bind.txt_maxNum = string.format("/%d", _situationTabTpl:getNumber(tpl_situationTab))
end

function this:initPetBoxData()
  local boxList = self:createBoxListData()
  self.boxDataList = boxList
  self.maxBoxIndex = math.max(#boxList, 1)
  self.curBoxIndex = 1
end

function this:createBoxListData()
  local boxList = {}
  self.boxDataDict = {}
  self.boxIndex2RealIndex = {}
  local countList = L_PetStore:getPetBoxList()
  local curIndex = 1
  for boxIndex, list in ipairs(countList or table.empty) do
    for _, v in ipairs(list or table.empty) do
      local pet = L_PetStore:getPetItem(v)
      if not table.isEmpty(pet) then
        if not boxList[curIndex] then
          boxList[curIndex] = {}
        end
        local data = {
          guid = pet.guid,
          boxIndex = boxIndex
        }
        table.insert(boxList[curIndex], data)
        self.boxDataDict[data.guid] = data
      end
    end
    if not table.isEmpty(boxList[curIndex]) then
      self.boxIndex2RealIndex[curIndex] = boxIndex
      curIndex = curIndex + 1
    end
  end
  return boxList
end

function this:refreshBoxInfo(boxIndex)
  if not self.boxDataList then
    return
  end
  self.bind.list:clear()
  local list = self.boxDataList[boxIndex]
  if table.isEmpty(list) then
    return
  end
  self.bind.list:insert_array(list)
end

function this:setPointListActive(itemIndex)
  itemIndex = itemIndex or 1
  self:refreshWindow(itemIndex)
  local activeSlot = itemIndex - self.windowStart + 1
  for i = 1, self.toggleCount do
    local active = i == activeSlot
    self.bind.list_toggle:change(i, {
      on = active,
      off = not active
    })
  end
  local realBoxIndex = self.boxIndex2RealIndex[itemIndex] or itemIndex
  self.bind.txt_listIndex = self:indexChange(realBoxIndex)
  self.bind.txt_petName = self:getPetBoxName(realBoxIndex)
end

function this:moveBox(ins)
  local newVal = self.curBoxIndex + ins
  if newVal > self.maxBoxIndex then
    newVal = 1
  elseif newVal < 1 then
    newVal = self.maxBoxIndex
  end
  if self.curBoxIndex == newVal then
    return
  end
  self.curBoxIndex = newVal
  self:refreshBoxInfo(self.curBoxIndex)
  self:setPointListActive(self.curBoxIndex)
end

function this:indexChange(index)
  if index < 10 then
    return string.format("0%d", index)
  end
  return tostring(index)
end

function this:getPetBoxName(index)
  local petBoxNameList = L_PetStore:getPetBoxNameList()
  return petBoxNameList[index] or ""
end

function this:onClickAdd(guid)
  local petItem = L_PetStore:getPetItem(guid)
  if petItem then
    local param = {
      petGuid = guid,
      petConfigId = petItem.id,
      specialParam = petItem.color,
      flashParam = petItem:hasFlashGene(),
      pos = L_SituationManager:getLookPos(),
      rot = L_Vector3.new(0, 0, 0),
      actionId = L_Const.photoParam.petDefAction,
      actionTime = 0,
      faceId = L_Const.photoParam.petDefFace,
      skinId = petItem.wear_skin_id,
      starColorId = petItem.colorMatId
    }
    L_SituationManager:addCreatePetCommand(param)
  end
end

function this:onClickRemove(guid)
  local param = {petGuid = guid}
  L_SituationManager:addRemovePetCommand(param)
  self:refreshItemBtns()
  if self.curSelectPetContainer and self.curSelectPetContainer.data.petGuid == guid then
    self:deSelectPet()
  end
end

function this:selectPet(petContainer)
  if petContainer == self.curSelectPetContainer then
    return
  end
  self:deSelectPet()
  self.curSelectPetContainer = petContainer
  self.selectPetGuid = petContainer.data.petGuid
  self.bind.activeDragHandler = true
  self.modules.dragHandler:show()
  self.modules.dragHandler:bindObj(self.curSelectPetContainer.petObj)
  self.modules.actionPanel:bindContainer(petContainer)
  if L_DeviceTpl:getIsMobile() then
    self.bind.size_list_pet = C_Vector2(367, 511)
  end
  self.bind.panelBg = true
  for _, v in pairs(self.modules.list) do
    local cell = v
    cell:refreshSelectRoot(self.selectPetGuid)
  end
  self.bind.active_tabList = true
end

function this:deSelectPet()
  self.selectPetGuid = nil
  self.curSelectPetContainer = nil
  self.bind.activeDragHandler = false
  self.modules.dragHandler:bindObj(nil)
  self.modules.actionPanel:bindContainer(nil)
  if L_DeviceTpl:getIsMobile() then
    self.bind.size_list_pet = C_Vector2(367, 611)
  end
  self.bind.panelBg = false
  for _, v in pairs(self.modules.list) do
    local cell = v
    cell:refreshSelectRoot(nil)
  end
  self.bind.active_tabList = false
end

function this:onPosChanged(startPos, endPos)
  local param = {
    petGuid = self.selectPetGuid,
    startPos = startPos,
    endPos = endPos
  }
  L_SituationManager:addMovePetCommand(param)
end

function this:onRotChanged(startY, endY)
  local param = {
    petGuid = self.selectPetGuid,
    startRotate = L_Vector3.new(0, startY, 0),
    endRotate = L_Vector3.new(0, endY, 0)
  }
  L_SituationManager:addRotatePetCommand(param)
end

function this:refreshItemBtns()
  for _, v in pairs(self.modules.list) do
    local cell = v
    cell:refreshBtns()
  end
  if self.selectPetGuid then
    local has = L_SituationManager:hasPet(self.selectPetGuid)
    if not has then
      self:deSelectPet()
    end
  end
  self:refreshShowNum()
end

function this:initTab()
  self.currentActionTabId = L_Const.photoTabType.ACTION
  local tabList = {
    L_Const.photoTabType.ACTION,
    L_Const.photoTabType.FACE
  }
  self.modules.menuTabList:setData(tabList, handler(self, self.onSelectActionTabId), self.currentActionTabId)
  self:refreshSituationAction(self.currentActionTabId)
  self.modules.menuTabList:setSelectTabId(self.currentActionTabId)
end

function this:onSelectActionTabId(tabId)
  if self.currentActionTabId == tabId then
    return
  end
  self.currentActionTabId = tabId
  self:refreshSituationAction(tabId)
end

function this:refreshSituationAction(tabId)
  self.modules.actionPanel:refreshActionList(tabId)
end

return this
