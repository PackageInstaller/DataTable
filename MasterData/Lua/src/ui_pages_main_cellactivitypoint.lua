local this = class("cellActivityPoint", G_UIModuleBase)

function this.bind()
  return {go_normal = true, go_active = false}
end

function this.methods()
  return {}
end

function this:refresh()
  if self.bindComponents.cellActivityPoint then
    local sizeDelta = self.bindComponents.cellActivityPoint.sizeDelta
    sizeDelta.x = self.bind.go_active and 23 or 10
    self.bindComponents.cellActivityPoint.sizeDelta = sizeDelta
  end
end

function this:setBool(active)
  self.bindComponents.animation:SetBool("On", active)
end

function this:setOn(isOn)
  self.bind.go_normal = not isOn
  self.bind.go_active = isOn
  self:setBool(isOn)
  self:refresh()
end

return this
