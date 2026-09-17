local this = class("modulePetContent", G_UIModuleBase)

function this.bind()
  return {img_petIcon = ""}
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:refreshView(data)
  self.bind.img_petIcon = data.icon
end

return this
