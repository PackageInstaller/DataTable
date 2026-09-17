local module = class("cellTestClickItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {
    txt_name = "",
    txt_f_name = "",
    go_front_img = false
  }
end

function module.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind)
    end
  }
end

return module
