local module = class("cellTypeBtn", G_UIModuleBase)
local _shopTpl = L_GameTpl:getShopGroupTpl()

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
      if self.bind.commondId then
        self:emit("onClickSelect", self.bind.commondId)
      end
    end
  }
end

return module
