local this = class("cellKeyCombinedIcon", G_UIModuleBase)
local guideIconTpl = L_GameTpl:getGuideIconTpl()

function this.bind()
  return {
    keyText = "",
    keyTextActive = true,
    keyLongText = "",
    keyLongTextActive = false,
    iconActive = false,
    icon = ""
  }
end

function this.methods()
  return {}
end

function this:refresh()
  if not self.bind.keyText then
    self.bind.keyText = ""
  end
  local isIcon = false
  local tpl = guideIconTpl:getTplById(self.bind.keyText)
  local keyShow = self.bind.keyText
  if tpl ~= nil then
    local icon = guideIconTpl:getIcon(tpl)
    if self.bind.isLongPress then
      icon = guideIconTpl:getHoldIcon(tpl)
    end
    isIcon = not string.isEmpty(icon)
    if isIcon then
      self.bind.icon = icon
    elseif not string.isEmpty(guideIconTpl:getDisName(tpl)) then
      keyShow = guideIconTpl:getDisName(tpl)
    end
  end
  self.bind.iconActive = isIcon
  self.bind.keyText = keyShow
  self.bind.keyLongText = self.bind.keyText
  local isLong = string.len(self.bind.keyText) > 1
  self.bind.keyTextActive = not isLong and not isIcon
  self.bind.keyLongTextActive = isLong and not isIcon
end

return this
