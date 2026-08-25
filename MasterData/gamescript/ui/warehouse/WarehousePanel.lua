local WarehousePanel, Super = System.NewClass("WarehousePanel", UIBasePanel)
WarehousePanel.uiResCls = Panel_Main_WarehouseResource

function WarehousePanel:ctor()
  Super.ctor(self)
  self.allItems = Vue.ref({})
  self.Material = Vue.ref({})
  self.TrinketItems = Vue.ref({})
  self.WeaponItems = Vue.ref({})
  self.specialItems = Vue.ref({})
end

function WarehousePanel:OnBind(binder)
  self.binder = binder
  Logger.Debug("WarehousePanel:OnBind(), 创建 UI")
  binder:BindButtonClick(self.ui.Btn_Close, function()
    self:Close()
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Material, self.ui.ScrollView_Warehouse_Material)
  binder:BindToZ1Toggle(self.ui.Btn_Trinket, self.ui.ScrollView_Warehouse_Trinket)
  binder:BindToZ1Toggle(self.ui.Btn_Weapon, self.ui.ScrollView_Warehouse_Weapon)
  binder:BindToZ1Toggle(self.ui.Btn_Special, self.ui.ScrollView_Warehouse_Special)
  binder:SetZ1Toggle(self.ui.Btn_Material, true)
  EventMgr.Instance.UpdateBagEvent:RegisterEvent(System.fn(self, self.OnBagListChange))
  self:OnBagListChange()
  
  local function useItemFunction(itemTid)
    ItemDataUtils.ReqOnUseItem(itemTid, 1)
  end
  
  binder:BindToCircularListView(self.ui.ScrollView_Warehouse_Material, function()
    return self.Material.value
  end, function(itemBinder, item, index)
    local data = self.Material.value[index]
    local it = itemBinder:BindComponent(ItemPublicArticle(item, data.tid, StrUtils.NumberConvert(data.num), false, true, true, nil, nil, useItemFunction))
    itemBinder:BindToRaw(function(_, v, _)
      local text = StrUtils.NumberConvert(v)
      it:SetNumText(text)
    end, function()
      return data.num
    end, true)
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Warehouse_Trinket, function()
    return self.TrinketItems.value
  end, function(itemBinder, item, index)
    local data = self.TrinketItems.value[index]
    local it = itemBinder:BindComponent(ItemPublicArticle(item, data.tid, StrUtils.NumberConvert(data.num), false, true, true, nil, nil, useItemFunction))
    itemBinder:BindToRaw(function(_, v, _)
      local text = StrUtils.NumberConvert(v)
      it:SetNumText(text)
    end, function()
      return data.num
    end, true)
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Warehouse_Weapon, function()
    return self.WeaponItems.value
  end, function(itemBinder, item, index)
    local data = self.WeaponItems.value[index]
    ItemIconCompBase.CreateFromRuntimeData(itemBinder, item, data)
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Warehouse_Special, function()
    return self.specialItems.value
  end, function(itemBinder, item, index)
    local data = self.specialItems.value[index]
    local it = itemBinder:BindComponent(ItemPublicArticle(item, data.tid, StrUtils.NumberConvert(data.num), false, true, true, nil, nil, useItemFunction))
    itemBinder:BindToRaw(function(_, v, _)
      local text = StrUtils.NumberConvert(v)
      it:SetNumText(text)
    end, function()
      return data.num
    end, true)
  end)
end

function WarehousePanel:OnUnbind()
  EventMgr.Instance.UpdateBagEvent:RemoveEvent(System.fn(self, self.OnBagListChange))
end

function WarehousePanel:OnBagListChange()
  self.allItems.value = {}
  self.Material.value = {}
  self.TrinketItems.value = {}
  self.WeaponItems.value = {}
  self.specialItems.value = {}
  local IType = CommonDefine.ItemType
  for _, v in pairs(DataCenter.itemData.BagItemData) do
    local config = ItemDataUtils.GetItemConfig(v.tid)
    if config.Type == IType.Trinket and not AwakerTrinketDataUtils.IsTrinketVisibleInList(v.uid) then
    else
      if config.Type == IType.Material or config.Type == IType.Trinket or config.Type == IType.Weapon or config.Type == IType.Special then
        table.insert(self.allItems.value, v)
      end
      if config.Type == CommonDefine.ItemType.Material then
        table.insert(self.Material.value, v)
      elseif config.Type == CommonDefine.ItemType.Trinket then
        table.insert(self.TrinketItems.value, v)
      elseif config.Type == CommonDefine.ItemType.Weapon then
        table.insert(self.WeaponItems.value, v)
      elseif config.Type == CommonDefine.ItemType.Special then
        table.insert(self.specialItems.value, v)
      end
    end
  end
  
  local function sortFunc(a, b)
    do return ItemDataUtils.CommonItemSortFunc, a.tid end
    return ItemDataUtils.CommonItemSortFunc, a.tid, b.tid
  end
  
  table.sort(self.allItems.value, sortFunc)
  table.sort(self.Material.value, sortFunc)
  table.sort(self.TrinketItems.value, sortFunc)
  table.sort(self.WeaponItems.value, sortFunc)
  table.sort(self.specialItems.value, sortFunc)
end

return WarehousePanel
