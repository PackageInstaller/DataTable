local this = class("cellPhotoMenuTab", G_UIModuleBase)
local menuTabName = {
  [1] = "ui_modulePhotoMenu_02",
  [2] = "ui_modulePhotoMenu_03",
  [3] = "residual_code_cellphotomenutab_01",
  [4] = "residual_code_cellphotomenutab_02"
}

function this.bind()
  return {
    txt_nameOff = "",
    txt_nameOn = "",
    tabId = -1
  }
end

function this.methods()
  return {
    onClick_tab = function(self)
      self:emit("onTabId", self.bind.tabId)
    end
  }
end

function this:open()
  if self.bind.tabGroup ~= nil then
    self.bindComponents.tabItem.Group = self.bind.tabGroup
  end
  self.bind.tabId = self.bind.id
  self.bind.txt_nameOff = L_WordsTpl:getValue(menuTabName[self.bind.id])
  self.bind.txt_nameOn = L_WordsTpl:getValue(menuTabName[self.bind.id])
end

return this
