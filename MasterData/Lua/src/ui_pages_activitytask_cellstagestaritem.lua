local module = class("cellStageStarItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    imgType = {
      [1] = "Page/BSActivityTask/tex_activity_icon_hy_1",
      [2] = "Page/BSActivityTask/tex_activity_icon_hy_2"
    }
  }
end

function module.bind()
  return {
    img = "Page/BSActivityTask/tex_activity_icon_hy_2"
  }
end

function module.methods()
  return {}
end

function module:open()
  self:refreshInfo()
end

function module:refreshInfo()
  if self.bind.isFinish and self.bind.isFinish == true then
    self.bind.img = self.data.imgType[1]
  end
end

function module:close()
end

return module
