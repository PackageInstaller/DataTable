local baseBox = require("ui.pages.home.homeCenter.pageHomeCenterPetStationedManage.cellHomeCenterPetStationedManageBox")
local module = class("cellHomeRanchPetStationedManageBox", baseBox)

function module.bind()
  return {
    list_pet = {
      moduleName = "pages/home/homeCenter/pageHomeCenterPetStationedManage/cellPetStationedPxielPet"
    }
  }
end

function module:isStationed(petGuid)
  local blockId = self.bind.blockId
  local ranchData = C_HomeManager:GetHomeStore():GetRanchData(blockId)
  local slot = ranchData:GetSlotByGuid(petGuid)
  return not math.isEmpty(slot)
end

function module:bindCustomParam(cell)
  cell.isDropItem = true
  return cell
end

function module:open()
  module.super.open(self)
  self.onHomeRanchSync = handler(self, self.refreshRanch)
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeRanchSync, self.onHomeRanchSync)
end

function module:close()
  module.super.close(self)
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeRanchSync, self.onHomeRanchSync)
end

function module:refreshRanch()
  self:refresh()
end

return module
