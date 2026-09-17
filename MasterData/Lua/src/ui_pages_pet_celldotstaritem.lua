local module = class("cellDotStarItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    id = nil,
    rarity = nil,
    isGray = nil
  }
end

function module.bind()
  return {start_color = 1}
end

function module.methods()
  return {}
end

function module:open()
  self.ImgColor = self.gameObject:GetComponent(typeof(C_LImage))
  self:refreshInfo()
end

function module:refreshInfo()
  self.ImgColor.color = C_Color(1, 1, 1, self.bind.start_color)
end

function module:close()
end

return module
