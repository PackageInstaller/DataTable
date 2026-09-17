local module = class("cellShopItem", G_UIModuleBase)

function module.bind()
  return {
    isCellIcon = false,
    moduleIcon = {
      moduleName = "modulePages/cellIcon"
    },
    bigImgIcon = "",
    txtName = "",
    imgCurrency = "",
    isImgCIcon = true,
    istxtCIcon = false,
    txtCost = "",
    choice = false,
    txtLastTime = "",
    isBigImagIcon = false,
    lastBox = false,
    stockBox = false,
    goSoldOut = false,
    goStock = "",
    goRecommend = false
  }
end

function module.methods()
  return {
    onClick = function(self)
      if not self.bind.goSoldOut then
        self:emit("onClickSelect", self.bind.slotId)
      end
    end
  }
end

function module:open()
  self:refreshCell()
end

function module:refreshCell()
  if self.bind.isCellIcon and self.modules.moduleIcon ~= nil then
    self.modules.moduleIcon:setGeneralContent(self.bind.itemType, self.bind.itemId)
  end
end

return module
