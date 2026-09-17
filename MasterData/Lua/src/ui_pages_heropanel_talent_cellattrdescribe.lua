local module = class("cellAttrDescribe", G_UIModuleBase)

function module.bind()
  return {
    propertyNameTxt = "",
    curText = "",
    nextText = "",
    bgActive = true,
    arrowActive = true
  }
end

function module:refresh()
  if not self.isBind then
    return
  end
  self.bind.propertyNameTxt = self.bind.nameTxt
  self.bind.curText = self.bind.curValue
  self.bind.nextText = self.bind.nextValue
  self.bind.bgActive = self.bind.bg
end

return module
