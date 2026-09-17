local module = class("cellPlaceHero", G_UIModuleBase)

function module.bind()
  return {goEmpty = false}
end

function module.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind)
    end
  }
end

function module:refresh()
end

return module
