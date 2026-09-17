local module = class("cellRaffleUpItem", G_UIModuleBase)

function module.bind()
  return {
    img_icon = nil,
    img_quality = nil,
    txt_name = ""
  }
end

function module.methods()
  return {
    onClick = function(self)
      self:emit("onClick_select", self.bind)
    end
  }
end

return module
