local this = class("cellPetBoxSelectItem", G_UIModuleBase)

function this.bind()
  return {
    name = "",
    icon = "",
    show_line = true,
    isFull = false
  }
end

function this.methods()
  return {
    onClick_choose = function(self)
      self:emit("onClick_choose", self.bind)
    end
  }
end

return this
