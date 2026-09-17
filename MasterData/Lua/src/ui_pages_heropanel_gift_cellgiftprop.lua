local module = class("cellGiFtProp", G_UIModuleBase)

function module.bind()
  return {
    transPosition = L_Vector3.new(0, 0),
    equipIcon = "",
    num = ""
  }
end

function module.methods()
  return {
    onClick_openGiftsEquiped = function(self)
      self:emit("openGiftsBg", self.bind.id, self.bind.itemType)
    end
  }
end

return module
