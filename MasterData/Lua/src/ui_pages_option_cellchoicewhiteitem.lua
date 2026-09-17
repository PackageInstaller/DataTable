local module = class("cellChoiceWhiteItem", G_UIModuleBase)

function module.bind()
  return {
    text = "",
    textB = "",
    line = true,
    bgB = false
  }
end

function module.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.index, self.bind.num)
    end
  }
end

return module
