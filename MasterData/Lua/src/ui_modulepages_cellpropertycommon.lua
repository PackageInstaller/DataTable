local this = class("cellPropertyCommon", G_UIModuleBase)

function this.bind()
  return {
    txt_name = "",
    txt_value = "",
    active_bg = false
  }
end

function this.methods()
  return {}
end

function this:refresh()
  if self.bindComponents.go_addArrow then
    self.bindComponents.go_addArrow.gameObject:ActiveTrans(self.bind.go_addArrow)
  end
  if self.bindComponents.go_decreaseArrow then
    self.bindComponents.go_decreaseArrow.gameObject:ActiveTrans(self.bind.go_decreaseArrow)
  end
end

return this
