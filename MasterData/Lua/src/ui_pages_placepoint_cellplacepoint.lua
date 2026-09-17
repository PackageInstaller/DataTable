local module = class("cellPlacePoint", G_UIModuleBase)

function module.bind()
  return {
    txt_name = "",
    img_icon = "",
    go_choice = false
  }
end

function module.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind)
    end
  }
end

function module:refresh()
end

return module
