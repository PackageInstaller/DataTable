local this = class("cellPlayerDisplayTab", G_UIModuleBase)

function this.bind()
  return {
    txtNameOn = "",
    txtNameOff = "",
    activeRed = nil,
    tabId = 0
  }
end

function this:open()
  AzurWorld.RedDotMgr:BindRedDotRenderer("playerDisplay_tab_" .. tostring(self.bind.tabId), self.bindComponents.reddot.gameObject)
end

return this
