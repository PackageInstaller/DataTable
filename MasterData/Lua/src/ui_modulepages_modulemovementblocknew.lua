local this = class("moduleMovementBlockNew", G_UIModuleBase)
local EEquipmentStatus = {
  None = 0,
  PC = 1,
  Mobile = 2
}

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:toBind(uiBinding)
  this.super.toBind(self, uiBinding)
  self:registerModule()
end

function this:registerModule()
  if not self.subModuleMgr then
    self.subModuleMgr = require("ui.manager.ui.uiSubModuleManager").new(self)
  end
  self.subModuleMgr:init()
  self.subModuleMgr:initSubModules(self, EEquipmentStatus.None)
  self.subModuleMgr:addSubModules(EEquipmentStatus.PC, "moduleMovementBlockPc", self.bindComponents.transParent)
  self.subModuleMgr:addSubModules(EEquipmentStatus.Mobile, "moduleMovementBlockMobile", self.bindComponents.transParent)
end

function this:open()
  L_SettingStore:listenCallFunc(L_SettingStore.event.refreshEquipment, self.onEvent_refreshEquipment, self)
  self:onEvent_refreshEquipment()
end

function this:show()
  if not self.subModuleMgr then
    return
  end
  self.subModuleMgr:show()
end

function this:onEvent_refreshEquipment()
  if not self.subModuleMgr then
    return
  end
  local isPc = L_DeviceTpl:getIsPc()
  self.subModuleMgr:openSubModulesByIndex(isPc and EEquipmentStatus.PC or EEquipmentStatus.Mobile)
end

function this:hide()
  self.subModuleMgr:hide()
end

function this:close()
  L_SettingStore:unListenCallFunc(L_SettingStore.event.refreshEquipment, self.onEvent_refreshEquipment, self)
  self.subModuleMgr:closeAllSubModules()
end

function this:unBind()
  this.super.unBind(self)
  self.subModuleMgr:destroyAllSubModules()
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
