local this = class("cellKeyIcon", G_UIModuleBase)

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
  self.bind.iconActive = self.bind.isIcon
  if self.bind.isIcon then
    self.bind.icon = string.format("Atlas/Guide/tex_guide_fight_icon_sb%s.png", self.bind.iconIndex)
  end
  if not self.bind.keyText then
    self.bind.keyText = ""
  end
  self.bind.keyLongText = self.bind.keyText
  local isLong = string.len(self.bind.keyText) > 1
  self.bind.keyTextActive = not isLong and not self.bind.isIcon
  self.bind.keyLongTextActive = isLong and not self.bind.isIcon
end

return this
