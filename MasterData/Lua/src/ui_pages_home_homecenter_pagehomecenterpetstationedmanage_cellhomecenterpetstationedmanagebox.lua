local module = class("cellHomeCenterPetStationedManageBox", require("ui.pages.pet.cellPetBox"))

function module.bind()
  return {
    list_pet = {
      moduleName = "pages/home/homeCenter/pageHomeCenterPetStationedManage/cellPetStationedPxielPet"
    }
  }
end

function module:refresh()
  if not self.bindComponents then
    return
  end
  if L_CommonUtil.isValid(self.bindComponents.boxList) then
  end
  if self.stopRefreshInfo then
    return
  end
  self:refreshInfo()
end

function module:refreshSinglePet(pet)
  local petGuid = pet.guid
  if self.petGuidDic and self.petGuidDic[petGuid] == true then
    if self.parent.getCurIndex and L_CommonUtil.isValid(self.bindComponents.boxList) then
      if self.bind.index == self.parent:getCurIndex() then
        self.bindComponents.boxList:setIsFrame(false)
      else
        self.bindComponents.boxList:setIsFrame(true)
      end
    end
    self:refreshInfo()
  end
end

function module:refreshSinglePetGuid(guid)
  for i, v in ipairs(self.bind.list_pet) do
    if v and v.guid == guid then
      local cell = self.bind.list_pet:getItemCls(i)
      local pet = L_PetStore:getPetItem(guid)
      cell.txtWorkStatusStr, cell.workStatusIconStr = self:getWorkStatusIcon(pet)
      cell.inInHomeHub = self:isStationed(guid, self.bind.filterType)
      local o = v
      o.txtWorkStatusStr = cell.txtWorkStatusStr
      o.workStatusIconStr = cell.workStatusIconStr
      o.inInHomeHub = cell.inInHomeHub
      self.bind.list_pet:change(i, o)
    end
  end
end

function module:refreshSinglePetStationed(guid, stationed, nothingChanged)
  if not self.stationPetGuidDict then
    self.stationPetGuidDict = {}
    self.stationPetGuidRefreshDict = {}
    self.stationPetGuidDictValue = {}
  end
  self.stationPetGuidDict[guid] = true
  self.stationPetGuidDictValue[guid] = stationed
  local refreshed = false
  for i, v in ipairs(self.bind.list_pet) do
    local cell = self.bind.list_pet:getItemCls(i)
    if v and v.guid == guid then
      refreshed = cell.isBind
      if cell then
        cell.bind.inInHomeHub = stationed
        if L_DeviceTpl:getIsMobile() then
          cell.bind.pointEnter = stationed and true or false
        end
        if not stationed then
          self.bind.petClicked = nil
          if not nothingChanged then
            cell.bind.txtWorkStatusStr = ""
            cell.bind.workStatusGroup = false
          end
        end
        local o = v
        o.txtWorkStatusStr = cell.bind.txtWorkStatusStr
        o.workStatusIconStr = cell.bind.workStatusIconStr
        o.inInHomeHub = cell.bind.inInHomeHub
        self.bind.list_pet:change(i, o)
        if cell.isBind and stationed then
          cell.bind.txtWorkStatusStr = ""
          cell.bind.workStatusGroup = false
          cell:SetTagActive(L_PetConst.TagEnum.Team, false)
        end
      end
    elseif L_DeviceTpl:getIsMobile() and cell and cell.bind.pointEnter then
      cell.bind.pointEnter = false
      local o = v
      o.pointEnter = false
      self.bind.list_pet:change(i, o)
    end
  end
  if not refreshed then
    self.stationPetGuidDict[guid] = nil
  end
end

function module:refreshBoxList(guid)
end

function module:refreshFilterList(filteredPets, filterType, boxIndex)
  if self.boxIndex ~= boxIndex then
    self.boxIndex = boxIndex
    self.stationPetGuidDict = {}
    self.stationPetGuidRefreshDict = {}
    self.stationPetGuidDictValue = {}
  end
  if self.stationPetGuidDict then
    local done = true
    for k, v in pairs(self.stationPetGuidDict) do
      self:refreshSinglePetGuid(k)
      if not self.stationPetGuidRefreshDict[k] then
        self.stationPetGuidRefreshDict[k] = true
        done = false
        return
      end
    end
    if done then
      self.stationPetGuidDict = {}
      self.stationPetGuidRefreshDict = {}
    end
  end
  if not self.isBind then
    return
  end
  
  local function onPointEnter_pet(cell)
    if L_UI:checkPageShown("pageNetworkWaiting", false) then
      return
    end
    cell.bind.pointEnter = true
    if self.bind.OnPointEnter then
      self.bind.OnPointEnter(cell.bind.guid)
    end
    cell:refresh()
  end
  
  local function onPointExit_pet(cell)
    cell.bind.pointEnter = nil
    if self.bind.OnPointExit then
      self.bind.OnPointExit(cell.bind.guid)
    end
    cell:refresh()
  end
  
  local function onClick_pet(cell)
    if self.bind.OnClickPetInPetBox then
      self.bind.OnClickPetInPetBox(cell.bind.guid)
    end
    self:emit("onClick_pet", cell.bind.guid)
  end
  
  local function onClick_remove_pet(cell)
    self.bind.petClicked = true
    if self.bind.OnRemoveClickPetInPetBox then
      self.bind.OnRemoveClickPetInPetBox(cell.bind.guid)
    end
    self:emit("onClick_remove_pet", cell.bind.guid)
  end
  
  if filteredPets then
    if not self.bind.filteredPets or #self.bind.filteredPets < #filteredPets then
    end
    self.bind.filteredPets = filteredPets
  end
  if filterType then
    self.bind.filterType = filterType
  end
  if not self.bind.filteredPets then
    return
  end
  local countList = self.bind.filteredPets
  local data = {}
  self.petGuidDic = self.petGuidDic or {}
  if not table.isEmpty(countList) then
    for k, v in ipairs(countList) do
      local pet = L_PetStore:getPetItem(v)
      if not table.isEmpty(pet) then
        local petGuid = pet.guid
        self.petGuidDic[petGuid] = true
        table.insert(data, pet)
      else
        table.insert(data, {})
      end
    end
  end
  local lst = {}
  for i = 1, #data do
    local cell = {}
    if not table.isEmpty(data[i]) then
      cell.index = i
      cell.pointEnterCallback = onPointEnter_pet
      cell.pointExitCallback = onPointExit_pet
      cell.txtWorkStatusStr, cell.workStatusIconStr = self:getWorkStatusIcon(data[i])
      cell.filterType = self.bind.filterType
      cell.guid = data[i].guid
      cell.itemType = L_Const.resType.pet
      cell.reddotName = string.format(L_ReddotManager.DotDef.PetNew, countList[i])
      cell.reddotGeneName = string.format(L_ReddotManager.DotDef.PetGeneMutation, countList[i])
      cell.callback = onClick_pet
      cell.inInHomeHub = self:isStationed(data[i].guid, self.bind.filterType)
      cell.pointEnter = false
      cell.pageType = L_PetConst.PageType.Home
      cell.removeCallback = onClick_remove_pet
      self:bindCustomParam(cell)
    else
      cell.guid = 0
      cell.inInHomeHub = false
      cell.workStatusIconStr = ""
      cell.txtWorkStatusStr = ""
      cell.removeCallback = nil
    end
    table.insert(lst, cell)
  end
  if self.bind.list_pet:getLength() == #lst then
    self.bind.list_pet:freshAll(lst)
  else
    self.bind.list_pet:clear()
    self.bind.list_pet:insert_array(lst)
  end
end

function module:getGameObjectByGuid(petGuid)
  for i = 1, self.bind.list_pet:getLength() do
    local item = self.bind.list_pet[i]
    if item.guid == petGuid then
      local cls = self.bind.list_pet:getItemCls(i)
      if cls and cls.gameObject then
        return cls.gameObject, i
      end
      if cls then
        return "", i
      end
    end
  end
end

function module:findPetIndexInProductPets(targetGuid)
  local ranchData = C_HomeManager:GetHomeStore():GetRanchData(201)
  if ranchData and ranchData.harvestPetGuid == targetGuid then
    return targetGuid
  end
  return nil
end

function module:getWorkStatusIcon(petItem)
  if petItem.work_status == L_Const.PetStationedWorkStatusType.PSWST_RANCH_WORK then
    if self.bind.filterType ~= L_PetConst.filterPetBox.none then
      if self:findPetIndexInProductPets(petItem.guid) then
        return ""
      end
      return L_WordsTpl:getValue("ui_homecenter_pethome_state_1"), "UI/Page/PetBox/tex_pet_frame_homeranch.png"
    elseif self:findPetIndexInProductPets(petItem.guid) then
      return L_WordsTpl:getValue("ui_homecenter_pethome_state_2"), "UI/Page/PetBox/tex_pet_frame_homework.png"
    end
    return ""
  elseif petItem.work_status ~= L_Const.PetStationedWorkStatusType.PSWST_NONE then
    if self.bind.filterType ~= L_PetConst.filterPetBox.none then
      return "", ""
    end
    return L_WordsTpl:getValue("ui_homecenter_pethome_state_2"), "UI/Page/PetBox/tex_pet_frame_homework.png"
  elseif petItem.hero_id > 0 and L_FormationStore:getPetPlaceInTeam(L_FormationManager:getCurFormationType(), nil, petItem.guid) ~= 0 then
    return L_WordsTpl:getValue("ui_homecenter_pethome_state_5"), "UI/Page/PetBox/tex_pet_frame_zhandou.png"
  elseif 0 < petItem.roulette_pos then
    return L_WordsTpl:getValue("ui_homecenter_pethome_state_3"), "UI/Page/PetBox/tex_pet_frame_zuoji.png"
  else
    local index = L_QuickRouletteStore:checkInRoulette(L_Const.quickRouletteType.petPuzzle, petItem.guid)
    if 0 <= index then
      return L_WordsTpl:getValue("ui_homecenter_pethome_state_4"), "UI/Page/PetBox/tex_pet_frame_jiemi.png"
    end
    return ""
  end
end

function module:refreshInfo()
  if self.stopRefreshInfo then
    return
  end
  if not self.isBind then
    return
  end
  
  local function onClick_pet(cell)
    self:emit("onClick_pet", cell.bind.guid)
  end
  
  local function onClick_remove_pet(cell)
    self:emit("onClick_remove_pet", cell.bind.guid)
  end
  
  local boxIndex = self.bind.boxIndex
  local countList = L_PetStore:getPetBoxList(boxIndex)
  local data = {}
  self.petGuidDic = self.petGuidDic or {}
  if not table.isEmpty(countList) then
    for _, v in ipairs(countList) do
      local pet = L_PetStore:getPetItem(v)
      if not table.isEmpty(pet) then
        local petGuid = pet.guid
        self.petGuidDic[petGuid] = true
        table.insert(data, pet)
      else
        table.insert(data, {})
      end
    end
  end
  local lst = {}
  for i = 1, #data do
    local cell = {}
    if not table.isEmpty(data[i]) then
      cell.filterType = self.parent:getFilterType()
      cell.guid = countList[i]
      cell.itemType = L_Const.resType.pet
      cell.reddotName = string.format(L_ReddotManager.DotDef.PetNew, countList[i])
      cell.reddotGeneName = string.format(L_ReddotManager.DotDef.PetGeneMutation, countList[i])
      cell.callback = onClick_pet
      if not self.stopRefreshInfo then
        cell.inInHomeHub = self:isStationed(data[i].guid)
      else
        cell.inInHomeHub = false
      end
      cell.removeCallback = onClick_remove_pet
      self:bindCustomParam(cell)
    else
      cell.guid = 0
    end
    table.insert(lst, cell)
  end
  if self.bind.list_pet:getLength() == #lst then
    self.bind.list_pet:freshAll(lst)
  else
    self.bind.list_pet:clear()
    self.bind.list_pet:insert_array(lst)
  end
end

function module:bindCustomParam(cell)
  return cell
end

function module:isStationed(petGuid, filterType)
  if self.stationPetGuidDict and self.stationPetGuidDict[petGuid] then
    return self.stationPetGuidDictValue[petGuid]
  end
  if filterType == L_PetConst.filterPetBox.none then
    local _homeBlockTpl = L_GameTpl:getHomeBlockTpl()
    local defaultBlockId = _homeBlockTpl:getId(_homeBlockTpl:getBlockTypeList(L_HomeConst.blockType.RANCH)[1])
    local ranchData = C_HomeManager:GetHomeStore():GetRanchData(defaultBlockId)
    local slot = ranchData:GetSlotByGuid(petGuid)
    return not math.isEmpty(slot)
  else
    local csPetData = L_PetStore:getCsPetData(petGuid)
    return csPetData:GetIsInHomeHub()
  end
end

function module:closeCell()
  self.bind.list_pet:clear()
end

return module
