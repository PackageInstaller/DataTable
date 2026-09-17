local module = class("KiboDuelSimulatorClickItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {
    input_name = "",
    txt_name = "",
    input_visible = false,
    txt_visible = true
  }
end

function module.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind)
    end,
    onChanged_name = function(self, text)
      self:emit("onRename", self.bind, text)
    end
  }
end

return module
