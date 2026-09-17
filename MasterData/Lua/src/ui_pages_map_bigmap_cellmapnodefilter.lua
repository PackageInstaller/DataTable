local this = class("cellMapSiftNode", G_UIModuleBase)

function this.bind()
  return {
    go_default = false,
    go_active = false,
    img_icon_default = nil,
    txt_name_default = "",
    img_icon_active = nil,
    txt_name_active = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.type)
    end
  }
end

function this:refresh()
end

return this
