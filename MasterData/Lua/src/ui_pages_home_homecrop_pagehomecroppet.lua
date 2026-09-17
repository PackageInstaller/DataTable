local this = class("pageHomeCropPet", G_UIPageBase)
local _blockTpl = L_GameTpl:getHomeBlockTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local RewardTab = {
  CAN_REWARD = 1,
  EMPTY = 2,
  LOCK = 3
}

function this.bind()
  return {
    module_stationBuildingTop = {
      moduleName = "pages/home/homeStation/moduleStationBuildingTop"
    },
    module_buildFrameTexture = L_Const.ModuleInfo.FrameTexture,
    module_plantPet = {
      moduleName = "pages/home/homeCrop/moduleHomeCropBoxPet"
    },
    module_waterPet = {
      moduleName = "pages/home/homeCrop/moduleHomeCropBoxPet"
    },
    module_harvestPet = {
      moduleName = "pages/home/homeCrop/moduleHomeCropBoxPet"
    },
    module_reward = {
      moduleName = "pages/home/homeCrop/moduleHomeRewardPanel"
    },
    module_homeProperty = {
      moduleName = "pages/home/homeProperty/moduleHomeProperty"
    }
  }
end

function this.methods()
  return {
    onClick_close = function()
      L_UI:close("pageHomeCropPet")
    end,
    onClick_bg = function()
    end,
    onClick_addSeed = function(self)
      L_UI:open("pageHomeCropBox", {
        buildingGuid = self._guid
      })
    end
  }
end

function this:preOpen(params)
  self._guid = params.buildingGuid
  self._buildingData = C_HomeUtil.GetBuildData(self._guid)
  self.modules.module_stationBuildingTop:initModule({
    stationBuildingType = L_HomeConst.StationType.Crop,
    buildingGuid = self._guid
  })
  local buildTpl = _homeBuildingTpl:getTplById(self._buildingData.buildId)
  self.modules.module_buildFrameTexture:setFrameId(_homeBuildingTpl:getFrameTexture(buildTpl))
  self.modules.module_plantPet:setHomeCropPet(self._guid, L_HomeConst.homeLaborType.PLANT, L_HomeConst.HomeLaborId.GENG_ZUO)
  self.modules.module_waterPet:setHomeCropPet(self._guid, L_HomeConst.homeLaborType.WATER, L_HomeConst.HomeLaborId.JIAO_SHUI)
  self.modules.module_harvestPet:setHomeCropPet(self._guid, L_HomeConst.homeLaborType.HARVEST, L_HomeConst.HomeLaborId.GENG_ZUO)
  self.modules.module_reward:initCropData(self._guid)
  self:refreshAll()
  
  function self._refreshFunc()
    self:refreshAll()
  end
  
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildSync, self._refreshFunc)
end

function this:getHomeCropPetInfo(homeLaborType, homeLaborId)
  local buildGuid = self._guid
  local labor = homeLaborType
  local laborType = homeLaborId
  return buildGuid, labor, laborType
end

function this:close()
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeBuildSync, self._refreshFunc)
end

function this:refreshAll()
  self.modules.module_homeProperty:setCropBuild(self._guid)
end

return this
