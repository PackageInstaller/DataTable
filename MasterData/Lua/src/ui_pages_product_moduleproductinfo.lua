local this = class("moduleProductInfo", G_UIModuleBase)
local TabID = {
  Normal = 1,
  Accessory = 2,
  Cook = 3,
  EGG = 4
}

function this.bind()
  return {
    module_petInfoNew = {
      moduleName = "pages/home/homeStation/moduleStationInfo"
    },
    module_productInfoNormal = {
      moduleName = "pages/product/moduleProductInfoNormal"
    },
    active_productInfoNormal = false,
    module_productInfoCook = {
      moduleName = "pages/product/moduleProductInfoCook"
    },
    active_productInfoCook = false,
    module_petHatchEggInfoNew = {
      moduleName = "pages/pet/modulePetHatchEggInfoNew"
    },
    active_petHatchEggInfoNew = false,
    active_isEmpty = false
  }
end

function this.methods()
  return {
    module_petHatchEggInfoNew = {
      onClick_startHatch = function(self, isStartHatch, callback)
        callback()
        self.isStartHatch = isStartHatch
      end
    }
  }
end

function this:open()
end

function this:close()
end

function this:initModule(guid, type)
  self._guid = guid or self._guid
  self._buildType = type or self._buildType
  if not self._guid then
    return
  end
  self.tab_infoType = -1
  local moduleStationInfo = self.modules.module_petInfoNew
  moduleStationInfo:initBuilding(self._guid)
end

function this:refreshId(id, isMultiQuality)
  self.bind.active_isEmpty = id <= 0
  self.bind.active_productInfoNormal = false
  self.bind.active_productInfoCook = false
  self.bind.active_petHatchEggInfoNew = false
  if self._buildType == L_Const.WorldMapBuildType.WMBT_PRO_ORNAMENT then
    self.tab_infoType = -1
    self.bind.active_productInfoNormal = false
  elseif self._buildType == L_Const.WorldMapBuildType.WMBT_HATCH then
    if id == 0 or self.isStartHatch then
      self.bind.tab_infoType = -1
      self.bind.active_petHatchEggInfoNew = false
      self.isStartHatch = false
      return
    end
    self.bind.active_petHatchEggInfoNew = true
    self.tab_infoType = TabID.EGG
    self.modules.module_petHatchEggInfoNew:InitModule(id, self._guid)
  else
    if id == 0 then
      self.tab_infoType = -1
      self.bind.active_productInfoCook = false
      self.bind.active_productInfoNormal = false
      return
    end
    if isMultiQuality then
      local foodGroupId = id
      self.bind.active_productInfoCook = true
      self.tab_infoType = TabID.Cook
      self.modules.module_productInfoCook:setFoodGroup(self._guid, foodGroupId)
    else
      local productId = id
      self.bind.active_productInfoNormal = true
      self.tab_infoType = TabID.Normal
      self.modules.module_productInfoNormal:setProduct(self._guid, productId, self._buildType)
    end
  end
end

return this
