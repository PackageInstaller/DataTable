local cell = class("cellHomeCropPetSlotItem", G_UIModuleBase)
local homeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()

function cell.bind()
  return {
    btn_add_active = true,
    module_petPixelIcon = {
      moduleName = "pages/pet/modulePetFrameIcon"
    },
    module_petPixelIcon_active = true
  }
end

function cell.methods()
  return {}
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
  if not (self.isBind and self.isShow) or self._buildGuid == nil then
    return
  end
  self._buildingData = C_HomeUtil.GetBuildData(self._buildGuid)
  if self._buildingData == nil then
    return
  end
  self._autoWorkData = self._buildingData.auto
  self._petData = nil
  if self._slotIndex == 1 then
    self._petData = {
      petGuid = self._autoWorkData.plantPetGuid,
      laborType = L_HomeConst.homeLaborType.PLANT,
      laborId = L_HomeConst.HomeLaborId.GENG_ZUO
    }
  elseif self._slotIndex == 2 then
    self._petData = {
      petGuid = self._autoWorkData.waterPetGuid,
      laborType = L_HomeConst.homeLaborType.WATER,
      laborId = L_HomeConst.HomeLaborId.JIAO_SHUI
    }
  elseif self._slotIndex == 3 then
    self._petData = {
      petGuid = self._autoWorkData.harvestPetGuid,
      laborType = L_HomeConst.homeLaborType.HARVEST,
      laborId = L_HomeConst.HomeLaborId.GENG_ZUO
    }
  end
  if self._petData == nil or self._petData.petGuid == 0 then
    self.bind.btn_add_active = true
    self.bind.module_petPixelIcon_active = false
  else
    self.bind.btn_add_active = false
    self.modules.module_petPixelIcon_active = true
    self.modules.module_petPixelIcon:setGuid(self._petData.petGuid, true)
  end
end

return cell
