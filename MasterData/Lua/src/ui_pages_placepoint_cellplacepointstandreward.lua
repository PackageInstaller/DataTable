local module = class("cellPlacePointStandReward", G_UIModuleBase)

function module.bind()
  return {
    img_icon = "",
    img_quality = "",
    txt_oneTime = "",
    txt_max = ""
  }
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
