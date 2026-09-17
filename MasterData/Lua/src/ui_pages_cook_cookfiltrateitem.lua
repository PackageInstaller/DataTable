local this = class("cookFiltrateItem", G_UIModuleBase)

function this.bind()
  return {
    name = "",
    icon = "",
    show_line = true
  }
end

function this.methods()
  return {
    onClick_choice = function(self)
      self:emit("cookFiltrate", self.bind)
    end
  }
end

return this
