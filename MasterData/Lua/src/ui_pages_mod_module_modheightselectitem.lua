local module = class("modHeightSelectItem", G_UIModuleBase)

function module.bind()
  return {
    heightName = "",
    transPos = C_Vector3.zero
  }
end

function module.methods()
  return {
    OnClick = function(self)
      self.parent.bind.value_slider = self.bind.height
    end
  }
end

return module
