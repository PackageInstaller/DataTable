require("Voyage/VoyageRichManWarehouseShopItem")

local this = {
    shopList = nil,
};

local objs = {
    maskBtn = { path = "root/Mask", type = "Button" },
    shopItem = { path = "template/ShopItem", type = "GameObject" },
    scrollViewTF = { path = "root/Middle/Warehouse/ScrollView/Viewport/Content", type = "RectTransform" },
};


this.SetData = function()
    this.SetShops();
end


this.SetShops = function()
    this.shopList:Clear();
    local listData;
    local listDatas = {};
    local sailingCargos = DataMgr.Player.SailingCargos;
    for k, v in pairs(sailingCargos) do
        if (v > 0) then
            listData = UIListData.GetData(this.shopItem, "VoyageRichManWarehouseShopItem", {id=k,count=v});
            table.insert(listDatas, listData);
        end
    end
    this.shopList:SetData(listDatas);
end


this.OnClickMask = function()
    LuaMgr.HidePanel(UIName.VoyageRichManWarehouseViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.shopList = UIListView.New(this.scrollViewTF);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.SetData();
    end,
    before_deactive = function(vm)
        this.shopList:Clear();
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
        UIListView.ClearItem("VoyageRichManWarehouseShopItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})