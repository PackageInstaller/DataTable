local this = class("cellReplaceAccessory", G_UIModuleBase)

function this.bind()
  return {txt_name = ""}
end

function this.methods()
  return {}
end

function this:open()
  this.super.open(self)
  self:refreshView()
end

function this:refreshView()
end

return this
