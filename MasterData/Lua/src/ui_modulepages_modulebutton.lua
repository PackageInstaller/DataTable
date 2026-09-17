local module = class("moduleButton", G_UIModuleBase)

function module.bind()
  return {
    activeSample = false,
    buttons = {
      moduleName = "modulePages/moduleButtonSingle",
      count = 4
    },
    buttonTab = -1
  }
end

function module.methods()
  return {}
end

function module:setData(buttonType, txtName, callback, params)
  params = params or {}
  self.bind.buttonTab = buttonType
  if self.modules.buttons[buttonType] then
    self.modules.buttons[buttonType]:setData(txtName, callback, params)
  end
  self._trueSize = params.size or self._trueSize
  self:refreshSize()
end

function module:open()
  self._trueSize = self._trueSize or self.bindComponents.Root.sizeDelta
  self:refreshSize()
end

function module:refreshSize()
  if not self._trueSize then
    return
  end
  if not self.modules.buttons[self.bind.buttonTab] then
    self.bindComponents.Root.sizeDelta = C_Vector2.zero
  else
    self.bindComponents.Root.sizeDelta = self._trueSize
  end
end

return module
