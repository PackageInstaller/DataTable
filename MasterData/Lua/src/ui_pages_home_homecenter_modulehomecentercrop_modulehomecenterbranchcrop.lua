local module = class("moduleHomeCenterBranchCrop", G_UIModuleBase)
local tag = "module:moduleHomeCenterBranchCrop"

function module:preBind()
  return {}
end

function module:bind()
  return {
    module_homeCenterCropPet_plant = {
      moduleName = "pages/home/homeCenter/moduleHomeCenterCrop/cellHomeCenterBranchCropPet"
    },
    module_homeCenterCropPet_water = {
      moduleName = "pages/home/homeCenter/moduleHomeCenterCrop/cellHomeCenterBranchCropPet"
    },
    module_homeCenterCropPet_harvest = {
      moduleName = "pages/home/homeCenter/moduleHomeCenterCrop/cellHomeCenterBranchCropPet"
    },
    grl_seedBag = {
      moduleName = "pages/home/homeCrop/cellIconHomeCropPetSeed"
    }
  }
end

function module:methods()
  return {
    onClick_close = function(self)
      self:onEventBtnClose()
    end,
    onClick_mask = function(self)
      self:onEventBtnClose()
    end,
    onClick_addSeed = function(self)
      self:onEventBtnAddSeed()
    end
  }
end

function module:onSetData(param)
  self._buildGuid = param.buildGuid
  self:onRefreshAll()
end

function module:show()
  self:onRefreshAll()
end

function module:onRefreshAll()
  self:onRefreshPanel()
  self:onRefreshSeedList()
end

function module:onRefreshPanel()
  if not self.isBind or self._buildGuid == nil then
    return
  end
  local plantParam = {
    slotIndex = 1,
    buildGuid = self._buildGuid
  }
  self.modules.module_homeCenterCropPet_plant:onSetData(plantParam)
  local wartParam = {
    slotIndex = 2,
    buildGuid = self._buildGuid
  }
  self.modules.module_homeCenterCropPet_water:onSetData(wartParam)
  local harvestParam = {
    slotIndex = 3,
    buildGuid = self._buildGuid
  }
  self.modules.module_homeCenterCropPet_harvest:onSetData(harvestParam)
end

function module:onRefreshSeedList()
  if not self.isBind or self._buildGuid == nil then
    return
  end
  self._buildingData = C_HomeUtil.GetBuildData(self._buildGuid)
  self._seedData = self._buildingData.auto.seeds
  local seedCount = self._seedData.Count
  local itemList = {}
  for i = 0, seedCount - 1 do
    local seedItem = self._seedData[i]
    local item = {
      item_id = seedItem.itemId,
      guid = seedItem.guid,
      num = seedItem.itemNum
    }
    table.insert(itemList, item)
  end
  local boxNum = math.max(math.ceil(#itemList / 3) * 3, 9)
  self.bind.grl_seedBag:clear()
  self.bind.grl_seedBag:insert_array(L_DataUtil.getEmptyModuleDatas(boxNum))
  for i, value in ipairs(self.modules.grl_seedBag) do
    value:refreshByItem(itemList[i])
  end
end

function module:onEventBtnClose()
  self.parent:onCloseBranchView()
end

function module:onEventBtnAddSeed()
  if self._buildGuid == nil then
    return
  end
  L_UI:open("pageHomeCropBox", {
    buildingGuid = self._buildGuid
  })
end

return module
