local this = class("moduleHomeCropBoxPet", G_UIModuleBase)
local _homeLaborTpl = L_GameTpl:getHomeLaborCapacityTpl()
local labor2bg = {
  [L_HomeConst.homeLaborType.PLANT] = "UI/Atlas/HomeCrop/tex_farminghut_icon_p_bozhong_temp",
  [L_HomeConst.homeLaborType.WATER] = "UI/Atlas/HomeCrop/tex_farminghut_icon_p_guangai_temp",
  [L_HomeConst.homeLaborType.HARVEST] = "UI/Atlas/HomeCrop/tex_farminghut_icon_p_shouhuo_temp"
}
local labor2emptybg = {
  [L_HomeConst.homeLaborType.PLANT] = "UI/Atlas/HomeCrop/tex_farminghut_icon_p_bozhong_lock_temp",
  [L_HomeConst.homeLaborType.WATER] = "UI/Atlas/HomeCrop/tex_farminghut_icon_p_guangai_lock_temp",
  [L_HomeConst.homeLaborType.HARVEST] = "UI/Atlas/HomeCrop/tex_farminghut_icon_p_shouhuo_lock_temp"
}
local labor2icon = {
  [L_HomeConst.homeLaborType.PLANT] = "UI/Atlas/HomeCrop/tex_farminghut_icon_bozhong",
  [L_HomeConst.homeLaborType.WATER] = "UI/Atlas/HomeCrop/tex_farminghut_icon_guangai",
  [L_HomeConst.homeLaborType.HARVEST] = "UI/Atlas/HomeCrop/tex_farminghut_icon_shouhuo"
}
local labor2desc = {
  [L_HomeConst.homeLaborType.WATER] = "ui_farminghut_watering_des",
  [L_HomeConst.homeLaborType.PLANT] = "ui_farminghut_sow_des",
  [L_HomeConst.homeLaborType.HARVEST] = "ui_farminghut_harvest_des"
}
local labor2frameTexture = {
  [L_HomeConst.homeLaborType.PLANT] = {0, 19},
  [L_HomeConst.homeLaborType.WATER] = {20, 21},
  [L_HomeConst.homeLaborType.HARVEST] = {22, 23}
}

function this.bind()
  return {
    toggle_empty = false,
    module_pixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    list_cropFrameTexture = L_Const.ModuleInfo.FrameTexture,
    saietyCurScore = "",
    saietyMaxScore = ""
  }
end

function this.methods()
  return {
    onclick_addPet = function(self)
      local function func(petGuid, isOutHomeHub, capacityId, replacePetGuidInHomeHub)
        self._autoData:Req_ChoosePet(petGuid, capacityId, handler(self, self.refreshView), isOutHomeHub, replacePetGuidInHomeHub or 0)
      end
      
      L_UI:open("pageStation", {
        capacityId = self._labor,
        selectGuid = self._petGuid,
        buildGuid = self._buildGuid,
        needLaborType = self._laborType,
        petSize = {
          1,
          2,
          3,
          4
        },
        stationType = L_HomeConst.StationType.Crop,
        callback = func,
        stationType = L_HomeConst.StationType.Crop
      })
    end,
    onClickChange = function(self)
      local function func(petGuid, isOutHomeHub, capacityId, replacePetGuidInHomeHub)
        self._autoData:Req_ChoosePet(petGuid, capacityId, handler(self, self.refreshView), isOutHomeHub, replacePetGuidInHomeHub or 0)
      end
      
      L_UI:open("pageStation", {
        capacityId = self._labor,
        selectGuid = self._petGuid,
        buildGuid = self._buildGuid,
        needLaborType = self._laborType,
        petSize = {
          1,
          2,
          3,
          4
        },
        stationType = L_HomeConst.StationType.Crop,
        callback = func,
        stationType = L_HomeConst.StationType.Crop
      })
    end
  }
end

function this:open()
  L_SatietyStore:listenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.refreshView, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshSatiety, self.refreshView, self)
  
  function self._refreshFunc()
    self:refreshView()
  end
  
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildSync, self._refreshFunc)
  self.bind.list_cropFrameTexture:clear()
  local count = self.bindComponents.list_trans.childCount
  local frame_array = {}
  for i = 1, count do
    frame_array[i] = {}
  end
  self.bind.list_cropFrameTexture:insert_array(frame_array)
end

function this:setHomeCropPet(guid, labor, laborType)
  self._buildGuid, self._labor, self._laborType = guid, labor, laborType
  self._buildingData = C_HomeUtil.GetBuildData(self._buildGuid)
  self._autoData = self._buildingData.auto
  self:refreshView()
end

function this:setFrameTexture(frameTexture, index)
  local ft = labor2frameTexture[self._labor][index]
  if type(ft) == "number" then
    frameTexture:setFrameId(ft)
  else
    frameTexture:setImage(ft)
  end
end

function this:refreshView()
  if not self._buildGuid then
    return
  end
  self._petGuid = self._autoData:GetPetGuid(self._labor)
  local petData = L_PetStore:getPetItem(self._petGuid)
  if petData then
    self.bind.toggle_empty = false
    self.modules.module_pixelIcon:setGuid(self._petGuid, true)
    self.modules.module_pixelIcon:setStarColorActive(false)
    local currentSaity = L_SatietyStore:getPetSatiety(self._petGuid)
    local maxSaity = L_SatietyStore:getPetMaxSatiety(self._petGuid)
    self.bind.saietyCurScore = string.format("%s", currentSaity)
    self.bind.saietyMaxScore = string.format("/%s", maxSaity)
    for _, frameTexture in ipairs(self.bind.list_cropFrameTexture:getItemCls()) do
      self:setFrameTexture(frameTexture, 2)
    end
  else
    self.bind.toggle_empty = true
    for _, frameTexture in ipairs(self.bind.list_cropFrameTexture:getItemCls()) do
      self:setFrameTexture(frameTexture, 1)
    end
  end
end

function this:close()
  L_SatietyStore:unListenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.refreshView, self)
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeBuildSync, self._refreshFunc)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshSatiety, self.refreshView, self)
  self._buildingData = nil
  self._autoData = nil
end

return this
