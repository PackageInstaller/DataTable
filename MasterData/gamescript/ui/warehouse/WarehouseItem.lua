local WarehouseItem, Super = System.NewComponent("WarehouseItem")

function WarehouseItem:ctor(res)
  Super.ctor(self)
  self.ui = Item_Character_StartResource(res)
end

function WarehouseItem:OnBind(binder)
  self.binder = binder
end

return WarehouseItem
