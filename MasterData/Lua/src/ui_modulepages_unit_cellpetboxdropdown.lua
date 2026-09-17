local this = class("cellPetBoxDropdown", G_UIModuleBase)

function this.bind()
  return {
    txt_name = nil,
    txt_nameh = nil,
    go_select = nil,
    go_lock = nil,
    txt_name_h = nil,
    txt_name_w = nil
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_select", self.bind.id)
    end
  }
end

function this:setActive(active)
  self.bind.go_active = active
  self.bind.go_name = active
  self.bind.go_name_h = not active
end

return this
