local module = class("cellListItem", G_UIModuleBase)

function module.bind()
  return {
    textW = "",
    textG = "",
    wObj = false,
    gObj = false,
    line = true
  }
end

function module.methods()
  return {
    onClick = function(self)
      L_SettingStore:setSelectLangText(L_Config:provider(self.bind.textW))
      self:emit("onClick", self.bind.textW, self.bind.index)
    end
  }
end

function module:onSetData(data)
  self.bind.textW = data.textW
  self.bind.textG = data.textG
  self.bind.wObj = data.wObj and true or false
  self.bind.gObj = data.gObj and true or false
  self.bind.line = not not data.line
end

return module
