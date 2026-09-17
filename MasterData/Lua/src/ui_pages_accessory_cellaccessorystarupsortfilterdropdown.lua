local this = class("cellAccessoryStarUpSortFilterDropdown", G_UIModuleBase)

function this.bind()
  return {
    txt_onName = nil,
    txt_offName = nil,
    go_onActive = false,
    go_offActive = false
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
  self.bind.go_onActive = active
  self.bind.go_offActive = not active
end

return this
