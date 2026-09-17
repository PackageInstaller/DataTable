local module = class("cellTestToggleItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {txt_name = ""}
end

function module.methods()
  return {
    onToggle = function(self, value)
      self:emit("onToggle", self.bind, value)
    end
  }
end

return module
