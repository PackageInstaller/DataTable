local this = class("cellItemIndex", G_UIModuleBase)

function this.bind()
  return {active_light = false, active_dark = false}
end

function this:refresh()
  local cellId = self.bind.cellId
  self.bind.active_light = self.bind.selected
  self.bind.active_dark = not self.bind.selected
end

return this
