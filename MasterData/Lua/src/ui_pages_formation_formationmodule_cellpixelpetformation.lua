local this = class("cellPixelPetFormation", G_UIModuleBase)
local MultiPlatformPrefabConfigType = typeof(CS.Lens.Framework.Utility.MultiPlatformPrefabConfig)

local function ensureMultiPlatformApplied(module)
  local multiPlatformConfig = module.gameObject:GetComponent(MultiPlatformPrefabConfigType)
  if L_CommonUtil.isValid(multiPlatformConfig) then
    multiPlatformConfig:EnsureRuntimeApplied()
  end
end

function this.bind()
  return {
    txt_petName = "",
    go_posIndex = false,
    txt_posIndex = "",
    showSeparatorObj = false,
    separatorGroupText = "",
    module_cellPixelPet = {
      moduleName = "pages/pet/cellPixelPet"
    },
    go_petGameplayStatus = false,
    module_petGameplayStatus = {
      moduleName = "pages/pet/modulePetGameplayStatus"
    },
    activeAdd = false,
    activeAddMaskChongwu = false,
    activeAddMaskTaijie = false,
    showGameplayStatus = true
  }
end

function this.methods()
  return {}
end

function this:open()
  self._cellPixelPet = self.modules.module_cellPixelPet
  ensureMultiPlatformApplied(self._cellPixelPet)
  ensureMultiPlatformApplied(self._cellPixelPet.modules.module_pixelIcon)
  self:initCell()
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
  if L_DeviceTpl:getIsMobile() and self.bindComponents.rect_masterIconRoot ~= nil then
    self.bindComponents.rect_masterIconRoot.anchoredPosition = C_Vector2(0, 16.77)
  end
end

function this:close()
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
end

function this:initCell()
  if not self.isBind then
    return
  end
  self:refreshView()
end

function this:refresh()
  self:refreshView()
end

function this:refreshView()
  if not self.isBind then
    return
  end
  local isEmpty = math.isEmpty(self.bind.guid)
  local isSeparator = not math.isEmpty(self.bind.groupId) and self.bind.groupId ~= 0
  self.bind.showSeparatorObj = isSeparator
  self.bind.separatorGroupText = tostring(self.bind.groupId)
  self.modules.module_cellPixelPet:SetActive(not isSeparator)
  self.bind.go_petGameplayStatus = not isEmpty and self.bind.showGameplayStatus ~= false
  self.notSelectGray = self.bind.notSelectGray
  if isEmpty then
    local param = {
      callback_Empty = self.bind.callback_Empty,
      pageType = self.bind.pageType
    }
    self._cellPixelPet:setPetDataContent(self.bind.guid, param)
    self:setSelect(false)
    self.bind.txt_petName = ""
    self:setPosIndex()
    return
  end
  local serverData = L_PetStore:getPetItem(self.bind.guid)
  self.bind.txt_petName = serverData.pet_name
  if self.bind.go_petGameplayStatus then
    local petGameplayStatus = self.modules.module_petGameplayStatus
    petGameplayStatus:setData(self.bind.guid)
  end
  if L_FormationManager:getRuntimeFormationType() then
    local pos
    pos = L_FormationStore:getPetPlaceInTeam(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), self.bind.guid)
    local editPos = L_FormationManager:getFocusIndex()
    self.bind.go_select = pos == editPos
  end
  local sel = self.bind.type == L_Const.cellIconUnitType.quickTeamUp and 0 < (self.bind.posIndex or 0)
  self._cellPixelPet:setPetDataContent(self.bind.guid, {
    pageType = self.bind.pageType,
    choice = self.bind.go_select,
    filterType = L_PetConst.filterPetBox.level,
    callback = self.bind.callback,
    callback_Empty = self.bind.callback_Empty,
    pointEnterCallback = self.bind.pointEnterCallback,
    pointExitCallback = function(cell)
      if self.bind.pointExitCallback then
        self.bind.pointExitCallback(cell)
      end
    end
  })
  self:setSelect(self.bind.go_select)
end

function this:refreshSelect()
  if L_FormationManager:getRuntimeFormationType() then
    local pos
    pos = L_FormationStore:getPetPlaceInTeam(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), self.bind.guid)
    local editPos = L_FormationManager:getFocusIndex()
    self.bind.go_select = pos == editPos
    self:setSelect(self.bind.go_select)
  end
end

function this:setSelect(selected)
  if self.bind.type or self.bind.type == L_Const.cellIconUnitType.quickTeamUp then
    if self.bind.posIndex and self.bind.posIndex > 0 and self.bind.type == L_Const.cellIconUnitType.quickTeamUp then
      self.bind.activeAdd = true
      self.bind.activeAddMaskChongwu = true
      self:setGray(true)
      self.bind.go_select = false
      if self.isBind then
        if self.bind.posIndex == self.parent.SelPetPosIndex then
          self.modules.module_cellPixelPet:refreshSel(true)
        else
          self.modules.module_cellPixelPet:refreshSel(false)
        end
        self.modules.module_cellPixelPet:setGifPlay(self.bind.go_select)
      end
    else
      self.bind.activeAdd = false
      self.bind.activeAddMaskChongwu = false
      self:setGray(selected)
      self.bind.go_select = selected
      if self.isBind then
        self.modules.module_cellPixelPet:refreshSel(selected)
        self.modules.module_cellPixelPet:setGifPlay(self.bind.go_select)
      end
    end
  else
    self.bind.activeAdd = false
    self.bind.go_select = selected
    self.bind.activeAddMaskChongwu = false
    self:setGray(selected)
    if not self.isBind then
      return
    end
    local cellPixelPet = self.modules.module_cellPixelPet
    cellPixelPet:setGifPlay(self.bind.go_select)
  end
end

function this:setSelectSimple(selected)
  self.bind.go_select = selected
  if not self.isBind then
    return
  end
  local cellPixelPet = self.modules.module_cellPixelPet
  cellPixelPet:setGifPlay(self.bind.go_select)
  cellPixelPet:setSelectRootActive(self.bind.go_select)
end

function this:setOnTeamShow(isOnTeam, teamIndex)
  self.bind.activeAdd = isOnTeam
  self.bind.go_posIndex = isOnTeam
  self.bind.activeAddMaskChongwu = isOnTeam
  self.bind.txt_posIndex = tostring(teamIndex)
  self:setGray(isOnTeam)
end

function this:setGray(ifGray)
  if self.isBind and not self.notSelectGray then
    self.modules.module_cellPixelPet:setGray(ifGray)
  end
end

function this:setIfInTeam()
  if not self.isBind then
    return
  end
  if self.bind.type == L_Const.cellIconUnitType.selectPet then
    local type = L_FormationManager:getRuntimeFormationType()
    if type == nil then
      return
    end
    local index = L_FormationManager:getRuntimeFormationIndex()
    local posData = L_FormationStore:getFormationPosData(type, index)
    self:setGray(false)
    for i, guid in ipairs(posData) do
      local pet_guid = L_FormationStore:getFormationPosPetGuid(type, index, i)
      if self.bind.guid == pet_guid then
        self:setGray(true)
        break
      end
    end
  end
end

function this:setPosIndex(index)
  local needShowFormationData = index ~= nil and 0 < index or false
  self.bind.posIndex = index
  if needShowFormationData then
    self.bind.txt_posIndex = tostring(index)
  end
  self.bind.go_posIndex = needShowFormationData
end

function this:getRaycastGo()
  if not self.isBind then
    return
  end
  return self._cellPixelPet:getRaycastGo()
end

function this:onEvent_refreshPet(pet)
  if pet.guid == self.bind.guid then
    self:refreshView()
  end
end

return this
