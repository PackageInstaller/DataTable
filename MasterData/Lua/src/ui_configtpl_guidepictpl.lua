local this = class("guidePicTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getIcon(tpl)
  local equipment = L_DeviceTpl:getEquipment()
  local icon = L_Config:getPathByHash(tpl.icon)
  local tempIcon
  if equipment == L_Const.equipment.mobile then
    tempIcon = L_Config:getPathByHash(tpl.phoneIcon)
    if tempIcon ~= nil then
      icon = tempIcon or icon
    end
  elseif equipment == L_Const.equipment.gameConsole then
    tempIcon = L_Config:getPathByHash(tpl.gameConsoleIcon)
    icon = tempIcon ~= nil and tempIcon or icon
  end
  return icon
end

function this:GetVideoPath(tpl)
  local video = L_Config:getPathByHash(tpl.video)
  return video
end

function this:GetDisplayType(tpl)
  return tpl.type
end

function this:getTitle(tpl)
  return L_Config:provider(tpl.title)
end

function this:gamepadRefresSprite(desc, useLine)
  if desc == nil then
    return desc
  end
  
  local function replaceSprite(sprite, name)
    local base, suffix = name:match("^(.*)_([^_]+)$")
    if not base then
      base = name
      suffix = ""
    end
    local newSprite = ""
    local device = C_InputManager.GetCurrentDevice(false)
    if device ~= nil then
      newSprite = L_Const.gamepadDeviceToSprite[device.layout]
    end
    local prefix = ""
    if useLine then
      prefix = "line"
    else
      prefix = "filled"
    end
    local newName = prefix .. "_" .. suffix
    return "<sprite=\"" .. newSprite .. "\" name=\"" .. newName .. "\">"
  end
  
  return string.gsub(desc, "<sprite=\"([^\"]*)\" name=\"([^\"]+)\">", replaceSprite)
end

function this:getDesc(tpl)
  local equipment = L_DeviceTpl:getEquipment()
  local desc = L_Config:provider(tpl.desc)
  local tempDesc
  if equipment == L_Const.equipment.mobile then
    tempDesc = L_Config:provider(tpl.phoneDesc)
    if tempDesc ~= nil then
      desc = tempDesc or desc
    end
  elseif equipment == L_Const.equipment.gameConsole then
    tempDesc = L_Config:provider(tpl.gameDesc)
    tempDesc = self:gamepadRefresSprite(tempDesc, false)
    if tempDesc ~= nil then
      desc = tempDesc or desc
    end
  else
    local inputControl = L_DeviceTpl:getInputControl()
    if inputControl == L_Const.inputControl.gamepad then
      tempDesc = L_Config:provider(tpl.gameDesc)
      tempDesc = self:gamepadRefresSprite(tempDesc, false)
      if tempDesc ~= nil then
        desc = tempDesc or desc
      end
    elseif inputControl == L_Const.inputControl.touch then
      tempDesc = L_Config:provider(tpl.phoneDesc)
      desc = tempDesc ~= nil and tempDesc or desc
    end
  end
  return desc
end

return this
