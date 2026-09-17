local this = class("guideWordsTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTalkIcon(tpl)
  local talkIcon = L_Config:getPathByHash(tpl.talkIcon)
  return talkIcon
end

function this:getWords(key)
  local tpl = self.data[key]
  if tpl == nil then
    return tostring(key)
  end
  local equipment = L_DeviceTpl:getEquipment()
  if equipment == L_Const.equipment.mobile then
    return L_Config:provider(tpl.mWords) or tostring(key)
  elseif equipment == L_Const.equipment.gameConsole then
    return L_Config:provider(tpl.cWords) or tostring(key)
  else
    local inputControl = L_DeviceTpl:getInputControl()
    if inputControl == L_Const.inputControl.gamepad then
      return L_Config:provider(tpl.cWords) or tostring(key)
    elseif inputControl == L_Const.inputControl.touch then
      return L_Config:provider(tpl.mWords) or tostring(key)
    else
      return L_Config:provider(tpl.words) or tostring(key)
    end
  end
end

return this
