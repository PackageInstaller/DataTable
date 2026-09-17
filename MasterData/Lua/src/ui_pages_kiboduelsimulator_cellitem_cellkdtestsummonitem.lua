local module = class("cellKDTestSummonItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {txt_name = ""}
end

function module.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind)
    end,
    onClickDelete = function(self)
      self:emit("onClickDelete", self.bind)
    end
  }
end

return module
