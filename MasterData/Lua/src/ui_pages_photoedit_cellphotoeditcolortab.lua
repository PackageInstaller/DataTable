local this = class("cellPhotoEditColorTab", G_UIModuleBase)

function this.bind()
  return {
    color = C_Color.white,
    enText = "COLOR",
    tabId = 0
  }
end

function this.methods()
  return {}
end

function this:open()
  self.bindComponents.tabItem.Group = self.bind.tabGroup
end

function this:refresh()
end

function this:close()
end

return this
