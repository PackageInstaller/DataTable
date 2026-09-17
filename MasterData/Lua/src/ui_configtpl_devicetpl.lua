local this = class("deviceTpl")

function this:init()
  self.data = {}
  self:inject()
end

function this:inject()
  self.data.platform = C_AppConfigManager.Platform
  if C_AppConfigManager.IsPcPlatformForUI then
    self.data.equipment = L_Const.equipment.pc
  elseif C_AppConfigManager.IsMobilePlatformForUI then
    self.data.equipment = L_Const.equipment.mobile
  elseif C_AppConfigManager.IsConsolePlatformForUI then
    self.data.equipement = L_Const.equipment.gameConsole
  end
end

function this:getInputControl()
  if C_AppConfigManager.IsPcPlatformForInput then
    return L_Const.inputControl.keyBoard
  elseif C_AppConfigManager.IsMobilePlatformForInput then
    return L_Const.inputControl.touch
  elseif C_AppConfigManager.IsConsolePlatformForInput then
    return L_Const.inputControl.gamepad
  end
end

function this:getTpl()
  return self.data
end

function this:getPlatform(tpl)
  return self.data.platform
end

function this:getEquipment(tpl)
  return self.data.equipment
end

function this:getIsPc()
  if self.data.equipment == nil then
    self:inject()
  end
  return self.data.equipment == L_Const.equipment.pc
end

function this:getIsMobile()
  if self.data.equipment == nil then
    self:inject()
  end
  return self.data.equipment == L_Const.equipment.mobile
end

function this:getSystemResolution()
  local maxWidth, maxHeight = C_ResolutionUtility.GetSystemResolution()
  return maxWidth, maxHeight
end

return this
