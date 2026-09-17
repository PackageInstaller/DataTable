local cell = class("cellHomeCropItem", G_UIModuleBase)

function cell.bind()
  return {
    active_hadPet = true,
    active_noPet = true,
    module_petPixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    module_petPixelIcon_active = true
  }
end

function cell.methods()
  return {
    onClick_add = function(self)
      self:onEventBtnAdd()
    end,
    onClick_switch = function(self)
      self:onEventBtnSwitch()
    end
  }
end

function cell:onSetData(param)
  self._buildGuid = param.buildGuid
  self._slotIndex = param.slotIndex
  self:onRefreshCell()
end

function cell:open()
end

function cell:close()
end

function cell:show()
  self:onRefreshCell()
end

function cell:hide()
end

function cell:refresh()
end

function cell:onRefreshCell()
  if not self.isBind or self._buildGuid == nil then
    return
  end
  self._buildingData = C_HomeUtil.GetBuildData(self._buildGuid)
  if self._buildingData == nil then
    return
  end
  self._autoWorkData = self._buildingData.auto
  self._petData = nil
  if self._slotIndex == 1 then
    self.bind.pos2_self = C_Vector2(90, 0)
    self._petData = {
      petGuid = self._autoWorkData.plantPetGuid,
      laborType = L_HomeConst.homeLaborType.PLANT,
      laborId = L_HomeConst.HomeLaborId.GENG_ZUO
    }
  elseif self._slotIndex == 2 then
    self.bind.pos2_self = C_Vector2(-50, 50)
    self._petData = {
      petGuid = self._autoWorkData.waterPetGuid,
      laborType = L_HomeConst.homeLaborType.WATER,
      laborId = L_HomeConst.HomeLaborId.JIAO_SHUI
    }
  elseif self._slotIndex == 3 then
    self.bind.pos2_self = C_Vector2(-200, 0)
    self._petData = {
      petGuid = self._autoWorkData.harvestPetGuid,
      laborType = L_HomeConst.homeLaborType.HARVEST,
      laborId = L_HomeConst.HomeLaborId.GENG_ZUO
    }
  end
  if self._petData == nil or self._petData.petGuid == 0 then
    self.bind.active_noPet = true
    self.bind.active_hadPet = false
    self.bind.module_petPixelIcon_active = false
  else
    self.bind.active_noPet = false
    self.bind.active_hadPet = true
    self.bind.module_petPixelIcon_active = true
    self.modules.module_petPixelIcon:setGuid(self._petData.petGuid, true)
  end
end

function cell:onEventBtnAdd()
  if self._petData == nil or self._autoWorkData == nil then
    return
  end
  L_UI:open("pageStation", {
    capacityId = self._petData.laborType,
    selectGuid = self._petData.petGuid,
    needLaborType = self._petData.laborId,
    petSize = {
      1,
      2,
      3,
      4
    },
    callback = function(petGuid, isOutHomeHub, capacityId, replacePetGuidInHomeHub)
      self._autoWorkData:Req_ChoosePet(petGuid, self._petData.laborType, handler(self, self.onRefreshCell), replacePetGuidInHomeHub or 0)
    end
  })
end

function cell:onEventBtnSwitch()
  if self._petData == nil or self._autoWorkData == nil then
    return
  end
  L_UI:open("pageStation", {
    capacityId = self._petData.laborType,
    selectGuid = self._petData.petGuid,
    needLaborType = self._petData.laborId,
    petSize = {
      1,
      2,
      3,
      4
    },
    callback = function(petGuid, isOutHomeHub, capacityId, replacePetGuidInHomeHub)
      self._autoWorkData:Req_ChoosePet(petGuid, self._petData.laborType, handler(self, self.onRefreshCell), replacePetGuidInHomeHub or 0)
    end
  })
end

function cell:close()
  self._buildGuid = nil
  self._slotIndex = nil
end

return cell
