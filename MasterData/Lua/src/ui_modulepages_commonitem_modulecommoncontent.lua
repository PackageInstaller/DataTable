local this = class("moduleCommonContent", G_UIModuleBase)

function this.bind()
  return {img_Icon = "", img_iconFilter = ""}
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:refreshView(data)
  self.bind.img_Icon = data.icon
  self.bind.img_iconFilter = data.filterIcon and data.filterIcon or ""
end

return this
