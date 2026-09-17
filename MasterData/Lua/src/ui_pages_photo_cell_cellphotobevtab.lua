local this = class("cellPhotoBevTab", G_UIModuleBase)
local bevName = {
  L_WordsTpl:getValue("residual_code_cellphotobevtab_01"),
  L_WordsTpl:getValue("residual_code_cellphotobevtab_02")
}

function this.bind()
  return {
    tabId = -1,
    txt_bevOff = "",
    txt_bevOn = "",
    on_upOnClick = true,
    on_downClick = true
  }
end

function this.methods()
  return {
    onUpOnClick = function(self)
      self:emit("onTabId", self.bind.tabId)
    end,
    onDownOnClick = function(self)
      self:emit("onTabId", self.bind.tabId)
    end
  }
end

function this:open()
  self.bind.tabId = self.bind.id
  self.bind.txt_bevOff = bevName[self.bind.id]
  self.bind.txt_bevOn = bevName[self.bind.id]
  if self.bind.tabId == L_Const.photoBevMode.capture then
    self.bind.on_upOnClick = true
    self.bind.on_downClick = false
  elseif self.bind.tabId == L_Const.photoBevMode.recording then
    self.bind.on_upOnClick = false
    self.bind.on_downClick = true
  end
end

return this
