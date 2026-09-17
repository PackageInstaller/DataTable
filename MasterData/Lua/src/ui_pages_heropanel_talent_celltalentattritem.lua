local module = class("cellTalentAttrItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {
    attrIcon = "",
    name = "",
    value = "",
    bgEnable = true
  }
end

function module.methods()
  return {}
end

function module:open()
  self:refreshInfo()
end

function module:refresh()
  if not self.isBind then
    return
  end
  self:refreshInfo()
end

function module:refreshInfo()
end

function module:close()
end

return module
