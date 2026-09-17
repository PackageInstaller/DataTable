local module = class("cellSpiritItem", G_UIModuleBase)

function module.bind()
  return {spirit_name = ""}
end

function module.methods()
  return {
    onClick = function(self)
      if self.bind.spirit_id ~= 0 and self.bind.spirit_id ~= nil then
        self:emit("onClick_chooseSpirit", self.bind)
      end
    end
  }
end

function module:open()
end

return module
