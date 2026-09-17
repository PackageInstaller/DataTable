local this = class("cellSortFilterDropdown", G_UIModuleBase)

function this.bind()
  return {
    txt_name = nil,
    txt_name_h = nil,
    go_active = false,
    go_name_h = true,
    go_name = true,
    go_line = true
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_select", self.bind)
    end
  }
end

function this:setActive(active)
  self.bind.go_active = active
  self.bind.go_name = active
  self.bind.go_name_h = not active
end

return this
