local MainShopGoldShopItem, Super = System.NewComponent("MainShopGoldShopItem", MainShopItem)

function MainShopGoldShopItem:ctor(uiNode, data)
  Super.ctor(self, uiNode, data)
end

function MainShopGoldShopItem:RefreshTimeBind()
  self.binder:BindToVisible(self.ui.Group_Time, function()
    return false
  end)
end

return MainShopGoldShopItem
