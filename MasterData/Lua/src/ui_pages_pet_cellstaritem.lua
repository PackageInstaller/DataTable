local module = class("cellStarItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    id = nil,
    imgType = {
      [1] = CS.UnityEngine.Color(0.6784313725490196, 0.49411764705882355, 0.16470588235294117),
      [2] = CS.UnityEngine.Color(0.7294117647058823, 0.7294117647058823, 0.7294117647058823),
      [3] = CS.UnityEngine.Color(0.9333333333333333, 1.0, 0.047058823529411764)
    },
    rarity = nil
  }
end

function module.bind()
  return {
    img = CS.UnityEngine.Color(1.0, 1.0, 0 / 255)
  }
end

function module.methods()
  return {}
end

function module:open()
  self:refreshInfo()
end

function module:refreshInfo()
  if self.bind.rarity then
    self.bind.img = self.data.imgType[self.bind.rarity]
  end
end

function module:close()
end

return module
