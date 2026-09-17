local this = class("cellHeroLevelUpAttStrength", G_UIModuleBase)

function this.bind()
  return {
    txt_attName = "",
    txt_attValue = "",
    txt_attValue_strength = "",
    icon = "",
    go_bg_normal = false
  }
end

function this:refresh()
  if not math.isEmpty(self.bind.index) then
    self.bind.go_bg_normal = self.bind.index % 2 == 1
  end
end

return this
