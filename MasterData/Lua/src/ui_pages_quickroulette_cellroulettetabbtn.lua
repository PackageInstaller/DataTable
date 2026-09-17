local module = class("cellRouletteTabBtn", G_UIModuleBase)

function module.bind()
  return {
    isActive = nil,
    isNomarl = nil,
    shopNameShow = "",
    shopNameOut = "",
    shopImageShow = "",
    shopImageOut = ""
  }
end

function module.methods()
  return {
    onClickShop = function(self)
      if self.bind.index then
        self:emit("onClick_tab", self.bind.index)
      end
    end
  }
end

return module
