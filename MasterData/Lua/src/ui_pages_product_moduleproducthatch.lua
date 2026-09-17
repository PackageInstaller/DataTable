local this = class("moduleProductHatch", G_UIModuleBase)
local columnNum = L_DeviceTpl:getIsPc() and 7 or 6
local minLineNum = 3

function this.bind()
  return {
    grid_petEgg = {
      moduleName = "pages/pet/cellPetEggItem"
    }
  }
end

function this.methods()
  return {}
end

function this:open()
  function self._refreshView()
    if not self._guid then
      return
    end
    self:refreshList()
  end
  
  L_HomeStore:listenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self._refreshView)
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshHomeProduct, self._refreshView)
end

function this:close()
  L_HomeStore:unListenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self._refreshView)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.refreshHomeProduct, self._refreshView)
end

function this:initModule(buildGuid)
  self._guid = buildGuid
  self:refreshList()
end

function this:refreshList()
  local petEggsList = self:getSortPetEggList()
  if #petEggsList == self._lastNum then
    for i, module in ipairs(self.modules.grid_petEgg) do
      module:refreshView(module.guid, self._guid)
    end
    return
  end
  self._lastNum = #petEggsList
  local lineNum = math.max(minLineNum, math.ceil(#petEggsList / columnNum))
  self.bindComponents.produceTargetList.disableScroll = lineNum <= minLineNum
  local dataListCount = lineNum * columnNum
  if #self.modules.grid_petEgg ~= dataListCount then
    self.bind.grid_petEgg:clear()
    self.bind.grid_petEgg:insert_array(L_DataUtil.getEmptyModuleDatas(dataListCount))
  end
  for i, module in ipairs(self.modules.grid_petEgg) do
    module:refreshView(petEggsList[i] and petEggsList[i].guid, self._guid)
  end
  if not L_PetStore:getPetEggItem(self._selectedGuid) then
    self:onSelectEgg(petEggsList[1] and petEggsList[1].guid or 0)
  else
    self:onSelectEgg(self._selectedGuid)
  end
end

function this:onSelectEgg(guid)
  self._selectedGuid = guid
  for i, module in ipairs(self.modules.grid_petEgg) do
    module:setSelect(guid == module.guid)
  end
  self.parent:onSelectId(guid)
end

function this:getSortPetEggList()
  local petEggsDic = L_PetStore:getPetEggList()
  local petEggsList = {}
  for _, v in pairs(petEggsDic) do
    if self:checkPetEggShow(v.guid) then
      table.insert(petEggsList, v)
    end
  end
  table.sort(petEggsList, function(a, b)
    local productGuidA = L_ProductManager:getProductGuidBySpecialGuid(self._guid, a.guid)
    local stateA = L_ProductManager:getProductState(self._guid, productGuidA)
    local productGuidB = L_ProductManager:getProductGuidBySpecialGuid(self._guid, b.guid)
    local stateB = L_ProductManager:getProductState(self._guid, productGuidB)
    local eggHatchTimeA = L_PetStore:getEggIncubationTime(a.configId)
    local eggHatchTimeB = L_PetStore:getEggIncubationTime(b.configId)
    local weightA = stateA * 10000000 - eggHatchTimeA * 100 - L_PetStore:getEggElementId(a.configId)
    local weightB = stateB * 10000000 - eggHatchTimeB * 100 - L_PetStore:getEggElementId(b.configId)
    if weightA == weightB then
      return a.guid < b.guid
    end
    return weightA > weightB
  end)
  return petEggsList
end

function this:checkPetEggShow(eggUid)
  local eggInfo = L_PetStore:getPetEggItem(eggUid)
  if eggInfo and eggInfo.hatch_state == 0 then
    return true
  end
  local serverData = L_HomeStore:getHomeBuildingByGuid(self._guid)
  for _, data in ipairs(serverData.specials or {}) do
    if data.extra_guid == eggUid then
      return true
    end
  end
  return false
end

return this
