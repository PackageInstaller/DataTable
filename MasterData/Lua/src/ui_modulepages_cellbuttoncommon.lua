local this = class("cellButtonCommon", G_UIModuleBase)

function this.bind()
  return {txt_name = ""}
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind)
    end
  }
end

function this:refresh()
  if self.bindComponents.go_active then
    self.bindComponents.go_active.gameObject:ActiveTrans(self.bind.go_active)
  end
end

return this
