local this = class("cellPhotoEditSize", G_UIModuleBase)

function this.bind()
  return {
    txt_name = "",
    txt_nameOn = "",
    font_name = 20,
    font_nameOn = 20,
    tabId = 0,
    img = "",
    imgOff = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  self.bindComponents.tabItem.Group = self.bind.tabGroup
  if self.bind.tabId == 1 then
  end
end

function this:refresh()
  self.bind.imgOff = self.bind.img
  self:refreshView()
end

function this:refreshView()
  if L_DeviceTpl:getIsPc() then
    self.bind.font_name = 20
    self.bind.font_nameOff = 20
  else
    self.bind.font_name = 22
    self.bind.font_nameOff = 22
  end
end

function this:close()
end

return this
