local module = class("cellCommonShopItem", G_UIModuleBase)

function module.bind()
  return {
    imgChoice = false,
    textName = "",
    textStock = "",
    moduleIcon = {
      moduleName = "modulePages/cellIcon"
    }
  }
end

function module.methods()
  return {
    onClick = function(self)
      if not self.bind.go_soldOut then
        self:emit("onClickSelect", self.bind.slotId)
      end
    end
  }
end

function module:open(options)
  module.super.open(self, options)
  self.modules.moduleIcon:setGeneralContent(self.bind.itemType, self.bind.itemId)
end

return module
