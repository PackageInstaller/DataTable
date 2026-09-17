local module = class("propertyItem", G_UIModuleBase)

function module.bind()
  return {
    bg = true,
    iconObj = false,
    icon = nil,
    textBase = nil,
    textAdvance = nil,
    num = nil,
    baseNum = nil,
    addNum = nil,
    splitTextActive = false,
    numActive = true
  }
end

function module.methods()
  return {}
end

return module
