local this = class("cellTeamPresetTip", G_UIModuleBase)

function this.bind()
  return {normal = true, active = false}
end

function this:refresh()
end

function this.methods()
  return {}
end

function this:setActive(active)
  self.bind.normal = not active
  self.bind.active = active
end

return this
